CREATE OR ALTER PROCEDURE spLoadFactStockMovement
AS
BEGIN
    SET NOCOUNT ON;

    ----------------------------------------------------------------------------
    -- 1) Entradas (Compras)
    ----------------------------------------------------------------------------
    ;WITH PurchasesData AS (
        SELECT
            C.CompraID,
            C.FornecedorID,
            C.FuncionarioID,
            CONVERT(INT, CONVERT(VARCHAR(8), C.DataCompra, 112)) AS DateKey,
            CP.ProdutoID,
            CP.Quantidade,
            CP.PrecoUnitario,
            (CP.Quantidade * CP.PrecoUnitario) AS TotalValue
        FROM LojaDB.dbo.Compras C
        INNER JOIN LojaDB.dbo.CompraProdutos CP
            ON C.CompraID = CP.CompraID
    )
    INSERT INTO FactStockMovement (
        DateKey,
        ProductKey,
        EmployeeKey,
        SupplierKey,
        MovementType,
        Quantity,
        UnitValue,
        TotalValue
    )
    SELECT
        P.DateKey,
        DP.ProductKey,
        DE.EmployeeKey,
        DS.SupplierKey,
        'ENTRADA' AS MovementType,
        P.Quantidade,
        P.PrecoUnitario,
        P.TotalValue
    FROM PurchasesData P
        INNER JOIN DimProduct DP ON DP.ProdutoID = P.ProdutoID
        INNER JOIN DimEmployee DE ON DE.FuncionarioID = P.FuncionarioID
        INNER JOIN DimSupplier DS ON DS.FornecedorID = P.FornecedorID
        INNER JOIN DimDate DD ON DD.DateKey = P.DateKey;

    ----------------------------------------------------------------------------
    -- 2) Saídas (Vendas)
    ----------------------------------------------------------------------------
    ;WITH SalesData AS (
        SELECT
            V.VendaID,
            V.FuncionarioID,
            CONVERT(INT, CONVERT(VARCHAR(8), V.DataVenda, 112)) AS DateKey,
            VP.ProdutoID,
            VP.Quantidade,
            VP.PrecoUnitario,
            (VP.Quantidade * VP.PrecoUnitario) AS TotalValue
        FROM LojaDB.dbo.Vendas V
        INNER JOIN LojaDB.dbo.VendaProdutos VP
            ON V.VendaID = VP.VendaID
    )
    INSERT INTO FactStockMovement (
        DateKey,
        ProductKey,
        EmployeeKey,
        SupplierKey,
        MovementType,
        Quantity,
        UnitValue,
        TotalValue
    )
    SELECT
        S.DateKey,
        DP.ProductKey,
        DE.EmployeeKey,
        NULL AS SupplierKey,       -- Não tem fornecedor na saída
        'SAIDA' AS MovementType,
        S.Quantidade,
        S.PrecoUnitario,
        S.TotalValue
    FROM SalesData S
        INNER JOIN DimProduct DP ON DP.ProdutoID = S.ProdutoID
        INNER JOIN DimEmployee DE ON DE.FuncionarioID = S.FuncionarioID
        INNER JOIN DimDate DD ON DD.DateKey = S.DateKey;
END;
GO
