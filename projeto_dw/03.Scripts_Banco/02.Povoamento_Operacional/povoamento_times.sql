--Scripts para povoar o ambiente operacional
--Utilização de API para consumir os arquivos json

use projeto_football_scouting

create or alter procedure sp_povoar_times
as
begin
	DECLARE @j_times VARCHAR(MAX) = (SELECT BULKCOLUMN FROM OPENROWSET (BULK 'C:\Users\USUARIO\Desktop\Scouting_Football_Manager\projeto_dw\03.Scripts_Banco\02.Povoamento_Operacional\times.json', SINGLE_CLOB) A)

	INSERT INTO TB_TIME(COD_TIME, NOME_TIME, PAIS, NR_JOGADORES, VALOR_MERCADO, COD_LIGA)
	SELECT id, name, country, squad, marketValue, leagueID
	FROM OPENJSON(@j_times, '$.results')
	WITH (
		id int,
		name VARCHAR(100),
		country VARCHAR(100),
		squad INT,
		marketValue VARCHAR(50),
		leagueID VARCHAR(10)
	)
end

exec sp_povoar_times

select * from TB_TIME