
/* Dim Currency */
SELECT 
CurrencyCode AS CurrencyAlternateKey, 
Name AS CurrencyName
FROM Sales.Currency;

/* Dim Sales Territoty */
SELECT 
    salest.TerritoryID AS SalesTerritoryKey, 
    salest.TerritoryID AS SalesTerritoryAlternateKey, 
    salest.[Name] AS SalesTerritoryRegion, 
    countryr.[Name] AS SalesTerritoryCountry, 
	salest.[Group] AS SalesTerritoryGroup 
FROM Sales.SalesTerritory salest 
    INNER JOIN Person.CountryRegion countryr 
    ON salest.CountryRegionCode = countryr.CountryRegionCode 
ORDER BY salest.Name;


/* DimGeography */
SELECT DISTINCT 
    a.City AS City, 
    statep.StateProvinceCode AS StateProvinceCode, 
    statep.[Name] AS StateProvinceName, 
    countryr.CountryRegionCode AS CountryRegionCode, 
    countryr.[Name] AS EnglishCountryRegionName, 
    a.PostalCode AS PostalCode
FROM Person.Address AS a 
    INNER JOIN Person.StateProvince AS statep 
    ON a.StateProvinceID = statep.StateProvinceID
    INNER JOIN Person.CountryRegion AS countryr 
    ON statep.CountryRegionCode = countryr.CountryRegionCode
ORDER BY countryr.CountryRegionCode, statep.StateProvinceCode, a.City;



/* Dim Product Category */

SELECT DISTINCT 
    ProductCategoryID AS ProductCategoryAlternateKey, 
    [Name] AS EnglishProductCategoryName
FROM Production.ProductCategory;

/* Dim Sub Product Category */


	SELECT DISTINCT 
    ps.ProductSubcategoryID AS ProductSubcategoryKey,    
    ps.ProductSubcategoryID AS ProductSubcategoryAlternateKey, 
    ps.[Name] AS EnglishProductSubcategoryName,
    dpc.ProductCategoryKey AS ProductCategoryKey 
FROM AdventureWorks2017.Production.ProductSubcategory ps 
    INNER JOIN dbo.DimProductCategory dpc 
    ON ps.ProductCategoryID = dpc.ProductCategoryAlternateKey;

	/* Dim Product */


	SELECT 
    p.ProductNumber AS ProductAlternateKey, 
    p.ProductSubcategoryID AS ProductSubcategoryKey, 
    p.WeightUnitMeasureCode AS WeightUnitMeasureCode, 
    p.SizeUnitMeasureCode AS SizeUnitMeasureCode, 
    p.[Name] AS EnglishProductName, 
    pch.StandardCost AS StandardCost, 
    p.FinishedGoodsFlag AS FinishedGoodsFlag, 
    COALESCE(p.Color, 'NA') AS Color, 
    p.SafetyStockLevel AS SafetyStockLevel, 
    p.ReorderPoint AS ReorderPoint, 
    plph.ListPrice AS ListPrice, 
    p.Size AS Size,  
    CONVERT(float, p.Weight) AS Weight, 
    p.DaysToManufacture AS DaysToManufacture, 
    p.ProductLine AS ProductLine, 
    p.Class AS Class, 
    p.Style AS Style, 
    pm.[Name] AS ModelName, 
    pp.LargePhoto AS LargePhoto, 
    (SELECT pd.Description FROM [AdventureWorks2017].Production.ProductModelProductDescriptionCulture pmpdc 
        INNER JOIN [AdventureWorks2017].Production.ProductDescription pd 
        ON pmpdc.ProductDescriptionID = pd.ProductDescriptionID 
    WHERE pmpdc.CultureID = 'en' 
        AND pmpdc.ProductModelID = p.ProductModelID) AS EnglishDescription,
    (SELECT pd.Description FROM [AdventureWorks2017].Production.ProductModelProductDescriptionCulture pmpdc 
        INNER JOIN [AdventureWorks2017].Production.ProductDescription pd 
        ON pmpdc.ProductDescriptionID = pd.ProductDescriptionID 
    WHERE pmpdc.CultureID = 'fr' 
        AND pmpdc.ProductModelID = p.ProductModelID) AS FrenchDescription, 
    (SELECT pd.Description FROM [AdventureWorks2017].Production.ProductModelProductDescriptionCulture pmpdc 
        INNER JOIN [AdventureWorks2017].Production.ProductDescription pd 
        ON pmpdc.ProductDescriptionID = pd.ProductDescriptionID 
    WHERE pmpdc.CultureID = 'zh-cht' 
        AND pmpdc.ProductModelID = p.ProductModelID) AS ChineseDescription, 
    (SELECT pd.Description FROM [AdventureWorks2017].Production.ProductModelProductDescriptionCulture pmpdc 
        INNER JOIN [AdventureWorks2017].Production.ProductDescription pd 
        ON pmpdc.ProductDescriptionID = pd.ProductDescriptionID 
    WHERE pmpdc.CultureID = 'ar' 
        AND pmpdc.ProductModelID = p.ProductModelID) AS ArabicDescription, 
    (SELECT pd.Description FROM [AdventureWorks2017].Production.ProductModelProductDescriptionCulture pmpdc 
        INNER JOIN [AdventureWorks2017].Production.ProductDescription pd 
        ON pmpdc.ProductDescriptionID = pd.ProductDescriptionID 
    WHERE pmpdc.CultureID = 'he' 
        AND pmpdc.ProductModelID = p.ProductModelID) AS HebrewDescription, 
    (SELECT pd.Description FROM [AdventureWorks2017].Production.ProductModelProductDescriptionCulture pmpdc 
        INNER JOIN [AdventureWorks2017].Production.ProductDescription pd 
        ON pmpdc.ProductDescriptionID = pd.ProductDescriptionID 
    WHERE pmpdc.CultureID = 'th' 
        AND pmpdc.ProductModelID = p.ProductModelID) AS ThaiDescription, 
    COALESCE(plph.StartDate, pch.StartDate, p.SellStartDate) AS StartDate, 
    COALESCE(plph.EndDate, pch.EndDate, p.SellEndDate) AS EndDate, 
    CASE 
        WHEN COALESCE(plph.EndDate, pch.EndDate, p.SellEndDate) IS NULL THEN N'Current'
        ELSE NULL
    END AS Status --Need to know all the possible values and mapping for this column
FROM [AdventureWorks2017].Production.Product p 
    LEFT OUTER JOIN [AdventureWorks2017].Production.ProductModel pm 
    ON p.ProductModelID = pm.ProductModelID 
    INNER JOIN [AdventureWorks2017].Production.ProductProductPhoto ppp 
    ON p.ProductID = ppp.ProductID 
    INNER JOIN [AdventureWorks2017].Production.ProductPhoto pp 
    ON ppp.ProductPhotoID = pp.ProductPhotoID 
    LEFT OUTER JOIN [AdventureWorks2017].Production.ProductCostHistory pch 
    ON p.ProductID = pch.ProductID
    LEFT OUTER JOIN [AdventureWorks2017].Production.ProductListPriceHistory plph 
    ON p.ProductID = plph.ProductID 
        AND pch.StartDate = plph.StartDate 
        AND COALESCE(pch.EndDate, '12-31-2020') = COALESCE(plph.EndDate, '12-31-2020');


/* Dim Promotion */
		SELECT DISTINCT 
    SpecialOfferID AS PromotionAlternateKey, 
    Description AS EnglishPromotionName, 
    CONVERT(float, DiscountPct) AS DiscountPct, 
    Type AS EnglishPromotionType, 
    Category AS EnglishPromotionCategory, 
    StartDate AS StartDate, 
    EndDate AS EndDate, 
    MinQty AS MinQty, 
    MaxQty AS MaxQty
FROM AdventureWorks2017.Sales.SpecialOffer;

/* Dim Customer */

SELECT 
    c.CustomerID AS [CustomerKey], 
    dg.GeographyKey AS [GeographyKey], 
    CONVERT(nvarchar(15), c.AccountNumber) AS [CustomerAlternateKey], 
    Title AS [Title], 
    FirstName AS [FirstName], 
    MiddleName AS [MiddleName], 
    LastName AS [LastName], 
    NameStyle AS [NameStyle], 
	AddressLine1 AS [AddressLine1],
	AddressLine2 AS [AddressLine2]
FROM [AdventureWorks2017].[Sales].[Customer] AS c
    INNER JOIN [AdventureWorks2017].[Person].[Person] AS p ON c.CustomerID = p.BusinessEntityID 
INNER JOIN [AdventureWorks2017].[Sales].[SalesOrderHeader] so ON p.BusinessEntityID = so.CustomerID 
INNER JOIN [AdventureWorks2017].[Person].[Address] a ON so.BillToAddressID = a.AddressID 
INNER JOIN dbo.DimGeography dg ON a.City = dg.City
ORDER BY c.CustomerID;

/* Dim Date */

declare @startdate date = '2000-01-01',
    @enddate date = '2020-12-31'

IF @startdate IS NULL
    BEGIN
        Select Top 1 @startdate = FulldateAlternateKey
        From DimDate 
        Order By DateKey ASC 
    END

Declare @datelist table (FullDate date)

while @startdate <= @enddate

Begin 
    Insert into @datelist (FullDate)
    Select @startdate

    Set @startdate = dateadd(dd,1,@startdate)

end 

select convert(int,convert(varchar,dl.FullDate,112)) as DateKey,
    dl.FullDate,
    datepart(dw,dl.FullDate) as DayNumberOfWeek,
    datename(weekday,dl.FullDate) as EnglishDayNameOfWeek,
    datepart(d,dl.FullDate) as DayNumberOfMonth,
    datepart(dy,dl.FullDate) as DayNumberOfYear,
    datepart(wk, dl.FUllDate) as WeekNumberOfYear,
    datename(MONTH,dl.FullDate) as EnglishMonthName,
    Month(dl.FullDate) as MonthNumberOfYear,
    datepart(qq, dl.FullDate) as CalendarQuarter,
    year(dl.FullDate) as CalendarYear,
    case datepart(qq, dl.FullDate)
        when 1 then 1
        when 2 then 1
        when 3 then 2
        when 4 then 2
    end as CalendarSemester,
    case datepart(qq, dl.FullDate)
        when 1 then 3
        when 2 then 4
        when 3 then 1
        when 4 then 2
    end as FiscalQuarter,
    case datepart(qq, dl.FullDate)
        when 1 then year(dl.FullDate)
        when 2 then year(dl.FullDate)
        when 3 then year(dl.FullDate) + 1
        when 4 then year(dl.FullDate) + 1
    end as FiscalYear,
    case datepart(qq, dl.FullDate)
        when 1 then 2
        when 2 then 2
        when 3 then 1
        when 4 then 1
    end as FiscalSemester

from @datelist dl left join 
    DimDate dd 
        on dl.FullDate = dd.FullDateAlternateKey
Where dd.FullDateAlternateKey is null

/* Fact Internet Sales */
SELECT 
        dp.[ProductKey] AS [ProductKey], 
        (SELECT [DateKey] FROM [dbo].[DimDate] dt 
            WHERE dt.[FullDateAlternateKey] = soh.[OrderDate]) AS [OrderDateKey],
        (SELECT [DateKey] FROM [dbo].[DimDate] dt 
            WHERE dt.[FullDateAlternateKey] = soh.[DueDate]) AS [DueDateKey],
        (SELECT [DateKey] FROM [dbo].[DimDate] dt 
            WHERE dt.[FullDateAlternateKey] = soh.[ShipDate]) AS [ShipDateKey], 
		soh.[CustomerID] AS [CustomerKey], 
        sod.[SpecialOfferID] AS [PromotionKey], 
        COALESCE(dc.[CurrencyKey], (SELECT CurrencyKey FROM [dbo].[DimCurrency] WHERE CurrencyAlternateKey = N'USD')) AS [CurrencyKey], --Updated to match OLTP which uses the RateID not the currency code.
        soh.[TerritoryID] AS [SalesTerritoryKey],
        soh.[SalesOrderNumber] AS [SalesOrderNumber], 
		sod.[SalesOrderDetailID] AS [SalesOrderLineNumber], 
        soh.[RevisionNumber] AS [RevisionNumber], 
        sod.[OrderQty] AS [OrderQuantity], 
        sod.[UnitPrice] AS [UnitPrice], 
        sod.[OrderQty] * sod.[UnitPrice] AS [ExtendedAmount], 
        sod.[UnitPriceDiscount] AS [UnitPriceDiscountPct], 
        sod.[OrderQty] * sod.[UnitPrice] * sod.[UnitPriceDiscount] AS [DiscountAmount], 
        pch.[StandardCost] AS [ProductStandardCost], 
        sod.[OrderQty] * pch.[StandardCost] AS [TotalProductCost], 
        sod.[LineTotal] AS [SalesAmount], 
        CONVERT(money, sod.[LineTotal] * 0.08) AS [TaxAmt], 
        CONVERT(money, sod.[LineTotal] * 0.025) AS [Freight],
        sod.[CarrierTrackingNumber] AS [CarrierTrackingNumber], 
        soh.[PurchaseOrderNumber] AS [CustomerPONumber] 
   FROM [AdventureWorks2017].[Sales].[SalesOrderHeader] soh 
        INNER JOIN [AdventureWorks2017].[Sales].[SalesOrderDetail] sod 
        ON soh.[SalesOrderID] = sod.[SalesOrderID] 
        INNER JOIN [AdventureWorks2017].[Production].[Product] p 
        ON sod.[ProductID] = p.[ProductID] 
        INNER JOIN [dbo].[DimProduct] dp 
        ON dp.[ProductAlternateKey] = p.[ProductNumber]
        INNER JOIN [AdventureWorks2017].[Sales].[Customer] c 
        ON soh.[CustomerID] = c.[CustomerID] 
        LEFT OUTER JOIN [AdventureWorks2017].[Production].[ProductCostHistory] pch 
        ON p.[ProductID] = pch.[ProductID]      
        LEFT OUTER JOIN [AdventureWorks2017].[Sales].[CurrencyRate] cr 
        ON soh.[CurrencyRateID] = cr.[CurrencyRateID] 
        LEFT OUTER JOIN [dbo].[DimCurrency] dc 
        ON cr.[ToCurrencyCode] = dc.[CurrencyAlternateKey] 
        
    ORDER BY [OrderDateKey], [CustomerKey];
