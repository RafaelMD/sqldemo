CREATE TABLE FactStockMovement (
    FactStockMovementID BIGINT IDENTITY(1,1) PRIMARY KEY,
    DateKey INT NOT NULL,         -- FK para DimDate
    ProductKey INT NOT NULL,      -- FK para DimProduct
    EmployeeKey INT NULL,         -- Quem realizou movimentação (pode ser nulo)
    SupplierKey INT NULL,         -- Fornecedor (em caso de entrada de compra)
    
    MovementType VARCHAR(10) NOT NULL,   -- Ex.: 'ENTRADA' ou 'SAIDA'
    Quantity INT NOT NULL,
    UnitValue DECIMAL(10,2) NOT NULL,    -- valor de compra/venda ou valor médio
    TotalValue DECIMAL(10,2) NOT NULL,

    DataInsertDW DATETIME NOT NULL DEFAULT GETDATE()
);

-- FKs
ALTER TABLE FactStockMovement
ADD CONSTRAINT FK_FactStockMovement_DimDate
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey);

ALTER TABLE FactStockMovement
ADD CONSTRAINT FK_FactStockMovement_DimProduct
    FOREIGN KEY (ProductKey) REFERENCES DimProduct(ProductKey);

ALTER TABLE FactStockMovement
ADD CONSTRAINT FK_FactStockMovement_DimEmployee
    FOREIGN KEY (EmployeeKey) REFERENCES DimEmployee(EmployeeKey);

ALTER TABLE FactStockMovement
ADD CONSTRAINT FK_FactStockMovement_DimSupplier
    FOREIGN KEY (SupplierKey) REFERENCES DimSupplier(SupplierKey);
