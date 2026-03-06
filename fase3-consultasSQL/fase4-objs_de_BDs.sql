CREATE OR REPLACE TRIGGER trg_valida_avaliacao_historico
BEFORE INSERT OR UPDATE ON Avaliacao
FOR EACH ROW
DECLARE
    v_qtd_assistido NUMBER;
BEGIN
    -- Busca no histórico se o perfil assistiu ao filme ou a algum episódio da série
    SELECT COUNT(*) INTO v_qtd_assistido
    FROM Historico h
    LEFT JOIN Episodio ep ON h.id_episodio = ep.id
    LEFT JOIN Temporada t ON ep.id_temporada = t.id
    WHERE h.id_perfil = :NEW.id_perfil
      AND (
          h.id_conteudo = :NEW.id_conteudo -- Se for Filme (vínculo direto)
          OR
          t.id_conteudo = :NEW.id_conteudo -- Se for Série (vínculo pela temporada do episódio)
      );

    -- Se a contagem for 0, significa que não tem histórico. Barrar a inserção!
    IF v_qtd_assistido = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Operação bloqueada: O perfil não pode avaliar um conteúdo que ainda não assistiu.');
    END IF;
END;
/


-- Insert para teste do Trigger
INSERT INTO Avaliacao (id, id_perfil, id_conteudo, nota, comentario, data)
VALUES (6, 1, 2, 1, 'Não assisti, mas achei ruim.', DATE '2024-03-07');