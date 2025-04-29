--PPT35,36,37. Sales(Revenue), Cost & Profit per region
SELECT 
    YEAR(H.OrderDate) AS OrderYear,
    ST.Name AS Region,
    CASE 
        WHEN C.StoreID IS NULL THEN 'B2C'
        ELSE 'B2B'
    END AS CustomerType,
    SUM((D.UnitPrice * D.OrderQty) * (1 - D.UnitPriceDiscount)) AS Revenue,
    SUM(P.StandardCost * D.OrderQty) AS Cost,
    SUM(((D.UnitPrice * D.OrderQty) * (1 - D.UnitPriceDiscount)) - (P.StandardCost * D.OrderQty)) AS Profit
FROM 
    Sales.SalesOrderHeader H 
JOIN 
    Sales.SalesOrderDetail D ON H.SalesOrderID = D.SalesOrderID
JOIN 
    Production.Product P ON D.ProductID = P.ProductID
JOIN 
    Sales.Customer C ON H.CustomerID = C.CustomerID
JOIN 
    Person.Address A ON H.ShipToAddressID = A.AddressID
JOIN 
    Person.StateProvince SP ON A.StateProvinceID = SP.StateProvinceID
JOIN 
    Sales.SalesTerritory ST ON SP.TerritoryID = ST.TerritoryID
GROUP BY 
    YEAR(H.OrderDate),
    ST.Name,
    CASE 
        WHEN C.StoreID IS NULL THEN 'B2C'
        ELSE 'B2B'
    END
ORDER BY 
    OrderYear,
    Region,
    CustomerType;