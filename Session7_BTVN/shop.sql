CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category TEXT[],
    price NUMERIC(10,2)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id),
    order_date DATE,
    quantity INT
);

INSERT INTO customers (full_name, email, city) VALUES
('Nguyen Van A', 'a@gmail.com', 'HCM'),
('Tran Thi B', 'b@gmail.com', 'Ha Noi'),
('Le Van C', 'c@gmail.com', 'Da Nang'),
('Pham Thi D', 'd@gmail.com', 'Can Tho'),
('Hoang Van E', 'e@gmail.com', 'Hai Phong');

INSERT INTO products (product_name, category, price) VALUES
('Laptop Dell', ARRAY['Electronics', 'Computer'], 20000000),
('iPhone 14', ARRAY['Electronics', 'Mobile'], 25000000),
('Chuột Logitech', ARRAY['Accessories'], 500000),
('Bàn phím cơ', ARRAY['Accessories'], 1500000),
('Tai nghe Sony', ARRAY['Electronics', 'Audio'], 3000000);

INSERT INTO orders (customer_id, product_id, order_date, quantity) VALUES
(1, 1, '2024-01-10', 1),
(2, 2, '2024-01-12', 1),
(3, 5, '2024-02-05', 2),
(1, 4, '2024-02-20', 1),
(4, 5, '2024-03-01', 1),
(5, 2, '2024-03-10', 1),
(2, 3, '2024-03-15', 3),
(3, 1, '2024-04-01', 1),
(4, 4, '2024-04-05', 2),
(5, 3, '2024-04-10', 4);
------------Cau 2-----------
CREATE INDEX idx_customers_email 
ON customers(email);

CREATE INDEX idx_customers_city_hash 
ON customers USING HASH(city);

CREATE INDEX idx_products_category 
ON products USING GIN(category);

CREATE EXTENSION IF NOT EXISTS btree_gist;
CREATE INDEX idx_products_price_gist 
ON products USING GIST(price);
------------Cau 3-----------
EXPLAIN ANALYZE
SELECT * FROM customers
WHERE email = 'a@gmail.com';

EXPLAIN ANALYZE
SELECT * FROM products
WHERE category @> ARRAY['Electronics'];

EXPLAIN ANALYZE
SELECT * FROM products
WHERE price BETWEEN 500 AND 1000;
------------Cau 4-----------
CREATE INDEX idx_orders_date 
ON orders(order_date);

CLUSTER orders USING idx_orders_date;
------------Cau 5-----------
CREATE VIEW v_top_customers AS
SELECT 
    c.customer_id,
    c.full_name,
    SUM(o.quantity) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_orders DESC
LIMIT 3;

SELECT * FROM v_top_customers;

CREATE VIEW v_product_revenue AS
SELECT 
    p.product_name,
    SUM(o.quantity * p.price) AS revenue
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name;

SELECT * FROM v_product_revenue;
------------Cau 6-----------
CREATE VIEW v_customer_city AS
SELECT customer_id, full_name, city
FROM customers
WITH CHECK OPTION;

UPDATE v_customer_city
SET city = 'Da Nang'
WHERE customer_id = 1;

SELECT * FROM customers WHERE customer_id = 1;