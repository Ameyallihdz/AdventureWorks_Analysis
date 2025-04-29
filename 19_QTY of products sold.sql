--PPT19. QTY of products sold
SELECT 
    YEAR(soh.OrderDate) AS Year,
    MONTH(soh.OrderDate) AS Month,
    CASE 
        WHEN c.StoreID IS NULL THEN 'B2C'
        ELSE 'B2B'
    END AS CustomerType,
    SUM(sod.OrderQty) AS TotalQuantitySold
FROM 
    Sales.SalesOrderHeader soh
JOIN 
    Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN 
    Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN 
    Production.Product p ON sod.ProductID = p.ProductID
GROUP BY 
    YEAR(soh.OrderDate),
    MONTH(soh.OrderDate),
    CASE 
        WHEN c.StoreID IS NULL THEN 'B2C'
        ELSE 'B2B'
    END
ORDER BY 
    Year,
    Month,
    CustomerType;