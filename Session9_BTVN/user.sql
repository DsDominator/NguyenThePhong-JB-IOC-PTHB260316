CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    email TEXT NOT NULL,
    username TEXT
);

INSERT INTO Users (email, username) VALUES
('example@example.com', 'user1'),
('john.doe@gmail.com', 'johndoe'),
('jane.smith@yahoo.com', 'janesmith'),
('alice.nguyen@gmail.com', 'alice123'),
('bob.tran@hotmail.com', 'bobtran');

CREATE INDEX idx_users_email_hash
ON Users USING HASH (email);

EXPLAIN
SELECT * 
FROM Users 
WHERE email = 'example@example.com';