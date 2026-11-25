-- PART 1

CREATE DATABASE COMP267_Registration;

USE COMP267_Registration;

CREATE TABLE Department (
    DepartmentID INT AUTO_INCREMENT,
    DepartmentName VARCHAR(50) NOT NULL,
    Building VARCHAR(40) NOT NULL,
    Budget DECIMAL(10,2),
    Status VARCHAR(15) DEFAULT 'Active',
    CONSTRAINT Department_DepartmentID_PK
        PRIMARY KEY (DepartmentID),
    CONSTRAINT Department_DepartmentName_UQ
        UNIQUE (DepartmentName),
    CONSTRAINT Department_Budget_CHK
        CHECK (Budget >= 0)
) ENGINE=InnoDB;

CREATE TABLE Student (
    StudentID INT AUTO_INCREMENT,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Email VARCHAR(80) NOT NULL,
    DepartmentID INT,
    GPA DECIMAL(3,2),
    StudentStatus VARCHAR(15) DEFAULT 'Active',
    CONSTRAINT Student_StudentID_PK
        PRIMARY KEY (StudentID),
    CONSTRAINT Student_Email_UQ
        UNIQUE (Email),
    CONSTRAINT Student_DepartmentID_FK
        FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
        ON DELETE SET NULL,
    CONSTRAINT Student_GPA_CHK
        CHECK (GPA BETWEEN 0 AND 4)
) ENGINE=InnoDB;

CREATE TABLE Course (
    CourseID INT AUTO_INCREMENT,
    CourseCode VARCHAR(10) NOT NULL,
    CourseName VARCHAR(60) NOT NULL,
    Credits INT,
    DepartmentID INT NOT NULL,
    CONSTRAINT Course_CourseID_PK
        PRIMARY KEY (CourseID),
    CONSTRAINT Course_CourseCode_UQ
        UNIQUE (CourseCode),
    CONSTRAINT Course_Credits_CHK
        CHECK (Credits BETWEEN 1 AND 4),
    CONSTRAINT Course_DepartmentID_FK
        FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
        ON DELETE RESTRICT
) ENGINE=InnoDB;


-- PART 2


CREATE TABLE Section (
    CourseID INT,
    SectionNumber INT,
    Semester VARCHAR(10),
    `Year` INT,
    Capacity INT,
    CONSTRAINT Section_PK
        PRIMARY KEY (
            CourseID,
            SectionNumber,
            Semester,
            `Year`
        ),
    CONSTRAINT Section_CourseID_FK
        FOREIGN KEY (CourseID)
        REFERENCES Course(CourseID),
    CONSTRAINT Section_Year_CHK
        CHECK (`Year` >= 2020),
    CONSTRAINT Section_Capacity_CHK
        CHECK (Capacity BETWEEN 5 AND 100)
) ENGINE=InnoDB;


-- PART 3

USE COMP267_Registration;

CREATE TABLE Enrollment (
    StudentID INT,
    CourseID INT,
    SectionNumber INT,
    Semester VARCHAR(10),
    `Year` INT,
    EnrollmentDate DATE NOT NULL,
    Grade VARCHAR(2) NULL,
    CONSTRAINT Enrollment_PK
        PRIMARY KEY (
            StudentID,
            CourseID,
            SectionNumber,
            Semester,
            `Year`
        ),
    CONSTRAINT Enrollment_Student_FK
        FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID)
        ON DELETE CASCADE,
    CONSTRAINT Enrollment_Section_FK
        FOREIGN KEY (
            CourseID,
            SectionNumber,
            Semester,
            `Year`
        )
        REFERENCES Section (
            CourseID,
            SectionNumber,
            Semester,
            `Year`
        )
) ENGINE=InnoDB;

-- PART 4A


 INSERT INTO Department (
     DepartmentName,
     Building,
    Budget
)
VALUES
    ('Computer Science', 'Technology Hall', 500000.00),
    ('Mathematics', 'Science Hall', 300000.00),
    ('History', 'Humanities Hall', 200000.00);

SET @cs = (
    SELECT DepartmentID
    FROM Department
    WHERE DepartmentName = 'Computer Science'
);

SET @math = (
    SELECT DepartmentID
    FROM Department
    WHERE DepartmentName = 'Mathematics'
);

SET @history = (
    SELECT DepartmentID
    FROM Department
    WHERE DepartmentName = 'History'
);

INSERT INTO Student (
    FirstName,
    LastName,
    Email,
    DepartmentID,
    GPA
)
VALUES
    ('Ava', 'Johnson', 'ava.johnson@example.edu', @cs, 3.50),
    ('Noah', 'Williams', 'noah.williams@example.edu', @math, 3.20),
    ('Mia', 'Davis', 'mia.davis@example.edu', @history, 3.80),
    ('Liam', 'Brown', 'liam.brown@example.edu', NULL, 2.90);

SET @ava = (
    SELECT StudentID
    FROM Student
    WHERE Email = 'ava.johnson@example.edu'
);

SET @noah = (
    SELECT StudentID
    FROM Student
    WHERE Email = 'noah.williams@example.edu'
);

SET @mia = (
    SELECT StudentID
    FROM Student
    WHERE Email = 'mia.davis@example.edu'
);

SET @liam = (
    SELECT StudentID
    FROM Student
    WHERE Email = 'liam.brown@example.edu'
);

INSERT INTO Course (
    CourseCode,
    CourseName,
    Credits,
    DepartmentID
)
VALUES
    ('COMP267', 'Database Design', 3, @cs),
    ('COMP163', 'Introduction to Programming', 3, @cs),
    ('MATH131', 'Calculus I', 4, @math),
    ('MATH224', 'Introduction to Statistics', 3, @math);

SET @db = (
    SELECT CourseID
    FROM Course
    WHERE CourseCode = 'COMP267'
);

SET @programming = (
    SELECT CourseID
    FROM Course
    WHERE CourseCode = 'COMP163'
);

SET @calculus = (
    SELECT CourseID
    FROM Course
    WHERE CourseCode = 'MATH131'
);

SET @statistics = (
    SELECT CourseID
    FROM Course
    WHERE CourseCode = 'MATH224'
);

INSERT INTO Section (
    CourseID,
    SectionNumber,
    Semester,
    `Year`,
    Capacity
)
VALUES
    (@db, 1, 'Fall', 2026, 30),
    (@programming, 1, 'Fall', 2026, 25),
    (@calculus, 1, 'Fall', 2026, 40),
    (@statistics, 1, 'Fall', 2026, 35);

INSERT INTO Enrollment (
    StudentID,
    CourseID,
    SectionNumber,
    Semester,
    `Year`,
    EnrollmentDate,
    Grade
)
VALUES
    (@ava, @db, 1, 'Fall', 2026, '2026-08-15', NULL),
    (@ava, @programming, 1, 'Fall', 2026, '2026-08-15', 'A'),
    (@noah, @calculus, 1, 'Fall', 2026, '2026-08-16', NULL),
    (@noah, @statistics, 1, 'Fall', 2026, '2026-08-16', 'B+'),
    (@mia, @statistics, 1, 'Fall', 2026, '2026-08-17', NULL),
    (@liam, @programming, 1, 'Fall', 2026, '2026-08-17', NULL);


-- PART 4B


UPDATE Student
SET GPA = 3.75
WHERE StudentID = @ava;

UPDATE Department
SET Status = 'Inactive'
WHERE DepartmentID = @history;

UPDATE Course
SET Credits = 4
WHERE CourseID = @db;

UPDATE Student
SET GPA = 5.00
WHERE StudentID = @ava;


-- PART 4C

SELECT *
FROM Enrollment
ORDER BY StudentID, CourseID;

DELETE FROM Student
WHERE StudentID = @noah;

SELECT *
FROM Enrollment
ORDER BY StudentID, CourseID;

SELECT *
FROM Student
WHERE StudentID = @mia;

DELETE FROM Department
WHERE DepartmentID = @history;

SELECT *
FROM Student
WHERE StudentID = @mia;


-- PART 5

INSERT INTO Student (
    FirstName,
    LastName,
    Email,
    DepartmentID,
    GPA
)
VALUES
    (NULL, 'Test', 'null.test@example.edu', @cs, 3.00);

INSERT INTO Student (
    FirstName,
    LastName,
    Email,
    DepartmentID,
    GPA
)
VALUES
    ('Alex', 'Test', 'duplicate.test@example.edu', @cs, 3.00),
    ('Taylor', 'Test',course 'duplicate.test@example.edu', @math, 3.10);

UPDATE Student
SET GPA = 5.00
WHERE StudentID = @ava;

SET @missing_department = (
    SELECT MAX(DepartmentID) + 1
    FROM Department
);

INSERT INTO Course (
    CourseCode,
    CourseName,
    Credits,
    DepartmentID
)
VALUES
    ('TEST404', 'Invalid Department Test', 3, @missing_department);

INSERT INTO Section (
    CourseID,
    SectionNumber,
    Semester,
    `Year`,
    Capacity
)
VALUES
    (@db, 1, 'Fall', 2026, 30);

INSERT INTO Enrollment (
    StudentID,
    CourseID,
    SectionNumber,
    Semester,
    `Year`,
    EnrollmentDate,
    Grade
)
VALUES
    (@ava, @db, 99, 'Fall', 2026, '2026-08-20', NULL);


-- PART 6

SELECT *
FROM Student
WHERE DepartmentID = NULL;

SELECT *
FROM Student
WHERE DepartmentID IS NULL;


-- PART 7

ALTER TABLE Student
ADD COLUMN Phone VARCHAR(15);

ALTER TABLE Student
ADD CONSTRAINT Student_Phone_UQ
UNIQUE (Phone);

ALTER TABLE Course
ADD COLUMN CourseLevel INT;

ALTER TABLE Course
ADD CONSTRAINT Course_CourseLevel_CHK
CHECK (CourseLevel BETWEEN 100 AND 900);

ALTER TABLE Course
DROP CHECK Course_CourseLevel_CHK;

