CREATE TABLE order_detail (
    id SERIAL PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(100),
    quantity INT,
    unit_price NUMERIC
);

INSERT INTO order_detail (order_id, product_name, quantity, unit_price)
VALUES
(1, 'Laptop Dell Inspiron', 1, 15000000),
(1, 'Chuột Logitech', 2, 250000),
(2, 'Bàn phím cơ Razer', 1, 1800000),
(2, 'Tai nghe Sony', 1, 2200000),
(3, 'Màn hình Samsung 24 inch', 2, 3500000),
(3, 'USB Kingston 64GB', 3, 150000);

CREATE OR REPLACE PROCEDURE calculate_order_total(
    IN order_id_input INT,
    OUT total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT SUM(quantity * unit_price)
    INTO total
    FROM order_detail
    WHERE order_id = order_id_input;

    IF total IS NULL THEN
        total := 0;
    END IF;
END;
$$;

CALL calculate_order_total(2, NULL);