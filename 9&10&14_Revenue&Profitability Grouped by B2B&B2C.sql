--PPT9,10,14. Revenue&Profitability Grouped by B2B/B2C
SELECT 
    YEAR(H.OrderDate) AS OrderYear,
    DATENAME(MONTH, H.OrderDate) AS OrderMonth,
    MONTH(H.OrderDate) AS OrderMonthNumber,  -- Add this for correct ordering
    C.CustomerID,
    C.StoreID,
    SUM((D.UnitPrice * D.OrderQty) * (1 - D.UnitPriceDiscount)) AS Revenue,
    SUM(P.StandardCost * D.OrderQty) AS Cost,
    SUM(((D.UnitPrice * D.OrderQty) * (1 - D.UnitPriceDiscount)) - (P.StandardCost * D.OrderQty)) AS Profit,
	 CASE 
        WHEN C.StoreID IS NULL THEN 'B2C'
        ELSE 'B2B'
    END AS CustomerType
FROM 
    Sales.SalesOrderHeader H
JOIN 
    Sales.SalesOrderDetail D ON H.SalesOrderID = D.SalesOrderID
JOIN 
    Production.Product P ON D.ProductID = P.ProductID
JOIN 
    Sales.Customer C ON H.CustomerID = C.CustomerID
GROUP BY 
    YEAR(H.OrderDate),
    DATENAME(MONTH, H.OrderDate),
    MONTH(H.OrderDate),
    C.CustomerID,
    C.StoreID
ORDER BY 
    OrderYear,
    OrderMonthNumber,
    C.CustomerID;