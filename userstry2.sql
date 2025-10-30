CREATE TABLE Department (
    DeptID INT PRIMARY KEY AUTO_INCREMENT,
    DeptName VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Student (
    StudentID VARCHAR(10) PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL
);

CREATE TABLE Course (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Instructor (
    InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    InstructorName VARCHAR(100) NOT NULL,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Enrollment (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID VARCHAR(10),
    CourseID INT,
    InstructorID INT,
    Grade CHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);
INSERT INTO Department (DeptName) VALUES
('Computer Science'),
('Electrical Engineering');
INSERT INTO Student (StudentID, StudentName) VALUES
('S101', 'Asha Gupta'),
('S102', 'Raj Verma'),
('S103', 'Priya Nair'),
('S104', 'Vikas Patel'),
('S105', 'Meena Rao');
INSERT INTO Course (CourseName, DeptID) VALUES
('Database Systems', 1),
('Data Structures', 1),
('Operating Systems', 1),
('Circuits and Networks', 2),
('Digital Signal Processing', 2);
INSERT INTO Instructor (InstructorName, DeptID) VALUES
('Dr. Mehta', 1),
('Dr. Sharma', 1),
('Dr. Rao', 2);
INSERT INTO Enrollment (StudentID, CourseID, InstructorID, Grade) VALUES
('S101', 1, 1, 'A'),
('S101', 2, 2, 'A'),
('S102', 2, 2, 'B'),
('S103', 3, 1, NULL),   -- Not graded yet
('S104', 4, 3, 'B');
-- S105 not enrolled yet
SELECT s.StudentName, c.CourseName, i.InstructorName
FROM Enrollment e
INNER JOIN Student s ON e.StudentID = s.StudentID
INNER JOIN Course c ON e.CourseID = c.CourseID
INNER JOIN Instructor i ON e.InstructorID = i.InstructorID;

SELECT c.CourseName, d.DeptName
FROM Course c
INNER JOIN Department d ON c.DeptID = d.DeptID;

SELECT s.StudentName, c.CourseName, e.Grade
FROM Student s
LEFT JOIN Enrollment e ON s.StudentID = e.StudentID
LEFT JOIN Course c ON e.CourseID = c.CourseID;

SELECT DISTINCT InstructorID FROM Enrollment;


DELETE FROM Enrollment WHERE InstructorID = 3;



SELECT i.InstructorName, c.CourseName
FROM Enrollment e
RIGHT JOIN Instructor i ON e.InstructorID = i.InstructorID
LEFT JOIN Course c ON e.CourseID = c.CourseID
WHERE e.StudentID IS NULL;


SELECT i.InstructorName, c.CourseName
FROM Instructor i
LEFT JOIN Enrollment e ON i.InstructorID = e.InstructorID
LEFT JOIN Course c ON c.DeptID = i.DeptID
WHERE e.InstructorID IS NULL;

SELECT DISTINCT 
    s.StudentID,
    s.StudentName
FROM Student s
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Course c ON e.CourseID = c.CourseID
WHERE e.Grade = 'A';


SELECT CourseID
FROM (
    SELECT 
        CourseID,
        AVG(
            CASE Grade
                WHEN 'A' THEN 4
                WHEN 'B' THEN 3
                WHEN 'C' THEN 2
                WHEN 'D' THEN 1
                ELSE 0
            END
        ) AS AvgGradeValue
    FROM Enrollment
    GROUP BY CourseID
) AS CourseAvg
WHERE AvgGradeValue = (
    SELECT MAX(AvgGradeValue)
    FROM (
        SELECT 
            AVG(
                CASE Grade
                    WHEN 'A' THEN 4
                    WHEN 'B' THEN 3
                    WHEN 'C' THEN 2
                    WHEN 'D' THEN 1
                    ELSE 0
                END
            ) AS AvgGradeValue
        FROM Enrollment
        GROUP BY CourseID
    ) AS AllCourses
);






SELECT i.InstructorID, i.InstructorName
FROM Instructor i
WHERE (
    SELECT COUNT(DISTINCT e.CourseID)
    FROM Enrollment e
    WHERE e.InstructorID = i.InstructorID
) > 1;


SELECT s.StudentID, s.StudentName
FROM Student s
WHERE s.StudentID NOT IN (
    SELECT e.StudentID
    FROM Enrollment e
);


SELECT i.InstructorID, i.InstructorName
FROM Instructor i
WHERE (
  SELECT COUNT(DISTINCT e.CourseID)
  FROM Enrollment e
  WHERE e.InstructorID = i.InstructorID
) > 1;


SELECT s.StudentID, s.StudentName
FROM Student s
WHERE NOT EXISTS (
  SELECT 1
  FROM Enrollment e
  WHERE e.StudentID = s.StudentID
);


