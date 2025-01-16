CREATE TABLE DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    ProdutoID INT NOT NULL, -- FK do sistema transacional (para rastreamento)
    NomeProduto VARCHAR(100),
    Descricao VARCHAR(250),
    -- Outros atributos relevantes
    IsActive BIT,           -- Ex.: se está ativo/inativo
    EffectiveDate DATE,     -- Controle de SCD (opcional)
    ExpirationDate DATE     -- Controle de SCD (opcional)
);
