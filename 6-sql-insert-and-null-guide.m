# SQL Basics: INSERT INTO Usage and NULL Value Control

This guide covers the fundamentals of inserting data into a SQL table—both for all columns and specific columns—and demonstrates how to filter records using `NULL` and `NOT NULL` conditions.

---

## 1. Inserting Data into All Columns

When adding a complete row, you list all the column names followed by their respective values in the exact same order.

```sql
INSERT INTO customers (customer_name, contact_name, address, city, postalcode, country, income)
VALUES ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway', 38500);

2. Inserting Data into Specific Columns
You don't always have to fill every column. If a column allows NULL values or has a default fallback, you can safely omit it from your INSERT statement.
INSERT INTO customers (customer_name, city, country)
VALUES ('Cardinal', 'Stavanger', 'Norway');

3. Verifying the Results
Let's fetch all clients located in Norway to see how our inserts look in the database.
SELECT * FROM customers WHERE country = 'Norway';

postalcode	country	income
70	Santé Gourmet	Jonas Bergulfsen	Erling Skakkes gate 78	Stavern	4110	Norway	19350.0
92	Cardinal	Tom B. Erichsen	Skagen 21	Stavanger	4006	Norway	38500.0
93	Cardinal	NULL	NULL	Stavanger	NULL	Norway	NULL

4. Filtering with IS NULL
In SQL, NULL represents missing or unknown data. You cannot use the regular equal sign (= NULL) to find these; instead, you must use the IS NULL operator.-- Find records where the income is missing
SELECT * FROM customers 
WHERE country = 'Norway' AND income IS NULL;

customer_id	customer_name	contact_name	address	city	postalcode	country	income
93	Cardinal	NULL	NULL	Stavanger	NULL	Norway	NULL

5. Filtering with IS NOT NULL
Conversely, if you want to exclude missing data and only fetch rows that contain actual values, use the IS NOT NULL operator.
-- Find records where the income is explicitly provided
SELECT * FROM customers 
WHERE country = 'Norway' AND income IS NOT NULL;
-- Find records where the income is explicitly provided
SELECT * FROM customers 
WHERE country = 'Norway' AND income IS NOT NULL;

customer_id	customer_name	contact_name	address	city	postalcode	country	income
70	Santé Gourmet	Jonas Bergulfsen	Erling Skakkes gate 78	Stavern	4110	Norway	19350.0
92	Cardinal	Tom B. Erichsen	Skagen 21	Stavanger	4006	Norway	38500.0
