CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO customers VALUES
(1, 'Nguyễn Văn A', 'Hà Nội'),
(2, 'Trần Thị B', 'Đà Nẵng'),
(3, 'Lê Văn C', 'Hồ Chí Minh'),
(4, 'Phạm Thị D', 'Hà Nội');

INSERT INTO orders VALUES
(101, 1, '2024-12-20', 3000),
(102, 2, '2025-01-05', 1500),
(103, 1, '2025-02-10', 2500),
(104, 3, '2025-02-15', 4000),
(105, 4, '2025-03-01', 800);

INSERT INTO order_items VALUES
(1, 101, 1, 2, 1500),
(2, 102, 2, 1, 1500),
(3, 103, 3, 5, 500),
(4, 104, 2, 4, 1000);

SELECT 
    c.customer_name,
    SUM(o.total_price) AS total_revenue,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING SUM(o.total_price) > 2000;

SELECT 
    c.customer_name,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id
HAVING SUM(oi.quantity * oi.price) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(oi.quantity * oi.price) AS total_spent
        FROM orders o
        JOIN order_items oi ON o.order_id = oi.order_id
        GROUP BY o.customer_id
    ) AS sub
);

SELECT 
    c.city,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.city
HAVING SUM(oi.quantity * oi.price) = (
    SELECT MAX(city_revenue)
    FROM (
        SELECT 
            c.city,
            SUM(oi.quantity * oi.price) AS city_revenue
        FROM customers c
        JOIN orders o ON c.customer_id = o.customer_id
        JOIN order_items oi ON o.order_id = oi.order_id
        GROUP BY c.city
    ) AS sub
);

SELECT 
    c.customer_name,
    c.city,
    SUM(oi.quantity) AS total_products,
    SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name, c.city;