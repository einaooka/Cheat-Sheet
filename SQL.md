
## Shortcut Keys
Ctrl + K + C  - Comment

Ctrl + K + U  - Uncomment 

## Data Types
- Use varchar instead of nvarchar
- Use decimal instead of float
- Use tinyint (0 ~ 255)> smallint (-32,768 ~ 32,767) > int (-2,147,483,648 ~ 2,147,483,647)

- Decimal Size

| Precision       | Storage bytes  |
| ------------- |:-------------:|
| 1 - 9    | 5 | 
| 10-19     | 9     |
| 20-28 | 13      | 
| 29-38 | 17     | 

```sql
CAST(BusinessEntityID as nvarchar(10)) 

--Dates
CONVERT(varchar, orderdate, 112) AS FormattedDate1
CONVERT(varchar, orderdate, 102) AS FormattedDate2
FORMAT(orderdate, 'yyyy/MM-MMM')
```


## Dates

```sql
GETDATE(month, getdate()) AS CurrentMonth
DATEPART(day, getdate()) AS CurrentDay
DAY/MONTH/YEAR
DATEADD(month, 2, getdate()) AS NextMonths
Datediff(month, '2000-1-1', getdate()) 

-- First Day of Month
SELECT DATEADD(month, DATEDIFF(month, 0, @mydate), 0) AS StartOfMonth

```

## String Manipulation
```sql
LEFT/RIGHT
UPPER/LOWER
LEN
```

## NULL

```sql
ISNULL() -- replace null by

-- filter
IS NULL 
IS NOT NULL
```

## Joins
- INNER JOIN
- LEFT OUTER JOIN
- RIGHT OUTER JOIN

Note: Watch out for NULLs. 

## Sub-Query

Examples
```sql
SELECT * FROM t1 WHERE c1 IN (SELECT C1 FROM t2)

-- Find row that do not match
SELECT * FROM table1 AS t1 WHERE c1 NOT EXISTS(SELECT * FROM table2 AS t2 WHERE t2.c1 = t1.c1)

-- Correlated
SELECT C1
    , (SELECT c2 FROM table2 WHERE c1 = A.c1) AS C2
FROM table1 AS A 

-- Union
SELECT p.name
FROM production.product AS P
UNION ALL 
	SELECT FirstName AS Name
	FROM person.person
```

## Common Table Expression (CTE)
```sql
WITH q AS (
  SELECT * FROM table1
)
SELECT q.c1, q.c2 FROM table2 AS A
JOIN q on q.c1 = A.c1
```

## Aggregate

##### Order of Operations
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY 

- SUM
- MIN/MAX

##### Example
-- WHERE can be used when filter should happen before grouping is one. To filter groups, use HAVING
```sql 
SELECT c1, SUM(c2) FROM table
GROUP BY c1
HAVING SUM(c2) > 10
```

## IF-ELSE

```sql
SELECT 
    CASE WHEN Firstname = 'Catherine' THEN 'Catherine'
	    ELSE 'Not Catherine' END AS IsCatherine
	, FirstName
FROM person.Person

SELECT	
    iif(FirstName = 'Catherine', 'Catherine', 'Not Catherine') AS ISCatherine
    , FirstName
FROM person.Person
```

## Modify Data
```sql
CREATE TABLE table (c1 INT, c2 INT)
CREATE TABLE #table (c1 INT, c2 INT) -- # makes the table into a temp table

INSERT INTO table (c1, c2)
VALUES (1,2)

INSERT INTO table2 (c1, c2)
SELECT c3,c4 FROM table1

SELECT c1, c2 
INTO table2
FROM table1

UPDATE #table
SET LastName = 'Smith', FirstName = 'ABC'
WHERE LastName = 'Smith'

DROP TABLE #Table

CREATE CLUSTERED INDEX CI_table1 ON Table1(RunID)
CREATE INDEX IX_table1col1 ON table1 (col1)
```

[Changing column order](https://docs.microsoft.com/en-us/sql/relational-databases/tables/change-column-order-in-a-table?view=sql-server-2017)

## Stored Procedures
```sql
CREATE PROC ups_Test
AS 
	SELECT BusinessEntityID
		, FirstName
		, LastName
	INTO #NNames_Loki
	FROM Person.Person

	WHILE EXISTS(
		SELECT * 
		FROM #NNames_Loki
		)
		BEGIN
			DELETE TOP(1) FROM #NNames_Loki
		END

	SELECT * FROM #NNames_Loki
GO
EXEC ups_Test

DROP PROC ups_Test GO
```
