CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(101, '2024-01-10', 250.50),
(102, '2024-01-12', 180.00),
(101, '2024-01-15', 320.75),
(103, '2024-01-18', 150.25),
(104, '2024-01-20', 500.00);

CREATE INDEX idx_orders_customer_id
ON Orders (customer_id);

EXPLAIN ANALYZE
SELECT * 
FROM Orders 
WHERE customer_id = 101;

