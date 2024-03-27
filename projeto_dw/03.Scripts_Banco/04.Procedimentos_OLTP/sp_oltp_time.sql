--Script para carga do operacional para o staging

use projeto_football_scouting

create or alter procedure sp_oltp_time(@data_carga datetime)
as
begin
	DECLARE @cod_time INT, @nome_time VARCHAR(100),
            @pais VARCHAR(100), @nr_jogadores INT,
            @valor_mercado VARCHAR(50), @cod_liga VARCHAR(10)

    DECLARE c_times CURSOR FOR
    SELECT COD_TIME, NOME_TIME, PAIS, NR_JOGADORES, VALOR_MERCADO, COD_LIGA
    FROM TB_TIME

	DELETE FROM TB_AUX_TIME
    WHERE DATA_CARGA = @data_carga

	OPEN c_times
    FETCH NEXT FROM c_times INTO @cod_time, @nome_time, @pais, @nr_jogadores, @valor_mercado, @cod_liga
    WHILE (@@FETCH_STATUS = 0)
    BEGIN
        INSERT INTO TB_AUX_TIME (DATA_CARGA, COD_TIME, NOME_TIME, PAIS, NR_JOGADORES, VALOR_MERCADO, COD_LIGA)
        VALUES (@data_carga, @cod_time, @nome_time, @pais, @nr_jogadores, @valor_mercado, @cod_liga)
        
        FETCH NEXT FROM c_times INTO @cod_time, @nome_time, @pais, @nr_jogadores, @valor_mercado, @cod_liga
    END

    CLOSE c_times
    DEALLOCATE c_times
end

-- Teste

exec sp_oltp_time '20240325'

select * from tb_aux_time