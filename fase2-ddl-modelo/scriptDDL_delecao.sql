-------------------------------------------------------------------------------- DROP das Tabelas -------------------------------------------------------------------------------------------------

-- Tabelas de relação M:N
DROP TABLE Artista_Conteudo CASCADE CONSTRAINTS;
DROP TABLE Genero_Conteudo CASCADE CONSTRAINTS;

-- Tabelas Dependentes
DROP TABLE Avaliacao CASCADE CONSTRAINTS;
DROP TABLE Historico CASCADE CONSTRAINTS;
DROP TABLE Episodio CASCADE CONSTRAINTS;
DROP TABLE Temporada CASCADE CONSTRAINTS;
DROP TABLE Perfil CASCADE CONSTRAINTS;

-- Tabelas principais
DROP TABLE Conteudo CASCADE CONSTRAINTS;
DROP TABLE Usuario CASCADE CONSTRAINTS;
DROP TABLE Assinatura CASCADE CONSTRAINTS;
DROP TABLE Artista CASCADE CONSTRAINTS;
DROP TABLE Genero CASCADE CONSTRAINTS;

---------------------------------------------------------------------------- DROP das Sequences -------------------------------------------------------------------------------------------------

DROP SEQUENCE seq_assinatura;
DROP SEQUENCE seq_usuario;
DROP SEQUENCE seq_conteudo;
DROP SEQUENCE seq_artista;
DROP SEQUENCE seq_genero;
DROP SEQUENCE seq_temporada;
DROP SEQUENCE seq_episodio;
DROP SEQUENCE seq_perfil;
DROP SEQUENCE seq_historico;
DROP SEQUENCE seq_avaliacao;
