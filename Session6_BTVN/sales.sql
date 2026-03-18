CREATE TABLE Product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2),
    stock INT
);

INSERT INTO Product (name, category, price, stock) VALUES
('Laptop Dell', 'Điện tử', 15000000, 10),
('iPhone 13', 'Điện tử', 12000000, 5),
('Tai nghe Sony', 'Điện tử', 3000000, 20),
('Bàn phím cơ', 'Phụ kiện', 1500000, 15),
('Chuột Logitech', 'Phụ kiện', 800000, 25);

SELECT * FROM Product;

SELECT * 
FROM Product
ORDER BY price DESC
LIMIT 3;

SELECT *
FROM Product
WHERE category = 'Điện tử'
  AND price < 10000000;

SELECT *
FROM Product
ORDER BY stock ASC;