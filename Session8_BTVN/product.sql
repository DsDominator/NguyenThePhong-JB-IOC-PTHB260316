CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC,
    discount_percent INT
);

INSERT INTO products (name, price, discount_percent)
VALUES
('Laptop Dell', 15000000, 10),
('Chuột Logitech', 500000, 20),
('Bàn phím cơ Razer', 2000000, 60),  -- >50% (test giới hạn)
('Tai nghe Sony', 3000000, 30),
('Màn hình Samsung', 5000000, 50);

CREATE OR REPLACE PROCEDURE calculate_discount(
    IN p_id INT,
    OUT p_final_price NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_price NUMERIC;
    v_discount INT;
BEGIN
    SELECT price, discount_percent
    INTO v_price, v_discount
    FROM products
    WHERE id = p_id;

    IF v_price IS NULL THEN
        RAISE EXCEPTION 'Sản phẩm không tồn tại';
    END IF;

    IF v_discount > 50 THEN
        v_discount := 50;
    END IF;

    p_final_price := v_price - (v_price * v_discount / 100);

    UPDATE products
    SET price = p_final_price
    WHERE id = p_id;

END;
$$;

CALL calculate_discount(1, NULL::NUMERIC);

CALL calculate_discount(3, NULL::NUMERIC);