--scripts para cria��o da �rea de staging

use projeto_football_scouting

CREATE TABLE TB_AUX_LIGA (
	DATA_CARGA DATETIME NOT NULL,
    COD_LIGA VARCHAR(10) NOT NULL,
    LIGA VARCHAR(50) NOT NULL,
    PAIS VARCHAR(50) NOT NULL,
    NR_CLUBS INT NOT NULL,
    VALOR_MERCADO VARCHAR(50) NOT NULL,
	MEDIA_VALOR_MERCADO VARCHAR(50) NOT NULL,
    CONFERENCIA VARCHAR(50) NOT NULL
)

CREATE TABLE TB_AUX_TIME (
	DATA_CARGA DATETIME NOT NULL,
    COD_TIME INT NOT NULL,
    NOME_TIME VARCHAR(100) NOT NULL,
    PAIS VARCHAR(100) NOT NULL,
    NR_JOGADORES INT NOT NULL,
    VALOR_MERCADO VARCHAR(50) NOT NULL,
    COD_LIGA VARCHAR(10) NOT NULL
)

CREATE TABLE TB_AUX_JOGADOR (
	DATA_CARGA DATETIME NOT NULL,
    COD_JOGADOR INT NOT NULL,
    NOME VARCHAR(100) NOT NULL,
    DT_NASCIMENTO VARCHAR(50) NOT NULL,
    ALTURA VARCHAR(20) NOT NULL,
    NACIONALIDADE VARCHAR(50) NOT NULL,
    PE_BOM VARCHAR(20) NOT NULL,
	POSICAO VARCHAR(50) NOT NULL,
    VALOR_DE_MERCADO VARCHAR(50) NOT NULL,
    COD_TIME INT NULL,
    COD_STATS INT NOT NULL
) 

CREATE TABLE TB_AUX_CONTRATACAO (
	DATA_CARGA DATETIME NOT NULL,
    COD_CONTRATACAO INT NOT NULL,
    VALOR VARCHAR(50) NOT NULL,
    DT_CONTRATACAO VARCHAR(50) NOT NULL,
	TIME_ORIGEM VARCHAR(100) NOT NULL,
	TIME_DESTINO VARCHAR(100) NOT NULL,
	TEMPORADA VARCHAR(50) NOT NULL,
    COD_JOGADOR INT NOT NULL,
    COD_TIME INT NULL
)

CREATE TABLE TB_AUX_STATS (
	DATA_CARGA DATETIME NOT NULL,
	ID_TIME INT NOT NULL,
	ID_LIGA INT NOT NULL,
	ID_JOGADOR INT NOT NULL,
	ID_TEMPO BIGINT NOT NULL,
    COD_STATS INT NOT NULL,
    GOLS INT NOT NULL,
    ASSISTENCIAS INT NOT NULL,
    JOGOS INT NOT NULL,
    MINUTOS_JOGADOS INT NOT NULL,
    CARTOES_AMARELOS INT NOT NULL,
    CARTOES_VERMELHOS INT NOT NULL,
    CLEAN_SHEETS INT NOT NULL,
    TEMPORADA VARCHAR(20) NOT NULL
)