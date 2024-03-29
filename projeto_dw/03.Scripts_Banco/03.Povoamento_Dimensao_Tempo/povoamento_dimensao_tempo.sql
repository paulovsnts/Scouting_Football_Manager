--Povoamento da dimens�o tempo para o projeto

use projeto_football_scouting

SET LANGUAGE 'PORTUGUESE'

CREATE OR ALTER PROCEDURE SP_DIM_TEMPO (@DT_INICIAL DATETIME, @DT_FINAL DATETIME)
AS
BEGIN
	WHILE @DT_INICIAL <= @DT_FINAL
	BEGIN
		INSERT INTO DIM_TEMPO (NIVEL, DATA, DIA, DIA_SEMANA, FIM_SEMANA, 
							   FERIADO, FL_FERIADO, MES, NOME_MES,
							   TRIMESTRE, NOME_TRIMESTRE, SEMESTRE,
							   NOME_SEMESTRE, ANO)
		VALUES (
			'DIA',
			@DT_INICIAL,
			DAY(@DT_INICIAL),
			DATENAME(WEEKDAY, @DT_INICIAL),
			CASE WHEN DATENAME(WEEKDAY, @DT_INICIAL) IN ('S�bado', 'Domingo') THEN 'SIM' ELSE 'NAO' END,
			NULL,
		    'NAO',
			MONTH(@DT_INICIAL),
			DATENAME(MONTH, @DT_INICIAL),
			DATEPART(QUARTER, @DT_INICIAL),
			CASE 
				WHEN DATEPART(QUARTER, @DT_INICIAL) = 1 THEN '1� Trimestre' + CAST(YEAR(@DT_INICIAL) AS VARCHAR(4))
				WHEN DATEPART(QUARTER, @DT_INICIAL) = 2 THEN '2� Trimestre' + CAST(YEAR(@DT_INICIAL) AS VARCHAR(4))
				WHEN DATEPART(QUARTER, @DT_INICIAL) = 3 THEN '3� Trimestre' + CAST(YEAR(@DT_INICIAL) AS VARCHAR(4))
				ELSE '4� Trimestre' + CAST(YEAR(@DT_INICIAL) AS VARCHAR(4))
			END,
			CASE 
				WHEN DATEPART(MONTH, @DT_INICIAL) <= 6 THEN 1
				ELSE 2
			END,
			CASE 
				WHEN DATEPART(MONTH, @DT_INICIAL) <= 6 THEN '1� Semestre' + CAST(YEAR(@DT_INICIAL) AS VARCHAR(4))
				ELSE '2� Trimestre' + CAST(YEAR(@DT_INICIAL) AS VARCHAR(4))
			END,
			YEAR(@DT_INICIAL)
		)

		IF @DT_INICIAL = EOMONTH(@DT_INICIAL) 
		BEGIN
			INSERT INTO DIM_TEMPO (NIVEL, MES, NOME_MES, 
								   TRIMESTRE, NOME_TRIMESTRE, SEMESTRE,
							       NOME_SEMESTRE, ANO)
			VALUES (
				'MES',
				MONTH(@DT_INICIAL),
				DATENAME(MONTH,@DT_INICIAL),
				DATEPART(QUARTER, @DT_INICIAL),
				CASE 
					WHEN DATEPART(QUARTER, @DT_INICIAL) = 1 THEN '1� Trimestre' + CAST(YEAR(@DT_INICIAL) AS VARCHAR(4))
					WHEN DATEPART(QUARTER, @DT_INICIAL) = 2 THEN '2� Trimestre' + CAST(YEAR(@DT_INICIAL) AS VARCHAR(4))
					WHEN DATEPART(QUARTER, @DT_INICIAL) = 3 THEN '3� Trimestre' + CAST(YEAR(@DT_INICIAL) AS VARCHAR(4))
					ELSE '4� Trimestre' + CAST(YEAR(@DT_INICIAL) AS VARCHAR(4))
				END,
				CASE 
					WHEN DATEPART(MONTH, @DT_INICIAL) <= 6 THEN 1
					ELSE 2
				END,
				CASE 
					WHEN DATEPART(MONTH, @DT_INICIAL) <= 6 THEN '1� Semestre' + CAST(YEAR(@DT_INICIAL) AS VARCHAR(4))
					ELSE '2� Trimestre' + CAST(YEAR(@DT_INICIAL) AS VARCHAR(4))
				END,
				YEAR(@DT_INICIAL)
			)
		END

		IF DAY(@DT_INICIAL) = 31 AND MONTH(@DT_INICIAL) = 12
		BEGIN
			INSERT INTO DIM_TEMPO (NIVEL, ANO)
			VALUES ('ANO', YEAR(@DT_INICIAL))
		END

		SET @DT_INICIAL = DATEADD(DAY,1,@DT_INICIAL)
	END
END

EXEC SP_DIM_TEMPO '20060101','20241231'

SELECT *FROM DIM_TEMPO