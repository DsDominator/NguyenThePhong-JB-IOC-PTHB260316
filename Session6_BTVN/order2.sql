CREATE TABLE Orders (
	id SERIAL PRIMARY KEY,
	customer_id INT,
	order_date DATE,
	total_amount NUMERIC(10,2)
);
INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2023-01-15', 12000000),
(2, '2023-03-20', 8000000),
(3, '2023-07-10', 15000000),
(1, '2024-02-05', 20000000),
(4, '2024-06-18', 5000000),
(2, '2024-10-22', 25000000),
(5, '2024-12-01', 30000000);

SELECT 
    SUM(total_amount) AS total_revenue,
    COUNT(*) AS total_orders,
    AVG(total_amount) AS average_order_value
FROM Orders;

SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    SUM(total_amount) AS total_revenue
FROM Orders
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY year;

SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    SUM(total_amount) AS total_revenue
FROM Orders
GROUP BY EXTRACT(YEAR FROM order_date)
HAVING SUM(total_amount) > 50000000
ORDER BY year;

SELECT *
FROM Orders
ORDER BY total_amount DESC
LIMIT 5;