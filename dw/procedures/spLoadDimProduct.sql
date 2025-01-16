CREATE OR ALTER PROCEDURE spLoadDimProduct
AS
BEGIN
    SET NOCOUNT ON;

    /*
      Estratégia simples: 
       - Verificar se já existe ProductKey para o ProdutoID do transacional.
       - Se não existir, inserir.
       - Se existir, atualizar.
    */

    -- Vamos supor que o transacional esteja no mesmo servidor e BD 'LojaDB'
    WITH SourceData AS (
        SELECT 
            p.ProdutoID,
            p.NomeProduto,
            p.Descricao
        FROM LojaDB.dbo.Produto p
    )
    MERGE DimProduct AS T
    USING SourceData AS S
        ON (T.ProdutoID = S.ProdutoID)
    WHEN MATCHED THEN
        UPDATE SET 
            NomeProduto = S.NomeProduto,
            Descricao = S.Descricao
            -- e se quiser controlar SCD, atualizar ExpirationDate, etc.
    WHEN NOT MATCHED THEN
        INSERT (ProdutoID, NomeProduto, Descricao, IsActive, EffectiveDate)
        VALUES (S.ProdutoID, S.NomeProduto, S.Descricao, 1, GETDATE())
    OUTPUT $action, Inserted.ProductKey, Inserted.ProdutoID;
END;
GO
