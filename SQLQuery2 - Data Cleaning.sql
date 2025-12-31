-- Data Cleaning for our Retail Sales Table
USE Retail_Sales_db

-- Checking Count of Records (COUNT INITIAL - 2000)
SELECT 
	COUNT(*) As Total_Records
FROM Retail_Sales;

-- Total Columns
SELECT TOP 1 * FROM Retail_Sales;

-- Checking for Nulls
SELECT * FROM Retail_Sales
WHERE 
	transactions_id IS NULL
	OR 
	sale_date IS NULL
	or 
	sale_time IS NULL
	or 
	customer_id IS NULL
	or 
	gender IS NULL
	or 
	age IS NULL
	or 
	category IS NULL
	or 
	quantiy IS NULL
	or
	price_per_unit IS NULL
	or
	cogs IS NULL
	or
	total_sale IS NULL;

-- DELETE These null records from table
DELETE FROM Retail_Sales
WHERE 
	transactions_id IS NULL
	OR 
	sale_date IS NULL
	or 
	sale_time IS NULL
	or 
	customer_id IS NULL
	or 
	gender IS NULL
	or 
	age IS NULL
	or 
	category IS NULL
	or 
	quantiy IS NULL
	or
	price_per_unit IS NULL
	or
	cogs IS NULL
	or
	total_sale IS NULL;


-- COUNT of rows after deleting all nulls.
SELECT COUNT(*) AS total_rows FROM Retail_Sales;