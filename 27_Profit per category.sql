--PPT27. Profit per category
SELECT 
    PC.Name AS ProductCategory,
    SUM(D.OrderQty) AS TotalOrderQuantity,
    SUM(D.OrderQty * P.StandardCost) AS TotalStandardCost,
    SUM((D.UnitPrice * D.OrderQty) * (1 - D.UnitPriceDiscount)) AS TotalRevenue,
    SUM(((D.UnitPrice * D.OrderQty) * (1 - D.UnitPriceDiscount)) - (P.StandardCost * D.OrderQty)) AS TotalProfit,
    ROUND(
        SUM(((D.UnitPrice * D.OrderQty) * (1 - D.UnitPriceDiscount)) - (P.StandardCost * D.OrderQty)) / 
        NULLIF(SUM((D.UnitPrice * D.OrderQty) * (1 - D.UnitPriceDiscount)), 0) * 100, 2
    ) AS ProfitMarginPercentage,
    CASE 
        WHEN SUM(D.OrderQty) > 10000 AND 
             ROUND(
                SUM(((D.UnitPrice * D.OrderQty) * (1 - D.UnitPriceDiscount)) - (P.StandardCost * D.OrderQty)) / 
                NULLIF(SUM((D.UnitPrice * D.OrderQty) * (1 - D.UnitPriceDiscount)), 0) * 100, 2
             ) < 20 THEN 'High Volume, Low Margin'
        WHEN SUM(D.OrderQty) < 3000 AND 
             ROUND(
                SUM(((D.UnitPrice * D.OrderQty) * (1 - D.UnitPriceDiscount)) - (P.StandardCost * D.OrderQty)) / 
                NULLIF(SUM((D.UnitPrice * D.OrderQty) * (1 - D.UnitPriceDiscount)), 0) * 100, 2
             ) > 30 THEN 'Low Volume, High Margin'
        ELSE 'Balanced or Moderate'
    END AS PerformanceCategory
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
GROUP BY 
    PC.Name
ORDER BY 
    TotalStandardCost DESC;
