CREATE TABLE DimDate (
    DateKey INT NOT NULL PRIMARY KEY,  -- Ex: 20250115 (AAAAMMDD)
    FullDate DATE NOT NULL,
    Day INT NOT NULL,
    Month INT NOT NULL,
    [Year] INT NOT NULL,
    MonthName VARCHAR(20),
    Quarter INT,
    -- etc...
);
