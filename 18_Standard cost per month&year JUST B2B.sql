--PPT18. Standard cost per month&year JUST B2B
SELECT
    YEAR(H.OrderDate) AS Year,
    MONTH(H.OrderDate) AS Month,
    SUM(P.StandardCost * D.OrderQty) AS TotalStandardCost
FROM 
    Sales.SalesOrderHeader H
JOIN 
    Sales.SalesOrderDetail D ON H.SalesOrderID = D.SalesOrderID
JOIN 
    Production.Product P ON D.ProductID = P.ProductID
JOIN 
    Sales.Customer C ON H.CustomerID = C.CustomerID
WHERE 
    C.StoreID IS NOT NULL  -- B2B customers only
GROUP BY 
    YEAR(H.OrderDate), 
    MONTH(H.OrderDate)
ORDER BY 
    Year, Month;