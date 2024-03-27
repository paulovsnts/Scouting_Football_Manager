--Script para carga do operacional para o staging

use projeto_football_scouting

create or alter procedure sp_oltp_jogador(@data_carga datetime)
as
begin
	DECLARE @cod_jogador INT, @nome VARCHAR(100),
            @dt_nascimento VARCHAR(50), @altura VARCHAR(20),
            @nacionalidade VARCHAR(50), @pe_bom VARCHAR(20),
			@posicao VARCHAR(50), @valor_de_mercado VARCHAR(50),
            @cod_time INT, @cod_stats INT

    DECLARE c_jogadores CURSOR FOR
    SELECT COD_JOGADOR, NOME, DT_NASCIMENTO, ALTURA, NACIONALIDADE, PE_BOM, POSICAO, VALOR_DE_MERCADO, COD_TIME, COD_STATS
    FROM TB_JOGADOR

	DELETE FROM TB_AUX_JOGADOR
	WHERE DATA_CARGA = @data_carga

    OPEN c_jogadores
    FETCH NEXT FROM c_jogadores INTO @cod_jogador, @nome, @dt_nascimento, @altura, @nacionalidade, @pe_bom, @posicao, @valor_de_mercado, @cod_time, @cod_stats
    WHILE (@@FETCH_STATUS = 0)
    BEGIN
        INSERT INTO TB_AUX_JOGADOR (DATA_CARGA, COD_JOGADOR, NOME, DT_NASCIMENTO, ALTURA, NACIONALIDADE, PE_BOM, POSICAO, VALOR_DE_MERCADO, COD_TIME, COD_STATS)
        VALUES (@data_carga, @cod_jogador, @nome, @dt_nascimento, @altura, @nacionalidade, @pe_bom, @posicao, @valor_de_mercado, @cod_time, @cod_stats)
        
        FETCH NEXT FROM c_jogadores INTO @cod_jogador, @nome, @dt_nascimento, @altura, @nacionalidade, @pe_bom, @posicao, @valor_de_mercado, @cod_time, @cod_stats
    END

    CLOSE c_jogadores
    DEALLOCATE c_jogadores
end

-- Teste

exec sp_oltp_jogador '20240325'

select * from tb_aux_jogador