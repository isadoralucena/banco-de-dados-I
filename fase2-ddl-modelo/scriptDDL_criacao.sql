-- Criação das tabelas com suas CONTRAINTS, das SEQUENCES para cada PK e dos CHECKS necessários

CREATE TABLE Assinatura (
    id NUMBER NOT NULL,
    nome VARCHAR(100),
    preco_mensal NUMBER,
    max_resolucao NUMBER,
    max_telas NUMBER,

    CONSTRAINT pk_assinatura PRIMARY KEY (id),
    CONSTRAINT check_assinatura_preco CHECK (preco_mensal >= 0), --pode ser gratuito?
    CONSTRAINT ck_assinatura_telas CHECK (max_telas > 0)
);

CREATE SEQUENCE seq_assinatura
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;


CREATE TABLE Usuario (
    id NUMBER NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(200) NOT NULL,
    senha VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    data_cadastro DATE,
    id_Assinatura NUMBER NOT NULL,

    CONSTRAINT pk_usuario PRIMARY KEY (id),
    CONSTRAINT fk_usuario_assinatura 
        FOREIGN KEY (id_Assinatura) REFERENCES Assinatura(id)
);

CREATE SEQUENCE seq_usuario
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE TABLE Conteudo (
    id NUMBER NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    sinopse VARCHAR(1000),
    ano_lancamento NUMBER(4),
    classificacao_indicativa NUMBER,
    tipo VARCHAR(20) NOT NULL,
    duracao_minutos NUMBER,

    CONSTRAINT pk_conteudo PRIMARY KEY (id),
    CONSTRAINT check_conteudo_duracao CHECK (duracao_minutos > 0),
    CONSTRAINT check_conteudo_tipo CHECK (tipo IN ('FILME', 'SERIE'))
);

CREATE SEQUENCE seq_conteudo
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE TABLE Artista (
    id NUMBER NOT NULL,
    nome VARCHAR(100),
    data_nascimento DATE,
    biografia CLOB,

    CONSTRAINT pk_artista PRIMARY KEY (id)
);

CREATE SEQUENCE seq_artista
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE TABLE Genero (
    id NUMBER NOT NULL,
    nome VARCHAR(100) NOT NULL,

    CONSTRAINT pk_genero PRIMARY KEY (id)
);

CREATE SEQUENCE seq_genero
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE TABLE Temporada (
    id NUMBER NOT NULL,
    numero NUMBER NOT NULL,
    titulo VARCHAR(100),
    data_lancamento DATE,
    id_conteudo NUMBER NOT NULL,

    CONSTRAINT pk_temporada PRIMARY KEY (id),
    CONSTRAINT fk_temporada_conteudo
        FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id),
    CONSTRAINT check_temporada_numero CHECK (numero > 0) --se uma temporada for adicionada, ela deve ser a temporada 1 ou maior 
);

CREATE SEQUENCE seq_temporada
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE TABLE Episodio (
    id NUMBER NOT NULL,
    numero NUMBER NOT NULL,
    titulo VARCHAR(100),
    descricao VARCHAR(1000),
    duracao_minutos NUMBER,
    id_temporada NUMBER NOT NULL,

    CONSTRAINT pk_episodio PRIMARY KEY (id),
    CONSTRAINT fk_episodio_temporada
        FOREIGN KEY (id_temporada) REFERENCES Temporada(id)
        ON DELETE CASCADE,
    CONSTRAINT check_episodio_numero CHECK (numero > 0), --se um episodio for adicinado ele deve ser 1 ou maior
    CONSTRAINT check_episodio_duracao CHECK (duracao_minutos > 0)

);

CREATE SEQUENCE seq_episodio
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE TABLE Perfil (
    id NUMBER NOT NULL,
    nome VARCHAR(100) NOT NULL,
    url_img_avatar VARCHAR(500),
    restricao_idade NUMBER,
    id_usuario NUMBER NOT NULL,

    CONSTRAINT pk_perfil PRIMARY KEY (id),
    CONSTRAINT fk_perfil_usuario
        FOREIGN KEY (id_usuario) REFERENCES Usuario(id)
        ON DELETE CASCADE,
    CONSTRAINT check_perfil_restricao_idade CHECK (restricao_idade IN (0, 10, 12, 14, 16, 18)) --os valores de classificação indicativa que já vi

);

CREATE SEQUENCE seq_perfil
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;


CREATE TABLE Historico (
    id NUMBER NOT NULL,
    data_hora TIMESTAMP,
    minutos_assistidos NUMBER,
    id_conteudo NUMBER,
    id_episodio NUMBER,
    id_perfil NUMBER NOT NULL,

    CONSTRAINT pk_historico PRIMARY KEY (id),
    CONSTRAINT fk_historico_conteudo
        FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id),
    CONSTRAINT fk_historico_episodio
        FOREIGN KEY (id_episodio) REFERENCES Episodio(id),
    CONSTRAINT fk_historico_perfil
        FOREIGN KEY (id_perfil) REFERENCES Perfil(id)
        ON DELETE CASCADE,
    CONSTRAINT check_contem_conteudo_xor_episodio
        CHECK (
            (id_conteudo IS NOT NULL AND id_episodio IS NULL)
            OR (id_conteudo IS NULL AND id_episodio IS NOT NULL)
        ),
    CONSTRAINT check_historico_minutos CHECK (minutos_assistidos >= 0)
);

CREATE SEQUENCE seq_historico
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;


CREATE TABLE Avaliacao (
    id NUMBER NOT NULL,
    nota NUMBER NOT NULL,
    comentario VARCHAR (1000),
    data_avaliacao DATE NOT NULL,
    id_perfil NUMBER NOT NULL,
    id_conteudo NUMBER NOT NULL,

    CONSTRAINT pk_avaliacao PRIMARY KEY (id),
    CONSTRAINT fk_avaliacao_perfil
        FOREIGN KEY (id_perfil) REFERENCES Perfil(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_avaliacao_conteudo
        FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id),
    CONSTRAINT check_avaliacao_nota CHECK (nota BETWEEN 0 AND 5)

);

CREATE SEQUENCE seq_avaliacao
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE TABLE Artista_Conteudo (
    id_artista NUMBER NOT NULL,
    id_conteudo NUMBER NOT NULL,
    funcao VARCHAR(50) NOT NULL,

    CONSTRAINT pk_artista_conteudo PRIMARY KEY (id_artista, id_conteudo),
    CONSTRAINT fk_ac_artista
        FOREIGN KEY (id_artista) REFERENCES Artista(id),
    CONSTRAINT fk_ac_conteudo 
        FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id)
);

CREATE TABLE Genero_Conteudo (
    id_genero NUMBER NOT NULL,
    id_conteudo NUMBER NOT NULL,
    funcao VARCHAR(50) NOT NULL,

    CONSTRAINT pk_genero_conteudo PRIMARY KEY (id_genero, id_conteudo),
    CONSTRAINT fk_gc_genero
        FOREIGN KEY (id_genero) REFERENCES Genero(id),
    CONSTRAINT fk_gc_conteudo 
        FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id)
);

