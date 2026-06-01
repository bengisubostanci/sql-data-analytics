# SQL Basics: Data Analytics with Aggregate Functions

This guide covers the core SQL aggregate functions (`MIN`, `MAX`, `COUNT`, `AVG`, and `SUM`). These functions perform calculations on a set of values and return a single summarizing value, which is essential for data analysis and business intelligence reporting.

---

## 1. Finding Extreme Values: MIN and MAX

The `MIN()` function returns the smallest value, and the `MAX()` function returns the largest value of the selected column.

sql
-- Retrieve the lowest and highest customer income simultaneously
SELECT 
    MIN(income) AS min_income, 
    MAX(income) AS max_income 
FROM customers;

min_income	max_income
10690.0	98690.0

2. Statistical Summaries: COUNT, AVG, and SUM
These three functions allow you to perform baseline statistical analysis over entire datasets:

COUNT(): Counts the total number of rows/records.

-- Generate a quick statistical summary of our customers table
SELECT 
    COUNT(customer_id) AS row_count, 
    ROUND(AVG(income), 2) AS mean_income, 
    SUM(income) AS sum_income
FROM customers;

💡 Optimization Note: In the query above, we wrapped AVG(income) inside a ROUND(..., 2) function to clean up the long trailing decimal points (e.g., changing 54092.84090909091 into a clean currency format 54092.84).
row_count	mean_income	sum_income
89	54092.84	4760170.0

⚠️ CRITICAL INTERVIEW KNOWLEDGE: How Aggregates Handle NULLs
One of the most common mistakes in SQL reporting is forgetting how NULL values affect aggregate calculations.

COUNT(*) vs COUNT(column_name):

COUNT(*) counts every row, even if it contains completely blank or NULL data.

COUNT(income) will ignore rows where the income is NULL.

AVG() Automatically Ignores NULL:

If you have 4 customers with incomes: 1000, 2000, 3000, and one NULL.

AVG() will calculate (1000 + 2000 + 3000) / 3 = 2000. It divides by 3, completely ignoring the 4th user.

If you want to treat NULL as 0, you must use COALESCE: AVG(COALESCE(income, 0)).

🚀 Pro-Tip: Combining Aggregates with Filtering
You can seamlessly combine these functions with a WHERE clause to get insights into specific segments:

-- Find the average income of customers living ONLY in Norway
SELECT 
    COUNT(customer_id) AS norway_customer_count,
    ROUND(AVG(income), 2) AS norway_avg_income
FROM customers 
WHERE country = 'Norway';



AVG(): Calculates the mathematical mean (average) of a numeric column.

SUM(): Calculates the total total accumulated sum of a numeric column.
