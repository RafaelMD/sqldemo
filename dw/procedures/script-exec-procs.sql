BEGIN TRANSACTION;

BEGIN TRY

    -- Atualiza as dimensões
    EXEC spLoadDimDate @StartDate = '2023-01-01', @EndDate = '2025-12-31';
    EXEC spLoadDimProduct;
    EXEC spLoadDimEmployee;
    EXEC spLoadDimSupplier;

    -- Atualiza as tabelas fato
    EXEC spLoadFactSales;
    EXEC spLoadFactStockMovement;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;
