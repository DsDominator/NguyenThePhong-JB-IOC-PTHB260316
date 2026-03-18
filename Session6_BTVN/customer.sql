CREATE TABLE Customer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    points INT
);

INSERT INTO Customer (name, email, phone, points) VALUES
('Nguyen Van A', 'a@gmail.com', '0901111111', 100),
('Tran Thi B', 'b@gmail.com', '0902222222', 200),
('Le Van C', NULL, '0903333333', 150), 
('Pham Thi D', 'd@gmail.com', '0904444444', 300),
('Hoang Van E', 'e@gmail.com', '0905555555', 250),
('Do Thi F', 'f@gmail.com', '0906666666', 180),
('Nguyen Van G', 'g@gmail.com', '0907777777', 220);

SELECT DISTINCT name
FROM Customer;

SELECT *
FROM Customer
WHERE email IS NULL;

SELECT *
FROM Customer
ORDER BY points DESC
LIMIT 3 OFFSET 1;

SELECT *
FROM Customer
ORDER BY name DESC;