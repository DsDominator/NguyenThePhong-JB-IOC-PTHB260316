CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    credit_limit NUMERIC(12,2)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    order_amount NUMERIC(12,2),
    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(id)
);

CREATE OR REPLACE FUNCTION check_credit_limit()
RETURNS TRIGGER AS $$
DECLARE
    total_amount NUMERIC(12,2);
    limit_amount NUMERIC(12,2);
BEGIN
    SELECT credit_limit INTO limit_amount
    FROM customers
    WHERE id = NEW.customer_id;

    IF limit_amount IS NULL THEN
        RAISE EXCEPTION 'Customer % does not exist', NEW.customer_id;
    END IF;

    SELECT COALESCE(SUM(order_amount), 0)
    INTO total_amount
    FROM orders
    WHERE customer_id = NEW.customer_id;

    IF total_amount + NEW.order_amount > limit_amount THEN
        RAISE EXCEPTION 
        total_amount, NEW.order_amount, limit_amount;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_credit
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION check_credit_limit();

INSERT INTO customers (name, credit_limit)
VALUES
('Phong', 1000),
('An', 500);

INSERT INTO orders (customer_id, order_amount)
VALUES (1, 300); 

INSERT INTO orders (customer_id, order_amount)
VALUES (1, 400);  

INSERT INTO orders (customer_id, order_amount)
VALUES (1, 400);  

INSERT INTO orders (customer_id, order_amount)
VALUES (99, 100);