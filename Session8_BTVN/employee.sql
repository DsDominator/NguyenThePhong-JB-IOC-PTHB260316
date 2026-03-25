CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    job_level INT,
    salary NUMERIC
);

INSERT INTO employees (emp_name, job_level, salary)
VALUES
('An', 1, 10000000),
('Bình', 2, 12000000),
('Cường', 3, 15000000);

CREATE OR REPLACE PROCEDURE adjust_salary(
    IN p_emp_id INT,
    OUT p_new_salary NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_level INT;
    v_salary NUMERIC;
BEGIN
    SELECT job_level, salary
    INTO v_level, v_salary
    FROM employees
    WHERE emp_id = p_emp_id;

    IF v_salary IS NULL THEN
        RAISE EXCEPTION 'Nhân viên không tồn tại';
    END IF;

    IF v_level = 1 THEN
        p_new_salary := v_salary * 1.05;
    ELSIF v_level = 2 THEN
        p_new_salary := v_salary * 1.10;
    ELSIF v_level = 3 THEN
        p_new_salary := v_salary * 1.15;
    END IF;

    UPDATE employees
    SET salary = p_new_salary
    WHERE emp_id = p_emp_id;

END;
$$;

CALL adjust_salary(3, NULL);