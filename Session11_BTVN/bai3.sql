CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    stock INT NOT NULL CHECK (stock >= 0),
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    total_amount NUMERIC(10,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INT REFERENCES products(product_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    subtotal NUMERIC(10,2) NOT NULL
);

INSERT INTO products (product_name, stock, price)
VALUES
('Laptop', 10, 1500.00),
('Mouse', 50, 20.00),
('Keyboard', 30, 50.00);

INSERT INTO orders (customer_name, total_amount)
VALUES
('Nguyen Van A', 0),
('Tran Thi B', 0);

INSERT INTO order_items (order_id, product_id, quantity, subtotal)
VALUES
(1, 1, 1, 1500.00),  
(1, 2, 2, 40.00),    
(2, 3, 1, 50.00);   

BEGIN;
DO $$
BEGIN
	INSERT INTO orders (customer_name)
	VALUES ('Nguyen Van A')
	RETURNING order_id;
    IF (SELECT stock FROM products WHERE product_id = 1) < 2 THEN
		ROLLBACK;
        RAISE EXCEPTION 'Product 1 not enough stock';
		RETURN;
    END IF;

    IF (SELECT stock FROM products WHERE product_id = 2) < 1 THEN
		ROLLBACK;
        RAISE EXCEPTION 'Product 2 not enough stock';
		RETURN;
    END IF;
END $$;

UPDATE products
SET stock = stock - 2

WHERE product_id = 1;

UPDATE products
SET stock = stock - 1
WHERE product_id = 2;

INSERT INTO order_items (order_id, product_id, quantity, subtotal)
VALUES 
(3, 1, 2, 2 * (SELECT price FROM products WHERE product_id = 1)),
(3, 2, 1, 1 * (SELECT price FROM products WHERE product_id = 2));

UPDATE orders
SET total_amount = (
    SELECT SUM(subtotal)
    FROM order_items
    WHERE order_id = 3
)
WHERE order_id = 3;

COMMIT;

UPDATE products
SET stock = 0
WHERE product_id = 1;

SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;