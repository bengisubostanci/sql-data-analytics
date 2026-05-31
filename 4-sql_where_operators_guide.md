# Comprehensive SQL Data Filtering Cheat Sheet

This module demonstrates how to limit row results, search patterns, manage multi-condition logical validation, and range-filter variables across database tables.

---

## 1. The `WHERE` Clause & Conditional Operators

The `WHERE` clause filters rows that fulfill specified search metrics. 

### A) Filtering Text Matching Exactly
sql
-- Retrieve all operational metrics for accounts located in Germany
SELECT * FROM public.customers
WHERE country = 'Germany';

customer_id	customer_name	contact_name	city	country	annual_income
1	Alfreds Futterkiste	Maria Anders	Berlin	Germany	48630.00
6	Blauer See Delikatessen	Hanna Moos	Mannheim	Germany	16410.00
17	Drachenblut Delikatessend	Sven Ottlieb	Aachen	Germany	60520.00
25	Frankenversand	Peter Franken	München	Germany	69370.00
39	Königlich Essen	Philip Cramer	Brandenburg	Germany	66390.00
44	Lehmanns Marktstand	Renate Messner	Frankfurt a.M.	Germany	29170.00
52	Morgenstern Gesundkost	Alexander Feuer	Leipzig	Germany	16220.00
56	Ottilies Käseladen	Henriette Pfalzheim	Köln	Germany	96710.00
63	QUICK-Stop	Horst Kloss	Cunewalde	Germany	94780.00
79	Toms Spezialitäten	Karin Josephs	Münster	Germany	38390.00
86	Die Wandernde Kuh	Rita Müller	Stuttgart	Germany	74300.00



B) Available Relational Operators
These operators can be integrated natively within any filtering execution branch:

Operator	Action	SQL Implementation Example
=	Equality Test	WHERE country = 'Mexico'
>	Strictly Greater Than	WHERE annual_income > 50000
<	Strictly Less Than	WHERE annual_income < 30000
>=	Greater Than or Equal To	WHERE annual_income >= 25000
<=	Less Than or Equal To	WHERE annual_income <= 75000
<> or !=	Inequality Test	WHERE country != 'USA'
BETWEEN	Inclusive Evaluation Range	WHERE annual_income BETWEEN 10000 AND 20000
LIKE	Wildcard Character Alignment Pattern	WHERE contact_name LIKE 'A%'
IN	Set-Membership Matrix Filter	WHERE country IN ('Germany', 'France')

2. Logical Operators: Combining Conditions
A) The AND Operator (Strict Intersect)
Requires both expressions to resolve true simultaneously.
-- Find specific localized customer entries matching exact state/city pairs
SELECT * FROM public.customers
WHERE country = 'France' AND city = 'Strasbourg';

customer_id	customer_name	contact_name	city	country	annual_income
7	Blondel père et fils	Frédérique Citeaux	Strasbourg	France	26220.00

B) The OR Operator (Inclusive Union)
Returns values if at least one condition tests true.
-- Find any entity representing France OR specifically based inside the city of Strasbourg
SELECT * FROM public.customers
WHERE country = 'France' OR city = 'Strasbourg';

customer_id	customer_name	city	country	annual_income
7	Blondel père et fils	Strasbourg	France	26220.00
9	Bon app'	Marseille	France	20200.00
18	Du monde entier	Nantes	France	52700.00
23	Folies gourmandes	Lille	France	91600.00
26	France restauration	Nantes	France	28830.00
40	La corne d'abondance	Versailles	France	71990.00
41	La maison d'Asie	Toulouse	France	84460.00
57	Paris spécialités	Paris	France	57170.00
74	Spécialités du monde	Paris	France	66180.00
84	Victuailles en stock	Lyon	France	81820.00
85	Vins et alcools Chevalier	Reims	France	97090.00

C) The NOT Negative Filter Exception
-- Return total dataset excluding entities inside Germany
SELECT * FROM public.customers
WHERE NOT country = 'Germany';

3. Complex Conditional Intersect Logic (NOT, AND, OR)
When mixing operators, use parenthesis () to enforce correct logical prioritization.
-- Target target accounts in France or Spain, explicitly avoiding capital locations
SELECT * FROM public.customers 
WHERE (country = 'France' OR country = 'Spain') 
  AND NOT city = 'Madrid';

customer_id	customer_name	city	country	annual_income
7	Blondel père et fils	Strasbourg	France	26220.00
9	Bon app'	Marseille	France	20200.00
18	Du monde entier	Nantes	France	52700.00
23	Folies gourmandes	Lille	France	91600.00
26	France restauration	Nantes	France	28830.00
29	Galería del gastrónomo	Barcelona	Spain	73110.00
30	Godos Cocina Típica	Sevilla	Spain	85480.00
40	La corne d'abondance	Versailles	France	71990.00
41	La maison d'Asie	Toulouse	France	84460.00
57	Paris spécialités	Paris	France	57170.00
74	Spécialités du monde	Paris	France	66180.00
84	Victuailles en stock	Lyon	France	81820.00
85	Vins et alcools Chevalier	Reims	France	97090.00

4. Advanced Evaluation Queries (LIKE, IN, BETWEEN)
A) Text Wildcard Layout Filtering (LIKE)
The % character captures any string length variable configuration sequence.

-- Identify contact targets whose registration profile starts with 'A'
SELECT * FROM public.customers 
WHERE contact_name LIKE 'A%';

customer_id	customer_name	contact_name	country	annual_income
2	Ana Trujillo Emparedados y helados	Ana Trujillo	Mexico	21470.00
3	Antonio Moreno Taquería	Antonio Moreno	Mexico	92640.00
19	Eastern Connection	Ann Devon	UK	59230.00
21	Familia Arquibaldo	Aria Cruz	Brazil	75570.00
31	Gourmet Lanchonetes	André Fonseca	Brazil	25990.00
41	La maison d'Asie	Annette Roulet	France	84460.00
52	Morgenstern Gesundkost	Alexander Feuer	Germany	16220.00
69	Romero y tomillo	Alejandra Camino	Spain	87010.00
75	Split Rail Beer & Ale	Art Braunschweiger	USA	44520.00
81	Tradição Hipermercados	Anabela Domingues	Brazil	65300.00

B) Set Matching Operator (IN)
Replaces multiple redundant OR conditions with a clean, performant checklist arrays array structure.

-- Pull names filtering strictly across our primary European hubs
SELECT customer_name, country 
FROM public.customers 
WHERE country IN ('Germany', 'France', 'UK') 
LIMIT 5;

customer_name	country
Alfreds Futterkiste	Germany
Around the Horn	UK
Blauer See Delikatessen	Germany
Blondel père et fils	France
Bon app'	France

C) Numeric Bounds Range Tracking (BETWEEN)
Evaluates value variables bounding an entry spectrum inclusive of both threshold extremities.

-- Isolate operational metrics within low-income thresholds
SELECT customer_name, country, annual_income AS income 
FROM public.customers 
WHERE annual_income BETWEEN 10000 AND 20000;

customer_name	country	income
Blauer See Delikatessen	Germany	16410.00
Ernst Handel	Austria	11140.00
Magazzini Alimentari Riuniti	Italy	19010.00
Morgenstern Gesundkost	Germany	16220.00
Piccolo und mehr	Austria	11550.00
Reggiani Caseifici	Italy	17570.00
Tortuga Restaurante	Mexico	16070.00
