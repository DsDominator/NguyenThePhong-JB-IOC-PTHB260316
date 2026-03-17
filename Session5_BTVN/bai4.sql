CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount NUMERIC(10,2)
);

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_name VARCHAR(100),
    quantity INT,
    price NUMERIC(10,2)
);

INSERT INTO customers (customer_name, city) VALUES
('Hoàng Văn E', 'Hà Nội'),
('Nguyễn Thị F', 'Đà Nẵng'),
('Trần Văn G', 'Cần Thơ'),
('Lê Thị H', 'Hồ Chí Minh'),
('Nguyễn Văn F', 'Hà Nội'),
('Nguyễn Thị G', 'Hà Nội');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2025-03-05', 4500),
(2, '2025-03-06', 2000),
(3, '2025-03-07', 3500),
(4, '2025-03-08', 1200),
(5, '2025-05-07', 7000),
(6, '2025-08-09', 4000);

INSERT INTO order_items (order_id, product_name, quantity, price) VALUES
(1, 'Laptop HP', 1, 4500),
(2, 'Chuột Logitech', 2, 1000),
(3, 'Bàn phím cơ', 1, 3500),
(4, 'Tai nghe Sony', 2, 600),
(5, 'Bàn phím cơ', 2, 3500),
(6, 'Chuột Logitech', 4, 1000);

SELECT 
    c.customer_name AS customer_name,
    o.order_date AS order_date,
    o.total_amount AS total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

SELECT 
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_order_value,
    MAX(total_amount) AS max_order,
    MIN(total_amount) AS min_order,
    COUNT(order_id) AS order_count
FROM orders;

SELECT 
    c.city,
    SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 10000;

SELECT 
    c.customer_name,
    o.order_date,
    oi.product_name,
    oi.quantity,
    oi.price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id;

SELECT 
    c.customer_name,
    SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) = (
    SELECT MAX(total_spent)
    FROM (
        SELECT SUM(total_amount) AS total_spent
        FROM orders
        GROUP BY customer_id
    ) sub
);

SELECT city FROM customers

UNION

SELECT DISTINCT c.city
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

SELECT city FROM customers

INTERSECT

SELECT DISTINCT c.city
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;
