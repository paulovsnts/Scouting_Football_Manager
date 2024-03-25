--Scripts para povoar o ambiente operacional
--Utilização de API para consumir os arquivos json

use projeto_football_scouting

create or alter procedure sp_povoar_jogadores
as
begin
	DECLARE @j_jogadores VARCHAR(MAX) = (SELECT BULKCOLUMN FROM OPENROWSET (BULK 'C:\Users\USUARIO\Desktop\Scouting_Football_Manager\projeto_dw\03.Scripts_Banco\02.Povoamento_Operacional\jogadores.json', SINGLE_CLOB) A)

	INSERT INTO TB_JOGADOR(COD_JOGADOR, NOME, DT_NASCIMENTO, ALTURA, NACIONALIDADE, PE_BOM, POSICAO, VALOR_DE_MERCADO, COD_TIME)
	SELECT id, name, dateOfBirth, height, nationality, foot, position, marketValue, idClub
	FROM OPENJSON(@j_jogadores, '$.results')
	WITH (
		id int,
		name VARCHAR(100),
		dateOfBirth VARCHAR(50),
		height VARCHAR(20),
		nationality VARCHAR(50),
		foot VARCHAR(20),
		position VARCHAR(50),
		marketValue VARCHAR(50),
		idClub int
	)
end

exec sp_povoar_jogadores

select * from TB_JOGADOR