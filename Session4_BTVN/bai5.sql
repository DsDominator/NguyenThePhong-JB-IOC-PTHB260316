CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    department VARCHAR(50),
    position VARCHAR(50),
    salary BIGINT,
    bonus BIGINT,
    join_year INT
);

INSERT INTO employees (full_name, department, position, salary, bonus, join_year) VALUES
('Nguyễn Văn Huy', 'IT', 'Developer', 18000000, 1000000, 2021),
('Trần Thị Mai', 'HR', 'Recruiter', 12000000, NULL, 2020),
('Lê Quốc Trung', 'IT', 'Tester', 15000000, 800000, 2023),
('Nguyễn Văn Huy', 'IT', 'Developer', 18000000, 1000000, 2021),
('Phạm Ngọc Hân', 'Finance', 'Accountant', 14000000, NULL, 2019),
('Bùi Thị Lan', 'HR', 'HR Manager', 20000000, 3000000, 2018),
('Đặng Hữu Tài', 'IT', 'Developer', 17000000, NULL, 2022);

UPDATE employees
SET salary = salary * 1.10
WHERE department = 'IT'
AND salary < 18000000;

UPDATE employees
SET bonus = 500000
WHERE bonus IS NULL;

SELECT *,
       salary + bonus AS total_income
FROM employees
WHERE department IN ('IT','HR')
AND join_year > 2020
AND (salary + bonus) > 15000000
ORDER BY total_income DESC
LIMIT 3;

SELECT *
FROM employees
WHERE full_name LIKE 'Nguyễn%'
OR full_name LIKE '%Hân';

SELECT DISTINCT department
FROM employees
WHERE bonus IS NOT NULL;

SELECT *
FROM employees
WHERE join_year BETWEEN 2019 AND 2022;