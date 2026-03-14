CREATE DATABASE ElearningDB;
CREATE SCHEMA elearning;
CREATE TABLE elearning.Students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE elearning.Instructors (
    instructor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE elearning.Courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    instructor_id INT,
    FOREIGN KEY (instructor_id) 
        REFERENCES elearning.Instructors(instructor_id)
);

CREATE TABLE elearning.Enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    enroll_date DATE NOT NULL,
    FOREIGN KEY (student_id) 
        REFERENCES elearning.Students(student_id),
    FOREIGN KEY (course_id) 
        REFERENCES elearning.Courses(course_id)
);

CREATE TABLE elearning.Assignments (
    assignment_id SERIAL PRIMARY KEY,
    course_id INT,
    title VARCHAR(100) NOT NULL,
    due_date DATE NOT NULL,
    FOREIGN KEY (course_id) 
        REFERENCES elearning.Courses(course_id)
);

CREATE TABLE elearning.Submissions (
    submission_id SERIAL PRIMARY KEY,
    assignment_id INT,
    student_id INT,
    submission_date DATE NOT NULL,
    grade REAL CHECK (grade >= 0 AND grade <= 100),
    FOREIGN KEY (assignment_id) 
        REFERENCES elearning.Assignments(assignment_id),
    FOREIGN KEY (student_id) 
        REFERENCES elearning.Students(student_id)
);