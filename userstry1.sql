-- Using EduPro Database
CREATE DATABASE IF NOT EXISTS EduProLearning;
USE EduProLearning;

-- Department Table
CREATE TABLE Department (
    DeptID INT PRIMARY KEY AUTO_INCREMENT,
    DeptName VARCHAR(100) UNIQUE NOT NULL
);

-- Student Table
CREATE TABLE Student (
    StudentID CHAR(10) PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL
);

-- Course Table
CREATE TABLE Course (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Instructor Table
CREATE TABLE Instructor (
    InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    InstructorName VARCHAR(100) NOT NULL,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Enrollment Table
CREATE TABLE Enrollment (
    StudentID CHAR(10),
    CourseID INT,
    InstructorID INT,
    Grade CHAR(2),
    PRIMARY KEY (StudentID, CourseID, InstructorID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);
-- Departments
INSERT INTO Department (DeptName) VALUES ('Computer Science');

-- Students
INSERT INTO Student (StudentID, StudentName) VALUES 
('S101', 'Asha Gupta'),
('S102', 'Raj Verma');

-- Courses
INSERT INTO Course (CourseName, DeptID) VALUES
('Database Systems', 1),
('Data Structures', 1);

-- Instructors
INSERT INTO Instructor (InstructorName, DeptID) VALUES
('Dr. Mehta', 1),
('Dr. Sharma', 1);

-- Enrollment Records
INSERT INTO Enrollment (StudentID, CourseID, InstructorID, Grade) VALUES
('S101', 1, 1, 'A'),
('S102', 2, 2, 'B'),
('S101', 2, 2, 'A');
SELECT 
    s.StudentName,
    c.CourseName,
    i.InstructorName,
    d.DeptName,
    e.Grade
FROM Enrollment e
JOIN Student s ON e.StudentID = s.StudentID
JOIN Course c ON e.CourseID = c.CourseID
JOIN Instructor i ON e.InstructorID = i.InstructorID
JOIN Department d ON c.DeptID = d.DeptID;
