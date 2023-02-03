CREATE DATABASE ForbesDataCompanies;
USE  ForbesDataCompanies;
SELECT * FROM global500companies;
/* After checking table: there are 500 global companies that have 7 columns. 
Rank column is unique number for ever company like ID.
Then there is a name and country of a company.
Next is the sales and profit. 
The last two columns are assets and market value. */

-- #Task1: Find top 3 companies with highest marketvalue
SELECT name, marketvalue
FROM global500companies
ORDER BY marketvalue DESC
LIMIT 3;

-- #Task2: Which 5 countries had most profitable companies on average
SELECT AVG(profit) AS averageprofit, country
FROM global500companies
GROUP BY country
ORDER BY averageprofit DESC
LIMIT 5;

-- #Task3: Retrieve the top 10 companies with the highest sales.
SELECT name, sales 
FROM global500companies
ORDER BY sales DESC
LIMIT 10;

-- #Task4: Find the average sales, profit, and assets of all companies.
SELECT AVG(profit) AS averageprofit, 
AVG(sales) AS averagesales, AVG(assets) AS averageassets
FROM global500companies;

-- #Task5: Find the total sales, profit, and assets for each country.
SELECT SUM(sales), SUM(profit), SUM(assets), country
FROM global500companies
GROUP BY country;

-- Task6: Retrieve the name and country of companies with market value greater than $100 billion.
SELECT name, country
FROM global500companies
WHERE marketvalue > 100000000000;

-- Task7: Find the average market value for each country.
SELECT AVG(marketvalue), country
FROM global500companies
GROUP BY country;

-- Task8: Retrieve the name and country of companies with a profit margin (profit/sales) greater than 10%.
SELECT name, country
FROM global500companies
WHERE (profit/sales) > 0.1;

-- Task9: Retrieve the name of the company with the highest market value.
SELECT name
FROM global500companies
ORDER BY marketvalue DESC
LIMIT 1;

-- Task10: Retrieve the names and countries of companies that have assets greater than the average assets.
WITH cte AS (
  SELECT AVG(assets) AS avg_assets
  FROM global500companies
)
SELECT name, country
FROM global500companies
WHERE assets > (SELECT avg_assets FROM cte);

/* Task11: Create a new column called "Performance" which is calculated as (profit/sales)*100 
and retrieve the names of the top 5 companies with the highest performance. */
ALTER TABLE global500companies
ADD Performance bigint;

UPDATE global500companies
SET Performance = (profit / sales) * 100;

SELECT name
FROM global500companies
ORDER BY performance DESC
LIMIT 5; 

-- Task12: Retrieve the top 10 countries with the highest average market value.
SELECT AVG(marketvalue) AS averagemarketvalue, country
FROM global500companies
GROUP BY country
ORDER BY averagemarketvalue DESC
LIMIT 10;

-- Task13: Find the average sales, profit, and assets for companies in each country, sorted in descending order by average sales.
SELECT AVG(sales) AS avgsales, AVG(profit) AS avgprofit, AVG(assets) AS avgassets, country
FROM global500companies
GROUP BY country
ORDER BY avgsales DESC;

-- Task14: Retrieve the name and country of companies that have a profit margin (profit/sales) greater than the average profit margin.
WITH cte AS (
  SELECT AVG(profit/sales) AS avg_profitmargin
  FROM global500companies
)
SELECT name, country
FROM global500companies
WHERE (profit/sales) > (SELECT avg_profitmargin FROM cte);

-- Task15: Retrieve the name and country of companies with sales greater than the average sales and assets less than the average assets.
WITH cte AS (
  SELECT AVG(sales) AS avg_sales, AVG(assets) AS avg_assets
  FROM global500companies
)
SELECT name, country
FROM global500companies
WHERE sales > (SELECT avg_sales FROM cte) && assets < (SELECT avg_assets FROM cte);

-- Task16: Calculate the sum, average, minimum, and maximum of sales, profit, assets, and market value for all companies.
SELECT SUM(sales) total_sales, AVG(sales) avg_sales, MIN(sales) min_sales, MAX(sales) max_sales,
       SUM(profit) total_profit, AVG(profit) avg_profit, MIN(profit) min_profit, MAX(profit) max_profit,
       SUM(assets) total_assets, AVG(assets) avg_assets, MIN(assets) min_assets, MAX(assets) max_assets,
       SUM(marketvalue) total_marketvalue, AVG(marketvalue) avg_marketvalue, MIN(marketvalue) min_marketvalue, MAX(marketvalue) max_marketvalue
FROM global500companies;

-- Task17: Retrieve the top 5 companies with the highest sales and the top 5 companies with the highest profit.
SELECT name
FROM global500companies
ORDER BY sales DESC
LIMIT 5;

SELECT name
FROM global500companies
ORDER BY profit DESC
LIMIT 5;

/* Task18: Calculate the average sales, profit, assets, and market value for each country, 
and retrieve the countries with the highest average values for each of the 4 categories. */
SELECT 
  MAX(avgsales) max_avgsales, 
  country
FROM 
  (SELECT AVG(sales) avgsales, country
   FROM global500companies
   GROUP BY country) t
GROUP BY country
ORDER BY max_avgsales DESC
LIMIT 1;

SELECT 
  MAX(avgprofit) max_avgprofit, 
  country
FROM 
  (SELECT AVG(profit) avgprofit, country
   FROM global500companies
   GROUP BY country) t
GROUP BY country
ORDER BY max_avgprofit DESC
LIMIT 1;

SELECT 
  MAX(avgassets) max_avgassets, 
  country
FROM 
  (SELECT AVG(assets) avgassets, country
   FROM global500companies
   GROUP BY country) t
GROUP BY country
ORDER BY max_avgassets DESC
LIMIT 1;

SELECT 
  MAX(avgmarketvalue) max_avgmarketvalue, 
  country
FROM 
  (SELECT AVG(marketvalue) avgmarketvalue, country
   FROM global500companies
   GROUP BY country) t
GROUP BY country
ORDER BY max_avgmarketvalue DESC
LIMIT 1;

-- Task19: Find the countries that have more than 10 companies in the global500companies table.
SELECT country, COUNT(*)
FROM global500companies
GROUP BY country
HAVING COUNT(*) > 10;

-- Task20: Find the countries with an average sales of more than $100 billion.
SELECT country, AVG(sales)
FROM global500companies
GROUP BY country
HAVING AVG(sales) > 10000000000;




















