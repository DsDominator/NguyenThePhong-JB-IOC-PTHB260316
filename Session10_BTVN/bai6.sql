CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    stock INT CHECK (stock >= 0)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(id),
    quantity INT CHECK (quantity > 0),
    order_status VARCHAR(20) DEFAULT 'ACTIVE'
);

CREATE OR REPLACE FUNCTION manage_stock()
    RETURNS TRIGGER AS $$
DECLARE
    current_stock INT;
BEGIN
    IF (TG_OP = 'INSERT') THEN

        SELECT stock INTO current_stock
        FROM products
        WHERE id = NEW.product_id
            FOR UPDATE;

        IF current_stock < NEW.quantity THEN
            RAISE EXCEPTION 'Không đủ tồn kho. Hiện có: %, yêu cầu: %',
                current_stock, NEW.quantity;
        END IF;

        UPDATE products
        SET stock = stock - NEW.quantity
        WHERE id = NEW.product_id;

        RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN

        IF NEW.product_id <> OLD.product_id THEN

            UPDATE products
            SET stock = stock + OLD.quantity
            WHERE id = OLD.product_id;

            SELECT stock INTO current_stock
            FROM products
            WHERE id = NEW.product_id
                FOR UPDATE;

            IF current_stock < NEW.quantity THEN
                RAISE EXCEPTION 'Không đủ tồn kho khi đổi sản phẩm';
            END IF;

            UPDATE products
            SET stock = stock - NEW.quantity
            WHERE id = NEW.product_id;

        ELSE
            IF NEW.quantity <> OLD.quantity THEN

                SELECT stock INTO current_stock
                FROM products
                WHERE id = NEW.product_id
                    FOR UPDATE;

                IF current_stock + OLD.quantity < NEW.quantity THEN
                    RAISE EXCEPTION 'Không đủ tồn kho khi cập nhật';
                END IF;

                UPDATE products
                SET stock = stock + OLD.quantity - NEW.quantity
                WHERE id = NEW.product_id;
            END IF;
        END IF;

        IF NEW.order_status = 'CANCELLED' AND OLD.order_status <> 'CANCELLED' THEN
            UPDATE products
            SET stock = stock + NEW.quantity
            WHERE id = NEW.product_id;
        END IF;

        RETURN NEW;

    ELSIF (TG_OP = 'DELETE') THEN

        -- trả lại tồn kho khi xóa
        UPDATE products
        SET stock = stock + OLD.quantity
        WHERE id = OLD.product_id;

        RETURN OLD;
    END IF;

END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_manage_stock
    BEFORE INSERT OR UPDATE OR DELETE
    ON orders
    FOR EACH ROW
EXECUTE FUNCTION manage_stock();

INSERT INTO products(name, stock)
VALUES ('Laptop', 10),
       ('Mouse', 50);

INSERT INTO orders(product_id, quantity)
VALUES (1, 3);

UPDATE orders
SET quantity = 6
WHERE id = 1;

DELETE FROM orders WHERE id = 1;
