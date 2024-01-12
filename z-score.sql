-- Definindo uma Tabela de Express�o Comum (CTE) chamada 'calc'
WITH calc AS (
-- Calculando a m�dia e o desvio padr�o do 'UnitPrice' da tabela 'Products'
    SELECT
        AVG(UnitPrice) AS media,
        STDEV(UnitPrice) AS desvio_padrao
    FROM [dbo].[Products]
)

-- Selecionando as colunas desejadas
SELECT
    ProductName,
    UnitPrice,
    ROUND(media, 2) AS media_UnitPrice, -- Adicionando a m�dia do 'UnitPrice' da CTE 'calc'
    ROUND((UnitPrice - calc.media) / calc.desvio_padrao, 2) AS z_score -- Calculando o z-score
FROM
    [dbo].[Products]
CROSS JOIN calc -- Realizando um JOIN com a CTE 'calc'
GROUP BY
    ProductName,
    UnitPrice,
    calc.media,
    calc.desvio_padrao
HAVING
    (UnitPrice - calc.media) / calc.desvio_padrao > 2 -- Aplicando a condi��o de filtro (z-score > 2)