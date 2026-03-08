CREATE OR REPLACE TRIGGER bloqueia_avaliacao
BEFORE INSERT ON Avaliacao
FOR EACH ROW
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM Historico h
    LEFT JOIN Episodio e ON h.id_episodio = e.id
    LEFT JOIN Temporada t ON t.id = e.id_temporada
    WHERE :NEW.id_perfil = h.id_perfil AND (:NEW.id_conteudo = t.id_conteudo OR :NEW.id_conteudo = h.id_conteudo);
  ) THEN
      RAISE_APPLICATION_ERROR(-20003, 'Perfil não assistiu esse conteúdo');
  END IF;
END;
