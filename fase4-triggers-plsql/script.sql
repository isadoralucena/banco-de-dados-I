-- 1. Trigger: Crie um trigger na tabela Historico que impeça um Perfil de inserir 
-- uma visualização de um Conteudo (seja filme direto ou através de episódio/série) 
-- se a classificacao_indicativa do conteúdo for maior que a restricao_idade do perfil. 
-- (Dica: Lembre-se de tratar a conversão de 'Livre' para avaliação numérica)

CREATE OR REPLACE TRIGGER TRG_HISTORICO_BI
BEFORE INSERT ON Historico
FOR EACH ROW
DECLARE
    v_idade_conteudo NUMBER;
    v_idade_perfil NUMBER;
    v_classificacao VARCHAR2(10);
    v_restricao VARCHAR2(20);
BEGIN
	SELECT restricao_idade
    INTO v_restricao
    FROM Perfil
    WHERE id = :NEW.id_perfil;
	
	IF v_restricao = 'Livre' THEN
        v_idade_perfil  := 0;
    ELSE
        v_idade_perfil  := TO_NUMBER(v_restricao);
    END IF;
	
	IF :NEW.id_conteudo IS NOT NULL THEN
        SELECT classificacao_indicativa
        INTO v_classificacao
        FROM Conteudo
        WHERE id = :NEW.id_conteudo;
	ELSE
        SELECT c.classificacao_indicativa
        INTO v_classificacao
        FROM Episodio e
        JOIN Temporada t ON e.id_temporada = t.id
        JOIN Conteudo c ON t.id_conteudo = c.id
        WHERE e.id = :NEW.id_episodio;
    END IF;
	
	IF v_classificacao  = 'Livre' THEN
        v_idade_conteudo  := 0;
    ELSE
        v_idade_conteudo  := TO_NUMBER(v_classificacao );
    END IF;

	IF v_idade_conteudo > v_idade_perfil THEN
        RAISE_APPLICATION_ERROR(
        	-20001, 
        	'Perfil não pode visualizar este conteúdo devido à restrição de idade.'
        );
    END IF;
END;

-- 2. Trigger: Crie um trigger na tabela Perfil que impeça a criação de um novo perfil 
-- se o usuário já possuir uma quantidade de perfis igual ao limite 
-- de max_telas estipulado no seu plano de Assinatura

CREATE OR REPLACE TRIGGER TRG_PERFIL_BI
BEFORE INSERT ON Perfil
FOR EACH ROW
DECLARE
	v_max_telas NUMBER;
	v_qtd_perfis NUMBER;
BEGIN
	SELECT a.max_telas
    INTO v_max_telas
    FROM Usuario u
    JOIN Assinatura a ON u.id_assinatura = a.id
    WHERE u.id = :NEW.id_usuario;

	SELECT COUNT(p.id_usuario) 
	INTO v_qtd_perfis
	FROM Perfil p 
	WHERE p.id_usuario = :NEW.id_usuario;
	
	IF v_qtd_perfis >= v_max_telas THEN
		RAISE_APPLICATION_ERROR(
			-20001, 
			'Um usuário só pode inserir uma quantidade de perfis igual ao limite da sua assinatura.'
		);
	END IF;
END;

-- 3. Trigger: Crie um trigger na tabela Avaliacao que garanta que um perfil 
-- só possa avaliar um conteúdo se existir pelo menos um registro dele 
-- assistindo a esse título na tabela Historico 
-- (se for série, ele deve ter assistido pelo menos a um episódio dela)

CREATE OR REPLACE TRIGGER TRG_AVALIACAO_BIU
BEFORE INSERT OR UPDATE ON Avaliacao
FOR EACH ROW
DECLARE
    v_qtd_assistido NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO v_qtd_assistido
    FROM Historico h
    LEFT JOIN Episodio ep ON h.id_episodio = ep.id
    LEFT JOIN Temporada t ON ep.id_temporada = t.id
    WHERE h.id_perfil = :NEW.id_perfil
      AND (
          h.id_conteudo = :NEW.id_conteudo
          OR
          t.id_conteudo = :NEW.id_conteudo
      );

    IF v_qtd_assistido = 0 THEN
        RAISE_APPLICATION_ERROR(
    		-20001, 
    		'O perfil não pode avaliar um conteúdo que ainda não assistiu.'
    	);
    END IF;
END;

-- 4. Procedure: Implemente SP_MESCLAR_PERFIS. Ela recebe dois parâmetros: 
-- P_ID_PERFIL_ORIGEM e P_ID_PERFIL_DESTINO. A procedure deve transferir todos 
-- os registros de Historico e Avaliacao da origem para o destino 
-- e, em seguida, excluir o perfil de origem. Tudo deve ocorrer na mesma transação

CREATE OR REPLACE PROCEDURE SP_MESCLAR_PERFIS(
	P_ID_PERFIL_ORIGEM NUMBER, 
	P_ID_PERFIL_DESTINO NUMBER
) 
IS
BEGIN
  -- De forma defensiva, colocamos essa checagem de NULL aqui invés de colocar NOT NULL nos parâmetros
  -- garantindo que não aconteça nada se as entradas não forem válidas
	IF P_ID_PERFIL_ORIGEM IS NULL OR P_ID_PERFIL_DESTINO IS NULL 
		THEN RAISE_APPLICATION_ERROR(
    		-20001, 
    		'Parâmetros inválidos para mesclagem.'
    	);
	END IF; 

	IF P_ID_PERFIL_ORIGEM = P_ID_PERFIL_DESTINO 
		THEN RAISE_APPLICATION_ERROR(
    		-20001, 
    		'Não é possível mesclar o mesmo perfil.'
    	);
	END IF;
  
	UPDATE HISTORICO
		SET id_perfil = P_ID_PERFIL_DESTINO
	WHERE id_perfil = P_ID_PERFIL_ORIGEM;
  
	UPDATE Avaliacao
		SET id_perfil = P_ID_PERFIL_DESTINO
	WHERE id_perfil = P_ID_PERFIL_ORIGEM;
  
	DELETE FROM Perfil
	WHERE id = P_ID_PERFIL_ORIGEM;
	COMMIT;
END;

-- 5. Function: Implemente uma function chamada FN_TOTAL_HORAS_CONTEUDO. 
-- Ela deve receber o ID de um conteúdo (filme ou série) e retornar um número (NUMBER) 
-- representando a quantidade total de horas (minutos convertidos) que aquele 
-- título foi assistido somando o histórico de todos os usuários

CREATE OR REPLACE FUNCTION FN_TOTAL_HORAS_CONTEUDO (
	P_ID_CONTEUDO NUMBER
) 
RETURN NUMBER
IS
	v_tipo VARCHAR2(20);
	v_total_minutos_assistidos NUMBER;
BEGIN
	SELECT tipo INTO v_tipo FROM Conteudo c WHERE c.id = P_ID_CONTEUDO;

	IF v_tipo = 'Filme' THEN 
	  	SELECT SUM(minutos_assistidos) 
		INTO v_total_minutos_assistidos 
		FROM Historico h 
		WHERE h.id_conteudo = P_ID_CONTEUDO; 
	ELSE
		SELECT SUM(minutos_assistidos) 
		INTO v_total_minutos_assistidos 
		FROM Historico h 
		JOIN Episodio e ON e.id = h.id_episodio 
		JOIN Temporada t ON e.id_temporada = t.id
		WHERE t.id_conteudo = P_ID_CONTEUDO 
	END IF;
	RETURN NVL(v_total_minutos_assistidos, 0)/60;
END;
