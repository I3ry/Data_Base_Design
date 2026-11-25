CREATE TABLE Employees ( 
EmployeeID INT PRIMARY KEY, 
FullName VARCHAR(60), 
Department VARCHAR(30), 
JobTitle VARCHAR(50), 
Gender VARCHAR(10), 
Salary DECIMAL(10,2), 
Bonus DECIMAL(10,2), 
HireDate DATE, 
BirthDate DATE, 
City VARCHAR(40), 
PerformanceScore INT 
);

INSERT INTO Employees VALUES 
(1, 'Alice Johnson', 'IT', 'Developer', 'Female', 
75000, 5000, '2020-03-15', '1995-06-12', 
'Greensboro', 90), 
(2, 'Brian Smith', 'IT', 'Developer', 'Male', 
82000, NULL, '2019-07-20', '1992-11-04', 
'Charlotte', 85), 
(3, 'Carla Davis', 'HR', 'HR Specialist', 'Female', 
55000, 3000, '2021-01-10', '1997-02-18', 
'Greensboro', 88), 
(4, 'David Wilson', 'Finance', 'Accountant', 'Male', 
68000, 4000, '2018-09-05', '1990-08-25', 
'Raleigh', 92), 
(5, 'Emily Brown', 'IT', 'Developer', 'Female', 
78000, NULL, '2022-06-01', '1998-04-09', 
'Charlotte', 95), 
(6, 'Frank Miller', 'HR', 'HR Manager', 'Male', 
72000, 6000, '2017-11-12', '1988-12-15', 
'Greensboro', 80), 
(7, 'Grace Lee', 'Finance', 'Analyst', 'Female', 
65000, 2500, '2020-08-19', '1994-07-21', 
'Raleigh', 87), 
(8, 'Henry Clark', 'Sales', 'Sales Representative', 'Male', 
50000, 10000, '2023-02-14', '2000-01-30', 
'Charlotte', 78), 
(9, 'Isabella White', 'Sales', 'Sales Manager', 'Female', 
85000, 12000, '2016-05-23', '1987-09-11', 
'Greensboro', 94), 
(10, 'James Harris', 'IT', 'System Administrator', 'Male', 
70000, NULL, '2021-10-10', '1996-03-17', 
'Raleigh', 82), 
(11, 'Karen Martin', 'Finance', 'Accountant', 'Female', 
72000, 3500, '2019-04-08', '1993-05-22', 
'Charlotte', 91), 
(12, 'Leo Thompson', 'Sales', 'Sales Representative', 'Male', 
48000, 8000, '2024-01-15', '2001-10-05', 
'Greensboro', 75), 
(13, 'Mia Anderson', 'HR', 'Recruiter', 'Female', 
58000, NULL, '2022-09-20', '1999-06-14', 
'Raleigh', 89), 
(14, 'Noah Jackson', 'IT', 'Developer', 'Male', 
88000, 7000, '2018-02-11', '1991-12-08', 
'Greensboro', 96), 
(15, 'Olivia Thomas', 'Finance', 'Financial Analyst', 'Female', 
62000, 2000, '2023-07-03', '1998-09-19', 
'Charlotte', 84), 
(16, 'Peter Moore', 'Sales', 'Sales Representative', 'Male', 
53000, NULL, '2021-12-01', '1995-02-26', 
'Raleigh', 81), 
(17, 'Rachel Taylor', 'IT', 'Developer', 'Female', 
80000, 5500, '2020-05-18', '1994-11-13', 
'Greensboro', 93), 
(18, 'Samuel Walker', 'HR', 'HR Specialist', 'Male', 
56000, 1500, '2023-03-22', '1997-07-07', 
'Charlotte', 79), 
(19, 'Sophia Hall', 'Finance', 'Finance Manager', 'Female', 
95000, 9000, '2015-08-30', '1985-01-16', 
'Raleigh', 97), 
(20, 'William Young', 'Sales', 'Sales Representative', 'Male', 
52000, 6000, '2022-04-12', '1996-05-03', 
'Greensboro', 86);

-- Question 1 -- 
SELECT
    FullName,
    Salary,
    ROUND(Salary * 1.075, 2) AS NewSalary
FROM Employees
ORDER BY NewSalary DESC;

-- Question 2 -- 
SELECT
    UPPER(FullName) AS UppercaseName,
    Department,
    Length(FullName) AS NameLength
FROM employees
ORDER BY NameLength DESC;

-- Question 3 --
SELECT
    FullName,
    HireDate,
    DATEDIFF(CURDATE(), HireDate) AS DaysWorked
FROM Employees
ORDER BY DaysWorked DESC;

-- Question 4 --
SELECT
    FullName,
    Salary,
    ROUND(SQRT(Salary), 2) AS SalarySquareRoot
FROM Employees;

-- Question 5 --
SELECT
    FullName,
    Department,
    CONCAT(FullName, ' - ', Department) AS EmployeeInfo
FROM Employees;

-- Question 6 --
SELECT
    COUNT(*) AS TotalEmployees,
    MAX(Salary) AS HighestSalary,
    MIN(Salary) AS LowestSalary
FROM Employees;

-- Question 7 --
SELECT
    ROUND(AVG(Salary), 2) AS AverageITSalary
FROM Employees
WHERE Department = 'IT';

-- Question 8 -- 
SELECT
    SUM(Salary) AS TotalSalary,
    AVG(PerformanceScore) AS AveragePerformanceScore
FROM Employees;

-- Question 9 --
SELECT
    COUNT(Bonus) AS EmployeesWithBonus
FROM Employees;

-- Question 10 --
SELECT
    MAX(Bonus) AS HighestBonus,
    MIN(Bonus) AS LowestBonus,
    AVG(Bonus) AS AverageBonus
FROM Employees;

-- Question 11 --
SELECT
    Department,
    COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY Department
ORDER BY TotalEmployees DESC;

-- Question 12 --
SELECT
    Department,
    ROUND(AVG(Salary), 2) AS AverageSalary,
    MAX(Salary) AS MaximumSalary
FROM Employees
GROUP BY Department;

-- Question 13 --
SELECT
    Department,
    Gender,
    COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY Department, Gender;

-- Question 14 --
SELECT
    City,
    SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY City
ORDER BY TotalSalary DESC;

-- Question 15 --
SELECT
    Department,
    ROUND(AVG(PerformanceScore), 2) AS AveragePerformanceScore
FROM Employees
GROUP BY Department
ORDER BY AveragePerformanceScore DESC;

-- Question 16 --
SELECT
    Department,
    COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY Department
HAVING COUNT(*) > 4;

-- Question 17--
SELECT
    Department,
    COUNT(*) AS TotalEmployees,
    AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Department
HAVING AVG(Salary) > 65000
ORDER BY AverageSalary DESC;

-- Question 18 --
SELECT
    City,
    COUNT(*) AS TotalEmployees,
    SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY City
HAVING SUM(Salary) > 400000;

-- Question 19 --
SELECT
    Department,
    COUNT(*) AS FemaleEmployees,
    AVG(PerformanceScore) AS AveragePerformanceScore
FROM Employees
WHERE Gender = 'Female'
GROUP BY Department
HAVING AVG(PerformanceScore) > 90;

-- Question 20 --
SELECT
    Department,
    Gender,
    COUNT(*) AS TotalEmployees,
    AVG(Salary) AS AverageSalary
FROM Employees
WHERE HireDate > '2020-01-01'
GROUP BY Department, Gender
HAVING COUNT(*) >= 2
ORDER BY Department, Gender;

-- Question 21 --

-- Query 1 --
SELECT SUM(Salary) + SUM(Bonus) AS TotalCompensation
FROM Employees;

-- Query 2 --

SELECT SUM(Salary + Bonus) AS TotalCompensation
FROM Employees;

-- Question 22 --
SELECT
    COUNT(*) AS TotalEmployees,
    COUNT(Bonus) AS EmployeesWithBonus,
    AVG(Bonus) AS AverageBonus
FROM Employees;

-- Question 23 --
-- WHERE Clause Example --
SELECT FullName, Salary
FROM Employees
WHERE Salary > 60000;

-- HAVING Clause Example
SELECT
    Department,
    COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY Department
HAVING COUNT(*) > 4;

-- Question 24 -- 
SELECT Department, COUNT(*) AS TotalEmployees
FROM Employees
WHERE Salary > 60000
GROUP BY Department
HAVING COUNT(*) >= 3
ORDER BY TotalEmployees DESC;