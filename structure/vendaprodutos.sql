CREATE TABLE VendaProdutos (
    VendaProdutosID INT IDENTITY(1,1) PRIMARY KEY,
    VendaID INT NOT NULL,
    ProdutoID INT NOT NULL,
    Quantidade INT NOT NULL,
    PrecoUnitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_VendaProdutos_Vendas
        FOREIGN KEY (VendaID) REFERENCES Vendas(VendaID),
    CONSTRAINT FK_VendaProdutos_Produto
        FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID)
);
