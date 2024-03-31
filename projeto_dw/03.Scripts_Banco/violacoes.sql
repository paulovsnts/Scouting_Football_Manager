--Tabela de violações para o sistema

/* 

Violações:
   1- A data de contratação deve ser uma data válida na dimensão tempo
   2- O código do jogador deve ser um código válido na dimensão jogador

*/

--A lógica das violações está implementada no script de carga para o fato transferencia
use projeto_football_scouting

CREATE TABLE TB_VIO_TRANSFERENCIA_TIME (
    ID_VIOLACAO INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    DATA_CARGA DATETIME NOT NULL,
    COD_JOGADOR INT NOT NULL,
    DATA_CONTRATACAO DATETIME NOT NULL,
    DT_ERRO DATETIME NOT NULL,
    VIOLACAO VARCHAR(150) NOT NULL
)

select *from TB_VIO_TRANSFERENCIA_TIME