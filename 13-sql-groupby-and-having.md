SQL GROUP BY and HAVING Clause: Practical Guide
The GROUP BY statement groups rows that have the same values into summary rows, such as "find the number of customers in each country."

It is almost always used with aggregate functions like COUNT(), MAX(), MIN(), SUM(), and AVG() to compile metrics across specific categories.

1. GROUP BY with COUNT()
This query counts the total number of customers residing in each country, sorted from highest to lowest.
SELECT 
    country, 
    COUNT(customer_id) AS customer_count
FROM public.customers 
GROUP BY country
ORDER BY customer_count DESC;

country,customer_count
USA,12
Germany,11
France,11
Brazil,9
UK,7
... (truncated for brevity),

2. GROUP BY with AVG()
This query calculates the average income per country. We use the ROUND() function here to clean up long decimal outputs for better readability.
SELECT 
    country, 
    ROUND(AVG(income), 2) AS avg_income
FROM public.customers 
GROUP BY country

country,avg_income
Brazil,81086.67
Mexico,78248.00
Venezuela,77632.50
Ireland,75500.00
... (truncated for brevity),

3. Combining Multiple Aggregates (COUNT & AVG)
You can request multiple statistical metrics within a single GROUP BY statement.
SELECT 
    country, 
    ROUND(AVG(income), 2) AS avg_income, 
    COUNT(customer_id) AS customer_count
FROM public.customers 
GROUP BY country
ORDER BY avg_income DESC;

country,avg_income,customer_count
Brazil,81086.67,9
Mexico,78248.00,5
Venezuela,77632.50,4
Ireland,75500.00,1
... (truncated for brevity),,

4. Filtering Grouped Data: WHERE vs. HAVING
A common point of confusion is how and where to filter data when grouping.

❌ The Common Syntax Mistake
If you place a WHERE clause after a GROUP BY clause, SQL will throw a syntax error:

-- INVALID SQL (Throws Syntax Error)
SELECT country, AVG(income), COUNT(customer_id)
FROM customers 
GROUP BY country
WHERE country IN ('USA', 'Sweden', 'Brazil'); 
-- Error: syntax error at or near "where"

The Correct SQL Order of Execution
WHERE filters raw rows before any grouping happens.

HAVING filters summary rows after the GROUP BY operation is applied. It is specifically designed to filter on aggregate functions (e.g., HAVING COUNT(customer_id) > 5).

Approach A: Using WHERE (Filtering rows before grouping)
Since country is a regular column (not an aggregate function), we can filter it using a correctly positioned WHERE clause.

SELECT 
    country, 
    ROUND(AVG(income), 2) AS avg_income, 
    COUNT(customer_id) AS customer_count
FROM public.customers 
WHERE country IN ('USA', 'Sweden', 'Brazil') -- Executed 1st
GROUP BY country                             -- Executed 2nd
ORDER BY avg_income DESC;

Approach B: Using HAVING (Filtering after grouping)
Alternatively, you can filter using HAVING after the grouping is complete.
SELECT 
    country, 
    ROUND(AVG(income), 2) AS avg_income, 
    COUNT(customer_id) AS customer_count
FROM public.customers 
GROUP BY country                             -- Executed 1st
HAVING country IN ('USA', 'Sweden', 'Brazil') -- Executed 2nd
ORDER BY avg_income DESC;

country,avg_income,customer_count
Brazil,81086.67,9
USA,50509.17,12
Sweden,20800.00,2

