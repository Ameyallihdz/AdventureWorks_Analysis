--PPT32. Cost by Products
SELECT  
    PC.Name AS ProductCategory,
    SUM(P.StandardCost * D.OrderQty) AS TotalStandardCost,
    SUM(D.UnitPrice * D.OrderQty * (1 - D.UnitPriceDiscount)) AS TotalRevenue,
    SUM((D.UnitPrice * D.OrderQty * (1 - D.UnitPriceDiscount)) - (P.StandardCost * D.OrderQty)) AS TotalProfit,
    ROUND(
        SUM((D.UnitPrice * D.OrderQty * (1 - D.UnitPriceDiscount)) - (P.StandardCost * D.OrderQty)) /
        NULLIF(SUM(D.UnitPrice * D.OrderQty * (1 - D.UnitPriceDiscount)), 0) * 100, 2
    ) AS ProfitMarginPercentage
FROM 
    Sales.SalesOrderDetail D
JOIN 
    Sales.SalesOrderHeader H ON D.SalesOrderID = H.SalesOrderID
JOIN 
    Production.Product P ON D.ProductID = P.ProductID
JOIN 
    Production.ProductSubcategory PSC ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
JOIN 
    Production.ProductCategory PC ON PSC.ProductCategoryID = PC.ProductCategoryID
-- Join to include customer type (optional, useful if you want to add a filter or breakdown)
JOIN 
    Sales.Customer C ON H.CustomerID = C.CustomerID
GROUP BY  
    PC.Name
ORDER BY  
    TotalProfit DESC;