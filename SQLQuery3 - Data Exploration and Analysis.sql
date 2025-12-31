-- Data Exploration
USE Retail_Sales_db;


-- How many sales we have?
SELECT COUNT(*) as total_sales FROM Retail_Sales;

-- How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) unique_cust FROM Retail_Sales;

-- How many unique categories we have?
SELECT COUNT(DISTINCT category) unique_categ FROM Retail_Sales;

-- Data Analysis & Business Problems.

-- Q.1: Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT *
FROM Retail_Sales
WHERE sale_date = '2022-11-05';



-- Q.2: Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT *
FROM Retail_Sales
WHERE 
	category = 'Clothing'
	AND sale_date >= '2022-11-01' 
	AND sale_date < '2022-12-01'
	AND quantity >= 4;

-- Q.3: Write a SQL query to calculate the total sales(total_sale) for each category?
SELECT 
	category,
	SUM(total_sale) As sales_by_category,
	COUNT(*) AS orders_by_category
FROM Retail_Sales
GROUP BY category;

-- Q.4: Write a SQL Query to find the average age of customers who purchased items from the 'Beauty' category?
SELECT 
	'Beauty' AS category,
	AVG(age) AS avg_age
FROM Retail_Sales
WHERE category = 'Beauty';

-- Q.5: Write a SQL Query to find all transactions where the total_sales is greater than 1000.
SELECT * FROM Retail_Sales
WHERE total_sale > 1000;

-- Q.6: Write a SQL Query to find the total number of transactions (transactions_id) made by each gender in each category?
SELECT
	category,
	gender,
	COUNT(*) as total_transaction
FROM Retail_Sales
GROUP BY gender, category
ORDER BY category;

-- Q.7: Write a SQL query to calculate average sale for each month. find out the best selling month in each year.
SELECT
	year,
	month,
	avg_sale_by_month
FROM
(
	SELECT
		DATEPART(YEAR, sale_date) AS year,
		DATEPART(MONTH, sale_date) AS month,
		AVG(total_sale) AS avg_sale_by_month,
		RANK() OVER(PARTITION BY DATEPART(YEAR, sale_date) ORDER BY AVG(total_sale) DESC) as rank
	FROM Retail_Sales
	GROUP BY DATEPART(YEAR, sale_date), 
			 DATEPART(MONTH, sale_date)
) as t1
WHERE rank = 1
-- ORDER BY DATEPART(YEAR, sale_date), DATEPART(MONTH, sale_date);

-- Q.8: Write a SQL query to find the top 5 customers based on the highest total sales
SELECT TOP 5
	customer_id,
	SUM(total_sale) AS total_sales_by_customer
FROM Retail_Sales
GROUP BY customer_id 
ORDER BY total_sales_by_customer DESC;

-- Q.9: Write a SQL Query to find the number of unique customers who purchased items from each category?
SELECT 
	category,
	COUNT(DISTINCT customer_id) AS unqe_custmr_by_ctgry
FROM Retail_Sales
GROUP BY category;

-- Q.10: Write a SQL Query to create each shift and number of orders (Example Morning <=12, Afternoon between 12 and 17, Evening > 17)?
WITH shiftwise_sale
AS
(
SELECT *,
	CASE 
		WHEN DATEPART(Hour, sale_time) < 12 THEN 'Morning'
		WHEN DATEPART(Hour, sale_time) BETWEEN 12 and 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as Shift
FROM Retail_Sales
)
SELECT 
	Shift,
	COUNT(*) AS total_orders
FROM shiftwise_sale
GROUP BY Shift;


-- Q.11: Write a SQL query to find out total quantity sales for each category?
SELECT 
	category,
	SUM(quantity) total_quantity_sales
FROM Retail_Sales
GROUP BY category;
-- END OF PROJECT
