/* Dim DimCurrency */
IF NOT EXISTS (SELECT * FROM [sys].[tables] WHERE [object_id] = OBJECT_ID(N'[dbo].[DimCurrency]') AND OBJECTPROPERTY([object_id], N'IsUserTable') = 1)
CREATE TABLE dbo.DimCurrency(
	CurrencyKey int IDENTITY(1,1) NOT NULL,
	CurrencyAlternateKey nchar(3) NOT NULL,
	CurrencyName nvarchar(50) NOT NULL
 )ON [PRIMARY];

 /* Dim DimSalesTerritory */
 IF NOT EXISTS (SELECT * FROM [sys].[tables] WHERE [object_id] = OBJECT_ID(N'[dbo].[DimSalesTerritory]') AND OBJECTPROPERTY([object_id], N'IsUserTable') = 1)

CREATE TABLE dbo.DimSalesTerritory(
	SalesTerritoryKey int IDENTITY(1,1) NOT NULL,
	SalesTerritoryAlternateKey int NULL,
	SalesTerritoryRegion nvarchar(50) NOT NULL,
	SalesTerritoryCountry nvarchar(50) NOT NULL,
	SalesTerritoryGroup nvarchar(50) NULL
) ON [PRIMARY];

/* Dim DimGeography */
IF NOT EXISTS (SELECT * FROM [sys].[tables] WHERE [object_id] = OBJECT_ID(N'[dbo].[DimGeography]') AND OBJECTPROPERTY([object_id], N'IsUserTable') = 1)
 CREATE TABLE dbo.DimGeography(
	GeographyKey int IDENTITY(1,1) NOT NULL,
	City nvarchar(30) NULL,
	StateProvinceCode nvarchar(3) NULL,
	StateProvinceName nvarchar(50) NULL,
	CountryRegionCode nvarchar(3) NULL,
	EnglishCountryRegionName nvarchar(50) NULL,
	PostalCode nvarchar(15) NULL
) ON [PRIMARY];

/* Dim DimProductCategory */
IF NOT EXISTS (SELECT * FROM [sys].[tables] WHERE [object_id] = OBJECT_ID(N'[dbo].[DimProductCategory]') AND OBJECTPROPERTY([object_id], N'IsUserTable') = 1)
CREATE TABLE dbo.DimProductCategory(
	ProductCategoryKey int IDENTITY(1,1) NOT NULL,
	ProductCategoryAlternateKey int NULL,
	EnglishProductCategoryName nvarchar(50) NOT NULL
) ON [PRIMARY];

/* Dim DimProductSubcategory */
IF NOT EXISTS (SELECT * FROM [sys].[tables] WHERE [object_id] = OBJECT_ID(N'[dbo].[DimProductSubcategory]') AND OBJECTPROPERTY([object_id], N'IsUserTable') = 1)
CREATE TABLE dbo.DimProductSubcategory(
	ProductSubcategoryKey int IDENTITY(1,1) NOT NULL,
	ProductSubcategoryAlternateKey int NULL,
	EnglishProductSubcategoryName nvarchar(50) NOT NULL,
	ProductCategoryKey int NULL
) ON [PRIMARY];

/* Dim DimProduct */
IF NOT EXISTS (SELECT * FROM [sys].[tables] WHERE [object_id] = OBJECT_ID(N'[dbo].[DimProduct]') AND OBJECTPROPERTY([object_id], N'IsUserTable') = 1)
CREATE TABLE dbo.DimProduct(
	ProductKey int IDENTITY(1,1) NOT NULL,
	ProductAlternateKey nvarchar(25) NULL,
	ProductSubcategoryKey [int] NULL,
	WeightUnitMeasureCode nchar(3) NULL,
	SizeUnitMeasureCode nchar(3) NULL,
	EnglishProductName nvarchar(50) NOT NULL,
	StandardCost money NULL,
	FinishedGoodsFlag bit NOT NULL,
	Color nvarchar(15) NOT NULL,
	SafetyStockLevel smallint NULL,
	ReorderPoint smallint NULL,
	ListPrice money NULL,
	Size nvarchar(50) NULL,
	Weight float NULL,
	DaysToManufacture int NULL,
	ProductLine nchar(2) NULL,
	DealerPrice money NULL,
	Class nchar(2) NULL,
	Style nchar(2) NULL,
	ModelName nvarchar(50) NULL,
	LargePhoto varbinary(max) NULL,
	EnglishDescription nvarchar(400) NULL,
	FrenchDescription nvarchar(400) COLLATE French_CI_AS NULL,
	ChineseDescription nvarchar(400) COLLATE Chinese_PRC_CI_AI NULL,
	ArabicDescription nvarchar(400) COLLATE Arabic_CI_AS NULL,
	HebrewDescription nvarchar(400) COLLATE Hebrew_CI_AS NULL,
	ThaiDescription nvarchar(400) COLLATE Thai_CI_AS NULL,
	StartDate datetime NULL,
	EndDate datetime NULL,
	Status nvarchar(7) NULL
) ON [PRIMARY];

/* Dim DimPromotion */
IF NOT EXISTS (SELECT * FROM [sys].[tables] WHERE [object_id] = OBJECT_ID(N'[dbo].[DimPromotion]') AND OBJECTPROPERTY([object_id], N'IsUserTable') = 1)
CREATE TABLE dbo.[DimPromotion](
	PromotionKey int IDENTITY(1,1) NOT NULL,
	PromotionAlternateKey int NULL,
	EnglishPromotionName nvarchar(255) NULL,
	DiscountPct float NULL,
	EnglishPromotionType nvarchar(50) NULL,
	EnglishPromotionCategory nvarchar(50) NULL,
	StartDate datetime NOT NULL,
	EndDate datetime NULL,
	MinQty int NULL,
	MaxQty int NULL
) ON [PRIMARY];

/* Dim DimCustomer */
IF NOT EXISTS (SELECT * FROM [sys].[tables] WHERE [object_id] = OBJECT_ID(N'[dbo].[DimCustomer]') AND OBJECTPROPERTY([object_id], N'IsUserTable') = 1)
CREATE TABLE dbo.DimCustomer(
	CustomerKey int IDENTITY(1,1) NOT NULL,
	GeographyKey int NULL,
	CustomerAlternateKey nvarchar(15) NOT NULL,
	Title nvarchar(8) NULL,
	FirstName nvarchar(50) NULL,
	MiddleName nvarchar(50) NULL,
	LastName nvarchar(50) NULL,
	NameStyle bit NULL,
	AddressLine1 nvarchar(120) NULL,
	AddressLine2 nvarchar(120) NULL
) ON [PRIMARY];

/* Dim DimDate */
IF NOT EXISTS (SELECT * FROM [sys].[tables] WHERE [object_id] = OBJECT_ID(N'[dbo].[DimDate]') AND OBJECTPROPERTY([object_id], N'IsUserTable') = 1)
CREATE TABLE dbo.DimDate(
	DateKey int IDENTITY(1,1) NOT NULL,
	FullDateAlternateKey [datetime] NULL,
	DayNumberOfWeek tinyint NULL,
	EnglishDayNameOfWeek nvarchar(30) NULL,
	DayNumberOfMonth tinyint NULL,
	DayNumberOfYear smallint NULL,
	WeekNumberOfYear tinyint NULL,
	EnglishMonthName nvarchar(30) NULL,
	MonthNumberOfYear tinyint NULL,
	CalendarQuarter tinyint NULL,
	CalendarYear char(4) NULL,
	CalendarSemester tinyint NULL,
	FiscalQuarter [tinyint] NULL,
	FiscalYear char(4) NULL,
	FiscalSemester tinyint NULL
) ON [PRIMARY];

/* Dim FactInterntSales */
IF NOT EXISTS (SELECT * FROM [sys].[tables] WHERE [object_id] = OBJECT_ID(N'[dbo].[FactInternetSales]') AND OBJECTPROPERTY([object_id], N'IsUserTable') = 1)
CREATE TABLE dbo.FactInternetSales (
	ProductKey int NOT NULL,
	OrderDateKey int NOT NULL,
	DueDateKey int NOT NULL,
	ShipDateKey int NOT NULL,
	CustomerKey int NOT NULL,
	PromotionKey int NOT NULL,
	CurrencyKey int NOT NULL,
	SalesTerritoryKey int NOT NULL,
	SalesOrderNumber nvarchar (25) NOT NULL,
	[SalesOrderLineNumber] int NOT NULL,
	RevisionNumber tinyint NULL,
	OrderQuantity smallint NULL,
	UnitPrice money NULL,
	ExtendedAmount money NULL,
	UnitPriceDiscountPct float NULL,
	DiscountAmount float NULL,
	ProductStandardCost money NULL,
	TotalProductCost money NULL,
	SalesAmount money NULL,
	TaxAmt money NULL,
	Freight money NULL,
	CarrierTrackingNumber nvarchar (25) NULL,
	CustomerPONumber nvarchar (25) NULL 
) ON [PRIMARY];

USE master
USE [AdventureWorks2017];
USE [AdventureWorksDWX];
USE [AdventureWorksDW2017];

Select * from DimGeography;
Select * from DimSalesTerritory;
Select * from DimProductCategory;
Select * from DimProductSubcategory;
Select * from DimProduct;
Select * from DimPromotion;
Select * from DimCustomer;
Select * from Sales.SpecialOffer;

select * FROM [AdventureWorks2017].[Sales].[Customer] cu 
    INNER JOIN [AdventureWorks2017].Person.Person co ON cu.CustomerID = co.BusinessEntityID; 