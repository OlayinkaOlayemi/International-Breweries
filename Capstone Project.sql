create table international_breweries
( sales_id int primary key,
 sales_rep varchar null,
 email varchar,
 brands varchar,
 plant_cost numeric,
 unit_price numeric,
 quantity int,
 cost numeric,
 profit numeric,
 country varchar,
 region varchar,
 month text,
 year varchar
 );
 select * from international_breweries
 
 copy international_breweries
 from 'C:\Users\DELL\Videos\UDI SQL CLASSES\International_Breweries.csv'
 delimiter ',' csv
 header 
 
 select distinct country from international_breweries
 
SELECT * FROM international_breweries
 		
		PROFIT ANALYSIS
		
/* 1. Within the space of the last three years, what was the profit worth of the breweries,
inclusive of the anglophone and the francophone territories?  */

SELECT SUM(profit) total_profit_for_3_years
FROM international_breweries

/* 2. Compare the total profit between these two territories in order for the territory manager,
Mr. Stone made a strategic decision that will aid profit maximization in 2020 */
--ANGLOPHONE
select country, sum (profit) as total_profit from international_breweries
where country in('Nigeria', 'Ghana')
group by 1
-- FRANCOPHONE
select country, sum (profit) as total_profit from international_breweries
where country not in ('Nigeria', 'Ghana')
group by 1

-- 3. Country that generated the highest profit in 2019
select country, sum (profit) as profit_2019 from international_breweries
where year = '2019'
group by 1
order by 2 desc
limit 1

-- 4. Help him find the year with the highest profit.
select year, sum (profit) as highest_profit from international_breweries
group by 1
order by 2 desc
limit 1

-- 5. Which month in the three years was the least profit generated?
select year, month, sum (profit) as least_profit from international_breweries
group by 1, 2
order by 3 asc
limit 1

-- 6. What was the minimum profit in the month of December 2018?
SELECT year, month,TO_CHAR (MIN(profit),'l99,999')profit
FROM international_breweries
WHERE month = 'December' AND year = '2018'
GROUP BY 1,2

-- 7. Compare the profit in percentage for each of the month in 2019
SELECT month, SUM(cost) AS "Cost Price", SUM(profit) AS "Monthly Profit",
to_char((SUM(profit)/SUM(cost)),'FM0.99%') As "Profit % Per Month" 
FROM international_breweries
WHERE year = '2019'
GROUP BY 1
ORDER BY to_date(month, 'month')

-- 8. Which particular brand generated the highest profit in Senegal?
SELECT brands, SUM(profit) total_profit
FROM international_breweries
WHERE country = 'Senegal'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

BRAND ANALYSIS

/* 1. Within the last two years, the brand manager wants to know the top three brands
consumed in the francophone countries */
SELECT brands top_brands, SUM(quantity) quantity_sold, SUM(profit) profit
FROM international_breweries
WHERE year NOT IN ('2017') AND country NOT IN ('Nigeria', 'Ghana')
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3

-- 2. Find out the top two choice of consumer brands in Ghana
SELECT brands top_brands, SUM(quantity) quantity_sold, SUM(profit) profit
FROM international_breweries
WHERE country = ('Ghana')
GROUP BY 1
ORDER BY 2 DESC
LIMIT 2

/* 3. Find out the details of beers consumed in the past three years in the most oil reached
country in West Africa.*/
select brands, sum(quantity) as quantity_sold, sum(profit) as profit from international_breweries
where country = 'Nigeria' and brands not in ('grand malt', 'beta malt')
group by 1
order by 2 asc

-- 4. Favorites malt brand in Anglophone region between 2018 and 2019
select brands, sum(quantity) as quantity, sum (profit) as total_profit from international_breweries
where country in ('Nigeria', 'Ghana') and year not in ('2017') and brands in ('beta malt', 'grand malt')
group by 1
order by 2 desc

-- 5. Which brands sold the highest in 2019 in Nigeria?
select year, country, brands, sum(quantity) as qty_sold from international_breweries
where country in ('Nigeria') and year in ('2019')
group by 1,2,3
order by 4 desc

--6. Favorites brand in South_South region in Nigeria
select distinct region from international_breweries

select brands, sum(quantity) as qty, sum(profit) as profit from international_breweries
where country in ('Nigeria') and region in ('southsouth')
group by 1
order by 2 desc

-- 7. Beer consumption in Nigeria
select brands, sum(quantity) as Quantity_consumed from international_breweries
where country in ('Nigeria') and brands not in ('grand malt', 'beta malt')
group by 1
order by 2 desc

-- 8. Level of consumption of Budweiser in the regions in Nigeria
select brands, region, sum(quantity) as Quantity_consumed from international_breweries
where country in ('Nigeria') and brands in ('budweiser')
group by 1,2
order by 3 desc

--9. Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)
select brands, region, sum(quantity) as Quantity_consumed from international_breweries
where country in ('Nigeria') and brands in ('budweiser') and year in ('2019')
group by 1,2
order by 3 desc


Session C
COUNTRIES ANALYSIS
--1. Country with the highest consumption of beer.
select country, sum(quantity) as Quantity_consumed, sum(profit) as Total_profit 
from international_breweries
where brands not in ('grand malt, beta malt')
group by 1
order by 2 desc

--2. Highest sales personnel of Budweiser in Senegal
SELECT sales_rep, email, SUM(quantity) quantity_sold, SUM(profit) profit_generated
FROM international_breweries
WHERE brands = 'budweiser' and country = 'Senegal'
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 1

--3. Country with the highest profit of the fourth quarter in 2019
SELECT country, TO_CHAR(SUM(profit),'l9,999999') total_profit
FROM international_breweries
WHERE month IN ('October', 'November', 'December') AND year = '2019'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
