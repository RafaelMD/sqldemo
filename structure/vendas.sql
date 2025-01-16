CREATE TABLE Vendas (
    VendaID INT IDENTITY(1,1) PRIMARY KEY,
    FuncionarioID INT NOT NULL,
    DataVenda DATETIME NOT NULL DEFAULT GETDATE(),
    ValorTotal DECIMAL(10,2) NOT NULL DEFAULT 0,
    CONSTRAINT FK_Vendas_Funcionario
        FOREIGN KEY (FuncionarioID) REFERENCES Funcionario(FuncionarioID)
);

