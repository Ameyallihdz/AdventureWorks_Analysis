--PPT16. B2B Profit Tendency
SELECT
YEAR(H.OrderDate) AS Year,
MONTH(H.OrderDate) AS Month,
SUM(D.UnitPrice * D.OrderQty * (1 - D.UnitPriceDiscount)) AS Revenue,
SUM(P.StandardCost * D.OrderQty) AS Cost,
SUM((D.UnitPrice * D.OrderQty * (1 - D.UnitPriceDiscount)) - (P.StandardCost * D.OrderQty)) AS Profit
FROM
Sales.SalesOrderHeader H
JOIN
Sales.SalesOrderDetail D ON H.SalesOrderID = D.SalesOrderID
JOIN
Sales.Customer C ON H.CustomerID = C.CustomerID
JOIN
Production.Product P ON D.ProductID = P.ProductID
WHERE
C.StoreID IS NOT NULL -- B2B only
AND YEAR(H.OrderDate) BETWEEN 2011 AND 2014
GROUP BY
YEAR(H.OrderDate), MONTH(H.OrderDate)
ORDER BY
Year, Month;