--Scripts para carga da dimensão jogador

use projeto_football_scouting

CREATE OR ALTER PROCEDURE sp_dim_jogador (@data_carga DATETIME)
AS
BEGIN
    DECLARE @cod_jogador INT
    DECLARE @nome VARCHAR(100)
    DECLARE @dt_nascimento DATE
    DECLARE @dt_nascimento_datetime DATETIME 
    DECLARE @altura DECIMAL(10,2)
    DECLARE @nacionalidade VARCHAR(50)
    DECLARE @pe_bom VARCHAR(20)
    DECLARE @posicao VARCHAR(50)
    DECLARE @valor_de_mercado DECIMAL(18,2)
    DECLARE @cod_time INT

    DECLARE c_jogadores CURSOR FOR
    SELECT COD_JOGADOR, NOME, DT_NASCIMENTO, ALTURA, NACIONALIDADE, PE_BOM, POSICAO, VALOR_DE_MERCADO, COD_TIME
    FROM TB_AUX_JOGADOR
    WHERE DATA_CARGA = @data_carga

    OPEN c_jogadores

    FETCH NEXT FROM c_jogadores INTO @cod_jogador, @nome, @dt_nascimento, @altura, @nacionalidade, @pe_bom, @posicao, @valor_de_mercado, @cod_time

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @dt_nascimento_datetime = CONVERT(DATETIME, @dt_nascimento)

        IF EXISTS (SELECT 1 FROM DIM_JOGADOR WHERE COD_JOGADOR = @cod_jogador)
        BEGIN
            UPDATE DIM_JOGADOR
            SET
                NOME = @nome,
                DT_NASCIMENTO = @dt_nascimento_datetime, 
                ALTURA = @altura,
                NACIONALIDADE = @nacionalidade,
                PE_BOM = @pe_bom,
                POSICAO = @posicao,
                VALOR_DE_MERCADO = @valor_de_mercado,
                COD_TIME = @cod_time
            WHERE COD_JOGADOR = @cod_jogador
        END
        ELSE
        BEGIN
            INSERT INTO DIM_JOGADOR (COD_JOGADOR, NOME, DT_NASCIMENTO, ALTURA, NACIONALIDADE, PE_BOM, POSICAO, VALOR_DE_MERCADO, COD_TIME)
            VALUES (@cod_jogador, @nome, @dt_nascimento_datetime, @altura, @nacionalidade, @pe_bom, @posicao, @valor_de_mercado, @cod_time)
        END

        FETCH NEXT FROM c_jogadores INTO @cod_jogador, @nome, @dt_nascimento, @altura, @nacionalidade, @pe_bom, @posicao, @valor_de_mercado, @cod_time
    END

    CLOSE c_jogadores
    DEALLOCATE c_jogadores
END

exec sp_dim_jogador '20240325'

select *from DIM_JOGADOR