CREATE TABLE Course (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    instructor VARCHAR(50),
    price NUMERIC(10,2),
    duration INT 
);

INSERT INTO Course (title, instructor, price, duration) VALUES
('SQL Cơ bản', 'Nguyen Van A', 500000, 20),
('SQL Nâng cao', 'Tran Thi B', 1200000, 40),
('Python cho Data', 'Le Van C', 1500000, 35),
('Machine Learning', 'Pham Van D', 2000000, 50),
('Demo khóa học AI', 'Hoang Van E', 300000, 10),
('Web Development', 'Do Thi F', 800000, 25);

UPDATE Course
SET price = price * 1.15
WHERE duration > 30;

DELETE FROM Course
WHERE title ILIKE '%demo%';

SELECT *
FROM Course
WHERE title ILIKE '%sql%';

SELECT *
FROM Course
WHERE price BETWEEN 500000 AND 2000000
ORDER BY price DESC
LIMIT 3;