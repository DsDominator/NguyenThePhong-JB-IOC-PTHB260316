CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    major VARCHAR(50)
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    credit INT
);

CREATE TABLE enrollments (
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    score NUMERIC(5,2)
);

INSERT INTO students (full_name, major) VALUES
('Nguyễn Văn A', 'Công nghệ thông tin'),
('Trần Thị B', 'Khoa học dữ liệu'),
('Lê Văn C', 'Hệ thống thông tin'),
('Phạm Thị D', 'Trí tuệ nhân tạo'),
('Hoàng Văn E', 'An toàn thông tin');

INSERT INTO courses (course_name, credit) VALUES
('Cơ sở dữ liệu', 3),
('Lập trình Python', 4),
('Machine Learning', 3),
('Mạng máy tính', 3),
('Trí tuệ nhân tạo', 4);

INSERT INTO enrollments (student_id, course_id, score) VALUES
(1, 1, 8.5),
(1, 2, 9.0),
(2, 2, 7.5),
(2, 3, 8.0),
(3, 1, 6.5),
(3, 4, 7.0),
(4, 3, 9.2),
(4, 5, 8.8),
(5, 4, 7.9),
(5, 5, 8.3);

SELECT 
    s.full_name AS "Tên sinh viên",
    c.course_name AS "Môn học",
    e.score AS "Điểm"
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;

SELECT 
    s.full_name,
    AVG(e.score) AS avg_score,
    MAX(e.score) AS max_score,
    MIN(e.score) AS min_score
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.full_name;

SELECT 
    s.major,
    AVG(e.score) AS avg_score
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.major
HAVING AVG(e.score) > 7.5;

SELECT 
    s.full_name,
    c.course_name,
    c.credit,
    e.score
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;

SELECT 
    s.full_name,
    AVG(e.score) AS avg_score
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name
HAVING AVG(e.score) > (
    SELECT AVG(score) FROM enrollments
);

SELECT DISTINCT s.full_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE e.score >= 9

UNION

SELECT DISTINCT s.full_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id;

SELECT DISTINCT s.full_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE e.score >= 9

INTERSECT

SELECT DISTINCT s.full_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id;