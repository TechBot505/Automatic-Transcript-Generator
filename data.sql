-- Table to store student details
CREATE DATABASE IF NOT EXISTS stud_transcript;
USE stud_transcript;

CREATE TABLE students (
    roll_number VARCHAR(10) PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL
);

-- Table to store semester information
CREATE TABLE semesters (
    semester_id INT AUTO_INCREMENT PRIMARY KEY,
    semester VARCHAR(20) NOT NULL,
    sem_year INT NOT NULL
);

-- Table to store course information
CREATE TABLE courses (
    course_code VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_credits FLOAT NOT NULL
);

-- Table to link courses to semesters
CREATE TABLE course_semester (
    course_code VARCHAR(10),
    semester_id INT,
    PRIMARY KEY (course_code, semester_id),
    FOREIGN KEY (course_code) REFERENCES courses(course_code),
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id)
);

-- Table to store student enrollments in courses
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    roll_number VARCHAR(10),
    course_code VARCHAR(10),
    semester_id INT,
    grade VARCHAR(2),
    FOREIGN KEY (roll_number) REFERENCES students(roll_number),
    FOREIGN KEY (course_code) REFERENCES courses(course_code),
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id)
);

-- Table to store SPI and CPI data for each semester
CREATE TABLE spi_cpi (
    roll_number VARCHAR(10),
    semester_id INT,
    spi DECIMAL(4,2),
    cpi DECIMAL(4,2),
    PRIMARY KEY (roll_number, semester_id),
    FOREIGN KEY (roll_number) REFERENCES students(roll_number),
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id)
);

-- Insert students
INSERT INTO students (roll_number, student_name, department) VALUES
('210001059', 'Rohit Dhanotia', 'Computer Science'),
('210001002', 'Abhinav Kumar', 'Computer Science');

-- Insert semester
INSERT INTO semesters (semester, sem_year) VALUES
('Spring', 2);

-- Insert courses
INSERT INTO courses (course_code, course_name, course_credits) VALUES
('CS202', 'Automata Theory and Logic', 3.0),
('CS204', 'Design and Analysis of Algorithms', 3.0),
('CS206', 'Logic Design', 3.0),
('CS208', 'Software Engineering', 3.0),
('CS254', 'Design and Analysis of Algorithms Lab', 1.5),
('CS256', 'Logic Design Lab', 1.5),
('CS258', 'Software Engineering Lab', 1.5),
('MA204', 'Numerical Methods', 4.0);

-- Link courses to the semester (assuming all these courses are in the Spring semester of year 2)
INSERT INTO course_semester (course_code, semester_id) VALUES
('CS202', 1),
('CS204', 1),
('CS206', 1),
('CS208', 1),
('CS254', 1),
('CS256', 1),
('CS258', 1),
('MA204', 1);

-- Insert enrollments for both students (with random grades)
INSERT INTO enrollments (roll_number, course_code, semester_id, grade) VALUES
('210001059', 'CS202', 1, 'AA'),
('210001059', 'CS204', 1, 'AB'),
('210001059', 'CS206', 1, 'BB'),
('210001059', 'CS208', 1, 'AA'),
('210001059', 'CS254', 1, 'AB'),
('210001059', 'CS256', 1, 'BB'),
('210001059', 'CS258', 1, 'AA'),
('210001059', 'MA204', 1, 'AA'),
('210001002', 'CS202', 1, 'BB'),
('210001002', 'CS204', 1, 'AB'),
('210001002', 'CS206', 1, 'AA'),
('210001002', 'CS208', 1, 'BB'),
('210001002', 'CS254', 1, 'AB'),
('210001002', 'CS256', 1, 'AA'),
('210001002', 'CS258', 1, 'BB'),
('210001002', 'MA204', 1, 'AB');

-- Insert SPI and CPI for students
INSERT INTO spi_cpi (roll_number, semester_id, spi, cpi) VALUES
('210001059', 1, 9.1, 8.9),
('210001002', 1, 8.2, 8.1);