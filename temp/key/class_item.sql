SELECT CompanyName
, OrderDate
, Orders.OrderId
, ProductName
, CategoryName
, Quantity * OD.UnitPrice as ExtendedPrice
FROM Customers
INNER JOIN Orders ON Customers.CustomerId = Orders.CustomerId
INNER JOIN Order_Details AS OD ON Orders.OrderId = OD.OrderId
INNER JOIN Products ON Products.ProductId = OD.ProductId
INNER JOIN Categories AS Cat on Products.CategoryId = Cat.CategoryId
WHERE OrderDate BETWEEN '1996-01-01' AND '1996-12-31'
--WHERE (OrderDate >= '1996-01-01' AND OrderDate < '1997-01-01')
--WHERE EXTRACT(YEAR FROM OrderDate) = 1996
ORDER BY ExtendedPrice DESC



