CREATE SCHEMA bai3;

CREATE TABLE bai3.students (
    id INT PRIMARY KEY,
    full_name VARCHAR(100),
    gender VARCHAR(10),
    birth_year INT,
    major VARCHAR(50),
    gpa DECIMAL(3,1)
);

INSERT INTO bai3.students (id, full_name, gender, birth_year, major, gpa) VALUES
(1, 'Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
(2, 'Trần Thị Bích Ngọc', 'Nữ', 2001, 'Kinh tế', 3.2),
(3, 'Lê Quốc Cường', 'Nam', 2003, 'CNTT', 2.7),
(4, 'Phạm Minh Anh', 'Nữ', 2000, 'Luật', 3.9),
(5, 'Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
(6, 'Lưu Đức Tài', 'Nam', 2004, 'Cơ khí', NULL),
(7, 'Võ Thị Thu Hằng', 'Nữ', 2001, 'CNTT', 3.0);

INSERT INTO bai3.students (id,full_name, gender, birth_year, major, gpa)
VALUES (8,'Phan Hoàng Nam', 'Nam', 2003, 'CNTT', 3.8);

UPDATE bai3.students
SET gpa = 3.4
WHERE full_name = 'Lê Quốc Cường';

DELETE FROM bai3.students
WHERE gpa IS NULL;

SELECT *
FROM bai3.students
WHERE major = 'CNTT' AND gpa >= 3.0
LIMIT 3;

SELECT DISTINCT major
FROM bai3.students;

SELECT *
FROM bai3.students
WHERE major = 'CNTT'
ORDER BY gpa DESC, full_name ASC;

SELECT *
FROM bai3.students
WHERE full_name ILIKE 'Nguyễn%';

SELECT *
FROM bai3.students
WHERE birth_year BETWEEN 2001 AND 2003;