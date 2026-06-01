Execute precise UPDATE
Using the Primary Key (customer_id = 70) ensures that we modify exactly this row and avoid accidentally modifying any other customer named "Santé Gourmet".
-- Increase Santé Gourmet's income directly to 54,000
UPDATE customers 
SET income = 54000 
WHERE customer_id = 70;

Verify the updated value
SELECT * FROM customers 
WHERE customer_name = 'Santé Gourmet';

customer_idcustomer_namecontact_nameaddresscitypostalcodecountryincome70Santé GourmetJonas BergulfsenErling Skakkes gate 78Stavern4110Norway54000.0

2. Bulk Updating Multiple Rows Conditionallly
You can also update multiple rows simultaneously by targeting non-unique conditions (such as a demographic or geographic field like country).

Step A: Analyze affected rows beforehand
Run a SELECT statement using the exact conditional clause you plan to pass into your UPDATE statement. This ensures no unexpected records are caught in the update loop.
SELECT * FROM customers 
WHERE country = 'Italy';

customer_id	customer_name	contact_name	address	city	postalcode	country	income
27	Franchi S.p.A.	Paolo Accorti	Via Monte Bianco 34	Torino	10100	Italy	31320.0
49	Magazzini Alimentari Riuniti	Giovanni Rovelli	Via Ludovico il Moro 22	Bergamo	24100	Italy	17500.0
66	Reggiani Caseifici	Maurizio Moroni	Strada Provinciale 124	Reggio Emilia	42100	Italy	18980.0

Apply programmatic increment updates
Instead of assigning a static fixed number, we can dynamically increment existing values mathematically (income = income + 5000).
-- Apply a programmatic +5000 income raise to all customers in Italy
UPDATE customers 
SET income = income + 5000 
WHERE country = 'Italy';

Confirm changes across target domain
SELECT * FROM customers 
WHERE country = 'Italy';

customer_id	customer_name	contact_name	address	city	postalcode	country	income
27	Franchi S.p.A.	Paolo Accorti	Via Monte Bianco 34	Torino	10100	Italy	36320.0
49	Magazzini Alimentari Riuniti	Giovanni Rovelli	Via Ludovico il Moro 22	Bergamo	24100	Italy	22500.0
66	Reggiani Caseifici	Maurizio Moroni	Strada Provinciale 124	Reggio Emilia	42100	Italy	23980.0

💡 Best Practices for Safe SQL Updates
The SELECT-Before-UPDATE Pattern: Always change UPDATE table SET ... to SELECT * FROM table with the exact same WHERE conditions first to review what you are about to change.

Use Transactions: When working on live staging or production systems, wrap mutations inside transaction blocks:
BEGIN TRANSACTION;
UPDATE customers SET income = 60000 WHERE customer_id = 70;
-- Check results carefully...
COMMIT; -- or ROLLBACK; if a mistake was made

Save to a file
with open("sql-data-modification-and-safe-updates.md", "w", encoding="utf-8") as f:
f.write(md_content)

print("Markdown file successfully generated.")

