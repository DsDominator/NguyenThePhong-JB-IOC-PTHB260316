CREATE DATABASE LibraryDB;

CREATE SCHEMA library;

CREATE TABLE library.Books (
    book_id INTEGER PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    published_year INTEGER,
    available BOOLEAN DEFAULT TRUE
);

CREATE TABLE library.Members (
    member_id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    join_date DATE DEFAULT CURRENT_DATE
);

ALTER TABLE library.Books
ADD COLUMN genre VARCHAR(100);

ALTER TABLE library.Books
RENAME COLUMN available TO is_available;

ALTER TABLE library.Members
DROP COLUMN email;

DROP TABLE sales.OrderDetails;