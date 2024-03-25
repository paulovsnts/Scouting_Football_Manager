--Script para carga do operacional para o staging

use projeto_football_scouting

create or alter procedure sp_oltp_liga(@data_carga datetime)
as
begin
	DECLARE @cod_liga VARCHAR(10), @liga VARCHAR(50),
            @pais VARCHAR(50), @nr_clubs INT,
            @valor_mercado VARCHAR(50), @media_valor_mercado VARCHAR(50),
            @conferencia VARCHAR(50)

    DECLARE c_ligas CURSOR FOR
    SELECT COD_LIGA, LIGA, PAIS, NR_CLUBS, VALOR_MERCADO, MEDIA_VALOR_MERCADO, CONFERENCIA
    FROM TB_LIGA

    OPEN c_ligas
    FETCH NEXT FROM c_ligas INTO @cod_liga, @liga, @pais, @nr_clubs, @valor_mercado, @media_valor_mercado, @conferencia
    WHILE (@@FETCH_STATUS = 0)
    BEGIN
        INSERT INTO TB_AUX_LIGA (DATA_CARGA, COD_LIGA, LIGA, PAIS, NR_CLUBS, VALOR_MERCADO, MEDIA_VALOR_MERCADO, CONFERENCIA)
        VALUES (@data_carga, @cod_liga, @liga, @pais, @nr_clubs, @valor_mercado, @media_valor_mercado, @conferencia)
        
        FETCH NEXT FROM c_ligas INTO @cod_liga, @liga, @pais, @nr_clubs, @valor_mercado, @media_valor_mercado, @conferencia
    END

    CLOSE c_ligas
    DEALLOCATE c_ligas
end

-- Teste

exec sp_oltp_liga '20240325'

select * from tb_aux_liga