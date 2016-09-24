SELECT customers."CompanyName"
, orders."OrderDate"
, orders."OrderID"
, products."ProductName"
, categories."CategoryName"
, order_details."UnitPrice" * order_details."Quantity" AS ExtendedPrice
FROM customers
INNER JOIN orders ON customers."CustomerID" = orders."CustomerID"
INNER JOIN order_details on order_details."OrderID" = orders."OrderID"
INNER JOIN products on products."ProductID" = order_details."ProductID"
INNER JOIN categories on categories."CategoryID" = products."CategoryID"
ORDER BY ExtendedPrice DESC, customers."CompanyName"



SELECT c."CompanyName"
, o."OrderDate"
, o."OrderID"
, p."ProductName"
, cat."CategoryName"
, od."UnitPrice" * od."Quantity" AS ExtendedPrice
FROM customers AS c
INNER JOIN orders AS o ON c."CustomerID" = o."CustomerID"
INNER JOIN order_details AS od on od."OrderID" = o."OrderID"
INNER JOIN products AS p on p."ProductID" = od."ProductID"
INNER JOIN categories AS cat on cat."CategoryID" = p."CategoryID"
ORDER BY ExtendedPrice DESC, c."CompanyName"




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

