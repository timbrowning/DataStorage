USE [AdventureWorks2017];
USE [AdventureWorksDWX];


select * from DimSalesTerritory;
select * from DimGeography;

SELECT 
CurrencyCode AS CurrencyAlternateKey, 
Name AS CurrencyName
FROM Sales.Currency;

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

SELECT DISTINCT 
    a.City AS City, 
    statep.StateProvinceCode AS StateProvinceCode, 
    statep.[Name] AS StateProvinceName, 
    countryr.CountryRegionCode AS CountryRegionCode, 
    countryr.[Name] AS EnglishCountryRegionName, 
    regionName.SpanishCountryRegionName AS SpanishCountryRegionName, 
    regionName.FrenchCountryRegionName AS FrenchCountryRegionName, 
    a.PostalCode AS PostalCode, 
    customer.TerritoryID AS SalesTerritoryKey
FROM Person.Address AS a 
    INNER JOIN Person.StateProvince AS statep 
    ON a.StateProvinceID = statep.StateProvinceID
    INNER JOIN Person.CountryRegion AS countryr 
    ON statep.CountryRegionCode = countryr.CountryRegionCode
    INNER JOIN [sales].[CustomerAddress] AS customera 
    ON a.AddressID = customera.AddressID
    INNER JOIN [sales].Customer AS customer 
    ON customera.CustomerID = customer.CustomerID 
    INNER JOIN [sales].SalesTerritory AS salest 
    ON customer.TerritoryID = salest.TerritoryID 
    LEFT OUTER JOIN dbo.[tempCountryRegion-ForeignNames] AS regionName 
    ON statep.CountryRegionCode = regionName.CountryRegionCode 
WHERE (salest.TerritoryID IS NOT NULL)
ORDER BY countryr.CountryRegionCode, statep.StateProvinceCode, a.City;
   
   


SELECT DISTINCT 
    a.[City] AS [City], 
    sp.[StateProvinceCode] AS [StateProvinceCode], 
    sp.[Name] AS [StateProvinceName], 
    cr.[CountryRegionCode] AS [CountryRegionCode], 
    cr.[Name] AS [EnglishCountryRegionName], 
    crfn.[SpanishCountryRegionName] AS [SpanishCountryRegionName], 
    crfn.[FrenchCountryRegionName] AS [FrenchCountryRegionName], 
    a.[PostalCode] AS [PostalCode], 
    c.[TerritoryID] AS [SalesTerritoryKey] 
FROM [Person].[Address] AS a 
    INNER JOIN [Person].[StateProvince] AS sp 
    ON a.[StateProvinceID] = sp.[StateProvinceID] 
    INNER JOIN [Person].[CountryRegion] AS cr 
    ON sp.[CountryRegionCode] = cr.[CountryRegionCode] 
    INNER JOIN [Sales].[CustomerAddress] AS ca 
    ON a.[AddressID] = ca.[AddressID] 
    INNER JOIN [Sales].[Customer] AS c 
    ON ca.[CustomerID] = c.[CustomerID] 
    INNER JOIN [Sales].[SalesTerritory] AS st 
    ON c.[TerritoryID] = st.[TerritoryID] 
    LEFT OUTER JOIN [dbo].[tempCountryRegion-ForeignNames] AS crfn 
    ON sp.[CountryRegionCode] = crfn.[CountryRegionCode] 
WHERE (st.[TerritoryID] IS NOT NULL)
ORDER BY cr.[CountryRegionCode], sp.[StateProvinceCode], a.[City];