CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    category_id INT,
    price DECIMAL(10,2),
    stock_quantity INT
);

INSERT INTO Products (product_id, category_id, price, stock_quantity) VALUES
(1, 1, 100.00, 50),
(2, 1, 200.00, 30),
(3, 1, 150.00, 20),
(4, 2, 300.00, 10),
(5, 2, 250.00, 15),
(6, 3, 400.00, 5);

CREATE INDEX idx_products_category
ON Products (category_id);

CLUSTER Products USING idx_products_category;

CREATE INDEX idx_products_price

EXPLAIN
SELECT * 
FROM Products
WHERE category_id = 1
ORDER BY price;
ON Products (price);