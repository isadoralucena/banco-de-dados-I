---- Q1
SELECT p.nome, c.titulo 
FROM Perfil p 
JOIN Avaliacao a ON p.id = a.id_perfil 
JOIN Conteudo c ON a.id_conteudo = c.id 
WHERE a.comentario LIKE '%Ação%' OR a.comentario LIKE '%melhor%'

---- Q2
SELECT MAX(h.minutos_assistidos * 100.0/ c.duracao_minutos) 
FROM Perfil p 
JOIN Historico h ON h.id_perfil = p.id 
JOIN Conteudo c ON h.id_conteudo = c.id 
WHERE p.nome = 'João' AND c.tipo = 'Filme' AND c.titulo = 'O Resgate Final'

---- Q3
SELECT u.nome, u.email 
FROM Usuario u 
JOIN Assinatura a ON u.id_assinatura = a.id 
WHERE a.preco_mensal > (SELECT AVG (preco_mensal) FROM Assinatura)

---- Q4
SELECT c.titulo 
FROM Conteudo c 
JOIN Temporada t ON t.id_conteudo = c.id 
WHERE c.tipo = 'Serie' GROUP BY c.id, c.titulo 
HAVING COUNT(t.id) = (SELECT MAX(num_temporadas) 
FROM (SELECT COUNT(*) AS num_temporadas 
FROM Temporada GROUP BY id_conteudo))

---- Q5
SELECT u.nome, a.nome, a.max_telas, (SELECT COUNT(*) FROM Perfil p WHERE p.id_usuario = u.id) AS qtd_perfis 
FROM Usuario u 
JOIN Assinatura a ON a.id = u.id_assinatura 
WHERE a.max_telas < (
                    SELECT COUNT(*) 
                    FROM Perfil p 
                    WHERE p.id_usuario = u.id
                    )

---- Q6
SELECT DISTINCT u.nome, u.email, c.titulo 
FROM Usuario u 
JOIN Assinatura a ON u.id_assinatura = a.id 
JOIN Perfil p ON u.id = p.id_usuario 
JOIN Historico h ON p.id = h.id_perfil 
JOIN Conteudo c ON c.id = h.id_conteudo 
JOIN Conteudo_Genero cg ON cg.id_conteudo = c.id 
JOIN Genero g ON g.id = cg.id_genero 
WHERE g.nome = 'Ficção Científica' AND a.nome = 'Premium'

---- Q7
SELECT c.titulo, t.numero, e.titulo 
FROM Conteudo c 
JOIN Temporada t ON t.id_conteudo = c.id 
JOIN Episodio e ON e.id_temporada = t.id 
WHERE c.tipo = 'Serie' AND (e.duracao_minutos > 60 OR e.descricao IS NULL) ORDER BY c.titulo, t.numero

---- Q8
CREATE VIEW conteudos_por_classificacao AS 
SELECT c.classificacao_indicativa , COUNT(*) AS qtd_por_classificacao 
FROM Conteudo c 
GROUP BY c.classificacao_indicativa 
HAVING COUNT(*) > 1

---- Q9
CREATE VIEW one_for_all AS
SELECT p.nome
FROM Perfil p
JOIN Historico h ON p.id = h.id_perfil
JOIN Conteudo c ON h.id_conteudo = c.id
WHERE c.tipo = 'Serie'
GROUP BY p.id, p.nome
HAVING COUNT(DISTINCT c.id) = (
    SELECT COUNT(*)
    FROM Conteudo
    WHERE tipo = 'Serie'
);

---- Q10
CREATE VIEW artistas_filme_especifico AS 
SELECT a.nome, ca.funcao 
FROM Conteudo c 
JOIN Conteudo_Artista ca ON c.id = ca.id_conteudo 
JOIN Artista a ON a.id = ca.id_artista 
WHERE c.titulo = 'O Resgate Final' AND a.id IN (
                                                SELECT ca2.id_artista 
                                                FROM Conteudo_Artista ca2 
                                                JOIN Conteudo c2 ON c2.id = ca2.id_conteudo 
                                                JOIN Conteudo_Genero cg ON cg.id_conteudo = c2.id 
                                                JOIN Genero g ON g.id = cg.id_genero 
                                                GROUP BY ca2.id_artista 
                                                HAVING COUNT(DISTINCT g.id) >= 2
                                               )
