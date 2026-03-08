-- 1. Trigger: Crie um trigger na tabela Historico que impeça um Perfil de inserir 
-- uma visualização de um Conteudo (seja filme direto ou através de episódio/série) 
-- se a classificacao_indicativa do conteúdo for maior que a restricao_idade do perfil. 
-- (Dica: Lembre-se de tratar a conversão de 'Livre' para avaliação numérica)

CREATE OR REPLACE TRIGGER HISTORICO_IB_TRG
BEFORE INSERT ON Historico
FOR EACH ROW
DECLARE
    idade_conteudo NUMBER;
    idade_perfil NUMBER;
    conteudo_classificacao VARCHAR2(10);
    perfil_restricao VARCHAR2(20);
BEGIN
	SELECT restricao_idade
    INTO perfil_restricao
    FROM Perfil
    WHERE id = :NEW.id_perfil;
	
	IF perfil_restricao = 'Livre' THEN
        idade_perfil := 0;
    ELSE
        idade_perfil := TO_NUMBER(perfil_restricao);
    END IF;

	IF :NEW.id_conteudo IS NOT NULL THEN
        SELECT classificacao_indicativa
        INTO conteudo_classificacao
        FROM Conteudo
        WHERE id = :NEW.id_conteudo;

        IF conteudo_classificacao = 'Livre' THEN
            idade_conteudo := 0;
        ELSE
            idade_conteudo := TO_NUMBER(conteudo_classificacao);
        END IF;

        IF idade_conteudo > idade_perfil THEN
            RAISE_APPLICATION_ERROR(-20001, 'Perfil não pode visualizar este conteúdo devido à restrição de idade.');
        END IF;
    END IF;
END;

INSERT INTO Historico (id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (2, 5, NULL, SYSTIMESTAMP, 60);

-- 2. Trigger: Crie um trigger na tabela Perfil que impeça a criação de um novo perfil 
-- se o usuário já possuir uma quantidade de perfis igual ao limite 
-- de max_telas estipulado no seu plano de Assinatura

CREATE OR REPLACE TRIGGER PERFIL_IB_TGR
BEFORE INSERT ON Perfil
FOR EACH ROW
DECLARE
	max_telas_usuario NUMBER;
	num_perfis_usuario NUMBER;
BEGIN
	SELECT a.max_telas
    INTO max_telas_usuario
    FROM Usuario u
    JOIN Assinatura a ON u.id_assinatura = a.id
    WHERE u.id = :NEW.id_usuario;

	SELECT COUNT(p.id_usuario) 
	INTO num_perfis_usuario
	FROM PERFIL p 
	WHERE p.id_usuario = :NEW.id_usuario;
	
	IF num_perfis_usuario >= max_telas_usuario THEN
		RAISE_APPLICATION_ERROR(-20001, 'Um usuário só pode inserir uma qunatidade de perfis igual ao limite da sua assinatura.');
	END IF;
END;

-- 3. Trigger: Crie um trigger na tabela Avaliacao que garanta que um perfil 
-- só possa avaliar um conteúdo se existir pelo menos um registro dele 
-- assistindo a esse título na tabela Historico 
-- (se for série, ele deve ter assistido pelo menos a um episódio dela)


-- 4. Procedure: Implemente SP_MESCLAR_PERFIS. Ela recebe dois parâmetros: 
-- P_ID_PERFIL_ORIGEM e P_ID_PERFIL_DESTINO. A procedure deve transferir todos 
-- os registros de Historico e Avaliacao da origem para o destino 
-- e, em seguida, excluir o perfil de origem. Tudo deve ocorrer na mesma transação.

-- 5. Function: Implemente uma function chamada FN_TOTAL_HORAS_CONTEUDO. 
-- Ela deve receber o ID de um conteúdo (filme ou série) e retornar um número (NUMBER) 
-- representando a quantidade total de horas (minutos convertidos) que aquele 
-- título foi assistido somando o histórico de todos os usuários