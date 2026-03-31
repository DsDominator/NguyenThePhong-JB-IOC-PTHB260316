CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    stock INT
);

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    quantity INT
);

INSERT INTO products (name, stock)
VALUES 
('Laptop', 10),
('Mouse', 50);

CREATE OR REPLACE FUNCTION check_stock_before_insert()
RETURNS TRIGGER AS $$
DECLARE
    current_stock INT;
BEGIN
    SELECT stock INTO current_stock
    FROM products
    WHERE product_id = NEW.product_id;

    IF current_stock IS NULL THEN
        RAISE EXCEPTION 'Product not found';
    END IF;

    IF NEW.quantity > current_stock THEN
        RAISE EXCEPTION 'Not enough stock. Available: %, Requested: %',
        current_stock, NEW.quantity;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_stock
BEFORE INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION check_stock_before_insert();

INSERT INTO sales (product_id, quantity)
VALUES (1, 5);

INSERT INTO sales (product_id, quantity)
VALUES (1, 15);

CREATE OR REPLACE FUNCTION update_stock_after_insert()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_stock
AFTER INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION update_stock_after_insert();

SELECT * FROM products;