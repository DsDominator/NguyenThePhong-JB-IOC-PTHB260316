CREATE TABLE bai5.Products (
    product_id SERIAL PRIMARY KEY,
    name TEXT,
    price NUMERIC,
    category_id INT
);

INSERT INTO bai5.Products (name, price, category_id) VALUES
('Laptop', 1000, 1),
('Mouse', 50, 1),
('Keyboard', 80, 1),
('Phone', 700, 2),
('Tablet', 500, 2);

CREATE OR REPLACE PROCEDURE update_product_price(
    IN p_category_id INT,
    IN p_increase_percent NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    new_price NUMERIC;
BEGIN
    -- Duyệt từng sản phẩm theo category
    FOR rec IN 
        SELECT product_id, price 
        FROM  bai5.Products
        WHERE category_id = p_category_id
    LOOP
        -- Tính giá mới
        new_price := rec.price * (1 + p_increase_percent / 100);

        -- Cập nhật giá
        UPDATE  bai5.Products
        SET price = new_price
        WHERE product_id = rec.product_id;
    END LOOP;
END;
$$;

CALL update_product_price(1, 10);

SELECT * FROM bai5.Products;