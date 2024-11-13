DECLARE @startDate DATE = '2024-10-01';
DECLARE @endDate DATE = '2024-11-14';
DECLARE @currentDate DATE = @startDate;

WHILE @currentDate <= @endDate
BEGIN
    -- Insert records for ElementID with larger gaps (for 1 element)
    DECLARE @i INT = 1;
    WHILE @i <= 20 -- Reduced the number of iterations to create larger gaps
    BEGIN
        INSERT INTO [dbo].[General] (ElementID, KuaID, CreatedDate)
        VALUES (FLOOR(RAND() * 5) + 1, NULL, @currentDate);
        SET @i = @i + 1;
    END

    -- Insert records for KuaID with larger gaps (for 1 element)
    SET @i = 1;
    WHILE @i <= 10 -- Reduced number of iterations for KuaID as well
    BEGIN
        INSERT INTO [dbo].[General] (ElementID, KuaID, CreatedDate)
        VALUES (NULL, FLOOR(RAND() * 9) + 1, @currentDate);
        SET @i = @i + 1;
    END

    -- Insert records for both ElementID and KuaID with larger gaps
    SET @i = 1;
    WHILE @i <= 12 -- Reduced number of iterations here as well
    BEGIN
        INSERT INTO [dbo].[General] (ElementID, KuaID, CreatedDate)
        VALUES (FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 9) + 1, @currentDate);
        SET @i = @i + 1;
    END

    -- Move to the next day to simulate a larger gap
    SET @currentDate = DATEADD(DAY, 1, @currentDate);
END