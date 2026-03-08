CREATE OR REPLACE FUNCTION FN_TOTAL_HORAS_CONTEUDO ( P_ID_CONTEUDO NUMBER ) 
RETURN NUMBER
IS
v_tipo VARCHAR2(20);
v_total_minutos_assistidos NUMBER;
BEGIN
SELECT tipo INTO v_tipo FROM Conteudo c WHERE c.id = P_ID_CONTEUDO;
IF v_tipo = 'Filme' THEN 
  SELECT SUM(minutos_assistidos) INTO v_total_minutos_assistidos FROM Historico h WHERE h.id_conteudo = P_ID_CONTEUDO; 
ELSE
  SELECT SUM(minutos_assistidos) INTO v_total_minutos_assistidos FROM Historico h JOIN Episodio e ON e.id = h.id_episodio JOIN Temporada t ON e.id_temporada = t.id AND t.id_conteudo = P_ID_CONTEUDO; 
END IF;
RETURN NVL(v_total_minutos_assistidos, 0)/60;
END;
