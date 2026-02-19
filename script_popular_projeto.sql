-- =========================================
-- ASSINATURAS
-- =========================================

INSERT INTO ASSINATURA VALUES (SEQ_ASSINATURA.NEXTVAL, 'BASICO', 29.90, '720P', 1);
INSERT INTO ASSINATURA VALUES (SEQ_ASSINATURA.NEXTVAL, 'PADRAO', 39.90, '1080P', 2);
INSERT INTO ASSINATURA VALUES (SEQ_ASSINATURA.NEXTVAL, 'PREMIUM', 59.90, '4K', 4);

-- =========================================
-- USUARIOS
-- =========================================

INSERT INTO USUARIO VALUES (
    SEQ_USUARIO.NEXTVAL,
    'Lukas',
    'lukas@email.com',
    'hash1',
    DATE '2000-01-01',
    SYSDATE,
    1
);

INSERT INTO USUARIO VALUES (
    SEQ_USUARIO.NEXTVAL,
    'Ana',
    'ana@email.com',
    'hash2',
    DATE '1998-05-10',
    SYSDATE,
    2
);

INSERT INTO USUARIO VALUES (
    SEQ_USUARIO.NEXTVAL,
    'Carlos',
    'carlos@email.com',
    'hash3',
    DATE '1995-09-20',
    SYSDATE,
    3
);

-- =========================================
-- PERFIS
-- =========================================

INSERT INTO PERFIL VALUES (SEQ_PERFIL.NEXTVAL, 'Perfil Lukas 1', NULL, 'L', 1);
INSERT INTO PERFIL VALUES (SEQ_PERFIL.NEXTVAL, 'Perfil Lukas 2', NULL, '12', 1);
INSERT INTO PERFIL VALUES (SEQ_PERFIL.NEXTVAL, 'Perfil Ana', NULL, '14', 2);
INSERT INTO PERFIL VALUES (SEQ_PERFIL.NEXTVAL, 'Perfil Carlos', NULL, '16', 3);

-- =========================================
-- GENEROS
-- =========================================

INSERT INTO GENERO VALUES (SEQ_GENERO.NEXTVAL, 'ACAO');
INSERT INTO GENERO VALUES (SEQ_GENERO.NEXTVAL, 'DRAMA');
INSERT INTO GENERO VALUES (SEQ_GENERO.NEXTVAL, 'COMEDIA');

-- =========================================
-- ARTISTAS
-- =========================================

INSERT INTO ARTISTA VALUES (SEQ_ARTISTA.NEXTVAL, 'Ator 1', DATE '1980-01-01', 'Biografia 1');
INSERT INTO ARTISTA VALUES (SEQ_ARTISTA.NEXTVAL, 'Ator 2', DATE '1985-05-05', 'Biografia 2');

-- =========================================
-- CONTEUDOS
-- =========================================

-- Filme A
INSERT INTO CONTEUDO VALUES (
    SEQ_CONTEUDO.NEXTVAL,
    'Filme A',
    'Sinopse Filme A',
    2023,
    '12',
    'FILME',
    120
);

-- Filme B
INSERT INTO CONTEUDO VALUES (
    SEQ_CONTEUDO.NEXTVAL,
    'Filme B',
    'Sinopse Filme B',
    2021,
    '14',
    'FILME',
    90
);

-- Serie X
INSERT INTO CONTEUDO VALUES (
    SEQ_CONTEUDO.NEXTVAL,
    'Serie X',
    'Sinopse Serie X',
    2022,
    '16',
    'SERIE',
    NULL
);

-- =========================================
-- RELACAO CONTEUDO_GENERO
-- =========================================

INSERT INTO CONTEUDO_GENERO VALUES (1, 1);
INSERT INTO CONTEUDO_GENERO VALUES (1, 2);
INSERT INTO CONTEUDO_GENERO VALUES (2, 3);
INSERT INTO CONTEUDO_GENERO VALUES (3, 1);

-- =========================================
-- RELACAO CONTEUDO_ARTISTA
-- =========================================

INSERT INTO CONTEUDO_ARTISTA VALUES (1, 1, 'Ator Principal');
INSERT INTO CONTEUDO_ARTISTA VALUES (3, 2, 'Diretor');

-- =========================================
-- TEMPORADAS (Serie X)
-- =========================================

INSERT INTO TEMPORADA VALUES (SEQ_TEMPORADA.NEXTVAL, 1, 'Temporada 1', DATE '2022-01-01', 3);
INSERT INTO TEMPORADA VALUES (SEQ_TEMPORADA.NEXTVAL, 2, 'Temporada 2', DATE '2023-01-01', 3);

-- =========================================
-- EPISODIOS
-- =========================================

INSERT INTO EPISODIO VALUES (SEQ_EPISODIO.NEXTVAL, 1, 'Ep 1', 45, 'Descricao 1', 1);
INSERT INTO EPISODIO VALUES (SEQ_EPISODIO.NEXTVAL, 2, 'Ep 2', 50, 'Descricao 2', 1);
INSERT INTO EPISODIO VALUES (SEQ_EPISODIO.NEXTVAL, 1, 'Ep 1 T2', 48, 'Descricao T2', 2);

-- =========================================
-- HISTORICO
-- =========================================

-- Assistindo Filme A
INSERT INTO HISTORICO VALUES (SEQ_HISTORICO.NEXTVAL, SYSTIMESTAMP, 100, NULL, 1, 1);

-- Assistindo Episodio
INSERT INTO HISTORICO VALUES (SEQ_HISTORICO.NEXTVAL, SYSTIMESTAMP, 30, 1, NULL, 2);

-- =========================================
-- AVALIACOES
-- =========================================

INSERT INTO AVALIACAO VALUES (SEQ_AVALIACAO.NEXTVAL, 5, 'Excelente!', SYSDATE, 1, 1);
INSERT INTO AVALIACAO VALUES (SEQ_AVALIACAO.NEXTVAL, 4, 'Muito bom', SYSDATE, 2, 3);

COMMIT;
