CREATE TABLE Employee (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    department VARCHAR(50),
    salary NUMERIC(10,2),
    hire_date DATE
);

INSERT INTO Employee (full_name, department, salary, hire_date) VALUES
('Nguyen Van An', 'IT', 8200000, '2024-03-15'),
('Tran Thi Binh', 'HR', 7300000, '2022-11-10'),
('Le Hoang Nam', 'IT', 9100000, '2026-05-20'),
('Pham Thi An', 'Marketing', 6900000, '2022-04-05'),
('Do Minh Tuan', 'Finance', 7600000, '2021-09-14'),
('Hoang Van An', 'IT', 5500000, '2023-07-08');

UPDATE Employee
SET salary = salary * 1.10
WHERE department = 'IT';

DELETE FROM Employee
WHERE salary < 6000000;

SELECT *
FROM Employee
WHERE full_name ILIKE '%An%';

SELECT *
FROM Employee
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31';