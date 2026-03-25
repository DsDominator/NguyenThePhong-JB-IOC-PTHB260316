CREATE TABLE Sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT,
    amount NUMERIC,
    sale_date DATE
);

INSERT INTO Sales (customer_id, amount, sale_date) VALUES
(1, 200, '2026-01-01'),
(2, 300, '2026-01-05'),
(1, 500, '2024-05-10'),
(3, 700, '2025-01-15'),
(2, 400, '2026-02-20');

CREATE OR REPLACE PROCEDURE calculate_total_sales(
    IN start_date DATE,
    IN end_date DATE,
    OUT total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT SUM(amount)
    INTO total
    FROM bai5.Sales
    WHERE sale_date BETWEEN start_date AND end_date;

    IF total IS NULL THEN
        total := 0;
    END IF;
END;
$$;

CALL calculate_total_sales('2026-01-01', '2026-01-31', NULL);