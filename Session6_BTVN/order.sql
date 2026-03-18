CREATE TABLE OrderInfo (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total NUMERIC(10,2),
    status VARCHAR(20)
);

INSERT INTO OrderInfo (customer_id, order_date, total, status) VALUES
(1, '2024-10-05', 600000, 'Completed'),
(2, '2024-10-10', 450000, 'Pending'),
(3, '2024-09-25', 800000, 'Completed'),
(4, '2024-10-15', 300000, 'Cancelled'),
(5, '2024-10-20', 1000000, 'Pending');

SELECT *
FROM OrderInfo
WHERE total > 500000;

SELECT *
FROM OrderInfo
WHERE order_date BETWEEN '2024-10-01' AND '2024-10-31';

SELECT *
FROM OrderInfo
WHERE status <> 'Completed';

SELECT *
FROM OrderInfo
ORDER BY order_date DESC
LIMIT 2;