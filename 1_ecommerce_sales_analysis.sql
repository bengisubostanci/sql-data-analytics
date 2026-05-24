-- Eğer tablo daha önceden varsa temizle
DROP TABLE IF EXISTS sales_orders;

-- Tablo oluşturma
CREATE TABLE sales_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    product_category VARCHAR(50) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(30)
);

-- Temiz ve yapılandırılmış veri ekleme
INSERT INTO sales_orders (order_id, customer_id, order_date, product_category, quantity, unit_price, total_amount, payment_method) 
VALUES 
(1001, 501, '2026-01-15', 'Electronics', 1, 1200.00, 1200.00, 'Credit Card'),
(1002, 502, '2026-01-16', 'Clothing',    3,   45.00,  135.00, 'PayPal'),
(1003, 503, '2026-01-18', 'Home & Living',2,   80.00,  160.00, 'Credit Card'),
(1004, 504, '2026-01-20', 'Electronics', 1,  350.00,  350.00, 'Bank Transfer'),
(1005, 505, '2026-01-22', 'Books',        5,   15.50,   77.50, 'Credit Card');

-- 1. Kategori bazında toplam satış cirosunu getiren sorgu
SELECT 
    product_category, 
    SUM(total_amount) AS total_revenue,
    SUM(quantity) AS total_sold_quantity
FROM sales_orders
GROUP BY product_category
ORDER BY total_revenue DESC;

-- 2. Kredi kartı ile yapılan en yüksek harcamayı bulma
SELECT * FROM sales_orders
WHERE payment_method = 'Credit Card'
ORDER BY total_amount DESC
LIMIT 1;


