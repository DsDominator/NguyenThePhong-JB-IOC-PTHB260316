CREATE TABLE patients(
    patient_id SERIAL PRIMARY KEY ,
    full_name VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50),
    symptoms TEXT[]
);

CREATE TABLE doctors (
     doctor_id SERIAL PRIMARY KEY,
     full_name VARCHAR(100),
    department VARCHAR(50)
);

CREATE TABLE appointments (
    appointment_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    doctor_id INT REFERENCES doctors(doctor_id),
    appointment_date DATE,
    diagnosis VARCHAR(200),
    fee NUMERIC(10,2)
);

INSERT INTO patients (full_name, phone, city, symptoms) VALUES
    ('Nguyen Van A', '0901111111', 'HCM', ARRAY['sot', 'ho']),
    ('Tran Thi B', '0902222222', 'Ha Noi', ARRAY['dau dau']),
    ('Le Van C', '0903333333', 'Da Nang', ARRAY['ho', 'kho tho']),
    ('Pham Thi D', '0904444444', 'HCM', ARRAY['sot']),
    ('Hoang Van E', '0905555555', 'Can Tho', ARRAY['met moi', 'dau hong']);

INSERT INTO doctors (full_name, department) VALUES
    ('Dr. An', 'Noi'),
    ('Dr. Cuong', 'Tim mach'),
    ('Dr. Binh', 'Ngoai'),
    ('Dr. Hanh', 'Da lieu'),
    ('Dr. Dung', 'Nhi');

INSERT INTO appointments (patient_id, doctor_id, appointment_date, diagnosis, fee) VALUES
    (1, 1, '2026-03-01', 'Cam', 200),
    (2, 2, '2026-03-02', 'Dau dau', 150),
    (3, 3, '2026-03-03', 'Hen', 300),
    (4, 4, '2026-03-04', 'Sot', 180),
    (5, 5, '2026-03-05', 'Di ung', 220),
    (1, 2, '2026-03-06', 'Ho', 210),
    (2, 3, '2026-03-07', 'Tim', 350),
    (3, 1, '2026-03-08', 'Viem hong', 170),
    (4, 5, '2026-03-09', 'Da', 250),
    (5, 4, '2026-03-10', 'Nhi', 190)

CREATE INDEX inx_patient_phone
ON patients(phone);

CREATE INDEX inx_patients_city_hash
ON patients USING hash(city);

CREATE INDEX inx_patients_symptoms_gin
ON patients USING gin(symptoms);

CREATE INDEX idx_appointments_fee
ON appointments USING gist(numrange(fee, fee));

CREATE INDEX idx_appointments_date
ON appointments(appointment_date);

CLUSTER appointments USING idx_appointments_fee;

CREATE VIEW vw_top_patients
AS
SELECT p.full_name,SUM(a.fee)
FROM patients p JOIN appointments a on p.patient_id = a.patient_id
GROUP BY p.full_name
ORDER BY SUM(a.fee) DESC
LIMIT 3;

SELECT * FROM vw_top_patients;

CREATE VIEW vw_doctor_appointments
AS
SELECT d.full_name,COUNT(a.appointment_id)
FROM doctors d JOIN appointments a on d.doctor_id = a.patient_id
GROUP BY d.full_name
ORDER BY COUNT(a.appointment_id) ;

SELECT * FROM vw_doctor_appointments;

CREATE VIEW v_patients_city AS
SELECT patient_id, full_name, city
FROM patients
WITH CHECK OPTION ;

UPDATE v_patients_city
SET city = 'Vinh Long'
WHERE patient_id = 1;