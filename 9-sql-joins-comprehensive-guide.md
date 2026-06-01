# SQL Basics: Mastering Joins (INNER, LEFT, RIGHT, FULL)

This practical guide demonstrates how to combine data from multiple tables using relational SQL `JOIN` statements. By setting up a specific data anomaly (deleting a referenced customer), we clearly illustrate how each join type handles matching and non-matching records.

---

## 🛠️ Step 0: Preparing the Data Scenario

To clearly see how `NULL` propagation and unmatched rows work in different joins, we intentionally delete a customer (`customer_id = 77`) who already has an order placed in the `orders` table.

```sql
-- Remove a specific customer to create an unmatched relational state
DELETE FROM customers WHERE customer_id = 77;`````
```

An INNER JOIN returns records that have matching values in both tables. If an order belongs to a customer_id that does not exist in the customers table (like our deleted ID 77), that entire row is excluded from the results.
SELECT o.customer_id, o.order_date, c.customer_id, c.customer_name
FROM public.orders o
INNER JOIN public.customers c ON o.customer_id = c.customer_id;

Result Table
(Notice that Customer 77 is completely missing here because it cannot find a match in the customers table).
customer_id (Order)order_datecustomer_id (Customer)customer_name21996-09-182Ana Trujillo Emparedados y helados371996-09-1937Hungry Owl All-Night Grocers

2. LEFT JOIN / LEFT OUTER JOIN (Keep All Left Records)
A LEFT JOIN returns all records from the left table (orders), and the matched records from the right table (customers). If there is no match, the right side returns NULL.

SELECT o.customer_id, o.order_date, c.customer_id, c.customer_name
FROM public.orders o
LEFT JOIN public.customers c ON o.customer_id = c.customer_id;

customer_id (Order)	order_date	customer_id (Customer)	customer_name
2	1996-09-18	2	Ana Trujillo Emparedados y helados
37	1996-09-19	37	Hungry Owl All-Night Grocers
77	1996-09-20	NULL	NUL

3. RIGHT JOIN / RIGHT OUTER JOIN (Keep All Right Records)
A RIGHT JOIN returns all records from the right table (customers), and the matched records from the left table (orders). If a customer hasn't placed any orders yet, the order details will return NULL.

SELECT o.customer_id, o.order_date, c.customer_id, c.customer_name
FROM public.orders o
RIGHT JOIN public.customers c ON o.customer_id = c.customer_id
LIMIT 5;

customer_id (Order)	order_date	customer_id (Customer)	customer_name
2	1996-09-18	2	Ana Trujillo Emparedados y helados
37	1996-09-19	37	Hungry Owl All-Night Grocers
NULL	NULL	20	Ernst Handel
NULL	NULL	82	Trail's Head Gourmet Provisioners
NULL	NULL	25	Frankenversand

4. FULL JOIN / FULL OUTER JOIN (The Complete Matrix)
A FULL JOIN combines the behavior of both LEFT and RIGHT joins. It returns all records when there is a match in either left or right table. It exposes unmatched orders AND unordered customers in a single view.

SELECT o.customer_id, o.order_date, c.customer_id, c.customer_name
FROM public.orders o
FULL JOIN public.customers c ON o.customer_id = c.customer_id
LIMIT 5;

customer_id (Order)	order_date	customer_id (Customer)	customer_name
2	1996-09-18	2	Ana Trujillo Emparedados y helados
37	1996-09-19	37	Hungry Owl All-Night Grocers
77	1996-09-20	NULL	NULL (Unmatched Order)
NULL	NULL	20	Ernst Handel (Unmatched Customer)
NULL	NULL	82	Trail's Head Gourmet Provisioner

🎯 Quick Mental Model Cheat Sheet
INNER JOIN: Only rows where keys match in BOTH tables.

LEFT JOIN: Everything from the Left table + matches from the Right table.

RIGHT JOIN: Everything from the Right table + matches from the Left table.

FULL JOIN: Everything from BOTH tables, matching them where possible, filling NULLs where not.
