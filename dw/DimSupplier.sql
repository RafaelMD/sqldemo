CREATE TABLE DimSupplier (
    SupplierKey INT IDENTITY(1,1) PRIMARY KEY,
    FornecedorID INT NOT NULL, -- FK do sistema transacional
    NomeFornecedor VARCHAR(100),
    CNPJ VARCHAR(18),
    Endereco VARCHAR(200),
    Telefone VARCHAR(15),
    IsActive BIT,
    EffectiveDate DATE,
    ExpirationDate DATE
);
