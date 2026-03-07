-- 1. Exiba o nome dos perfis e o título do conteúdo que eles avaliaram, mas apenas se o comentário da avaliação contiver a palavra “Ação” ou “melhor”.
SELECT p.nome AS nome_perfil, c.titulo AS titulo_conteudo
FROM Avaliacao a
JOIN Perfil p ON a.id_perfil = p.id
JOIN Conteudo c ON a.id_conteudo = c.id
WHERE LOWER(a.comentario) LIKE '%ação%' OR LOWER(a.comentario) LIKE '%melhor%';

--2. Calcule e exiba a porcentagem máxima que o perfil “João” já assistiu do filme “O Resgate Final” em uma única sessão.
SELECT p.nome AS nome_perfil, c.titulo AS titulo_conteudo,
    ROUND(MAX((h.minutos_assistidos / c.duracao_minutos) * 100), 2) AS porcentagem_maxima
FROM Historico h
JOIN Perfil p ON h.id_perfil = p.id
JOIN Conteudo c ON h.id_conteudo = c.id
WHERE p.nome = 'João'
    AND c.titulo = 'O Resgate Final'
GROUP BY
    p.nome, c.titulo;

-- 3.Qual o nome dos usuários e o e-mail daqueles cujo plano de assinatura custa mais do que a média de preços de todos os planos disponíveis no sistema?
SELECT us.nome AS nome_do_usuario, us.email
FROM Usuario us
JOIN Assinatura a ON us.id_assinatura = a.id
WHERE (SELECT AVG (preco_mensal) FROM Assinatura) < a.preco_mensal;

--4. Exiba a(s) série(s) que possui(em) a maior quantidade de temporadas cadastradas no banco.
SELECT c.titulo AS nome_serie,
       COUNT(t.id) AS total_temporadas
FROM Conteudo c
JOIN Temporada t ON c.id = t.id_conteudo
WHERE c.tipo = 'Serie'
GROUP BY c.titulo
HAVING COUNT(t.id) = (
    SELECT MAX(COUNT(temp.id))
    FROM Temporada temp
    GROUP BY temp.id_conteudo
);

-- 5. Exiba o nome do usuário, o nome do seu plano de assinatura, o limite máximo de telas do plano e a quantidade de perfis cadastrados na conta.
-- Filtre os resultados para retornar apenas os usuários cuja quantidade de perfis criados seja maior que o limite máximo de telas do seu plano.
SELECT us.nome AS nome_usuario, a.nome AS nome_plano_assinatura,
        a.max_telas, COUNT(p.id) AS quantidade_perfis
FROM Usuario us
JOIN Assinatura a ON us.id_assinatura = a.id
JOIN Perfil p ON us.id = p.id_usuario
GROUP BY us.nome,
    a.nome,
    a.max_telas
HAVING COUNT(p.id) > a.max_telas;

-- 6. Quais usuários (Nome e E-mail) que possuem a assinatura “Premium” já assistiram a algum conteúdo do gênero “Ficção Científica”?
-- Liste também o título do conteúdo que eles assistiram.
SELECT us.nome AS nome_usuario, us.email, c.titulo AS titulo_conteudo
FROM Usuario us
JOIN Assinatura a ON us.id_assinatura = a.id
JOIN Perfil p ON us.id = p.id_usuario
JOIN Historico h ON p.id = h.id_perfil
JOIN Conteudo c ON h.id_conteudo = c.id
JOIN Conteudo_Genero cg ON c.id = cg.id_conteudo
JOIN Genero g ON cg.id_genero = g.id
WHERE a.nome = 'Premium' AND g.nome = 'Ficção Científica';

-- 7. Liste o título da série, o número da temporada e o título do episódio para todos os episódios que possuem uma duração superior a
-- 60 minutos OU cuja descrição não tenha sido informada.
-- Ordene o resultado pelo título da série e, em seguida, pelo número da temporada.
SELECT c.titulo AS titulo_serie, temp.numero AS numero_temporada, ep.titulo AS titulo_episodio
FROM Episodio ep
JOIN Temporada temp ON ep.id_temporada = temp.id
JOIN Conteudo c ON c.id = temp.id_conteudo
WHERE ep.duracao_minutos > 60 OR ep.descricao IS NULL
ORDER BY c.titulo, temp.numero;

-- 8. Crie uma VIEW que encapsule a seguinte consulta: Liste as classificações indicativas e a quantidade de conteúdos (filmes ou séries) cadastrados em cada uma.
-- Retorne apenas as classificações que possuam mais de 1 conteúdo associado.
CREATE OR REPLACE VIEW classificaoesIndicativasConteudos (classificacao_indicativa, quantidade_conteudos)
    AS SELECT c.classificacao_indicativa, COUNT(c.id)
    FROM Conteudo c
    GROUP BY c.classificacao_indicativa
    HAVING COUNT(c.id) > 1

--9. Crie uma VIEW que encapsule a seguinte consulta: Liste o nome dos perfis que assistiram a pelo menos um episódio de
-- absolutamente todas as séries disponíveis no catálogo.
CREATE OR REPLACE VIEW perfis_super_fas AS
SELECT p.nome AS nome_perfil
FROM Perfil p
JOIN Historico h ON p.id = h.id_perfil
JOIN Episodio e ON h.id_episodio = e.id
JOIN Temporada t ON e.id_temporada = t.id
JOIN Conteudo c ON t.id_conteudo = c.id
WHERE c.tipo = 'Serie'
GROUP BY p.id, p.nome
HAVING COUNT(DISTINCT c.id) = (
    -- Subconsulta para contar o total de séries no catálogo
    SELECT COUNT(id)
    FROM Conteudo
    WHERE tipo = 'Serie'
);

-- 10. Crie uma VIEW que encapsule a seguinte consulta: Liste o nome e a função dos artistas que participaram do filme “O Resgate Final”.
-- Filtre o resultado para exibir apenas os artistas que já trabalharam em conteúdos de pelo menos dois gêneros diferentes ao longo de toda a sua trajetória no catálogo.
CREATE OR REPLACE VIEW vw_artistas_resgate_multigenero AS
SELECT a.nome AS nome_artista,
       ca.funcao
FROM Artista a
JOIN Conteudo_Artista ca ON a.id = ca.id_artista
JOIN Conteudo c ON ca.id_conteudo = c.id
WHERE c.titulo = 'O Resgate Final'
  AND c.tipo = 'Filme'
  AND a.id IN (
      -- Subconsulta: agrupa o histórico do artista e verifica se há 2 ou mais gêneros distintos
      SELECT ca_hist.id_artista
      FROM Conteudo_Artista ca_hist
      JOIN Conteudo_Genero cg ON ca_hist.id_conteudo = cg.id_conteudo
      GROUP BY ca_hist.id_artista
      HAVING COUNT(DISTINCT cg.id_genero) >= 2
  );