--Scripts para carga da dimensão time

use projeto_football_scouting

CREATE OR ALTER PROCEDURE sp_dim_time (@data_carga DATETIME)
AS
BEGIN
    DECLARE @cod_time INT, @nome_time VARCHAR(100), @pais VARCHAR(100),
			@nr_jogadores INT, @valor_mercado DECIMAL(18,2), @cod_liga VARCHAR(10)

    DECLARE c_times CURSOR FOR
    SELECT COD_TIME, NOME_TIME, PAIS, NR_JOGADORES, VALOR_MERCADO, COD_LIGA
    FROM TB_AUX_TIME
    WHERE DATA_CARGA = @data_carga

    OPEN c_times

    FETCH NEXT FROM c_times INTO @cod_time, @nome_time, @pais, @nr_jogadores, @valor_mercado, @cod_liga

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF EXISTS (SELECT 1 FROM DIM_TIME WHERE COD_TIME = @cod_time)
        BEGIN
            UPDATE DIM_TIME
            SET
                NOME_TIME = @nome_time,
                PAIS = @pais,
                NR_JOGADORES = @nr_jogadores,
                VALOR_MERCADO = @valor_mercado,
                COD_LIGA = @cod_liga
            WHERE COD_TIME = @cod_time
        END
        ELSE
        BEGIN
            INSERT INTO DIM_TIME (COD_TIME, NOME_TIME, PAIS, NR_JOGADORES, VALOR_MERCADO, COD_LIGA)
            VALUES (@cod_time, @nome_time, @pais, @nr_jogadores, @valor_mercado, @cod_liga)
        END

        FETCH NEXT FROM c_times INTO @cod_time, @nome_time, @pais, @nr_jogadores, @valor_mercado, @cod_liga
    END

    CLOSE c_times
    DEALLOCATE c_times
END

exec sp_dim_time '20240325'

select *from DIM_TIME