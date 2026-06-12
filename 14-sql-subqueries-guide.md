SQL Subqueries: Finding Maximum Values Dynamically
A subquery (or inner query) is a query nested inside another SQL statement. It allows you to use the result of one query as a dynamic condition for another.

The Problem
If you want to find the customer with the highest income in the USA, you cannot simply write WHERE income = MAX(income) because aggregate functions like MAX() cannot be used directly in a WHERE clause.

Instead, we use a subquery to calculate the maximum value first, and then pass that exact value to the outer query.

1. Finding the Customer with the Max Income (USA)
This query uses a subquery to find the exact highest income among US customers, then pulls the full profile of whichever customer matches that specific number.

SELECT 
    customer_name, 
    income, 
    city, 
    country 
FROM public.customers 
WHERE income = (
    -- The Subquery: Calculates the top US income first
    SELECT MAX(income) 
    FROM public.customers 
    WHERE country = 'USA'
);

customer_name,income,city,country
Rattlesnake Canyon Grocery,93560.00,Albuquerque,USA
🧠 How This Query Executes Under the Hood
SQL splits the workload into two sequential steps:

Step 1 (Inner Query): SQL executes the query inside the parentheses first. It scans all customers in the USA and finds that the maximum income is 93560.0.

Step 2 (Outer Query): SQL replaces the subquery with that calculated number, turning the main query into a simple filter:

SELECT customer_name, income, city, country 
FROM customers 
WHERE income = 93560.0;
