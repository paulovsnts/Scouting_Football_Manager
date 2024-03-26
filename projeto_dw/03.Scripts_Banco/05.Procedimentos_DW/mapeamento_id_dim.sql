--Criação de uma tabela de mapeamento para id

/*É necessário fazer o mapeamento pois os ids das dimensões
  não são iguais aos códigos nas tabelas */

use projeto_football_scouting

CREATE TABLE MAPEAMENTO_LIGA (
    COD_LIGA VARCHAR(10) PRIMARY KEY,
    ID_LIGA INT,
    FOREIGN KEY (ID_LIGA) REFERENCES DIM_LIGA (ID_LIGA)
)

CREATE TABLE MAPEAMENTO_TIME (
    COD_TIME INT PRIMARY KEY,
    ID_TIME INT,
    FOREIGN KEY (ID_TIME) REFERENCES DIM_TIME (ID_TIME)
)

CREATE TABLE MAPEAMENTO_JOGADOR (
    COD_JOGADOR INT PRIMARY KEY,
    ID_JOGADOR INT,
    FOREIGN KEY (ID_JOGADOR) REFERENCES DIM_JOGADOR (ID_JOGADOR)
)

--Preenchimento das tabelas de mapeamento
CREATE OR ALTER PROCEDURE sp_Preencher_Tabelas_Mapeamento
AS
BEGIN
	DECLARE @cod_liga varchar(10), @id_liga int,
			@cod_time int, @id_time int,
			@cod_jogador int, @id_jogador int

    -- Cursor para preencher a tabela de mapeamento para ligas
    DECLARE c_liga CURSOR FOR
    SELECT COD_LIGA, ID_LIGA 
    FROM DIM_LIGA

    OPEN c_liga
    FETCH NEXT FROM c_liga INTO @cod_liga, @id_liga

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM MAPEAMENTO_LIGA WHERE COD_LIGA = @cod_liga)
        BEGIN
            INSERT INTO MAPEAMENTO_LIGA(COD_LIGA, ID_LIGA) VALUES (@cod_liga, @id_liga)
        END
        FETCH NEXT FROM c_liga INTO @cod_liga, @id_liga
    END

    CLOSE c_liga
    DEALLOCATE c_liga

    -- Cursor para preencher a tabela de mapeamento para times
    DECLARE c_time CURSOR FOR
    SELECT COD_TIME, ID_TIME 
    FROM DIM_TIME

    OPEN c_time
    FETCH NEXT FROM c_time INTO @cod_time, @id_time

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM MAPEAMENTO_TIME WHERE COD_TIME = @cod_time)
        BEGIN
            INSERT INTO MAPEAMENTO_TIME(COD_TIME, ID_TIME) VALUES (@cod_time, @id_time)
        END
        FETCH NEXT FROM c_time INTO @cod_time, @id_time
    END

    CLOSE c_time
    DEALLOCATE c_time

    -- Cursor para preencher a tabela de mapeamento para jogadores
    DECLARE c_jogador CURSOR FOR
    SELECT COD_JOGADOR, ID_JOGADOR 
    FROM DIM_JOGADOR

    OPEN c_jogador
    FETCH NEXT FROM c_jogador INTO @cod_jogador, @id_jogador

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM MAPEAMENTO_JOGADOR WHERE COD_JOGADOR = @cod_jogador)
        BEGIN
            INSERT INTO MAPEAMENTO_JOGADOR(COD_JOGADOR, ID_JOGADOR) VALUES (@cod_jogador, @id_jogador)
        END
        FETCH NEXT FROM c_jogador INTO @cod_jogador, @id_jogador
    END

    CLOSE c_jogador
    DEALLOCATE c_jogador
END

exec sp_Preencher_Tabelas_Mapeamento