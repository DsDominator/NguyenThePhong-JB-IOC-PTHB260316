CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10,2),
    last_modified TIMESTAMP
);

CREATE OR REPLACE FUNCTION update_last_modified()
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_modified := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_last_modified
BEFORE UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION update_last_modified();

INSERT INTO products (name, price, last_modified)
VALUES 
('Laptop', 1500.00, CURRENT_TIMESTAMP),
('Mouse', 20.00, CURRENT_TIMESTAMP),
('Keyboard', 50.00, CURRENT_TIMESTAMP);

UPDATE products
SET price = price + 100
WHERE name = 'Laptop';

SELECT * FROM products;