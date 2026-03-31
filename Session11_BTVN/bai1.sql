CREATE TABLE flights (
    flight_id SERIAL PRIMARY KEY,
    flight_name VARCHAR(100) NOT NULL,
    available_seats INT NOT NULL CHECK (available_seats >= 0)
);

CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    flight_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    CONSTRAINT fk_flight
        FOREIGN KEY (flight_id)
        REFERENCES flights(flight_id)
        ON DELETE CASCADE
);

INSERT INTO flights (flight_name, available_seats)
VALUES 
('VN123', 3),
('VN456', 2);

BEGIN;

UPDATE flights
SET available_seats = available_seats - 1
WHERE flight_name = 'VN123';

INSERT INTO bookings (flight_id, customer_name)
VALUES (
    (SELECT flight_id FROM flights WHERE flight_name = 'VN123'),
    'Nguyen Van A'
);

COMMIT;

BEGIN;

UPDATE flights
SET available_seats = available_seats - 1
WHERE flight_name = 'VN123';

INSERT INTO bookings (flight_id, customer_name)
VALUES (999, 'Nguyen Van B');

ROLLBACK;

SELECT * FROM flights;
SELECT * FROM bookings;