--PPT31. Cost vs Revenue B2C&B2B
SELECT
'B2B' AS CustomerType,
SUM(sod.UnitPrice * sod.OrderQty * (1 - sod.UnitPriceDiscount)) AS [Total Revenue],
SUM(p.StandardCost * sod.OrderQty) AS [Total Cost],
SUM((sod.UnitPrice * sod.OrderQty * (1 - sod.UnitPriceDiscount)) - (p.StandardCost * sod.OrderQty)) AS [Total Profit]
FROM
Sales.SalesOrderHeader soh
INNER JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
INNER JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE
c.StoreID IS NOT NULL
UNION ALL
--B2C
SELECT
'B2C' AS CustomerType,
SUM(sod.UnitPrice * sod.OrderQty * (1 - sod.UnitPriceDiscount)) AS [Total Revenue],
SUM(p.StandardCost * sod.OrderQty) AS [Total Cost],
SUM((sod.UnitPrice * sod.OrderQty * (1 - sod.UnitPriceDiscount)) - (p.StandardCost * sod.OrderQty)) AS [Total Profit]
FROM
Sales.SalesOrderHeader soh
INNER JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
INNER JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE
c.StoreID IS NULL
UNION ALL
--Total
SELECT
'Total' AS CustomerType,
SUM(sod.UnitPrice * sod.OrderQty * (1 - sod.UnitPriceDiscount)) AS [Total Revenue],
SUM(p.StandardCost * sod.OrderQty) AS [Total Cost],
SUM((sod.UnitPrice * sod.OrderQty * (1 - sod.UnitPriceDiscount)) - (p.StandardCost * sod.OrderQty)) AS [Total Profit]
FROM
Sales.SalesOrderHeader soh
INNER JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
INNER JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN Production.Product p ON sod.ProductID = p.ProductID;