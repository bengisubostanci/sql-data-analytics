# 📊 Sorting Query Results with ORDER BY

The `ORDER BY` keyword is used to sort the result-set in ascending or descending order. By default, SQL sorts records in ascending (`ASC`) order.

All examples below target our standard data infrastructure housed within the `ecommerce_customers_v2.csv` data cluster.

---

## 1. Ascending Sort (`ASC` - Default)

When you omit the sorting direction keyword, SQL automatically assumes an ascending structure (A to Z, lowest numeric value to highest).

sql
-- Explicitly sort customers alphabetically by country name
SELECT customer_id, customer_name, city, country, annual_income
FROM public.customers 
ORDER BY country ASC 
LIMIT 10;

customer_idcustomer_namecitycountryannual_income59Piccolo und mehrSalzburgAustria$11,550.0020Ernst HandelGrazAustria$11,140.0031Gourmet LanchonetesCampinasBrazil$25,990.0081Tradição HipermercadosSão PauloBrazil$65,300.0021Familia ArquibaldoSão PauloBrazil$75,570.0040La corne d'abondanceVersaillesFrance$71,990.0057Paris spécialitésParisFrance$57,170.0026France restaurationNantesFrance$28,830.0074Spécialités du mondeParisFrance$66,180.0023Folies gourmandesLilleFrance$91,600.00

2. Descending Sort (DESC)
To reverse the natural sequence order, explicitly append the DESC modifier keyword to your conditional column reference.
-- Sort customers starting from Z to A by country name
SELECT customer_id, customer_name, city, country, annual_income
FROM public.customers 
ORDER BY country DESC 
LIMIT 10;

customer_id	customer_name	city	country	annual_income
75	Split Rail Beer & Ale	Lander	USA	$44,520.00
4	Around the Horn	London	UK	$76,610.00
19	Eastern Connection	London	UK	$59,230.00
5	Berglunds snabbköp	Luleå	Sweden	$91,220.00
30	Godos Cocina Típica	Sevilla	Spain	$85,480.00
29	Galería del gastrónomo	Barcelona	Spain	$73,110.00
69	Romero y tomillo	Madrid	Spain	$87,010.00
2	Ana Trujillo Emparedados y helados	México D.F.	Mexico	$21,470.00
80	Tortuga Restaurante	México D.F.	Mexico	$16,070.00
3	Antonio Moreno Taquería	México D.F.	Mexico	$92,640.00

3. Advanced Sorting: Multi-Column Ordering
You can specify multiple columns in the ORDER BY clause. The engine sorts rows by the first column argument first. If duplicate values exist within that column segment, rows are sub-sorted by the secondary column definition.

-- Sort records primarily by country alphabetically, then sub-sort cities alphabetically
SELECT customer_id, customer_name, city, country, annual_income
FROM public.customers 
ORDER BY country ASC, city ASC 
LIMIT 10;

customer_id	customer_name	city	country	annual_income
20	Ernst Handel	Graz	Austria	$11,140.00
59	Piccolo und mehr	Salzburg	Austria	$11,550.00
31	Gourmet Lanchonetes	Campinas	Brazil	$25,990.00
21	Familia Arquibaldo	São Paulo	Brazil	$75,570.00
81	Tradição Hipermercados	São Paulo	Brazil	$65,300.00
23	Folies gourmandes	Lille	France	$91,600.00
84	Victuailles en stock	Lyon	France	$81,820.00
9	Bon app'	Marseille	France	$20,200.00
18	Du monde entier	Nantes	France	$52,700.00
26	France restauration	Nantes	France


