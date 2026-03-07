DROP TABLE Elenco;
DROP TABLE Categoria;
DROP TABLE Historico;
DROP TABLE Avaliacao;
DROP TABLE Episodio;
DROP TABLE Temporada;
DROP TABLE Conteudo;
DROP TABLE Perfil;
DROP TABLE Usuario;
DROP TABLE Assinatura;
DROP TABLE Artista;
DROP TABLE Genero;


DROP SEQUENCE seqAssinatura;
DROP SEQUENCE seqGenero;
DROP SEQUENCE seqArtista;
DROP SEQUENCE seqEpisodio;
DROP SEQUENCE seqTemporada;
DROP SEQUENCE seqConteudo;
DROP SEQUENCE seqAvaliacao;
DROP SEQUENCE seqHistorico;
DROP SEQUENCE seqPerfil;
DROP SEQUENCE seqUsuario;

CREATE SEQUENCE seqAssinatura START WITH 1 INCREMENT BY 1 ;
CREATE SEQUENCE seqGenero START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seqArtista START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seqEpisodio START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seqTemporada START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seqConteudo START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seqAvaliacao START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seqHISTORICO START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seqPerfil START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seqUsuario START WITH 1 INCREMENT BY 1;



CREATE TABLE Elenco(
    Id_conteudo NUMBER,
    Id_artista NUMBER,
    funcao VARCHAR2(100) NOT NULL,

    CONSTRAINT pk_elenco PRIMARY KEY(Id_conteudo, Id_artista)

);

CREATE TABLE Categoria(
    Id_conteudo NUMBER,
    Id_genero NUMBER,

    CONSTRAINT pk_categoria PRIMARY KEY(Id_conteudo,Id_genero)

);

CREATE TABLE Genero(
    nome VARCHAR2(50) NOT NULL,
    Id_genero NUMBER DEFAULT seqGenero.NEXTVAL,

    CONSTRAINT pk_genero PRIMARY KEY(Id_genero)
);

CREATE TABLE Artista(
    biografia VARCHAR2(500) NOT NULL,
    data_nascimento DATE NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    Id_artista NUMBER DEFAULT seqArtista.NEXTVAL,

    CONSTRAINT pk_artista PRIMARY KEY(Id_artista)
);

CREATE TABLE Assinatura(
    max_telas NUMBER,
    max_resolucao NUMBER,
    preco_mensal NUMBER,
    nome VARCHAR2(100) NOT NULL,
    Id_assinatura NUMBER DEFAULT seqAssinatura.NEXTVAL,

    CONSTRAINT pk_assinatura PRIMARY KEY (Id_assinatura)

);

CREATE TABLE Usuario(
    data_cadastro DATE NOT NULL,
    data_nascimento DATE NOT NULL,
    senha VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    Id_usuario NUMBER DEFAULT seqUsuario.NEXTVAL,
    Id_assinatura NUMBER,


    CONSTRAINT pk_usuario PRIMARY KEY (Id_usuario),
    CONSTRAINT email_un UNIQUE(email)
);


CREATE TABLE Perfil(
    restricao_idade NUMBER,
    url_img_avatar VARCHAR2(200) NOT NULL,
    nome VARCHAR2(100) NOT NULL,

    Id_perfil NUMBER DEFAULT seqPerfil.NEXTVAL,
    Id_usuario NUMBER NOT NULL,

    CONSTRAINT pk_perfil PRIMARY KEY(Id_perfil)
);

CREATE TABLE Conteudo(
    duracao_minutos NUMBER,
    tipo VARCHAR2(100) NOT NULL,
    classificacao_indicativa NUMBER,
    ano_lancamento NUMBER,
    sinopse VARCHAR2(500) NOT NULL,
    titulo VARCHAR2(100) NOT NULL,

    Id_conteudo NUMBER DEFAULT seqConteudo.NEXTVAL,

    CONSTRAINT pk_Conteudo PRIMARY KEY(Id_conteudo)
);

CREATE TABLE Temporada(
    data_de_lancamento DATE NOT NULL,
    titulo VARCHAR2(100) NOT NULL,
    numero NUMBER,
    Id_temporada NUMBER DEFAULT seqTemporada.NEXTVAL,
    Id_conteudo NUMBER NOT NULL,

    CONSTRAINT pk_temporada PRIMARY KEY(Id_temporada)
);

CREATE TABLE Episodio(
    duracao_minutos NUMBER,
    descricao VARCHAR2(300) NOT NULL,
    numero_ep NUMBER,
    Id_episodio NUMBER DEFAULT seqEpisodio.NEXTVAL,
    Id_temporada NUMBER NOT NULL,

    CONSTRAINT pk_episodio PRIMARY KEY(Id_episodio)

);

CREATE TABLE Avaliacao(
    data_avaliacao DATE NOT NULL,
    comentario VARCHAR2(500),
    nota_avaliacao NUMBER,
    Id_avaliacao NUMBER DEFAULT seqAvaliacao.NEXTVAL,
    Id_perfil NUMBER NOT NULL,
    Id_conteudo NUMBER NOT NULL,
    
    CONSTRAINT pk_avaliacao PRIMARY KEY(Id_avaliacao),
    CONSTRAINT avaliacao_valida CHECK (nota_avaliacao >= 0 AND nota_avaliacao <=  5),
    CONSTRAINT unique_avaliacao UNIQUE(Id_perfil,Id_conteudo)

);

CREATE TABLE Historico(
    minutos_assistidos NUMBER,
    data_hora DATE NOT NULL,
    Id_historico NUMBER DEFAULT seqHistorico.NEXTVAL,
    Id_episodio NUMBER,
    Id_conteudo NUMBER ,
    Id_perfil NUMBER ,

    CONSTRAINT pk_historico PRIMARY KEY(Id_historico),
    CONSTRAINT ck_historico_xor(epOuConteudo) CHECK ( (Id_episodio IS NULL AND Id_conteudo IS NOT NULL) OR (Id_episodio IS NOT NULL AND Id_conteudo IS NULL) )

);

ALTER TABLE Perfil ADD CONSTRAINT fk_perfil_usuario FOREIGN KEY(Id_usuario) REFERENCES Usuario(Id_usuario);
ALTER TABLE Usuario ADD CONSTRAINT fk_usuario_assinatura FOREIGN KEY(Id_assinatura) REFERENCES Assinatura(Id_assinatura);
ALTER TABLE Temporada ADD CONSTRAINT fk_temporada_conteudo FOREIGN KEY(Id_conteudo) REFERENCES Conteudo(Id_conteudo);
ALTER TABLE Episodio ADD CONSTRAINT fk_episodio_temporada FOREIGN KEY(Id_temporada) REFERENCES Temporada(Id_temporada);
ALTER TABLE Avaliacao ADD CONSTRAINT fk_avaliacao_perfil FOREIGN KEY(Id_perfil) REFERENCES Perfil(Id_perfil);
ALTER TABLE Avaliacao ADD CONSTRAINT fk_avaliacao_conteudo FOREIGN KEY(Id_conteudo) REFERENCES Conteudo(Id_conteudo);
ALTER TABLE Historico ADD CONSTRAINT fk_historico_episodio FOREIGN KEY(Id_episodio) REFERENCES Episodio(Id_episodio);
ALTER TABLE Historico ADD CONSTRAINT fk_historico_conteudo FOREIGN KEY(Id_conteudo) REFERENCES Conteudo(Id_conteudo);
ALTER TABLE Historico ADD CONSTRAINT fk_historico_perfil FOREIGN KEY(Id_perfil) REFERENCES Perfil(Id_perfil);

ALTER TABLE Categoria ADD CONSTRAINT fk_categoria_conteudo FOREIGN KEY(Id_conteudo) REFERENCES Conteudo(Id_conteudo);
ALTER TABLE Categoria ADD CONSTRAINT fk_categoria_genero FOREIGN KEY(Id_genero) REFERENCES Genero(Id_genero);

ALTER TABLE Elenco ADD CONSTRAINT fk_elenco_conteudo FOREIGN KEY(Id_conteudo) REFERENCES Conteudo(Id_conteudo);
ALTER TABLE Elenco ADD CONSTRAINT fk_elenco_artista  FOREIGN KEY(Id_artista) REFERENCES Artista(Id_artista);









