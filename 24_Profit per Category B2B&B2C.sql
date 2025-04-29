--PPT24. Profit per Category B2B&B2C
With Margin as
				(SELECT
					ISNULL(FORMAT(soh.OrderDate, 'yyyy-MM'), 'TOTAL') AS YearMonth,
					CASE 
						WHEN c.StoreID IS NULL THEN 'B2C'
						ELSE 'B2B'
					END AS CustomerType,
					p.Name AS ProductName,
					pc.productcategoryid AS ProductCategory,
					SUM((sod.UnitPrice - (sod.UnitPrice * sod.UnitPriceDiscount)) * sod.OrderQty) - SUM(p.StandardCost * sod.OrderQty) AS TotalMargin
				FROM
					Sales.SalesOrderDetail AS sod
				JOIN
					Production.Product AS p ON sod.ProductID = p.ProductID
				JOIN
					Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
				JOIN
					Sales.Customer AS c ON soh.CustomerID = c.CustomerID
				JOIN 
					Production.ProductSubcategory AS ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
				JOIN
					Production.ProductCategory AS pc ON ps.ProductCategoryID = pc.ProductCategoryID
				GROUP BY
					soh.OrderDate,
					CASE 
						WHEN c.StoreID IS NULL THEN 'B2C'
						ELSE 'B2B'
					END,
					p.Name,
					pc.ProductCategoryID)
Select YearMonth,
		ProductName,
		ProductCategory,
		CASE
			WHEN ProductCategory = 1 THEN 'Bikes'
			WHEN ProductCategory = 2 THEN 'Components'
			WHEN ProductCategory = 3 THEN 'Clothing'
			ELSE 'Accesories'
		END,
		CustomerType,
		TotalMargin,
		Rank () over (partition by YearMonth
					order by TotalMargin) as MonthRank
From Margin