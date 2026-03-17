CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    total_price INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_id, product_name, category) VALUES
(1, 'Laptop Dell', 'Electronics'),
(2, 'IPhone 15', 'Electronics'),
(3, 'Bàn học gỗ', 'Furniture'),
(4, 'Ghế xoay', 'Furniture');

INSERT INTO orders (order_id, product_id, quantity, total_price) VALUES
(101, 1, 2, 2200),
(102, 2, 3, 3300),
(103, 3, 5, 2500),
(104, 4, 4, 1600),
(105, 1, 1, 1100);

SELECT 
    p.category,
    SUM(o.total_price) AS total_sales,
    SUM(o.quantity) AS total_quantity
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 2000
ORDER BY total_sales DESC;

SELECT p.product_name, SUM(o.total_price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_id
HAVING SUM(o.total_price) = (
    SELECT MAX(total_sales)
    FROM (
        SELECT SUM(total_price) AS total_sales
        FROM orders
        GROUP BY product_id
    ) AS sub
);

SELECT p.category, SUM(o.total_price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category;

SELECT DISTINCT p.category
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.category
HAVING SUM(o.total_price) = (
    SELECT MAX(product_revenue)
    FROM (
        SELECT SUM(total_price) AS product_revenue
        FROM orders
        GROUP BY product_id
    ) AS sub
)

INTERSECT


SELECT p.category
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 3000;
