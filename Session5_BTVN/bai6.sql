CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100)
);

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    dept_id INT REFERENCES departments(dept_id),
    salary NUMERIC(10,2),
    hire_date DATE
);

CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100),
    dept_id INT REFERENCES departments(dept_id)
);

INSERT INTO departments (dept_name) VALUES
('Công nghệ thông tin'),
('Nhân sự'),
('Tài chính'),
('Marketing'),
('Nghiên cứu & Phát triển');

INSERT INTO employees (emp_name, dept_id, salary, hire_date) VALUES
('Nguyễn Văn A', 1, 15000000, '2022-03-15'),
('Trần Thị B', 1, 18000000, '2021-07-20'),
('Lê Văn C', 2, 12000000, '2023-01-10'),
('Phạm Thị D', 3, 20000000, '2020-11-05'),
('Hoàng Văn E', 4, 14000000, '2022-08-18'),
('Võ Thị F', 5, 22000000, '2019-06-25'),
('Đặng Văn G', 3, 17000000, '2021-12-01');

INSERT INTO projects (project_name, dept_id) VALUES
('Hệ thống quản lý nhân sự', 1),
('Website thương mại điện tử', 1),
('Chiến dịch quảng cáo mùa hè', 4),
('Phân tích dữ liệu tài chính', 3),
('Nghiên cứu AI', 5),
('Ứng dụng mobile bán hàng', 1);

SELECT 
    e.emp_name AS "Tên nhân viên",
    d.dept_name AS "Phòng ban",
    e.salary AS "Lương"
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

SELECT 
    SUM(salary) AS total_salary,
    AVG(salary) AS avg_salary,
    MAX(salary) AS max_salary,
    MIN(salary) AS min_salary,
    COUNT(*) AS total_employees
FROM employees;

SELECT 
    d.dept_name,
    AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > 15000000;

SELECT 
    p.project_name,
    d.dept_name,
    e.emp_name
FROM projects p
JOIN departments d ON p.dept_id = d.dept_id
LEFT JOIN employees e ON d.dept_id = e.dept_id;

SELECT *
FROM employees e
WHERE (e.salary,e.dept_id) IN (
    SELECT MAX(e2.salary), e2.dept_id
    FROM employees e2
    GROUP BY e2.dept_id
);


