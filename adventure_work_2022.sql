
use Adventure_Works_2022
-- overview data
SELECT top 5 * FROM [dbo].[Product]
SELECT top 5 * FROM [dbo].[Region]
SELECT top 5 * FROM [dbo].[Reseller]
SELECT top 5 * FROM [dbo].[Sales]
SELECT top 5 * FROM [dbo].[Salesperson]

SELECT * FROM [dbo].[Sales]
where Sales is NULL
ORDER BY 2

-- change data type colunm Sales money type to float
ALTER TABLE Sales
ALTER COLUMN Sales FLOAT

-- Use join and subquery
SELECT 
    r.Region
    --,r.country
    --,r.[GROUP]
    ,SUM(s_20.Sales) as total_revenue
from Region as r
LEFT JOIN (select *
        from Sales
        WHERE OrderDate BETWEEN '2020-01-01' and '2020-12-31') as s_20
on s_20.SalesTerritoryKey = r.SalesTerritoryKey
GROUP BY r.Region
    --,r.country
    --,r.[GROUP]
ORDER BY total_revenue DESC

-- use CTE and case when

with sale_profit AS
    (SELECT 
    *
    , (Sales - Cost) as Profit
    , case 
        when (Sales - Cost) >0 then 'Profitable'
        Else 'Losses'
        END as Tittle
    from Sales)
SELECT 
    p.Category
    , SUM(Profit) as total_profit
    ,sp.Tittle
from sale_profit as sp
LEFT JOIN Product as p
on sp.ProductKey = p.ProductKey
GROUP BY p.Category,sp.Tittle



-- CREATE TEMP TABLE
DROP TABLE IF EXISTS sale_table
CREATE TABLE sale_table
    (
        SalesOrderNumber VARCHAR(50)
        ,OrderDate Date
        ,Quantity NUMERIC
        ,Unit_Price FLOAT
        ,Sales FLOAT
        ,Cost FLOAT
        ,profit FLOAT
        ,Category NVARCHAR(50)
        ,Subcategory NVARCHAR(50)
        ,Product NVARCHAR(50)
        ,Color NVARCHAR(50)
        ,Salesperson NVARCHAR(50)
        ,Title NVARCHAR(50)
        ,Region NVARCHAR(50)
        ,[Group] NVARCHAR(50)
        ,Country NVARCHAR(50)
        ,Business_Type NVARCHAR(50)
        ,Reseller NVARCHAR(50)
    )
INSERT into sale_table
    select 
        s.SalesOrderNumber
        ,s.OrderDate
        ,s.Quantity
        ,s.Unit_Price
        ,s.Sales
        ,s.Cost
        ,(s.Sales - s.Cost) as Profit --add new column profit with sale - cost
        ,p.Category
        ,p.Subcategory
        ,p.Product
        ,p.Color
        ,sp.Salesperson
        ,sp.Title
        ,r.Region
        ,r.[Group]
        ,r.Country
        ,rs.Business_Type
        ,rs.Reseller
    from Sales as s
    left join Product as p
        on s.ProductKey = p.ProductKey
    left join Salesperson AS sp
        on s.EmployeeKey = sp.EmployeeKey
    LEFT JOIN Region as r
        on s.SalesTerritoryKey = r.SalesTerritoryKey
    LEFT JOIN Reseller as rs
        on s.ResellerKey = rs.ResellerKey
    WHERE SalesOrderNumber is not NULL

SELECT * from sale_table
order by 2








