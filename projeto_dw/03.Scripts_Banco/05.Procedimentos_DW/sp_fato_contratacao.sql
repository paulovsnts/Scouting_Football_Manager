--Scripts para carga da tabela de fato contratacao

use projeto_football_scouting

CREATE OR ALTER PROCEDURE sp_fato_contratacao (@data_carga DATETIME)
AS
BEGIN
    DECLARE @id_time INT, @id_liga INT, @id_jogador INT, @id_tempo BIGINT,
			@cod_contratacao INT, @valor DECIMAL(18,2), @dt_contratacao DATE,
			@dt_contratacao_datetime DATETIME, @time_origem VARCHAR(100), @time_destino VARCHAR(100),
			@temporada VARCHAR(50), @quantidade INT, @cod_liga VARCHAR(10), @cod_time inT, @cod_jogador int

    SET @quantidade = 1

    DECLARE c_contratacoes CURSOR FOR
    SELECT COD_CONTRATACAO, VALOR, DT_CONTRATACAO, TIME_ORIGEM, TIME_DESTINO, TEMPORADA, COD_JOGADOR, COD_TIME, COD_LIGA
    FROM TB_AUX_CONTRATACAO 
    WHERE DATA_CARGA = @data_carga

    OPEN c_contratacoes

    FETCH NEXT FROM c_contratacoes INTO @cod_contratacao, @valor, @dt_contratacao, @time_origem, @time_destino, @temporada, @cod_jogador, @cod_time, @cod_liga

    WHILE @@FETCH_STATUS = 0
    BEGIN

		SET @dt_contratacao_datetime = CONVERT(DATETIME, @dt_contratacao)

        SET @id_time = (SELECT ID_TIME FROM DIM_TIME WHERE COD_TIME = @cod_time)
        SET @id_liga = (SELECT ID_LIGA FROM DIM_LIGA WHERE COD_LIGA = @cod_liga)
        SET @id_jogador = (SELECT ID_JOGADOR FROM DIM_JOGADOR WHERE COD_JOGADOR = @cod_jogador)
        SET @id_tempo = (SELECT ID_TEMPO FROM DIM_TEMPO WHERE DATA = @dt_contratacao)

		IF NOT EXISTS (SELECT 1 FROM DIM_TEMPO WHERE DATA = @dt_contratacao_datetime)
		BEGIN
			INSERT INTO TB_VIO_TRANSFERENCIA_TIME(DATA_CARGA, COD_JOGADOR, DATA_CONTRATACAO, DT_ERRO, VIOLACAO)
			VALUES (@data_carga, @cod_jogador, @dt_contratacao_datetime, GETDATE(), 'Data de contratação inválida na dimensão tempo')
			FETCH NEXT FROM c_contratacoes INTO @cod_contratacao, @valor, @dt_contratacao, @time_origem, @time_destino, @temporada, @cod_jogador, @cod_time, @cod_liga
			CONTINUE
		END

		IF NOT EXISTS (SELECT 1 FROM DIM_JOGADOR WHERE COD_JOGADOR = @cod_jogador)
		BEGIN
			INSERT INTO TB_VIO_TRANSFERENCIA_TIME(DATA_CARGA, COD_JOGADOR, DATA_CONTRATACAO, DT_ERRO, VIOLACAO)
			VALUES (@data_carga, @cod_jogador, @dt_contratacao_datetime, GETDATE(), 'Código de jogador inválido na dimensão jogador')
			FETCH NEXT FROM c_contratacoes INTO @cod_contratacao, @valor, @dt_contratacao, @time_origem, @time_destino, @temporada, @cod_jogador, @cod_time, @cod_liga
			CONTINUE
		END

        IF EXISTS (SELECT 1 FROM FATO_CONTRATACAO WHERE COD_CONTRATACAO = @cod_contratacao)
        BEGIN
            UPDATE FATO_CONTRATACAO
            SET
                ID_TIME = @id_time,
                ID_LIGA = @id_liga,
                ID_JOGADOR = @id_jogador,
                ID_TEMPO = @id_tempo,
                VALOR = @valor,
                DT_CONTRATACAO = @dt_contratacao_datetime,
                TIME_ORIGEM = @time_origem,
                TIME_DESTINO = @time_destino,
                TEMPORADA = @temporada,
                QUANTIDADE = @quantidade,
				COD_JOGADOR = @cod_jogador,
				COD_TIME = @cod_time
            WHERE COD_CONTRATACAO = @cod_contratacao
        END
        ELSE
        BEGIN
            INSERT INTO FATO_CONTRATACAO (ID_TIME, ID_LIGA, ID_JOGADOR, ID_TEMPO, COD_CONTRATACAO, VALOR, DT_CONTRATACAO, 
										  TIME_ORIGEM, TIME_DESTINO, TEMPORADA, QUANTIDADE, COD_JOGADOR, COD_TIME)
            VALUES (@id_time, @id_liga, @id_jogador, @id_tempo, @cod_contratacao, @valor, @dt_contratacao, 
					@time_origem, @time_destino, @temporada, @quantidade, @cod_jogador, @cod_time)
        END

        FETCH NEXT FROM c_contratacoes INTO @cod_contratacao, @valor, @dt_contratacao, @time_origem, @time_destino, @temporada, @cod_jogador, @cod_time, @cod_liga
    END

    CLOSE c_contratacoes
    DEALLOCATE c_contratacoes
END

exec sp_fato_contratacao '20240325'

select *from FATO_CONTRATACAO