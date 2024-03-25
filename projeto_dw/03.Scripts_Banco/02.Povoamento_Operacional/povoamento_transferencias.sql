--Scripts para povoar o ambiente operacional
--Utilização de API para consumir os arquivos json

use projeto_football_scouting

create or alter procedure sp_povoar_transferencias
as
begin
	DECLARE @j_transferencias VARCHAR(MAX) = (SELECT BULKCOLUMN FROM OPENROWSET (BULK 'C:\Users\USUARIO\Desktop\Scouting_Football_Manager\projeto_dw\03.Scripts_Banco\02.Povoamento_Operacional\transferencias.json', SINGLE_CLOB) A)

	INSERT INTO TB_CONTRATACAO(COD_CONTRATACAO, VALOR, DT_CONTRATACAO, TIME_ORIGEM, TIME_DESTINO, TEMPORADA, COD_JOGADOR, COD_TIME)
	SELECT id, fee, date, origin, destiny, season, IdPlayer, IdClub
	FROM OPENJSON(@j_transferencias, '$.results')
	WITH (
		id int,
		fee VARCHAR(50),
		date VARCHAR(50),
		origin VARCHAR(100),
		destiny VARCHAR(100),
		season VARCHAR(50),
		IdPlayer INT,
		idClub INT
	)
end

exec sp_povoar_transferencias

select * from TB_CONTRATACAO