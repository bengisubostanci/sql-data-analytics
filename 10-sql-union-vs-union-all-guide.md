# SQL Basics: Combining Datasets with UNION and UNION ALL

The `UNION` and `UNION ALL` operators are used to combine the result sets of two or more `SELECT` statements into a single, unified result set. This guide explains how they work, their structural requirements, and when to use each for maximum performance.

---

## 📋 The 3 Golden Rules of UNION Operations

For a `UNION` or `UNION ALL` query to execute successfully, all participant queries must respect these database constraints:
1. **Column Count:** Each `SELECT` statement must have the exact same number of columns.
2. **Data Types:** Corresponding columns must share identical or compatible data types.
3. **Column Order:** Columns must be structured in the exact same logical order from left to right.

---

## 1. UNION (Distinct Values Only)

The `UNION` operator combines datasets and **removes duplicate rows** automatically. It behaves like a mathematical set union, leaving only unique rows behind.

```sql
-- Combine orders tables (Duplicates will be filtered out)
SELECT * FROM orders 
UNION
SELECT * FROM orders;
```

order_id	customer_id	employee_id	order_date	shipper_id
10308	2	7	1996-09-18	3
10309	37	3	1996-09-19	1
10310	77	8	1996-09-20	2

2. UNION ALL (Keeps Duplicates)
The UNION ALL operator combines datasets and keeps all rows, including duplicates. It simply appends the second result set directly underneath the first one without checking for identical values.
-- Combine orders tables (Duplicates will be preserved)
SELECT * FROM orders 
UNION ALL
SELECT * FROM orders;

order_id	customer_id	employee_id	order_date	shipper_id
10308	2	7	1996-09-18	3
10309	37	3	1996-09-19	1
10310	77	8	1996-09-20	2
10308	2	7	1996-09-18	3
10309	37	3	1996-09-19	1
10310	77	8	1996-09-20	2

🛡️ Performance Insight: Which one should you choose?
When working with large databases, choosing between UNION and UNION ALL has a major impact on memory and speed:

Use UNION ALL by default: Because it doesn't care about duplicates, the database engine just pipes the data straight to the screen. It is extremely fast and light on resources.

Use UNION only when necessary: To drop duplicates, SQL has to perform a hidden DISTINCT sort operation behind the scenes. This causes heavy CPU and disk utilization on millions of rows.

🧠 Interview Cheat Sheet: If you already know that the two tables you are combining have completely different data (meaning no duplicates can possibly exist), always use UNION ALL to save execution time!
