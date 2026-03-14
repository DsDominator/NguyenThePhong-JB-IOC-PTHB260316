CREATE DATABASE UniversityDB;
CREATE SCHEMA university;
CREATE TABLE university.Students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    email VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE university.Courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT
);
CREATE TABLE university.Enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    enroll_date DATE,
    FOREIGN KEY (student_id) REFERENCES university.Students(student_id),
    FOREIGN KEY (course_id) REFERENCES university.Courses(course_id)
);