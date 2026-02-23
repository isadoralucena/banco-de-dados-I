CREATE SEQUENCE seq_assinatura START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_usuario START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_perfil START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_conteudo START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_temporada START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_episodio START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_genero START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_artista START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_avaliacao START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_historico START WITH 1 INCREMENT BY 1;

CREATE TABLE Assinatura (
    id NUMBER DEFAULT seq_assinatura.NEXTVAL NOT NULL,
    nome VARCHAR2(50) NOT NULL,
    preco_mensal NUMBER(10, 2) NOT NULL,
    max_resolucao VARCHAR2(20) NOT NULL,
    max_telas NUMBER NOT NULL,
    CONSTRAINT pk_assinatura PRIMARY KEY (id),
    CONSTRAINT ck_assinatura_resolucao CHECK (max_resolucao IN ('480p', '720p', '1080p', '4K'))
);

CREATE TABLE Usuario (
    id NUMBER DEFAULT seq_usuario.NEXTVAL NOT NULL,
    id_assinatura NUMBER NOT NULL,
    nome VARCHAR2(150) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    senha VARCHAR2(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    data_cadastro DATE NOT NULL,
    CONSTRAINT pk_usuario PRIMARY KEY (id),
    CONSTRAINT fk_usuario_assinatura FOREIGN KEY (id_assinatura) REFERENCES Assinatura(id),
    CONSTRAINT ck_usuario_email UNIQUE (email)
);

CREATE TABLE Perfil (
    id NUMBER DEFAULT seq_perfil.NEXTVAL NOT NULL,
    id_usuario NUMBER NOT NULL,
    nome VARCHAR2(50) NOT NULL,
    url_img_avatar VARCHAR2(255),
    restricao_idade VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_perfil PRIMARY KEY (id),
    CONSTRAINT fk_perfil_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id),
    CONSTRAINT ck_perfil_restricao CHECK (restricao_idade IN ('Livre', '10', '12', '14', '16', '18'))
);

CREATE TABLE Conteudo (
    id NUMBER DEFAULT seq_conteudo.NEXTVAL NOT NULL,
    titulo VARCHAR2(200) NOT NULL,
    sinopse VARCHAR2(4000),
    ano_lancamento NUMBER(4) NOT NULL,
    classificacao_indicativa VARCHAR2(10) NOT NULL,
    tipo VARCHAR2(20) NOT NULL,
    duracao_minutos NUMBER,
    CONSTRAINT pk_conteudo PRIMARY KEY (id),
    CONSTRAINT ck_conteudo_tipo CHECK (tipo IN ('Filme', 'Serie')), 
    CONSTRAINT ck_conteudo_classificacao CHECK (classificacao_indicativa IN ('Livre', '10', '12', '14', '16', '18')),
    CONSTRAINT ck_conteudo_duracao CHECK ( 
        (tipo = 'Filme' AND duracao_minutos IS NOT NULL) OR 
        (tipo = 'Serie' AND duracao_minutos IS NULL)
    )
);

CREATE TABLE Temporada (
    id NUMBER DEFAULT seq_temporada.NEXTVAL NOT NULL,
    id_conteudo NUMBER NOT NULL,
    numero NUMBER NOT NULL,
    titulo VARCHAR2(150),
    data_de_lancamento DATE,
    CONSTRAINT pk_temporada PRIMARY KEY (id),
    CONSTRAINT fk_temporada_conteudo FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id)
);

CREATE TABLE Episodio (
    id NUMBER DEFAULT seq_episodio.NEXTVAL NOT NULL,
    id_temporada NUMBER NOT NULL,
    numero NUMBER NOT NULL,
    titulo VARCHAR2(150) NOT NULL,
    descricao VARCHAR2(4000),
    duracao_minutos NUMBER NOT NULL,
    CONSTRAINT pk_episodio PRIMARY KEY (id),
    CONSTRAINT fk_episodio_temporada FOREIGN KEY (id_temporada) REFERENCES Temporada(id)
);

CREATE TABLE Genero (
    id NUMBER DEFAULT seq_genero.NEXTVAL NOT NULL,
    nome VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_genero PRIMARY KEY (id)
);

CREATE TABLE Conteudo_Genero (
    id_conteudo NUMBER NOT NULL,
    id_genero NUMBER NOT NULL,
    CONSTRAINT pk_conteudo_genero PRIMARY KEY (id_conteudo, id_genero),
    CONSTRAINT fk_cg_conteudo FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id),
    CONSTRAINT fk_cg_genero FOREIGN KEY (id_genero) REFERENCES Genero(id)
);

CREATE TABLE Artista (
    id NUMBER DEFAULT seq_artista.NEXTVAL NOT NULL,
    nome VARCHAR2(150) NOT NULL,
    data_nascimento DATE,
    biografia VARCHAR2(4000),
    CONSTRAINT pk_artista PRIMARY KEY (id)
);

CREATE TABLE Conteudo_Artista (
    id_conteudo NUMBER NOT NULL,
    id_artista NUMBER NOT NULL,
    funcao VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_conteudo_artista PRIMARY KEY (id_conteudo, id_artista, funcao),
    CONSTRAINT fk_ca_conteudo FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id),
    CONSTRAINT fk_ca_artista FOREIGN KEY (id_artista) REFERENCES Artista(id)
);

CREATE TABLE Avaliacao (
    id NUMBER DEFAULT seq_avaliacao.NEXTVAL NOT NULL,
    id_perfil NUMBER NOT NULL,
    id_conteudo NUMBER NOT NULL,
    nota NUMBER NOT NULL,
    comentario VARCHAR2(4000),
    data DATE NOT NULL,
    CONSTRAINT pk_avaliacao PRIMARY KEY (id),
    CONSTRAINT fk_avaliacao_perfil FOREIGN KEY (id_perfil) REFERENCES Perfil(id),
    CONSTRAINT fk_avaliacao_conteudo FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id),
    CONSTRAINT ck_avaliacao_nota CHECK (nota >= 1 AND nota <= 5)
);

CREATE TABLE Historico (
    id NUMBER DEFAULT seq_historico.NEXTVAL NOT NULL,
    id_perfil NUMBER NOT NULL,
    id_conteudo NUMBER, 
    id_episodio NUMBER, 
    data_hora TIMESTAMP NOT NULL,
    minutos_assistidos NUMBER NOT NULL,
    CONSTRAINT pk_historico PRIMARY KEY (id),
    CONSTRAINT fk_historico_perfil FOREIGN KEY (id_perfil) REFERENCES Perfil(id),
    CONSTRAINT fk_historico_conteudo FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id),
    CONSTRAINT fk_historico_episodio FOREIGN KEY (id_episodio) REFERENCES Episodio(id),
    CONSTRAINT ck_historico_referencia CHECK (
        (id_conteudo IS NOT NULL AND id_episodio IS NULL) OR 
        (id_conteudo IS NULL AND id_episodio IS NOT NULL)
    )
);