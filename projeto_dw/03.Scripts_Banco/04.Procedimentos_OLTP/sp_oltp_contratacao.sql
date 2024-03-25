--Script para carga do operacional para o staging

use projeto_football_scouting

create or alter procedure sp_oltp_transferencia(@data_carga datetime)
as
begin
	DECLARE @cod_contratacao INT, @valor VARCHAR(50),
            @dt_contratacao VARCHAR(50), @time_origem VARCHAR(100),
            @time_destino VARCHAR(100), @temporada VARCHAR(50),
            @cod_jogador INT, @cod_time INT

    DECLARE c_contratacoes CURSOR FOR
    SELECT COD_CONTRATACAO, VALOR, DT_CONTRATACAO, TIME_ORIGEM, TIME_DESTINO, TEMPORADA, COD_JOGADOR, COD_TIME
    FROM TB_CONTRATACAO

    OPEN c_contratacoes
    FETCH NEXT FROM c_contratacoes INTO @cod_contratacao, @valor, @dt_contratacao, @time_origem, @time_destino, @temporada, @cod_jogador, @cod_time
    WHILE (@@FETCH_STATUS = 0)
    BEGIN
        INSERT INTO TB_AUX_CONTRATACAO (DATA_CARGA, COD_CONTRATACAO, VALOR, DT_CONTRATACAO, TIME_ORIGEM, TIME_DESTINO, TEMPORADA, COD_JOGADOR, COD_TIME)
        VALUES (@data_carga, @cod_contratacao, @valor, @dt_contratacao, @time_origem, @time_destino, @temporada, @cod_jogador, @cod_time)
        
        FETCH NEXT FROM c_contratacoes INTO @cod_contratacao, @valor, @dt_contratacao, @time_origem, @time_destino, @temporada, @cod_jogador, @cod_time
    END

    CLOSE c_contratacoes
    DEALLOCATE c_contratacoes
end

-- Teste

exec sp_oltp_transferencia '20240325'

select * from tb_aux_contratacao