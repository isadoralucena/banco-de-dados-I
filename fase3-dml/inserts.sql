-- ASSINATURA
INSERT INTO Assinatura (nome, preco_mensal, max_resolucao, max_telas)
VALUES ('Basico', 19.90, '720p', 1);

INSERT INTO Assinatura (nome, preco_mensal, max_resolucao, max_telas)
VALUES ('Padrao', 29.90, '1080p', 2);

INSERT INTO Assinatura (nome, preco_mensal, max_resolucao, max_telas)
VALUES ('Premium', 39.90, '4K', 4);


-- USUARIO
INSERT INTO Usuario (id_assinatura, nome, email, senha, data_nascimento, data_cadastro)
VALUES (1, 'João Silva', 'joao@email.com', '123456', DATE '1995-03-10', SYSDATE);

INSERT INTO Usuario (id_assinatura, nome, email, senha, data_nascimento, data_cadastro)
VALUES (2, 'Maria Souza', 'maria@email.com', '123456', DATE '1990-07-21', SYSDATE);

INSERT INTO Usuario (id_assinatura, nome, email, senha, data_nascimento, data_cadastro)
VALUES (3, 'Lucas Andrade', 'lucas@email.com', '123456', DATE '1988-11-12', SYSDATE);

INSERT INTO Usuario (id_assinatura, nome, email, senha, data_nascimento, data_cadastro)
VALUES (3, 'Fernanda Lima', 'fernanda@email.com', '123456', DATE '1992-04-05', SYSDATE);

INSERT INTO Usuario (id_assinatura, nome, email, senha, data_nascimento, data_cadastro)
VALUES (3, 'Pedro Martins', 'pedro@email.com', '123456', DATE '1996-08-14', SYSDATE);


-- PERFIL
INSERT INTO Perfil (id_usuario, nome, url_img_avatar, restricao_idade)
VALUES (1, 'João', 'img/joao.png', '18');

INSERT INTO Perfil (id_usuario, nome, url_img_avatar, restricao_idade)
VALUES (1, 'Kids', 'img/kids.png', 'Livre');

INSERT INTO Perfil (id_usuario, nome, url_img_avatar, restricao_idade)
VALUES (2, 'Maria', 'img/maria.png', '16');

INSERT INTO Perfil (id_usuario, nome, url_img_avatar, restricao_idade)
VALUES (1, 'João Filme', 'img/joao_filme.png', '16');

INSERT INTO Perfil (id_usuario, nome, url_img_avatar, restricao_idade)
VALUES (1, 'João Series', 'img/joao_series.png', '16');

INSERT INTO Perfil (id_usuario, nome, url_img_avatar, restricao_idade)
VALUES (3, 'Lucas', 'img/lucas.png', '18');

INSERT INTO Perfil (id_usuario, nome, url_img_avatar, restricao_idade)
VALUES (4, 'Fernanda', 'img/fernanda.png', '14');

INSERT INTO Perfil (id_usuario, nome, url_img_avatar, restricao_idade)
VALUES (5, 'Pedro', 'img/pedro.png', '16');

INSERT INTO Perfil (id_usuario, nome, url_img_avatar, restricao_idade)
VALUES (5, 'MaratonaSeries', 'img/maratona.png', '16');

-- GENERO
INSERT INTO Genero (nome) VALUES ('Ação');
INSERT INTO Genero (nome) VALUES ('Drama');
INSERT INTO Genero (nome) VALUES ('Aventura');
INSERT INTO Genero (nome) VALUES ('Animação');
INSERT INTO Genero (nome) VALUES ('Comédia');
INSERT INTO Genero (nome) VALUES ('Ficção Científica');
INSERT INTO Genero (nome) VALUES ('Romance');
INSERT INTO Genero (nome) VALUES ('Terror');


-- CONTEUDO
INSERT INTO Conteudo (titulo, sinopse, ano_lancamento, classificacao_indicativa, tipo, duracao_minutos)
VALUES ('O Resgate Final', 'Michael já fugiu da prisão com seu irmão uma vez. Ele agora precisa traçar um plano para tirar sua esposa grávida da cadeia, antes que ela seja assassinada por outras detentas que querem receber um prêmio por sua cabeça.', 2009, '14', 'Filme', 123);

INSERT INTO Conteudo (titulo, sinopse, ano_lancamento, classificacao_indicativa, tipo, duracao_minutos)
VALUES ('Cidade Misteriosa', 'Segredos escondidos em uma pequena cidade.', 2021, '14', 'Serie', NULL);

INSERT INTO Conteudo (titulo, sinopse, ano_lancamento, classificacao_indicativa, tipo, duracao_minutos)
VALUES ('Galáxia Perdida', 'Exploradores viajam por um universo desconhecido.', 2020, '12', 'Filme', 110);

INSERT INTO Conteudo (titulo, sinopse, ano_lancamento, classificacao_indicativa, tipo, duracao_minutos)
VALUES ('Robôs do Amanhã', 'Humanos e máquinas entram em conflito.', 2023, '12', 'Serie', NULL);

INSERT INTO Conteudo (titulo, sinopse, ano_lancamento, classificacao_indicativa, tipo, duracao_minutos)
VALUES ('Ilha do Medo', 'Uma ilha guarda segredos assustadores.', 2019, '16', 'Serie', NULL);


-- TEMPORADA
INSERT INTO Temporada (id_conteudo, numero, titulo, data_de_lancamento)
VALUES (2, 1, 'Temporada 1', DATE '2021-05-01');

INSERT INTO Temporada (id_conteudo, numero, titulo, data_de_lancamento)
VALUES (2, 2, 'Temporada 2', DATE '2022-05-01');

INSERT INTO Temporada (id_conteudo, numero, titulo, data_de_lancamento)
VALUES (3, 1, 'Temporada 1', DATE '2023-03-01');

INSERT INTO Temporada (id_conteudo, numero, titulo, data_de_lancamento)
VALUES (3, 2, 'Temporada 2', DATE '2024-03-01');

INSERT INTO Temporada (id_conteudo, numero, titulo, data_de_lancamento)
VALUES (3, 3, 'Temporada 3', DATE '2025-03-01');

INSERT INTO Temporada (id_conteudo, numero, titulo, data_de_lancamento)
VALUES (4, 1, 'Temporada 1', DATE '2023-01-01');

INSERT INTO Temporada (id_conteudo, numero, titulo, data_de_lancamento)
VALUES (5, 1, 'Temporada 1', DATE '2019-06-01');

-- EPISODIOS
INSERT INTO Episodio (id_temporada, numero, titulo, descricao, duracao_minutos)
VALUES (1, 1, 'O Começo', 'Tudo começa com um desaparecimento.', 45);

INSERT INTO Episodio (id_temporada, numero, titulo, descricao, duracao_minutos)
VALUES (1, 2, 'O Segredo', 'Um segredo é revelado.', 47);

INSERT INTO Episodio (id_temporada, numero, titulo, descricao, duracao_minutos)
VALUES (2, 1, 'O Retorno', 'Mistérios continuam surgindo.', 65);

INSERT INTO Episodio (id_temporada, numero, titulo, descricao, duracao_minutos)
VALUES (3, 1, 'Primeiro Contato', NULL, 70);

INSERT INTO Episodio (id_temporada, numero, titulo, descricao, duracao_minutos)
VALUES (4, 1, 'A Ilha', 'Chegada ao local misterioso.', 50);

INSERT INTO Episodio (id_temporada, numero, titulo, descricao, duracao_minutos)
VALUES (6, 1, 'Episódio 1', 'Primeiro episódio', 55);

INSERT INTO Episodio (id_temporada, numero, titulo, descricao, duracao_minutos)
VALUES (7, 1, 'O Mistério da Ilha', 'Estranhos acontecimentos começam.', 52);

-- CONTEUDO_GENERO
INSERT INTO Conteudo_Genero (id_conteudo, id_genero)
VALUES (1, 4);

INSERT INTO Conteudo_Genero (id_conteudo, id_genero)
VALUES (2, 2);

INSERT INTO Conteudo_Genero (id_conteudo, id_genero)
VALUES (3, 6);

INSERT INTO Conteudo_Genero (id_conteudo, id_genero)
VALUES (4, 8);


-- ARTISTA
INSERT INTO Artista (nome, data_nascimento, biografia)
VALUES ('Carlos Mendes', DATE '1980-02-15', 'Ator brasileiro conhecido por filmes de ação.');

INSERT INTO Artista (nome, data_nascimento, biografia)
VALUES ('Ana Ribeiro', DATE '1985-09-10', 'Atriz premiada em series de drama.');

INSERT INTO Artista (nome, data_nascimento, biografia)
VALUES ('Ricardo Alves', DATE '1975-06-22', 'Diretor conhecido por filmes de ficção científica.');

INSERT INTO Artista (nome, data_nascimento, biografia)
VALUES ('Juliana Costa', DATE '1990-02-11', 'Atriz versátil de drama e ação.');


-- CONTEUDO_ARTISTA
INSERT INTO Conteudo_Artista (id_conteudo, id_artista, funcao)
VALUES (1, 1, 'Ator');

INSERT INTO Conteudo_Artista (id_conteudo, id_artista, funcao)
VALUES (2, 2, 'Atriz');

INSERT INTO Conteudo_Artista (id_conteudo, id_artista, funcao)
VALUES (1, 3, 'Diretor');

INSERT INTO Conteudo_Artista (id_conteudo, id_artista, funcao)
VALUES (3, 3, 'Diretor');

INSERT INTO Conteudo_Artista (id_conteudo, id_artista, funcao)
VALUES (4, 4, 'Atriz');

INSERT INTO Conteudo_Artista (id_conteudo, id_artista, funcao)
VALUES (1, 4, 'Atriz');


-- AVALIACAO
INSERT INTO Avaliacao (id_perfil, id_conteudo, nota, comentario, data)
VALUES (1, 1, 5, 'Excelente filme de ação! O melhor do gênero', SYSDATE);

INSERT INTO Avaliacao (id_perfil, id_conteudo, nota, comentario, data)
VALUES (3, 2, 4, 'Série muito interessante. A melhor que vi em toda a minha vida', SYSDATE);
INSERT INTO Avaliacao (id_perfil, id_conteudo, nota, comentario, data)
VALUES (3, 2, 4, 'O pior filme de ação que vi em toda a minha vida. Não assistam', SYSDATE);

-- HISTORICO
INSERT INTO Historico (id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (1, 1, NULL, SYSTIMESTAMP, 120);

INSERT INTO Historico (id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (1, NULL, 1, SYSTIMESTAMP, 30);

INSERT INTO Historico (id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (1, 1, NULL, SYSTIMESTAMP, 80);

INSERT INTO Historico (id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (4, 3, NULL, SYSTIMESTAMP, 90);

INSERT INTO Historico (id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (4, NULL, 3, SYSTIMESTAMP, 40);

INSERT INTO Historico (id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (8, 3, NULL, SYSTIMESTAMP, 95);

INSERT INTO Historico (id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (9, NULL, 1, SYSTIMESTAMP, 40);

INSERT INTO Historico (id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (9, NULL, 2, SYSTIMESTAMP, 50);

SELECT id, id_temporada FROM EPISODIO;
INSERT INTO Historico (id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (9, NULL, 3, SYSTIMESTAMP, 45);

INSERT INTO Historico (id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (9, NULL, 4, SYSTIMESTAMP, 45);

INSERT INTO Historico (id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (9, NULL, 5, SYSTIMESTAMP, 50); 

INSERT INTO Historico (id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (9, NULL, 7, SYSTIMESTAMP, 50);

INSERT INTO Historico (id_perfil, id_conteudo, id_episodio, data_hora, minutos_assistidos)
VALUES (9, NULL, 8, SYSTIMESTAMP, 50); 