CREATE OR ALTER PROCEDURE spLoadDimEmployee
AS
BEGIN
    SET NOCOUNT ON;

    WITH SourceData AS (
        SELECT 
            f.FuncionarioID,
            f.Nome,
            f.CPF,
            f.Cargo,
            f.DataAdmissao
        FROM LojaDB.dbo.Funcionario f
    )
    MERGE DimEmployee AS T
    USING SourceData AS S
        ON (T.FuncionarioID = S.FuncionarioID)
    WHEN MATCHED THEN
        UPDATE SET
            Nome = S.Nome,
            CPF = S.CPF,
            Cargo = S.Cargo,
            DataAdmissao = S.DataAdmissao
    WHEN NOT MATCHED THEN
        INSERT (FuncionarioID, Nome, CPF, Cargo, DataAdmissao, IsActive, EffectiveDate)
        VALUES (S.FuncionarioID, S.Nome, S.CPF, S.Cargo, S.DataAdmissao, 1, GETDATE());
END;
GO
