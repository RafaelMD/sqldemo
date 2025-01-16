CREATE OR ALTER PROCEDURE spLoadDimSupplier
AS
BEGIN
    SET NOCOUNT ON;

    WITH SourceData AS (
        SELECT 
            FornecedorID,
            NomeFornecedor,
            CNPJ,
            Endereco,
            Telefone
        FROM LojaDB.dbo.Fornecedor
    )
    MERGE DimSupplier AS T
    USING SourceData AS S
        ON (T.FornecedorID = S.FornecedorID)
    WHEN MATCHED THEN
        UPDATE SET
            NomeFornecedor = S.NomeFornecedor,
            CNPJ = S.CNPJ,
            Endereco = S.Endereco,
            Telefone = S.Telefone
    WHEN NOT MATCHED THEN
        INSERT (FornecedorID, NomeFornecedor, CNPJ, Endereco, Telefone, IsActive, EffectiveDate)
        VALUES (S.FornecedorID, S.NomeFornecedor, S.CNPJ, S.Endereco, S.Telefone, 1, GETDATE());
END;
GO
