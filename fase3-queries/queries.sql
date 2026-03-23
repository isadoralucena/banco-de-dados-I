-- 1. Exiba o nome dos perfis e o título do conteúdo que eles avaliaram, mas 
-- apenas se o comentário da avaliação contiver a palavra "Ação" ou 
-- "melhor"

SELECT p.nome AS "Nome do perfil", c.titulo AS "Título do conteúdo"
FROM Perfil p, Conteudo c, Avaliacao a 
WHERE p.id = a.ID_PERFIL 
AND a.id_conteudo = c.id 
AND (
	UPPER(a.comentario) LIKE '%AÇÃO%'
	OR UPPER(a.comentario) LIKE '%MELHOR%'
);

-- 2. Calcule e exiba a porcentagem máxima que o perfil "João" já assistiu do 
-- filme "O Resgate Final" em uma única sessão

SELECT (MAX(h.minutos_assistidos) / c.duracao_minutos) * 100 AS "Porcentagem máxima"
FROM Perfil p
JOIN Historico h ON h.id_perfil = p.id
JOIN Conteudo c ON c.id = h.id_conteudo
WHERE UPPER(p.nome) = 'JOÃO'
AND c.tipo = 'Filme'
AND c.titulo = 'O Resgate Final'
GROUP BY c.duracao_minutos;

-- 3. Qual o nome dos usuários e o e-mail daqueles cujo plano de assinatura 
-- custa mais do que a média de preços de todos os planos disponíveis no 
-- sistema?

SELECT u.nome, u.email
FROM Usuario u, Assinatura a
WHERE u.id_assinatura = a.id
AND a.PRECO_MENSAL > (SELECT AVG(PRECO_MENSAL) FROM ASSINATURA);

-- 4. Exiba a(s) série(s) que possui(em) a maior quantidade de temporadas 
-- cadastradas no banco

SELECT c.titulo AS "Nome da série"
FROM Conteudo c
JOIN Temporada t ON c.id = t.id_conteudo
GROUP BY c.id, c.titulo
HAVING COUNT(t.id) =
(
    SELECT MAX(qtd)
    FROM (
        SELECT COUNT(id) AS qtd
        FROM Temporada
        GROUP BY id_conteudo
    )
);

-- 5. Exiba o nome do usuário, o nome do seu plano de assinatura, o limite 
-- máximo de telas do plano e a quantidade de perfis cadastrados na conta. 
-- Filtre os resultados para retornar apenas os usuários cuja quantidade de 
-- perfis criados seja maior que o limite máximo de telas do seu plano

SELECT u.nome AS "Nome do usuário", 
a.nome AS "Assinatura", 
a.max_telas AS "Máximo de telas", 
COUNT(p.nome) AS "Quantidade de perfis"
FROM Usuario u
JOIN Assinatura a ON u.id_assinatura = a.id
JOIN Perfil p ON p.id_usuario = u.id
GROUP BY u.nome, a.nome, a.max_telas
HAVING COUNT(p.nome) > a.max_telas;

-- 6. Quais usuários (Nome e E-mail) que possuem a assinatura "Premium" já 
-- assistiram a algum conteúdo do gênero "Ficção Científica"? Liste também 
-- o título do conteúdo que eles assistiram

SELECT DISTINCT
    us.nome AS "Nome do Usuário",
    us.email AS "Email do Usuário",
    c.titulo AS "Título do Conteúdo"
FROM Usuario us
JOIN Assinatura a ON us.id_assinatura = a.id
JOIN Perfil p ON us.id = p.id_usuario
JOIN Historico h ON p.id = h.id_perfil
JOIN Conteudo c ON h.id_conteudo = c.id
JOIN Conteudo_Genero cg ON c.id = cg.id_conteudo
JOIN Genero g ON cg.id_genero = g.id
WHERE a.nome = 'Premium' AND g.nome = 'Ficção Científica'

UNION

SELECT DISTINCT
    us.nome AS "Nome do Usuário",
    us.email AS "Email do Usuário",
    c.titulo AS "Título do Conteúdo"
FROM Usuario us
JOIN Assinatura a ON us.id_assinatura = a.id
JOIN Perfil p ON us.id = p.id_usuario
JOIN Historico h ON p.id = h.id_perfil
JOIN Episodio e ON h.id_episodio = e.id
JOIN Temporada t ON e.id_temporada = t.id
JOIN Conteudo c ON t.id_conteudo = c.id
JOIN Conteudo_Genero cg  ON c.id = cg.id_conteudo
JOIN Genero g ON cg.id_genero = g.id
WHERE a.nome = 'Premium' AND g.nome = 'Ficção Científica';

-- 7. Liste o título da série, o número da temporada e o título do episódio para 
-- todos os episódios que possuem uma duração superior a 60 minutos OU 
-- cuja descrição não tenha sido informada. Ordene o resultado pelo título da 
-- série e, em seguida, pelo número da temporada

SELECT c.titulo AS "Título da série", t.numero AS "Número da temporada", e.titulo AS "Título do episódio"
FROM Episodio e
JOIN Temporada t ON e.id_temporada = t.id
JOIN Conteudo c ON c.id = t.id_conteudo
WHERE (e.duracao_minutos > 60 OR e.descricao IS NULL)
ORDER BY c.titulo, t.numero;

-- 8. Crie uma VIEW que encapsule a seguinte consulta: Liste as 
-- classificações indicativas e a quantidade de conteúdos (filmes ou séries) 
-- cadastrados em cada uma. Retorne apenas as classificações que 
-- possuam mais de 1 conteúdo associado

CREATE OR REPLACE VIEW Vw_Classificacao_Indicativa_Qtd_Conteudo  
(classificacao_indicativa, qtd_conteudo) AS
SELECT c.classificacao_indicativa, COUNT(c.id) 
FROM Conteudo c
GROUP BY c.classificacao_indicativa 
HAVING COUNT(c.id) > 1;

-- 9. Crie uma VIEW que encapsule a seguinte consulta: Liste o nome dos 
-- perfis que assistiram a pelo menos um episódio de absolutamente todas as 
-- séries disponíveis no catálogo

CREATE OR REPLACE VIEW Vw_Perfis_Assistiram_Ep_Todas_Series
(nome_perfil) AS
SELECT p.nome 
FROM Perfil p
JOIN Historico h ON p.id = h.id_perfil
JOIN Episodio e ON h.id_episodio = e.id
JOIN Temporada t ON e.id_temporada = t.id
JOIN Conteudo c ON t.id_conteudo = c.id
WHERE c.tipo = 'Serie'
GROUP BY p.id, p.nome
HAVING COUNT(DISTINCT c.id) = (SELECT COUNT(c.id) FROM Conteudo WHERE tipo = 'Serie');

-- 10. Crie uma VIEW que encapsule a seguinte consulta: Liste o nome e a 
-- função dos artistas que participaram do filme "O Resgate Final". Filtre o 
-- resultado para exibir apenas os artistas que já trabalharam em conteúdos 
-- de pelo menos dois gêneros diferentes ao longo de toda a sua trajetória no 
-- catálogo

CREATE OR REPLACE VIEW Vw_Artistas_Resgate_Final
(nome_artista, funcao_artista) AS
SELECT a.nome, ca.funcao
FROM Artista a
JOIN Conteudo_Artista ca ON a.id = ca.id_artista
JOIN Conteudo c ON ca.id_conteudo = c.id
WHERE c.titulo = 'O Resgate Final'
AND c.tipo = 'Filme'
AND a.id IN
(
    SELECT ca2.id_artista
    FROM Conteudo_Artista ca2
    JOIN Conteudo_Genero cg ON ca2.id_conteudo = cg.id_conteudo
    GROUP BY ca2.id_artista
    HAVING COUNT(DISTINCT cg.id_genero) >= 2
);