
USE Retail_Supermarket

SELECT * FROM [dbo].[SampleSuperstore]

-- How much profit per Region?
SELECT 
Region
,SUM(Profit) as Sum_profit
,SUM(Sales) as Sum_sales
From [dbo].[SampleSuperstore]
group by Region
ORDER BY Region DESC

--Which city has the highes profit?
SELECT top 1
City
,SUM(Profit) as Sum_profit
-- ,SUM(Sales) AS Sum_Sales
From [dbo].[SampleSuperstore]
group by City
ORDER BY Sum_profit DESC

-- What is the quantity of Ship_mode?
SELECT 
Ship_Mode
,COUNT(*) as count_of_ship_mode
-- ,sum(sales) as sum_sales
-- ,sum(Profit) as sum_profit
from SampleSuperstore
group BY Ship_Mode
ORDER BY count_of_ship_mode DESC

-- Which order has the highest revenue in California State?
SELECT top 1
*
from [dbo].[SampleSuperstore]
where [State] = 'California'
ORDER BY Sales DESC

-- How much revenue and profit in California?
SELECT
[State]
, SUM(Sales) as Revenue_Cali
--, SUM(Profit) as Profit_Cali
--, SUM(Quantity) as quantity_Cali 
from SampleSuperstore
GROUP BY [State]
HAVING [State] = 'California'

--How much segment have discount?
WITH discount as
    (SELECT * FROM SampleSuperstore
    where Discount > 0)
SELECT
Segment
, count(*) as count_of_segment
from discount  
GROUP BY Segment
ORDER BY count_of_segment DESC  


-- Top 3 Sub_category have revenue highest Califonia State

SELECT top 3
[State]
, Sub_Category
, SUM(Sales) AS Sum_Revenue_cali
--, SUM(Profit) AS Sum_profit_Cali
--, SUM(Quantity) AS Sum_Quantity_Cali
From SampleSuperstore
GROUP BY [State], Sub_Category
HAVING [State] = 'California'
ORDER BY Sum_Revenue_cali DESC

-- How much order have discount California State?
WITH disount_order as
    (SELECT * 
    , CASE
        when Discount > 0 then 'Y'
        else 'N'
    END as Y_N_Discount
    from SampleSuperstore)
SELECT
[State]
,count(Y_N_Discount) as number_of_order_discount
from disount_order
GROUP BY [State], Y_N_Discount
HAVING [State] = 'California' and Y_N_Discount = 'Y'


