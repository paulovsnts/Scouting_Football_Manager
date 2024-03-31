--Script para verificação dos indicadores

use projeto_football_scouting

-- a) Quantas transferências ultrapassam o menor valor de mercado da liga?
SELECT COUNT(*) AS Transferencias_Acima_Menor_Valor
FROM FATO_CONTRATACAO fc
INNER JOIN DIM_LIGA dl ON fc.ID_LIGA = dl.ID_LIGA
WHERE fc.VALOR > (SELECT MIN(VALOR_MERCADO) FROM DIM_LIGA)

-- b) Quais os times cujo valor de mercado é maior que a média do valor de mercado total da liga?
SELECT t.NOME_TIME, t.VALOR_MERCADO, l.MEDIA_VALOR_MERCADO
FROM DIM_TIME t
INNER JOIN FATO_CONTRATACAO fc ON t.ID_TIME = fc.ID_TIME
INNER JOIN DIM_LIGA l ON fc.ID_LIGA = l.ID_LIGA
GROUP BY t.NOME_TIME, t.VALOR_MERCADO, l.MEDIA_VALOR_MERCADO
HAVING AVG(t.VALOR_MERCADO) > (SELECT MAX(MEDIA_VALOR_MERCADO) FROM DIM_LIGA)

-- c) Qual posição tem os jogadores com menor valor de mercado?
SELECT POSICAO, SUM(VALOR_DE_MERCADO) AS SOMA_VALOR_MERCADO
FROM DIM_JOGADOR
GROUP BY POSICAO
ORDER BY SOMA_VALOR_MERCADO ASC

-- d) Qual a idade média dos times da liga?
SELECT t.COD_LIGA, AVG(DATEDIFF(YEAR, CONVERT(DATE, j.DT_NASCIMENTO), GETDATE())) AS IDADE_MEDIA
FROM DIM_TIME t
INNER JOIN DIM_JOGADOR j ON t.COD_TIME = j.COD_TIME
GROUP BY t.COD_LIGA

-- e) Qual a média do valor de mercado das transferências por ano?
SELECT YEAR(DT_CONTRATACAO) AS Ano, AVG(VALOR) AS Media_Valor_Mercado
FROM FATO_CONTRATACAO
GROUP BY YEAR(DT_CONTRATACAO)

-- f) Qual país possui os jogadores mais valiosos?
SELECT j.NACIONALIDADE AS PAIS, SUM(j.VALOR_DE_MERCADO) AS VALOR_TOTAL_MERCADO
FROM DIM_JOGADOR j
GROUP BY j.NACIONALIDADE
ORDER BY VALOR_TOTAL_MERCADO DESC

-- g) Qual a liga mais desvalorizada e quais os jogadores mais bem avaliados da mesma (valor de mercado)?
SELECT DISTINCT TOP 10 j.NOME AS JOGADOR, j.VALOR_DE_MERCADO AS VALOR_MERCADO, l.LIGA
FROM DIM_JOGADOR j
JOIN DIM_TIME t ON j.COD_TIME = t.COD_TIME
JOIN FATO_CONTRATACAO fc ON t.ID_TIME = fc.ID_TIME
JOIN DIM_LIGA l ON fc.ID_LIGA = l.ID_LIGA
WHERE l.VALOR_MERCADO = (SELECT MIN(VALOR_MERCADO) FROM DIM_LIGA)
ORDER BY j.VALOR_DE_MERCADO DESC

-- h) Quantas transferências de zagueiros ocorreram por temporada?
SELECT YEAR(DT_CONTRATACAO) AS Ano, COUNT(*) AS Transferencias_Zagueiros
FROM FATO_CONTRATACAO FC
JOIN DIM_JOGADOR J ON FC.ID_JOGADOR = J.ID_JOGADOR
WHERE J.POSICAO = 'Centre-Back'
GROUP BY YEAR(DT_CONTRATACAO)

-- i) Quantas transferências acima de 10M de euros ocorreram na liga brasileira?
SELECT COUNT(*) AS Transferencias_Acima_10M
FROM FATO_CONTRATACAO FC
JOIN DIM_LIGA L ON FC.ID_LIGA = L.ID_LIGA
WHERE L.COD_LIGA = 'BRA1' AND VALOR > 10000000

-- j) Quais times brasileiros têm as transferências mais caras por temporada?
SELECT YEAR(DT_CONTRATACAO) AS Ano, NOME_TIME, MAX(VALOR) AS Maior_Valor
FROM FATO_CONTRATACAO FC
JOIN DIM_TIME T ON FC.ID_TIME = T.ID_TIME
JOIN DIM_LIGA L ON FC.ID_LIGA = L.ID_LIGA
WHERE L.COD_LIGA = 'BRA1'
GROUP BY YEAR(DT_CONTRATACAO), NOME_TIME

-- k) Qual é o total de transferências por time?
SELECT NOME_TIME, COUNT(*) AS Total_Transferencias
FROM FATO_CONTRATACAO FC
JOIN DIM_TIME T ON FC.ID_TIME = T.ID_TIME
GROUP BY NOME_TIME

-- l) Qual liga tem o maior número de transferências?
SELECT LIGA, COUNT(*) AS Total_Transferencias
FROM FATO_CONTRATACAO FC
JOIN DIM_LIGA L ON FC.ID_LIGA = L.ID_LIGA
GROUP BY LIGA
ORDER BY Total_Transferencias DESC

-- m) Quais jogadores têm mais transferências sem custos?
SELECT TOP 10 NOME, COUNT(*) AS Total_Transferencias
FROM FATO_CONTRATACAO FC
JOIN DIM_JOGADOR J ON FC.ID_JOGADOR = J.ID_JOGADOR
WHERE VALOR = 0
GROUP BY NOME
ORDER BY Total_Transferencias DESC