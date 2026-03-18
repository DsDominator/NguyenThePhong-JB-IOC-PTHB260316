CREATE DATABASE SchoolDB;

CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    dob DATE
);

CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

CREATE TABLE Enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade CHAR(1),

    CONSTRAINT fk_student
        FOREIGN KEY (student_id)
        REFERENCES Students(student_id),

    CONSTRAINT fk_course
        FOREIGN KEY (course_id)
        REFERENCES Courses(course_id),

    CONSTRAINT chk_grade
        CHECK (grade IN ('A', 'B', 'C', 'D', 'F'))
);