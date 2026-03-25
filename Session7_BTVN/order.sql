CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer(customer_id),
    total_amount DECIMAL(10,2),
    order_date DATE
);

INSERT INTO customer (full_name, email, phone) VALUES
('Nguyen Van A', 'a@gmail.com', '0901234567'),
('Tran Thi B', 'b@gmail.com', '0912345678'),
('Le Van C', 'c@gmail.com', '0923456789'),
('Pham Thi D', 'd@gmail.com', '0934567890'),
('Hoang Van E', 'e@gmail.com', '0945678901');

INSERT INTO orders (customer_id, total_amount, order_date) VALUES
(1, 300000, '2024-01-15'),
(1, 500000, '2024-02-10'),
(2, 200000, '2024-02-12'),
(3, 700000, '2024-03-05'),
(4, 150000, '2024-03-20'),
(5, 900000, '2024-04-01'),
(2, 400000, '2024-04-15'),
(3, 250000, '2024-05-10'),
(1, 800000, '2024-05-25'),
(4, 600000, '2024-06-18');

CREATE VIEW v_order_summary AS
SELECT 
    c.full_name,
    o.total_amount,
    o.order_date
FROM customer c
JOIN orders o 
ON c.customer_id = o.customer_id;

SELECT * FROM v_order_summary;

CREATE VIEW v_monthly_sales AS
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

CREATE VIEW v_order_update AS
SELECT order_id, customer_id, total_amount, order_date
FROM orders
WHERE total_amount >= 0
WITH CHECK OPTION;

UPDATE v_order_update
SET total_amount = 750000
WHERE order_id = 1;

SELECT * FROM v_monthly_sales;

DROP VIEW v_order_summary;
DROP VIEW v_monthly_sales;