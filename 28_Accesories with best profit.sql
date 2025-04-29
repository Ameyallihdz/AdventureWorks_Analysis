--PPT28. Accesories with best profit
SELECT TOP 5
P.Name AS ProductName,
PC.Name AS ProductCategory,
SUM(SD.LineTotal - (SD.OrderQty * P.StandardCost)) AS TotalProfit,
SUM(SD.LineTotal) AS TotalRevenue,
SUM(SD.OrderQty * P.StandardCost) AS TotalCost,
ROUND(SUM(SD.LineTotal - (SD.OrderQty * P.StandardCost)) * 100.0 / SUM(SD.LineTotal), 2) AS ProfitMarginPercent
FROM
Sales.SalesOrderDetail AS SD
JOIN
Production.Product AS P ON SD.ProductID = P.ProductID
JOIN
Production.ProductSubcategory AS PSC ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
JOIN
Production.ProductCategory AS PC ON PSC.ProductCategoryID = PC.ProductCategoryID
WHERE
PC.Name <> 'Bikes' -- Exclude bikes
GROUP BY
P.Name, PC.Name
ORDER BY
TotalProfit DESC;