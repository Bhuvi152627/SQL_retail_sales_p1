CREATE DATABASE sql_project_p2;
 CREATE TABLE retail_sales
 (
   transaction_id INT PRIMARY KEY,
   sale_date DATE,
   sale_time TIME,
   customer_id INT,
   gender VARCHAR(15),
   age INT,
   category VARCHAR(100),
   qunatity INT,
   price_per_unit INT,
   cogs FLOAT,
   total_sale FLOAT
 )
SELECT * FROM retail_sales
LIMIT 10

SELECT COUNT(*)FROM retail_sales;

SELECT * FROM retail_sales
WHERE sale_date IS NULL
--Data Cleaning--
SELECT * FROM retail_sales 
WHERE transaction_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
gender IS NULL
OR
category IS NULL
OR 
qunatity IS NULL
OR 
cogs IS NULL
OR
total_sale IS NULL;

DELETE FROM retail_sales
WHERE transaction_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
gender IS NULL
OR
category IS NULL
OR 
qunatity IS NULL
OR 
cogs IS NULL
OR
total_sale IS NULL;

--Data Exploration--
--How Many sale we have ?
SELECT COUNT(*) as total_sale FROM retail_sales;

--How Many Unique Customer we Have?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;

--Data Analysis 

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

SELECT 
  category,
  SUM(qunatity) AS total_qunatity
FROM 
  retail_sales
WHERE 
  category = 'Clothing' AND
  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' AND
  qunatity >= 4
  GROUP BY
  category;

SELECT
category,
SUM(total_sale) as net_sale,
COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1;

SELECT 
 ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

SELECT * FROM retail_sales
WHERE total_sale > 10000

SELECT
category,
gender,
COUNT(*) as total_trans
FROM retail_sales
GROUP BY 
  category,
  gender
ORDER BY 1

SELECT * FROM
(
SELECT
 EXTRACT(YEAR FROM sale_date) as year,
 EXTRACT(MONTH FROM sale_date) as month,
 AVG(total_sale) as avg_total_sale,
 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC) as rank
FROM retail_sales
GROUP BY 1, 2
)as t1
WHERE rank = 1
--ORDER BY 1, 3 DESC

SELECT 
customer_id,
SUM(total_sale)as Total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

SELECT
 category,
 COUNT(DISTINCT customer_id)
 FROM retail_sales
 GROUP BY category

WITH hourly_sale
AS
(
SELECT *,
 CASE 
  WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
  WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
  ELSE 'Evening'
  END as shift
FROM retail_sales
)
SELECT
shift,
   COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift





