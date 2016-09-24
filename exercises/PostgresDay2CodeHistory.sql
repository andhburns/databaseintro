-- Executing query:
SELECT c."CompanyName",
    o."OrderDate",
    o."OrderID",
    p."ProductName",
    cat."CategoryName",
    od."UnitPrice" * od."Quantity" AS extendedprice
   FROM customers c
     JOIN orders o ON c."CustomerID" = o."CustomerID"
     JOIN order_details od ON od."OrderID" = o."OrderID"
     JOIN products p ON p."ProductID" = od."ProductID"
     JOIN categories cat ON cat."CategoryID" = p."CategoryID"
  ORDER BY (od."UnitPrice" * od."Quantity"::double precision) DESC, c."CompanyName";

Total query runtime: 173 msec
2155 rows retrieved.

-- Executing query:
SELECT c."CompanyName",
    o."OrderDate",
    o."OrderID",
    p."ProductName",
    cat."CategoryName",
    od."UnitPrice" * od."Quantity" AS extendedprice
   FROM customers AS cust
     JOIN orders AS o ON c."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  ORDER BY (od."UnitPrice" * od."Quantity") DESC, c."CompanyName";

ERROR:  missing FROM-clause entry for table "c"
LINE 8:      JOIN orders AS o ON c."CustomerID" = o."CustomerID"
                                 ^
********** Error **********

ERROR: missing FROM-clause entry for table "c"
SQL state: 42P01
Character: 209

-- Executing query:
SELECT cust."CompanyName",
    o."OrderDate",
    o."OrderID",
    p."ProductName",
    cat."CategoryName",
    od."UnitPrice" * od."Quantity" AS extendedprice
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  ORDER BY (od."UnitPrice" * od."Quantity") DESC, cust."CompanyName";

Total query runtime: 172 msec
2155 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    o."OrderDate",
    o."OrderID",
    p."ProductName",
    cat."CategoryName",
    od."UnitPrice" * od."Quantity" AS extendedprice
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
  ORDER BY (od."UnitPrice" * od."Quantity") DESC, cust."CompanyName";

Total query runtime: 88 msec
1059 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    o."OrderDate",
    o."OrderID",
    p."ProductName",
    cat."CategoryName",
    SUM(od."UnitPrice" * od."Quantity") AS extendedprice
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
  GROUP BY cust."CompanyName",
    o."OrderDate",
    o."OrderID",
    p."ProductName",
    cat."CategoryName"
  ORDER BY (od."UnitPrice" * od."Quantity") DESC, cust."CompanyName";

ERROR:  column "od.UnitPrice" must appear in the GROUP BY clause or be used in an aggregate function
LINE 18:   ORDER BY (od."UnitPrice" * od."Quantity") DESC, cust."Comp...
                     ^

********** Error **********

ERROR: column "od.UnitPrice" must appear in the GROUP BY clause or be used in an aggregate function
SQL state: 42803
Character: 606

-- Executing query:
SELECT cust."CompanyName",
    o."OrderDate",
    o."OrderID",
    p."ProductName",
    cat."CategoryName",
    SUM(od."UnitPrice" * od."Quantity") AS extendedprice
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
  GROUP BY cust."CompanyName",
    o."OrderDate",
    o."OrderID",
    p."ProductName",
    cat."CategoryName"
  ORDER BY extendedprice DESC, cust."CompanyName";

Total query runtime: 86 msec
1059 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    o."OrderDate",
    o."OrderID",
    p."ProductName",
    cat."CategoryName",
    SUM(od."UnitPrice" * od."Quantity") AS extendedprice
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
  GROUP BY cust."CompanyName",
    o."OrderDate",
    o."OrderID",
    p."ProductName",
    cat."CategoryName"
  HAVING extendedprice > 5000
  ORDER BY extendedprice DESC, cust."CompanyName";

ERROR:  column "extendedprice" does not exist
LINE 18:   HAVING extendedprice > 5000
                  ^

********** Error **********

ERROR: column "extendedprice" does not exist
SQL state: 42703
Character: 603

-- Executing query:
SELECT cust."CompanyName",
    o."OrderDate",
    o."OrderID",
    p."ProductName",
    cat."CategoryName",
    SUM(od."UnitPrice" * od."Quantity") AS extendedprice
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
  GROUP BY cust."CompanyName",
    o."OrderDate",
    o."OrderID",
    p."ProductName",
    cat."CategoryName"
  HAVING SUM(od."UnitPrice" * od."Quantity") > 5000
  ORDER BY extendedprice DESC, cust."CompanyName";

Total query runtime: 22 msec
6 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth,
    --o."OrderID",
    p."ProductName",
    cat."CategoryName",
    SUM(od."UnitPrice" * od."Quantity") AS extendedprice
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
  GROUP BY cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate"),
    --o."OrderID",
    p."ProductName",
    cat."CategoryName"
  HAVING SUM(od."UnitPrice" * od."Quantity") > 5000
  ORDER BY extendedprice DESC, cust."CompanyName";

Total query runtime: 22 msec
6 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth,
    --o."OrderID",
    p."ProductName",
    cat."CategoryName",
    SUM(od."UnitPrice" * od."Quantity") AS extendedprice
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
  GROUP BY cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate"),
    --o."OrderID",
    p."ProductName",
    cat."CategoryName"
  HAVING SUM(od."UnitPrice" * od."Quantity") > 5000
  ORDER BY extendedprice DESC, cust."CompanyName";

Total query runtime: 32 msec
6 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth,
    --o."OrderID",
    p."ProductName",
    cat."CategoryName",
    SUM(od."UnitPrice" * od."Quantity") AS extendedprice
    COUNT(OrderId) as OrderCount
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
  GROUP BY cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate"),
    --o."OrderID",
    p."ProductName",
    cat."CategoryName"
  HAVING SUM(od."UnitPrice" * od."Quantity") > 5000
  ORDER BY extendedprice DESC, cust."CompanyName";

ERROR:  syntax error at or near "COUNT"
LINE 7:     COUNT(OrderId) as OrderCount
            ^

********** Error **********

ERROR: syntax error at or near "COUNT"
SQL state: 42601
Character: 206

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    --,o."OrderID",
    ,p."ProductName"
    ,cat."CategoryName"
    ,SUM(od."UnitPrice" * od."Quantity") AS extendedprice
    ,COUNT(OrderId) as OrderCount
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
  GROUP BY cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate"),
    --o."OrderID",
    p."ProductName",
    cat."CategoryName"
  HAVING SUM(od."UnitPrice" * od."Quantity") > 5000
  ORDER BY extendedprice DESC, cust."CompanyName";

ERROR:  column "orderid" does not exist
LINE 7:     ,COUNT(OrderId) as OrderCount
                   ^
HINT:  Perhaps you meant to reference the column "o.OrderID" or the column "od.OrderID".

********** Error **********

ERROR: column "orderid" does not exist
SQL state: 42703
Hint: Perhaps you meant to reference the column "o.OrderID" or the column "od.OrderID".
Character: 214

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    --,o."OrderID",
    ,p."ProductName"
    ,cat."CategoryName"
    ,SUM(od."UnitPrice" * od."Quantity") AS extendedprice
    ,COUNT(o."OrderId") as OrderCount
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
  GROUP BY cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate"),
    --o."OrderID",
    p."ProductName",
    cat."CategoryName"
  HAVING SUM(od."UnitPrice" * od."Quantity") > 5000
  ORDER BY extendedprice DESC, cust."CompanyName";

ERROR:  column o.OrderId does not exist
LINE 7:     ,COUNT(o."OrderId") as OrderCount
                   ^
HINT:  Perhaps you meant to reference the column "o.OrderID".

********** Error **********

ERROR: column o.OrderId does not exist
SQL state: 42703
Hint: Perhaps you meant to reference the column "o.OrderID".
Character: 214

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    --,o."OrderID",
    ,p."ProductName"
    ,cat."CategoryName"
    ,SUM(od."UnitPrice" * od."Quantity") AS extendedprice
    ,COUNT(o."OrderID") as OrderCount
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
  GROUP BY cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate"),
    --o."OrderID",
    p."ProductName",
    cat."CategoryName"
  HAVING SUM(od."UnitPrice" * od."Quantity") > 5000
  ORDER BY extendedprice DESC, cust."CompanyName";

Total query runtime: 30 msec
6 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    --,o."OrderID",
    ,p."ProductName"
    ,cat."CategoryName"
    --,SUM(od."UnitPrice" * od."Quantity") AS extendedprice
    ,COUNT(o."OrderID") as OrderCount
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
  GROUP BY cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate"),
    --o."OrderID",
    p."ProductName",
    cat."CategoryName"
  --HAVING SUM(od."UnitPrice" * od."Quantity") > 5000
  ORDER BY extendedprice DESC, cust."CompanyName";

ERROR:  column "extendedprice" does not exist
LINE 20:   ORDER BY extendedprice DESC, cust."CompanyName";
                    ^

********** Error **********

ERROR: column "extendedprice" does not exist
SQL state: 42703
Character: 758

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    --,o."OrderID",
    ,p."ProductName"
    ,cat."CategoryName"
    --,SUM(od."UnitPrice" * od."Quantity") AS extendedprice
    ,COUNT(o."OrderID") as OrderCount
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
  GROUP BY cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate"),
    --o."OrderID",
    p."ProductName",
    cat."CategoryName"
  --HAVING SUM(od."UnitPrice" * od."Quantity") > 5000
  ORDER BY OrderCount DESC, cust."CompanyName";

Total query runtime: 81 msec
1044 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    --,o."OrderID",
    ,p."ProductName"
    ,cat."CategoryName"
    --,SUM(od."UnitPrice" * od."Quantity") AS extendedprice
    ,COUNT(o."OrderID") as OrderCount
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
  GROUP BY cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate"),
    --o."OrderID",
    p."ProductName",
    cat."CategoryName"
  --HAVING SUM(od."UnitPrice" * od."Quantity") > 5000
  ORDER BY OrderCount DESC, cust."CompanyName";

Total query runtime: 68 msec
1044 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    --,o."OrderID",
    --,p."ProductName"
    ,cat."CategoryName"
    --,SUM(od."UnitPrice" * od."Quantity") AS extendedprice
    ,COUNT(o."OrderID") as OrderCount
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
  GROUP BY cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate"),
    --o."OrderID",
    --p."ProductName",
    cat."CategoryName"
  --HAVING SUM(od."UnitPrice" * od."Quantity") > 5000
  ORDER BY OrderCount DESC, cust."CompanyName";

Total query runtime: 53 msec
857 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    ,cat."CategoryName"
    --,COUNT(o."OrderID") as OrderCount
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
--   GROUP BY cust."CompanyName",
--     EXTRACT(MONTH FROM o."OrderDate"),
--     cat."CategoryName"
;

Total query runtime: 45 msec
1059 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    ,cat."CategoryName"
    ,COUNT(o."OrderID") as OrderCount
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
--   GROUP BY cust."CompanyName",
--     EXTRACT(MONTH FROM o."OrderDate"),
--     cat."CategoryName"
;

ERROR:  column "cust.CompanyName" must appear in the GROUP BY clause or be used in an aggregate function
LINE 1: SELECT cust."CompanyName",
               ^

********** Error **********

ERROR: column "cust.CompanyName" must appear in the GROUP BY clause or be used in an aggregate function
SQL state: 42803
Character: 8

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    ,cat."CategoryName"
    ,COUNT(o."OrderID") as OrderCount
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
  GROUP BY cust."CompanyName",
     EXTRACT(MONTH FROM o."OrderDate"),
    cat."CategoryName"
;

Total query runtime: 48 msec
857 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    ,cat."CategoryName"
   -- ,COUNT(o."OrderID") as OrderCount
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
	AND cust."CompanyName" = 'Save-a-lot Markets'
  --GROUP BY cust."CompanyName",
  --   EXTRACT(MONTH FROM o."OrderDate"),
  --  cat."CategoryName"
;

Total query runtime: 16 msec
64 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    ,cat."CategoryName"
    ,COUNT(o."OrderID") as OrderCount
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
	AND cust."CompanyName" = 'Save-a-lot Markets'
  --GROUP BY cust."CompanyName",
  --   EXTRACT(MONTH FROM o."OrderDate"),
  --  cat."CategoryName"
;

ERROR:  column "cust.CompanyName" must appear in the GROUP BY clause or be used in an aggregate function
LINE 1: SELECT cust."CompanyName",
               ^
********** Error **********

ERROR: column "cust.CompanyName" must appear in the GROUP BY clause or be used in an aggregate function
SQL state: 42803
Character: 8

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    ,cat."CategoryName"
    ,COUNT(o."OrderID") as OrderCount
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
	AND cust."CompanyName" = 'Save-a-lot Markets'
  GROUP BY cust."CompanyName",
     EXTRACT(MONTH FROM o."OrderDate"),
    cat."CategoryName"
;

Total query runtime: 13 msec
37 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    ,cat."CategoryName"
    ,COUNT(o."OrderID") as OrderCount
    ,SUM(od."UnitPrice" * od."Quantity") as ExtendedAmount
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
	AND cust."CompanyName" = 'Save-a-lot Markets'
  GROUP BY cust."CompanyName",
     EXTRACT(MONTH FROM o."OrderDate"),
    cat."CategoryName"
;

Total query runtime: 18 msec
37 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    ,cat."CategoryName"
    ,COUNT(o."OrderID") as OrderCount
    ,SUM(od."UnitPrice" * od."Quantity") as ExtendedAmount
    ,AVG(od."UnitPrice" * od."Quantity") as ExtendedAverage
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
	AND cust."CompanyName" = 'Save-a-lot Markets'
  GROUP BY cust."CompanyName",
     EXTRACT(MONTH FROM o."OrderDate"),
    cat."CategoryName"
;

Total query runtime: 16 msec
37 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    ,cat."CategoryName"
    ,COUNT(o."OrderID") as OrderCount
    ,SUM(od."UnitPrice" * od."Quantity") as ExtendedAmount
    ,MIN(od."UnitPrice" * od."Quantity") as ExtendedMin
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
	AND cust."CompanyName" = 'Save-a-lot Markets'
  GROUP BY cust."CompanyName",
     EXTRACT(MONTH FROM o."OrderDate"),
    cat."CategoryName"
;

Total query runtime: 17 msec
37 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    ,cat."CategoryName"
    ,COUNT(o."OrderID") as OrderCount
    ,SUM(od."UnitPrice" * od."Quantity") as ExtendedAmount
    ,MIN(od."UnitPrice" * od."Quantity") as ExtendedMin
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
	AND cust."CompanyName" = 'Save-a-lot Markets'
  GROUP BY cust."CompanyName",
     EXTRACT(MONTH FROM o."OrderDate"),
    cat."CategoryName"
  HAVING MIN(od."UnitPrice" * od."Quantity") < 250
  ORDER BY ordermonth, cat."CateogryName"
;

ERROR:  column cat.CateogryName does not exist
LINE 18:   ORDER BY ordermonth, cat."CateogryName"
                                ^
HINT:  Perhaps you meant to reference the column "cat.CategoryName".

********** Error **********

ERROR: column cat.CateogryName does not exist
SQL state: 42703
Hint: Perhaps you meant to reference the column "cat.CategoryName".
Character: 789

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    ,cat."CategoryName"
    ,COUNT(o."OrderID") as OrderCount
    ,SUM(od."UnitPrice" * od."Quantity") as ExtendedAmount
    ,MIN(od."UnitPrice" * od."Quantity") as ExtendedMin
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
	AND cust."CompanyName" = 'Save-a-lot Markets'
  GROUP BY cust."CompanyName",
     EXTRACT(MONTH FROM o."OrderDate"),
    cat."CategoryName"
  HAVING MIN(od."UnitPrice" * od."Quantity") < 250
  ORDER BY ordermonth, cat."CategoryName"
;

Total query runtime: 14 msec
9 rows retrieved.

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    ,cat."CategoryName"
    ,COUNT(o."OrderID") as OrderCount
    ,SUM(od."UnitPrice" * od."Quantity") as ExtendedAmount
    ,MIN(od."UnitPrice" * od."Quantity") as ExtendedMin
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
	AND cust."CompanyName" = 'Save-a-lot Markets'
	AND MIN(od."UnitPrice" * od."Quantity") < 250
  GROUP BY cust."CompanyName",
     EXTRACT(MONTH FROM o."OrderDate"),
    cat."CategoryName"

  ORDER BY ordermonth, cat."CategoryName"
;

ERROR:  aggregate functions are not allowed in WHERE
LINE 14:  AND MIN(od."UnitPrice" * od."Quantity") < 250
              ^

********** Error **********

ERROR: aggregate functions are not allowed in WHERE
SQL state: 42803
Character: 626

-- Executing query:
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    ,cat."CategoryName"
    ,COUNT(o."OrderID") as OrderCount
    ,SUM(od."UnitPrice" * od."Quantity") as ExtendedAmount
    ,MIN(od."UnitPrice" * od."Quantity") as ExtendedMin
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
	AND cust."CompanyName" = 'Save-a-lot Markets'
  GROUP BY cust."CompanyName",
     EXTRACT(MONTH FROM o."OrderDate"),
    cat."CategoryName"
  HAVING MIN(od."UnitPrice" * od."Quantity") < 250
  ORDER BY ordermonth, cat."CategoryName"
;

Total query runtime: 13 msec
9 rows retrieved.

-- Executing query:
CREATE VIEW public.savealotmarket1997 AS
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    ,cat."CategoryName"
    ,COUNT(o."OrderID") as OrderCount
    ,SUM(od."UnitPrice" * od."Quantity") as ExtendedAmount
    ,MIN(od."UnitPrice" * od."Quantity") as ExtendedMin
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
	AND cust."CompanyName" = 'Save-a-lot Markets'
  GROUP BY cust."CompanyName",
     EXTRACT(MONTH FROM o."OrderDate"),
    cat."CategoryName"
  HAVING MIN(od."UnitPrice" * od."Quantity") < 250
  --ORDER BY ordermonth, cat."CategoryName"
;

Query returned successfully with no result in 69 msec.

-- Executing query:
select * from savealotmarkets1997
ERROR:  relation "savealotmarkets1997" does not exist
LINE 1: select * from savealotmarkets1997
                      ^

********** Error **********

ERROR: relation "savealotmarkets1997" does not exist
SQL state: 42P01
Character: 15

-- Executing query:
select * from savealotmarket1997
Total query runtime: 12 msec
9 rows retrieved.

-- Executing query:
select * from savealotmarket1997 AS s
order by s."CompanyName"
Total query runtime: 13 msec
9 rows retrieved.

-- Executing query:
select * from savealotmarket1997 AS s
order by s."ordermonth"
Total query runtime: 13 msec
9 rows retrieved.

-- Executing query:
-- select * from savealotmarket1997 AS s
-- order by s."ordermonth"


CREATE VIEW public.Orders1997 AS
SELECT cust."CompanyName",
    EXTRACT(MONTH FROM o."OrderDate") AS OrderMonth
    ,cat."CategoryName"
    ,COUNT(o."OrderID") as OrderCount
    ,SUM(od."UnitPrice" * od."Quantity") as ExtendedAmount
    ,MIN(od."UnitPrice" * od."Quantity") as ExtendedMin
   FROM customers AS cust
     JOIN orders AS o ON cust."CustomerID" = o."CustomerID"
     JOIN order_details AS od ON od."OrderID" = o."OrderID"
     JOIN products AS p ON p."ProductID" = od."ProductID"
     JOIN categories AS cat ON cat."CategoryID" = p."CategoryID"
  WHERE EXTRACT(YEAR FROM o."OrderDate") = 1997
	--AND cust."CompanyName" = 'Save-a-lot Markets'
  GROUP BY cust."CompanyName",
     EXTRACT(MONTH FROM o."OrderDate"),
    cat."CategoryName"
  HAVING MIN(od."UnitPrice" * od."Quantity") < 250
  --ORDER BY ordermonth, cat."CategoryName"
;

Query returned successfully with no result in 16 msec.

-- Executing query:
select * from Orders1997 AS s
order by s."ordermonth"


Total query runtime: 35 msec
345 rows retrieved.

-- Executing query:
select * from Orders1997 AS s
where s."CompanyName" = 'Save-a-lot Markets'
order by s."ordermonth"


Total query runtime: 18 msec
9 rows retrieved.

