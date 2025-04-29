--PPT17. QTY of discount per year and month
SELECT  
    P.Name AS ProductName,
    YEAR(H.OrderDate) AS Year,
    MONTH(H.OrderDate) AS Month,
    CASE 
        WHEN C.StoreID IS NULL THEN 'B2C'
        ELSE 'B2B'
    END AS CustomerType,
    AVG(D.UnitPriceDiscount) AS AvgDiscount
FROM Sales.SalesOrderDetail D
JOIN Sales.SalesOrderHeader H ON D.SalesOrderID = H.SalesOrderID
JOIN Sales.Customer C ON H.CustomerID = C.CustomerID
JOIN Production.Product P ON D.ProductID = P.ProductID
GROUP BY P.Name, YEAR(H.OrderDate), MONTH(H.OrderDate), 
         CASE WHEN C.StoreID IS NULL THEN 'B2C' ELSE 'B2B' END
ORDER BY Year, Month, AvgDiscount DESC;