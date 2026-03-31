CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    price NUMERIC(10,2),
    stock INT
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    quantity INT,
    total_amount NUMERIC
);

INSERT INTO products (name, price, stock)
VALUES 
('Laptop', 1000, 10),
('Mouse', 50, 100),
('Keyboard', 150, 50);

CREATE OR REPLACE FUNCTION calculate_total_amount()
RETURNS TRIGGER AS $$
DECLARE
    product_price NUMERIC;
BEGIN
    SELECT price INTO product_price
    FROM products
    WHERE product_id = NEW.product_id;

    IF product_price IS NULL THEN
        RAISE EXCEPTION 'Product ID % does not exist', NEW.product_id;
    END IF;

    NEW.total_amount := NEW.quantity * product_price;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_calculate_total
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION calculate_total_amount();

INSERT INTO orders (product_id, quantity)
VALUES 
(1, 2), 
(2, 5),  
(3, 1);  

SELECT * FROM orders;