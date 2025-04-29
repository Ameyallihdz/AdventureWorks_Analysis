--PPT11. B2B Quantity Sold
SELECT
YEAR(H.OrderDate) AS OrderYear,
MONTH(H.OrderDate) AS OrderMonth,
'B2C' AS CustomerType,
SUM(D.OrderQty) AS TotalQuantity
FROM Sales.SalesOrderDetail D
JOIN Sales.SalesOrderHeader H ON D.SalesOrderID = H.SalesOrderID
JOIN Sales.Customer C ON H.CustomerID = C.CustomerID
WHERE C.StoreID IS NULL  -- B2C only
GROUP BY
YEAR(H.OrderDate), MONTH(H.OrderDate)
ORDER BY
OrderYear, OrderMonth;