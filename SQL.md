
## Shortcut Keys
Ctrl + K + C  - Comment

Ctrl + K + U  - Uncomment 

## 


## Dates

```sql
GETDATE()
DATEPART()
DAY/MONTH/YEAR
DATEADD()
DATEDIFF()

```

## NULL

```sql
ISNULL() -- replace null by

-- filter
IS NULL 
IS NOT NULL

```

## Sub-Query

Examples
```sql
SELECT * FROM t1 WHERE c1 ON (SELECT C1 FROM t2)

-- Find row that do not match
SELECT * FROM table1 AS t1 WHERE c1 NOT EXISTS(SELECT * FROM table2 AS t2 WHERE t2.c1 = t1.c1)

-- Correlated
SELECT C1
    , (SELECT c2 FROM table2 WHERE c1 = A.c1) AS C2
FROM table1 AS A 

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
From -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY 

##### Example
-- WHERE can be used when filter should happen before grouping is one. To filter groups, use HAVING
```sql 
SELECT c1, SUM(c2) FROM table
GROUP BY c1
HAVING SUM(c2) > 10
```

## Modify Data
```sql
CREATE TABLE table (c1 INT, c2 INT)

INSERT INTO table (c1, c2)
VALUES (1,2)

INSERT INTO table2 (c1, c2)
SELECT c3,c4 FROM table1

SELECT c1, c2 
INTO table2
FROM table1



```
