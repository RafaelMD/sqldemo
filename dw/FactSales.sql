CREATE TABLE FactSales (
    FactSalesID BIGINT IDENTITY(1,1) PRIMARY KEY,
    DateKey INT NOT NULL,            -- FK para DimDate
    ProductKey INT NOT NULL,         -- FK para DimProduct
    EmployeeKey INT NOT NULL,        -- FK para DimEmployee

    -- Medidas:
    QuantitySold INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    TotalValue DECIMAL(10,2) NOT NULL,

    -- Timestamps ou flags
    DataInsertDW DATETIME NOT NULL DEFAULT GETDATE()
);

-- Criação de índices e FKs
ALTER TABLE FactSales
ADD CONSTRAINT FK_FactSales_DimDate
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey);

ALTER TABLE FactSales
ADD CONSTRAINT FK_FactSales_DimProduct
    FOREIGN KEY (ProductKey) REFERENCES DimProduct(ProductKey);

ALTER TABLE FactSales
ADD CONSTRAINT FK_FactSales_DimEmployee
    FOREIGN KEY (EmployeeKey) REFERENCES DimEmployee(EmployeeKey);
