SQL Joins Cheat Sheet: Practical Examples
This guide demonstrates how different types of SQL JOINs work using a practical scenario.

The Setup Scenario
Imagine we deleted a customer (customer_id = 77) from the customers table, but that customer still has an active order in the orders table. This creates a mismatch that perfectly illustrates how INNER, LEFT, RIGHT, and FULL joins handle missing data.

-- Preparing the data state
DELETE FROM customers WHERE customer_id = 77;

1. INNER JOIN
Returns only the rows where there is a match in both tables. Since Customer 77 was deleted, their order is excluded from the results.
SELECT 
    o.customer_id AS order_cust_id, 
    o.order_date, 
    c.customer_id AS cust_id,  
    c.customer_name
FROM public.orders o
INNER JOIN public.customers c ON o.customer_id = c.customer_id;

order_cust_id,order_date,cust_id,customer_name
2,1996-09-18,2,Ana Trujillo Emparedados y helados
37,1996-09-19,37,Hungry Owl All-Night Grocers

2. LEFT JOIN (Left Outer Join)
Returns all rows from the left table (orders), and the matched rows from the right table (customers). If no match is found, NULL values are returned for the right table's columns. Notice how Customer 77 appears here, but with empty customer details.
SELECT 
    o.customer_id AS order_cust_id, 
    o.order_date, 
    c.customer_id AS cust_id,  
    c.customer_name
FROM public.orders o
LEFT JOIN public.customers c ON o.customer_id = c.customer_id;

order_cust_id,order_date,cust_id,customer_name
2,1996-09-18,2,Ana Trujillo Emparedados y helados
37,1996-09-19,37,Hungry Owl All-Night Grocers
77,1996-09-20,NULL,NULL

3. RIGHT JOIN (Right Outer Join)
Returns all rows from the right table (customers), and the matched rows from the left table (orders). Customers who haven't placed any orders (like IDs 20, 82, 25) will show NULL for the order details.
SELECT 
    o.customer_id AS order_cust_id, 
    o.order_date, 
    c.customer_id AS cust_id,  
    c.customer_name
FROM public.orders o
RIGHT JOIN public.customers c ON o.customer_id = c.customer_id
LIMIT 5;

order_cust_id,order_date,cust_id,customer_name
2,1996-09-18,2,Ana Trujillo Emparedados y helados
37,1996-09-19,37,Hungry Owl All-Night Grocers
NULL,NULL,20,Ernst Handel
NULL,NULL,82,Trail's Head Gourmet Provisioners
NULL,NULL,25,Frankenversand

4. FULL JOIN (Full Outer Join)
Returns all rows when there is a match in either left or right table. It combines the behavior of both LEFT and RIGHT joins. You will see the orphaned order (Customer 77) and the customers without orders (IDs 20, 82).
SELECT 
    o.customer_id AS order_cust_id, 
    o.order_date, 
    c.customer_id AS cust_id,  
    c.customer_name
FROM public.orders o
FULL JOIN public.customers c ON o.customer_id = c.customer_id
LIMIT 5;

order_cust_id,order_date,cust_id,customer_name
2,1996-09-18,2,Ana Trujillo Emparedados y helados
37,1996-09-19,37,Hungry Owl All-Night Grocers
77,1996-09-20,NULL,NULL
NULL,NULL,20,Ernst Handel
NULL,NULL,82,Trail's Head Gourmet Provisioners
