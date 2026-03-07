SELECT coluna1,coluna2
FROM nomeTabela
JOIN OUTRATABELA ON REGRAJUNCAO
WHERE CONDICAO FILTRO
GROUP BY COLUNA DE AGRUPAMENTO
HAVING CONDICAO GRUPO
ORDER BY CONDICAODEORDENACAO

/* ------------ QUESTÃO 01 ------------ */

SELECT p.nome AS Nome_Perfil, c.titulo AS Titulo_Conteudo
FROM Avaliacao a JOIN Perfil p ON a.id_perfil = p.id JOIN Conteudo c ON a.id_conteudo = c.id
WHERE UPPER(a.comentario) LIKE '%AÇÃO%' OR UPPER(a.comentario) LIKE '%MELHOR%'


/* ------------ QUESTÃO 02 ------------ */

SELECT MAX(h.minutos_assistidos/c.duracao_minutos)*100 AS Porcentagem_Maxima_Assistida
FROM Perfil p JOIN Historico h ON p.id = h.id_perfil JOIN Conteudo c ON c.id = h.id_conteudo
WHERE UPPER(p.nome) = 'JOÃO' AND UPPER(c.titulo) = 'O RESGATE FINAL'

/* ------------ QUESTÃO 03 ------------ */

SELECT u.nome AS Nome_Usuario, u.email AS Email_Usuario
FROM Usuario u JOIN Assinatura assi ON u.id_assinatura = assi.id
WHERE assi.preco_mensal > (
    SELECT AVG(a.preco_mensal)
    FROM Assinatura a 
);

/* ------------ QUESTÃO 04 ------------ */

SELECT c.titulo AS Nome_Serie
FROM Conteudo c JOIN Temporada t ON t.id_conteudo = c.id
GROUP BY c.titulo HAVING MAX(t.numero) = (SELECT MAX(temp.numero) FROM Temporada temp)

/* ------------ QUESTÃO 05 ------------ */

SELECT u.nome AS Nome_Usuario, assi.nome AS Nome_Assinatura,
       assi.max_telas AS NumeroMaximoDeTelas, COUNT(p.id)  AS QuantidadeDePerfis

FROM Usuario u JOIN Assinatura assi ON assi.id = u.id_assinatura JOIN Perfil p ON p.id_usuario = u.id
GROUP BY u.nome,assi.nome,assi.max_telas HAVING COUNT(p.id) > assi.max_telas

/* ------------ QUESTÃO 06 ------------ */

SELECT DISTINCT u.nome AS Nome_Usuario, u.email AS Email_Usuario, c.titulo AS Titulo_Conteudo_Assistido
FROM Usuario u 
JOIN Assinatura assi ON u.id_assinatura = assi.id 
JOIN Perfil p ON p.id_usuario = u.id
JOIN Historico h ON h.id_perfil = p.id
JOIN Conteudo c ON h.id_conteudo = c.id 
JOIN Conteudo_Genero cg ON cg.id_conteudo = c.id
JOIN Genero g ON cg.id_genero = g.id
WHERE UPPER(assi.nome) = 'PREMIUM' AND UPPER(g.nome) = 'FICÇÃO CIENTÍFICA'


/* ------------ QUESTÃO 07 ------------ */

SELECT c.titulo AS Titulo_Serie, t.numero AS Numero_Da_Temporada, e.titulo AS Titulo_Episodio
FROM Conteudo c JOIN Temporada t ON c.id = t.id_conteudo JOIN Episodio e ON e.id_temporada = t.id
WHERE e.duracao_minutos > 60 OR e.descricao IS NULL
ORDER BY Titulo_Serie,Numero_Da_Temporada

/* ------------ QUESTÃO 08 ------------ */

CREATE VIEW  listarQualificacoesIndicativasEQtdConteudo AS
SELECT c.classificacao_indicativa AS Classificacao_Indicativa, COUNT(c.id) AS Quantidade_Filmes_Ou_Series
FROM Conteudo c 
GROUP BY c.classificacao_indicativa HAVING COUNT(c.id) > 1

/* ------------ QUESTÃO 09 ------------ */

CREATE VIEW listarNomePerfilAssistiuPeloMenos1EPTodasAsSeries AS
SELECT p.nome AS Nome_Perfil 
FROM Perfil p 
JOIN Historico h ON h.id_perfil = p.id
JOIN Episodio e ON h.id_episodio = e.id
JOIN Temporada t ON e.id_temporada = t.id
JOIN Conteudo c ON t.id_conteudo = c.id
GROUP BY p.id,p.nome HAVING COUNT(DISTINCT c.id) = (SELECT COUNT(co.id) 
                                               FROM Conteudo co
                                               WHERE co.tipo = 'Serie')


/* ------------ QUESTÃO 10 ------------ */

CREATE VIEW listarNomeEFuncaoArtistasDoFilmeOResgateFinalComXPEmMaisDe1Genero AS
SELECT a.nome AS Nome_Artista,ca.funcao AS Funcao_Artista
FROM Conteudo_Artista ca 
JOIN Artista a ON ca.id_artista = a.id 
JOIN Conteudo c ON ca.id_conteudo = c.id
WHERE UPPER(c.titulo) = 'O RESGATE FINAL' AND (SELECT COUNT(DISTINCT cg.id_genero)
                                               FROM Conteudo_Artista coa
                                               JOIN Conteudo_Genero cg ON cg.id_conteudo = coa.id_conteudo
                                               WHERE coa.id_artista = a.id) >= 2











