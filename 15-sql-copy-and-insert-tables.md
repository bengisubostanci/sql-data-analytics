SQL: Copying Data to Tables (SELECT INTO vs. INSERT INTO)
When you need to copy data from one table to another, SQL provides two primary methods depending on whether the target table already exists or needs to be created on the fly.

Command,Target Table Status,What it does
SELECT INTO,❌ Does NOT exist,Creates a new table and inserts the data. (Fails if the table already exists).
INSERT INTO SELECT,Already exists,Appends data into an existing table. (Fails if the table doesn't exist).

SELECT COUNT(1) FROM public.customers;
-- Output: 88 rows

1. SELECT INTO (Create + Insert)
Use this syntax when you want to create a brand new table based on the structure and data of an existing query.

-- Creating a new table with customers earning more than 50,000
SELECT * INTO public.customers_gt_50k
FROM public.customers
WHERE income > 50000;

SELECT customer_name, income 
FROM public.customers_gt_50k 
LIMIT 5;

customer_name,income
Alfreds Futterkiste,67470.00
Ana Trujillo Emparedados y helados,79210.00
Around the Horn,64720.00
Bon app',59430.00
Bottom-Dollar Marketse,67550.00

SELECT COUNT(1) FROM public.customers_gt_50k;
-- Output: 47 rows created in the new table.

2. INSERT INTO SELECT (Insert into Existing Table)
If you try to run SELECT INTO again on customers_gt_50k, SQL will return an error because the table now exists. To append new records to this existing table, you must use INSERT INTO SELECT.

-- Appending rows where income is between 40,000 and 50,000
INSERT INTO public.customers_gt_50k
SELECT * FROM public.customers
WHERE income BETWEEN 40000 AND 50000;
Verifying the Updated Table
SELECT COUNT(1) FROM public.customers_gt_50k;
-- Output: 55 rows




