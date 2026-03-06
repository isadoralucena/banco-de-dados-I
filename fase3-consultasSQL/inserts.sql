-- 1. Assinaturas
INSERT INTO Assinatura (id, nome, preco_mensal, max_resolucao, max_telas)
VALUES (1, 'Básico', 25.90, '720p', 1);

INSERT INTO Assinatura (id, nome, preco_mensal, max_resolucao, max_telas)
VALUES (2, 'Padrão', 39.90, '1080p', 2);

INSERT INTO Assinatura (id, nome, preco_mensal, max_resolucao, max_telas)
VALUES (3, 'Premium', 55.90, '4K', 4);

-- 2. Usuários
INSERT INTO Usuario (id, id_assinatura, nome, email, senha, data_nascimento, data_cadastro)
VALUES (1, 3, 'João Silva', 'joao.silva@email.com', 'hashsenha123', DATE '1990-05-15', DATE '2024-01-10');

INSERT INTO Usuario (id, id_assinatura, nome, email, senha, data_nascimento, data_cadastro)
VALUES (2, 1, 'Maria Oliveira', 'maria.oliveira@email.com', 'hashsenha456', DATE '1995-08-22', DATE '2024-02-15');

-- 3. Perfis
INSERT INTO Perfil (id, id_usuario, nome, url_img_avatar, restricao_idade)
VALUES (1, 1, 'João', 'avatar1.png', '18');

INSERT INTO Perfil (id, id_usuario, nome, url_img_avatar, restricao_idade)
VALUES (2, 1, 'Kids', 'avatar_kids.png', '10');

INSERT INTO Perfil (id, id_usuario, nome, url_img_avatar, restricao_idade)
VALUES (3, 2, 'Maria', 'avatar2.png', '16');

-- 4. Conteúdos (Filmes e Séries)
INSERT INTO Conteudo (id, titulo, sinopse, ano_lancamento, classificacao_indicativa, tipo, duracao_minutos)
VALUES (1, 'Interestelar', 'Um grupo de exploradores viaja através de um buraco de minhoca no espaço.', 2014, '10', 'Filme', 169);

INSERT INTO Conteudo (id, titulo, sinopse, ano_lancamento, classificacao_indicativa, tipo, duracao_minutos)
VALUES (2, 'Breaking Bad', 'Um professor de química do ensino médio se torna produtor de metanfetamina.', 2008, '16', 'Serie', NULL);

INSERT INTO Conteudo (id, titulo, sinopse, ano_lancamento, classificacao_indicativa, tipo, duracao_minutos)
VALUES (3, 'Matrix', 'Um hacker descobre a verdadeira natureza de sua realidade.', 1999, '14', 'Filme', 136);

INSERT INTO Conteudo (id, titulo, sinopse, ano_lancamento, classificacao_indicativa, tipo, duracao_minutos)
VALUES (4, 'O Resgate Final', 'Um grupo de heróis tenta resgatar um cidadão sequestrado.', 2020, '14', 'Filme', 120);

-- 5. Temporadas
INSERT INTO Temporada (id, id_conteudo, numero, titulo, data_de_lancamento)
VALUES (1, 2, 1, 'Temporada 1', DATE '2008-01-20');

INSERT INTO Temporada (id, id_conteudo, numero, titulo, data_de_lancamento)
VALUES (2, 2, 2, 'Temporada 2', DATE '2009-03-08');

-- 6. Episódios
INSERT INTO Episodio (id, id_temporada, numero, titulo, descricao, duracao_minutos)
VALUES (1, 1, 1, 'Piloto', 'Walter White descobre que tem câncer e toma uma decisão radical.', 58);

INSERT INTO Episodio (id, id_temporada, numero, titulo, descricao, duracao_minutos)
VALUES (2, 1, 2, 'O Gato Está na Bolsa', 'Walter e Jesse tentam lidar com os traficantes Krazy-8 e Emilio.', 48);

-- 7. Gêneros
INSERT INTO Genero (id, nome) VALUES (1, 'Ficção Científica');
INSERT INTO Genero (id, nome) VALUES (2, 'Ação');
INSERT INTO Genero (id, nome) VALUES (3, 'Drama');
INSERT INTO Genero (id, nome) VALUES (4, 'Suspense');

-- 8. Conteúdo_Gênero
INSERT INTO Conteudo_Genero (id_conteudo, id_genero) VALUES (1, 1);
INSERT INTO Conteudo_Genero (id_conteudo, id_genero) VALUES (1, 3);
INSERT INTO Conteudo_Genero (id_conteudo, id_genero) VALUES (2, 3);
INSERT INTO Conteudo_Genero (id_conteudo, id_genero) VALUES (2, 4);
INSERT INTO Conteudo_Genero (id_conteudo, id_genero) VALUES (3, 1);
INSERT INTO Conteudo_Genero (id_conteudo, id_genero) VALUES (3, 2);
INSERT INTO Conteudo_Genero (id_conteudo, id_genero) VALUES (4, 2);
INSERT INTO Conteudo_Genero (id_conteudo, id_genero) VALUES (4, 4);

-- 9. Artistas
INSERT INTO Artista (id, nome, data_nascimento, biografia)
VALUES (1, 'Christopher Nolan', DATE '1970-07-30', 'Diretor, roteirista e produtor aclamado.');

INSERT INTO Artista (id, nome, data_nascimento, biografia)
VALUES (2, 'Matthew McConaughey', DATE '1969-11-04', 'Ator premiado com o Oscar de Melhor Ator.');

INSERT INTO Artista (id, nome, data_nascimento, biografia)
VALUES (3, 'Bryan Cranston', DATE '1956-03-07', 'Conhecido mundialmente por interpretar Walter White.');

INSERT INTO Artista (id, nome, data_nascimento, biografia)
VALUES (4, 'Keanu Reeves', DATE '1964-09-02', 'Ator famoso por franquias como Matrix e John Wick.');

-- 10. Conteúdo_Artista
INSERT INTO Conteudo_Artista (id_conteudo, id_artista, funcao) VALUES (1, 1, 'Diretor');
INSERT INTO Conteudo_Artista (id_conteudo, id_artista, funcao) VALUES (1, 2, 'Ator Principal');
INSERT INTO Conteudo_Artista (id_conteudo, id_artista, funcao) VALUES (2, 3, 'Ator Principal');
INSERT INTO Conteudo_Artista (id_conteudo, id_artista, funcao) VALUES (3, 4, 'Ator Principal');
INSERT INTO Conteudo_Artista (id_conteudo, id_artista, funcao) VALUES (4, 2, 'Ator Principal');

-- 11. Avaliações
INSERT INTO Avaliacao (id, id_perfil, id_conteudo, nota, comentario, data)
VALUES (1, 1, 1, 5, 'Uma obra-prima visual e narrativa absoluta!', DATE '2024-03-01');

INSERT INTO Avaliacao (id, id_perfil, id_conteudo, nota, comentario, data)
VALUES (2, 3, 2, 5, 'Com certeza a melhor série que já vi.', DATE '2024-03-02');

INSERT INTO Avaliacao (id, id_perfil, id_conteudo, nota, comentario, data)
VALUES (3, 1, 3, 4, 'Muito bom, efeitos revolucionários para a época. A ação é incrível!', DATE '2024-03-05');

INSERT INTO Avaliacao (id, id_perfil, id_conteudo, nota, comentario, data)
VALUES (4, 2, 4, 4, 'Filme emocionante com boas cenas de ação!', DATE '2024-03-03');

INSERT INTO Avaliacao (id, id_perfil, id_conteudo, nota, comentario, data)
VALUES (5, 1, 4, 5, 'Surpreendente e bem executado do início ao fim!', DATE '2024-03-06');

-- 12. Histórico
-- Para Filmes: id_conteudo é preenchido, id_episodio é NULL
INSERT INTO Historico (id, id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (1, 1, 1, NULL, TIMESTAMP '2024-03-01 20:30:00', 169);

INSERT INTO Historico (id, id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (2, 3, 3, NULL, TIMESTAMP '2024-03-04 15:00:00', 60);

INSERT INTO Historico (id, id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (5, 2, 4, NULL, TIMESTAMP '2024-03-03 19:00:00', 65);

INSERT INTO Historico (id, id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (6, 1, 4, NULL, TIMESTAMP '2024-03-06 22:15:00', 120);

-- Para Séries: id_conteudo é NULL, id_episodio é preenchido
INSERT INTO Historico (id, id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (3, 3, NULL, 1, TIMESTAMP '2024-03-02 21:00:00', 58);

INSERT INTO Historico (id, id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (4, 3, NULL, 2, TIMESTAMP '2024-03-02 22:00:00', 30);
