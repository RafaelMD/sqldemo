CREATE TABLE Fornecedor (
    FornecedorID INT IDENTITY(1,1) PRIMARY KEY,
    NomeFornecedor VARCHAR(100) NOT NULL,
    CNPJ VARCHAR(18) NOT NULL,
    Endereco VARCHAR(200),
    Telefone VARCHAR(15)
);
