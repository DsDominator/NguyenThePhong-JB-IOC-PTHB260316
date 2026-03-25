CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    region VARCHAR(50)
);


CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer(customer_id),
    total_amount DECIMAL(10,2),
    order_date DATE,
    status VARCHAR(20)
);

CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    category VARCHAR(50)
);

CREATE TABLE order_detail (
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES product(product_id),
    quantity INT
);

INSERT INTO customer (full_name, region) VALUES
('Nguyen Van A', 'HCM'),
('Tran Thi B', 'Ha Noi'),
('Le Van C', 'Da Nang'),
('Pham Thi D', 'Can Tho'),
('Hoang Van E', 'Hai Phong');

INSERT INTO product (name, price, category) VALUES
('Laptop Dell', 20000000, 'Electronics'),
('iPhone 14', 25000000, 'Electronics'),
('Chuột Logitech', 500000, 'Accessories'),
('Bàn phím cơ', 1500000, 'Accessories'),
('Tai nghe Sony', 3000000, 'Electronics');

INSERT INTO orders (customer_id, total_amount, order_date, status) VALUES
(1, 20500000, '2024-01-10', 'completed'),
(2, 25000000, '2024-01-12', 'completed'),
(3, 3500000, '2024-02-05', 'pending'),
(1, 1500000, '2024-02-20', 'completed'),
(4, 3000000, '2024-03-01', 'cancelled'),
(5, 25500000, '2024-03-10', 'completed'),
(2, 500000, '2024-03-15', 'completed');

INSERT INTO order_detail (order_id, product_id, quantity) VALUES
(1, 1, 1),  
(1, 3, 1),  
(2, 2, 1),  
(3, 5, 1),  
(4, 4, 1),  
(5, 5, 1),  
(6, 2, 1),  
(6, 3, 1),  
(7, 3, 1);  
-------------Cau 1---------------
CREATE VIEW v_revenue_by_region AS
SELECT 
    c.region,
    SUM(o.total_amount) AS total_revenue
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region;

SELECT *
FROM v_revenue_by_region
ORDER BY total_revenue DESC
LIMIT 3;
-------------Cau 2---------------
CREATE VIEW v_order_update AS
SELECT order_id, customer_id, total_amount, order_date, status
FROM orders
WHERE status IN ('pending', 'completed')
WITH CHECK OPTION;

UPDATE v_order_update
SET status = 'completed'
WHERE order_id = 3;

UPDATE v_order_update
SET status = 'cancelled'
WHERE order_id = 3;
-------------Cau 3---------------
CREATE VIEW v_revenue_above_avg AS
SELECT *
FROM v_revenue_by_region
WHERE total_revenue > (
    SELECT AVG(total_revenue)
    FROM v_revenue_by_region
);

SELECT * FROM v_revenue_above_avg;