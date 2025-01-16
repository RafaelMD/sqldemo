CREATE TABLE Compras (
    CompraID INT IDENTITY(1,1) PRIMARY KEY,
    FornecedorID INT NOT NULL,
    FuncionarioID INT NOT NULL,
    DataCompra DATETIME NOT NULL DEFAULT GETDATE(),
    ValorTotal DECIMAL(10,2) NOT NULL DEFAULT 0,
    CONSTRAINT FK_Compras_Fornecedor
        FOREIGN KEY (FornecedorID) REFERENCES Fornecedor(FornecedorID),
    CONSTRAINT FK_Compras_Funcionario
        FOREIGN KEY (FuncionarioID) REFERENCES Funcionario(FuncionarioID)
);
