--Script para carga do ambiente dimensional

use projeto_football_scouting

CREATE OR ALTER PROCEDURE sp_dim_liga (@data_carga DATETIME)
AS
BEGIN
    DECLARE @cod_liga VARCHAR(10), @liga VARCHAR(50), @pais VARCHAR(50),
		    @nr_clubs INT, @valor_mercado VARCHAR(50), @media_valor_mercado DECIMAL(18,2),
		    @conferencia VARCHAR(50)

    DECLARE c_ligas CURSOR FOR
    SELECT COD_LIGA, LIGA, PAIS, NR_CLUBS, VALOR_MERCADO, MEDIA_VALOR_MERCADO, CONFERENCIA
    FROM TB_AUX_LIGA
    WHERE DATA_CARGA = @data_carga

    OPEN c_ligas

    FETCH NEXT FROM c_ligas INTO @cod_liga, @liga, @pais, @nr_clubs, @valor_mercado, @media_valor_mercado, @conferencia

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF EXISTS (SELECT 1 FROM DIM_LIGA WHERE COD_LIGA = @cod_liga)
        BEGIN
            UPDATE DIM_LIGA
            SET
                LIGA = @liga,
                PAIS = @pais,
                NR_CLUBS = @nr_clubs,
                VALOR_MERCADO = @valor_mercado,
                MEDIA_VALOR_MERCADO = @media_valor_mercado,
                CONFERENCIA = @conferencia
            WHERE COD_LIGA = @cod_liga
        END
        ELSE
        BEGIN
            INSERT INTO DIM_LIGA (COD_LIGA, LIGA, PAIS, NR_CLUBS, VALOR_MERCADO, MEDIA_VALOR_MERCADO, CONFERENCIA)
            VALUES (@cod_liga, @liga, @pais, @nr_clubs, @valor_mercado, @media_valor_mercado, @conferencia)
        END

        FETCH NEXT FROM c_ligas INTO @cod_liga, @liga, @pais, @nr_clubs, @valor_mercado, @media_valor_mercado, @conferencia
    END

    CLOSE c_ligas
    DEALLOCATE c_ligas
END

exec sp_dim_liga '20240325'

select *from DIM_LIGA