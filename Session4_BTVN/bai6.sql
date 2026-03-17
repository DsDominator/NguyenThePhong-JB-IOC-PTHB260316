CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150),
    author VARCHAR(100),
    category VARCHAR(50),
    publish_year INT,
    price INT,
    stock INT
);

INSERT INTO books (title, author, category, publish_year, price, stock) VALUES
('Lập trình C cơ bản', 'Nguyễn Văn Nam', 'CNTT', 2018, 95000, 20),
('Học SQL qua ví dụ', 'Trần Thị Hạnh', 'CSDL', 2020, 125000, 12),
('Lập trình C cơ bản', 'Nguyễn Văn Nam', 'CNTT', 2018, 95000, 20),
('Phân tích dữ liệu với Python', 'Lê Quốc Bảo', 'CNTT', 2022, 180000, NULL),
('Quản trị cơ sở dữ liệu', 'Nguyễn Thị Minh', 'CSDL', 2021, 150000, 5),
('Học máy cho người mới bắt đầu', 'Nguyễn Văn Nam', 'AI', 2023, 220000, 8),
('Khoa học dữ liệu cơ bản', 'Nguyễn Văn Nam', 'AI', 2023, 220000, NULL);

DELETE FROM books a
USING books b
WHERE a.id > b.id
AND a.title = b.title
AND a.author = b.author
AND a.publish_year = b.publish_year;

UPDATE books
SET price = price * 1.10
WHERE publish_year >= 2021
AND price < 200000;

UPDATE books
SET stock = 0
WHERE stock IS NULL;

SELECT *
FROM books
WHERE category IN ('CNTT','AI')
AND price BETWEEN 100000 AND 250000
ORDER BY price DESC, title ASC;

SELECT *
FROM books
WHERE title ILIKE '%học%';

SELECT DISTINCT category
FROM books
WHERE publish_year > 2020;

SELECT *
FROM books
LIMIT 2 OFFSET 1;