SQL UNION vs. UNION ALL: Quick Guide
The UNION operator is used to combine the result sets of two or more SELECT statements into a single result set.

⚠️ Critical Rules for Using UNION
To combine queries successfully, you must meet these three requirements:

Each SELECT statement within the union must have the same number of columns.

The columns must have similar or compatible data types.

The columns in every SELECT statement must be in the same order.
1. UNION (Distinct Values Only)
The UNION operator selects only distinct values by default. If duplicate rows exist across the queries, it automatically removes them and returns a unique list.

-- Combining the orders table with itself using UNION
SELECT * FROM public.orders 
UNION
SELECT * FROM public.orders;

Output:
Notice how the duplicate records are filtered out, leaving exactly 3 unique rows.
order_id,customer_id,employee_id,order_date,shipper_id
10308,2,7,1996-09-18,3
10309,37,3,1996-09-19,1
10310,77,8,1996-09-20,2

2. UNION ALL (Includes Duplicates)
The UNION ALL operator combines the result sets but retains all duplicate rows. Because it doesn't spend resources scanning for and removing duplicates, UNION ALL is faster than UNION.
-- Combining the orders table with itself using UNION ALL
SELECT * FROM public.orders 
UNION ALL
SELECT * FROM public.orders;
order_id,customer_id,employee_id,order_date,shipper_id
10308,2,7,1996-09-18,3
10309,37,3,1996-09-19,1
10310,77,8,1996-09-20,2
10308,2,7,1996-09-18,3
10309,37,3,1996-09-19,1
10310,77,8,1996-09-20,2

💡 Summary: When to use which?
Use UNION when you absolutely need a unique list and want duplicates removed automatically.

Use UNION ALL when you want to see every single record, or when you already know there are no duplicates, to optimize query performance.



