--Scripts para povoar o ambiente operacional
--Utilização de API para consumir os arquivos json

use projeto_football_scouting

create or alter procedure sp_povoar_ligas
as
begin
	DECLARE @j_ligas VARCHAR(MAX) = (SELECT BULKCOLUMN FROM OPENROWSET (BULK 'C:\Users\USUARIO\Desktop\Scouting_Football_Manager\projeto_dw\03.Scripts_Banco\02.Povoamento_Operacional\campeonatos.json', SINGLE_CLOB) A)

	INSERT INTO TB_LIGA (COD_LIGA, LIGA, PAIS, NR_CLUBS, VALOR_MERCADO, MEDIA_VALOR_MERCADO, CONFERENCIA)
	SELECT id, name, country, clubs, totalMarketValue, meanMarketValue, continent
	FROM OPENJSON(@j_ligas, '$.results')
	WITH (
		id VARCHAR(10),
		name VARCHAR(50),
		country VARCHAR(50),
		clubs INT,
		totalMarketValue VARCHAR(50),
		meanMarketValue VARCHAR(50),
		continent VARCHAR(50)
	)
end

exec sp_povoar_ligas

select * from TB_LIGA