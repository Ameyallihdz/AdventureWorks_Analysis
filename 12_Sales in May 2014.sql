--PPT12. Why we had a lot of sales in May 2014?
SELECT  
    P.Name AS ProductName,
    SO.Description AS SpecialOffer,
    CASE 
        WHEN C.StoreID IS NULL THEN 'B2C'
        ELSE 'B2B'
    END AS CustomerType,
    SUM(SD.OrderQty) AS TotalQuantitySold,
    SUM(SD.LineTotal) AS TotalSalesAmount
FROM 
    Sales.SalesOrderHeader AS SOH
JOIN 
    Sales.SalesOrderDetail AS SD ON SOH.SalesOrderID = SD.SalesOrderID
JOIN 
    Production.Product AS P ON SD.ProductID = P.ProductID
JOIN 
    Sales.SpecialOfferProduct AS SOP ON P.ProductID = SOP.ProductID 
    AND SD.SpecialOfferID = SOP.SpecialOfferID
JOIN 
    Sales.SpecialOffer AS SO ON SOP.SpecialOfferID = SO.SpecialOfferID
JOIN 
    Sales.Customer AS C ON SOH.CustomerID = C.CustomerID
WHERE 
    SOH.OrderDate >= '2014-05-01' AND SOH.OrderDate < '2014-05-31'
GROUP BY 
    P.Name, SO.Description,
    CASE 
        WHEN C.StoreID IS NULL THEN 'B2C'
        ELSE 'B2B'
    END
ORDER BY 
    TotalQuantitySold DESC;