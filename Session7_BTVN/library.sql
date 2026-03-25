CREATE TABLE book (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(100),
    genre VARCHAR(50),
    price DECIMAL(10,2),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_book_genre ON book(genre);

CREATE EXTENSION pg_trgm;
CREATE INDEX idx_book_author_trgm 
ON book USING GIN (author gin_trgm_ops);

EXPLAIN ANALYZE
SELECT * FROM book WHERE genre = 'Fantasy';

EXPLAIN ANALYZE
SELECT * FROM book WHERE author ILIKE '%Rowling';

CLUSTER book USING idx_book_genre;