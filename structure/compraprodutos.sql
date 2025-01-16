CREATE TABLE CompraProdutos (
    CompraProdutosID INT IDENTITY(1,1) PRIMARY KEY,
    CompraID INT NOT NULL,
    ProdutoID INT NOT NULL,
    Quantidade INT NOT NULL,
    PrecoUnitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_CompraProdutos_Compras
        FOREIGN KEY (CompraID) REFERENCES Compras(CompraID),
    CONSTRAINT FK_CompraProdutos_Produto
        FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID)
);
