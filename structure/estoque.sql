CREATE TABLE Estoque (
    EstoqueID INT IDENTITY(1,1) PRIMARY KEY,
    ProdutoID INT NOT NULL,
    QuantidadeAtual INT NOT NULL DEFAULT 0,
    DataUltimaEntrada DATETIME,
    DataUltimaSaida DATETIME,
    CONSTRAINT FK_Estoque_Produto 
        FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID)
);
