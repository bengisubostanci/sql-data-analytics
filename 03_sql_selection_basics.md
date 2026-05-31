📊 SQL Basics: SELECT, Alias, and DISTINCT;

This module covers the absolute fundamentals of querying data from our e-commerce database. We will practice how to retrieve all data, select specific columns, rename columns on the fly, and filter unique values.

1. The SELECT Statement
The SELECT statement is used to fetch data from a database.

A) Retrieving All Columns (SELECT *)
To fetch every single column and row from the customers table, use the asterisk (*) wildcard. We use LIMIT 5 to keep the output concise.

-- Fetch the first 5 customers with all details
SELECT * FROM public.customers 
LIMIT 5;

customer_id,customer_name,contact_name,address,city,postal_code,country,annual_income
1,Alfreds Futterkiste,Maria Anders,Obere Str. 57,Berlin,12209,Germany,67470.00
2,Ana Trujillo Emparedados y helados,Ana Trujillo,Avda. de la Constitución 2222,México D.F.,05021,Mexico,79210.00
3,Antonio Moreno Taquería,Antonio Moreno,Mataderos 2312,México D.F.,05023,Mexico,45090.00
4,Around the Horn,Thomas Hardy,120 Hanover Sq.,London,WA1 1DP,UK,64720.00
5,Berglunds snabbköp,Christina Berglund,Berguvsvägen 8,Luleå,S-958 22,Sweden,30150.00

B) Selecting a Specific Subset of Columns
In production, it is best practice to select only the columns you actually need. This improves query performance.
-- Fetch only the company name and country
SELECT customer_name, country 
FROM public.customers 
LIMIT 5;

customer_name,country
Alfreds Futterkiste,Germany
Ana Trujillo Emparedados y helados,Mexico
Antonio Moreno Taquería,Mexico
Around the Horn,UK
Berglunds snabbköp,Sweden

2. Using Column Aliases (AS)
Aliases are used to give a column or a table a temporary name during the execution of a query. It makes the output headers cleaner and more readable.
-- Rename 'customer_id' to 'id' and 'customer_name' to 'company' in the final output
SELECT 
    customer_id AS id, 
    customer_name AS company
FROM public.customers 
LIMIT 5;

id,company
1,Alfreds Futterkiste
2,Ana Trujillo Emparedados y helados
3,Antonio Moreno Taquería
4,Around the Horn
5,Berglunds snabbköp

3. Extracting Unique Values (DISTINCT)
The DISTINCT keyword is used to return only unique (different) values. It filters out all duplicate rows for the specified columns.
-- Get a unique list of all countries where our customers are located
SELECT DISTINCT country 
FROM public.customers
ORDER BY country ASC; -- Ordered alphabetically for better presentation

country
Argentina
Austria
Belgium
Brazil
Canada
Denmark
Finland
France
Germany
Ireland
Italy
Mexico
Norway
Poland
Portugal
Spain
Sweden
Switzerland
UK
USA
Venezuela



