CREATE TABLE post (
    post_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT,
    tags TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_public BOOLEAN DEFAULT TRUE
);

CREATE TABLE post_like (
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, post_id)
);

INSERT INTO post (user_id, content, tags, created_at, is_public) VALUES
(1, 'Học SQL cơ bản', ARRAY['sql', 'database'], '2024-01-01', TRUE),
(2, 'PostgreSQL rất mạnh', ARRAY['postgres', 'database'], '2024-01-05', TRUE),
(3, 'Hôm nay đi chơi', ARRAY['life'], '2024-01-10', FALSE),
(1, 'Tối ưu query với index', ARRAY['sql', 'performance'], '2024-02-01', TRUE),
(2, 'Học Python cho Data Science', ARRAY['python', 'data'], '2024-02-10', TRUE),
(3, 'Ăn gì hôm nay?', ARRAY['food'], '2024-02-15', TRUE),
(4, 'Docker cơ bản', ARRAY['devops', 'docker'], '2024-03-01', TRUE),
(5, 'Tips học lập trình nhanh', ARRAY['coding', 'tips'], '2024-03-05', TRUE);

INSERT INTO post_like (user_id, post_id, liked_at) VALUES
(1, 2, '2024-01-06'),
(2, 1, '2024-01-06'),
(3, 1, '2024-01-07'),
(4, 1, '2024-01-07'),
(5, 1, '2024-01-08'),
(1, 4, '2024-02-02'),
(2, 4, '2024-02-02'),
(3, 4, '2024-02-03'),
(1, 5, '2024-02-11'),
(2, 5, '2024-02-11'),
(3, 6, '2024-02-16'),
(4, 7, '2024-03-02'),
(5, 7, '2024-03-02'),
(1, 8, '2024-03-06'),
(2, 8, '2024-03-06'),
(3, 8, '2024-03-06');
------------Cau 1---------------
CREATE INDEX idx_post_content_lower
ON post (LOWER(content));

EXPLAIN ANALYZE
SELECT * 
FROM post
WHERE is_public = TRUE
AND LOWER(content) LIKE 'sql%';
------------Cau 2---------------
CREATE INDEX idx_post_tags_gin
ON post USING GIN(tags);

EXPLAIN ANALYZE
SELECT * 
FROM post
WHERE tags @> ARRAY['sql'];
------------Cau 3---------------
CREATE INDEX idx_post_recent_public
ON post (created_at DESC)
WHERE is_public = TRUE;

EXPLAIN ANALYZE
SELECT *
FROM post
WHERE is_public = TRUE
AND created_at >= CURRENT_DATE - INTERVAL '7 days';
------------Cau 4---------------
CREATE INDEX idx_post_user_created
ON post (user_id, created_at DESC);

EXPLAIN ANALYZE
SELECT *
FROM post
WHERE user_id IN (1,2,3)
ORDER BY created_at DESC
LIMIT 10;