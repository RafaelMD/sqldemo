CREATE TABLE DimEmployee (
    EmployeeKey INT IDENTITY(1,1) PRIMARY KEY,
    FuncionarioID INT NOT NULL, -- FK do sistema transacional
    Nome VARCHAR(100),
    CPF VARCHAR(14),
    Cargo VARCHAR(50),
    DataAdmissao DATE,
    IsActive BIT,
    EffectiveDate DATE,     
    ExpirationDate DATE
);
