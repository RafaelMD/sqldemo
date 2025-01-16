CREATE OR ALTER PROCEDURE spLoadFactSales
AS
BEGIN
    SET NOCOUNT ON;

    /*
      Supondo que os dados de vendas no transacional:
       - Vendas (VendaID, FuncionarioID, DataVenda, ValorTotal)
       - VendaProdutos (VendaProdutosID, VendaID, ProdutoID, Quantidade, PrecoUnitario)
    */

    -- Exemplo de inserção incremental: carrega vendas da última data em que paramos.
    -- Para simplificar, vamos carregar tudo. Em produção, teríamos algum filtro.

    ;WITH SalesData AS (
        SELECT
            V.VendaID,
            VP.ProdutoID,
            V.FuncionarioID,
            CONVERT(INT, CONVERT(VARCHAR(8), V.DataVenda, 112)) AS DateKey,  -- AAAAMMDD
            VP.Quantidade AS QuantitySold,
            VP.PrecoUnitario AS UnitPrice,
            (VP.Quantidade * VP.PrecoUnitario) AS TotalValue
        FROM LojaDB.dbo.Vendas V
        INNER JOIN LojaDB.dbo.VendaProdutos VP
            ON V.VendaID = VP.VendaID
    )

    INSERT INTO FactSales (
        DateKey,
        ProductKey,
        EmployeeKey,
        QuantitySold,
        UnitPrice,
        TotalValue
    )
    SELECT 
        S.DateKey,
        DP.ProductKey,
        DE.EmployeeKey,
        S.QuantitySold,
        S.UnitPrice,
        S.TotalValue
    FROM SalesData S
        -- Fazendo join para pegar as dimensões
        INNER JOIN DimProduct DP ON DP.ProdutoID = S.ProdutoID
        INNER JOIN DimEmployee DE ON DE.FuncionarioID = S.FuncionarioID
        -- Filtra por datas que existam na DimDate
        INNER JOIN DimDate DD ON DD.DateKey = S.DateKey
    -- Em casos reais, filtrar para não inserir duplicado ou usar MERGE
    ;
END;
GO
