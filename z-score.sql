-- Definindo uma Tabela de Expressão Comum (CTE) chamada 'calc'
WITH calc AS (
-- Calculando a média e o desvio padrão do 'UnitPrice' da tabela 'Products'
    SELECT
        AVG(UnitPrice) AS media,
        STDEV(UnitPrice) AS desvio_padrao
    FROM [dbo].[Products]
)

-- Selecionando as colunas desejadas
SELECT
    ProductName,
    UnitPrice,
    ROUND(media, 2) AS media_UnitPrice, -- Adicionando a média do 'UnitPrice' da CTE 'calc'
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
    (UnitPrice - calc.media) / calc.desvio_padrao > 2 -- Aplicando a condição de filtro (z-score > 2)

-- O Banco de Dados utilizado nesse código vai estar disponível na pasta 'README.md', para quem quiser consultar o cógigo
