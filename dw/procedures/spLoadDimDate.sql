CREATE OR ALTER PROCEDURE spLoadDimDate
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH DateRange AS (
        SELECT @StartDate AS [Date]
        UNION ALL
        SELECT DATEADD(DAY, 1, [Date])
        FROM DateRange 
        WHERE [Date] < @EndDate
    )
    INSERT INTO DimDate (DateKey, FullDate, Day, Month, [Year], MonthName, Quarter)
    SELECT
        CONVERT(INT, CONVERT(VARCHAR(8), [Date], 112)) AS DateKey, 
        [Date] AS FullDate,
        DAY([Date]) AS [Day],
        MONTH([Date]) AS [Month],
        YEAR([Date]) AS [Year],
        DATENAME(MONTH, [Date]) AS MonthName,
        DATEPART(QUARTER, [Date]) AS Quarter
    FROM DateRange DR
    WHERE NOT EXISTS (
        SELECT 1 FROM DimDate D WHERE D.DateKey = CONVERT(INT, CONVERT(VARCHAR(8), DR.[Date], 112))
    )
    OPTION (MAXRECURSION 0);
END;
GO
