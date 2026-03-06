-- 1. Exiba o nome dos perfis e o título do conteúdo que eles avaliaram, mas apenas se o comentário da avaliação contiver a palavra “Ação” ou “melhor”.
SELECT p.nome AS nome_perfil, c.titulo AS titulo_conteudo
FROM Avaliacao a
JOIN Perfil p ON a.id_perfil = p.id
JOIN Conteudo c ON a.id_conteudo = c.id
WHERE LOWER(a.comentario) LIKE '%ação%' OR LOWER(a.comentario) LIKE '%melhor%';

--2. Calcule e exiba a porcentagem máxima que o perfil “João” já assistiu do filme “O Resgate Final” em uma única sessão.
