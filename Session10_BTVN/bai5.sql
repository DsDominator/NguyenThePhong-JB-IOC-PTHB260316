CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT
);

CREATE TABLE customers_log (
    log_id SERIAL PRIMARY KEY,
    customer_id INT,
    operation VARCHAR(10),
    old_data JSONB,
    new_data JSONB,
    changed_by TEXT,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_customer_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO customers_log(
            customer_id, operation, old_data, new_data, changed_by
        )
        VALUES (
            NEW.id,
            'INSERT',
            NULL,
            to_jsonb(NEW),
            current_user
        );

        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO customers_log(
            customer_id, operation, old_data, new_data, changed_by
        )
        VALUES (
            NEW.id,
            'UPDATE',
            to_jsonb(OLD),
            to_jsonb(NEW),
            current_user
        );

        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO customers_log(
            customer_id, operation, old_data, new_data, changed_by
        )
        VALUES (
            OLD.id,
            'DELETE',
            to_jsonb(OLD),
            NULL,
            current_user
        );

        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_customer_changes
AFTER INSERT OR UPDATE OR DELETE ON customers
FOR EACH ROW
EXECUTE FUNCTION log_customer_changes();

INSERT INTO customers (name, email, phone, address)
VALUES ('Phong', 'phong@gmail.com', '0123456789', 'Tra Vinh');

UPDATE customers
SET phone = '0987654321'
WHERE name = 'Phong';

DELETE FROM customers
WHERE name = 'Phong';

SELECT * FROM customers_log
ORDER BY change_time DESC;