CREATE TABLE inventory (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    quantity INT
);

INSERT INTO inventory (product_name, quantity)
VALUES
('Laptop Dell', 10),
('Chuột Logitech', 5),
('Bàn phím Razer', 2);

CREATE OR REPLACE PROCEDURE check_stock(p_id INT, p_qty INT)
LANGUAGE plpgsql
AS $$
DECLARE
    current_qty INT;
BEGIN
    SELECT quantity INTO current_qty
    FROM inventory
    WHERE product_id = p_id;

    IF current_qty IS NULL THEN
        RAISE EXCEPTION 'Sản phẩm không tồn tại';
    END IF;

    IF current_qty < p_qty THEN
        RAISE EXCEPTION 'Không đủ hàng trong kho';
    ELSE
        RAISE NOTICE 'Đủ hàng trong kho';
    END IF;
END;
$$;

CALL check_stock(1, 3);

CALL check_stock(3, 5);