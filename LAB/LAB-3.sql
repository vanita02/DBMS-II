CREATE TABLE Departments ( 
DepartmentID INT PRIMARY KEY, 
DepartmentName VARCHAR(100) NOT NULL UNIQUE, 
ManagerID INT NOT NULL, 
Location VARCHAR(100) NOT NULL 
); 

INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID, Location) 
VALUES  
(1, 'IT', 101, 'New York'), 
(2, 'HR', 102, 'San Francisco'), 
(3, 'Finance', 103, 'Los Angeles'), 
(4, 'Admin', 104, 'Chicago'), 
(5, 'Marketing', 105, 'Miami'); 

SELECT * FROM DEPARTMENTS


CREATE TABLE Employee ( 
EmployeeID INT PRIMARY KEY, 
FirstName VARCHAR(100) NOT NULL, 
LastName VARCHAR(100) NOT NULL, 
DoB DATETIME NOT NULL, 
Gender VARCHAR(50) NOT NULL, 
HireDate DATETIME NOT NULL, 
DepartmentID INT NOT NULL, 
Salary DECIMAL(10, 2) NOT NULL, 
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) 
); 


INSERT INTO Employee (EmployeeID, FirstName, LastName, DoB, Gender, HireDate, DepartmentID, 
Salary) 
VALUES  
(101, 'John', 'Doe', '1985-04-12', 'Male', '2010-06-15', 1, 75000.00), 
(102, 'Jane', 'Smith', '1990-08-24', 'Female', '2015-03-10', 2, 60000.00), 
(103, 'Robert', 'Brown', '1982-12-05', 'Male', '2008-09-25', 3, 82000.00), 
(104, 'Emily', 'Davis', '1988-11-11', 'Female', '2012-07-18', 4, 58000.00), 
(105, 'Michael', 'Wilson', '1992-02-02', 'Male', '2018-11-30', 5, 67000.00); 

SELECT * FROM EMPLOYEE


CREATE TABLE Projects ( 
ProjectID INT PRIMARY KEY, 
ProjectName VARCHAR(100) NOT NULL, 
StartDate DATETIME NOT NULL, 
EndDate DATETIME NOT NULL, 
DepartmentID INT NOT NULL, 
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) 
); 

INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID) 
VALUES  
(201, 'Project Alpha', '2022-01-01', '2022-12-31', 1), 
(202, 'Project Beta', '2023-03-15', '2024-03-14', 2), 
(203, 'Project Gamma', '2021-06-01', '2022-05-31', 3), 
(204, 'Project Delta', '2020-10-10', '2021-10-09', 4), 
(205, 'Project Epsilon', '2024-04-01', '2025-03-31', 5);

SELECT * FROM PROJECTS




					--PART – A 

--1. Create Stored Procedure for Employee table As User enters either First Name or Last Name and based 
--on this you must give EmployeeID, DOB, Gender & Hiredate. 

CREATE PROCEDURE PR_DETAILS_1
	@FIRSTNAME VARCHAR(100) = null,
	@LASTNAME VARCHAR(100) = null
AS
BEGIN
	SELECT EMPLOYEEID,DOB,GENDER,HIREDATE FROM EMPLOYEE
	WHERE FIRSTNAME = @FIRSTNAME or LASTNAME = @LASTNAME
END

EXEC PR_DETAILS_1 'JOHN','DOE'

--2. Create a Procedure that will accept Department Name and based on that gives employees list who 
--belongs to that department.  

CREATE PROCEDURE PR_DETAILS_2
	@DEPARTMENTNAME VARCHAR(100)
AS
BEGIN
	SELECT E.FIRSTNAME
	FROM EMPLOYEE E JOIN DEPARTMENTS D
	ON E.DEPARTMENTID = D.DEPARTMENTID
	WHERE DEPARTMENTNAME = @DEPARTMENTNAME
END

EXEC PR_DETAILS_2 'IT'

--3.  Create a Procedure that accepts Project Name & Department Name and based on that you must give 
--all the project related details. 

CREATE PROCEDURE PR_DETAILS_3
	@PROJECTNAME VARCHAR(100),
	@DEPARTMENTNAME VARCHAR(100)
AS
BEGIN
	SELECT * FROM PROJECTS P JOIN DEPARTMENTS D
	ON P.DEPARTMENTID = D.DEPARTMENTID
	WHERE P.PROJECTNAME = @PROJECTNAME AND D.DEPARTMENTNAME = @DEPARTMENTNAME
END

EXEC PR_DETAILS_3 'Project Alpha','IT'
	
--4. Create a procedure that will accepts any integer and if salary is between provided integer, then those 
--employee list comes in output.  

CREATE PROCEDURE PR_DETAILS_4
	@S1 INT,
	@S2 INT
AS
BEGIN
	SELECT * FROM PERSON
	WHERE SALARY > @S1 AND SALARY < @S2
END

EXEC PR_DETAILS_4 50000,80000

--5. Create a Procedure that will accepts a date and gives all the employees who all are hired on that date. 

CREATE PROCEDURE PR_DETAILS_5
	@HIREDATE DATETIME
AS
BEGIN
	SELECT * FROM EMPLOYEE
	WHERE HIREDATE = @HIREDATE
END

EXEC PR_DETAILS_5 '2015-03-10'



				--PART – B 

--6. Create a Procedure that accepts Gender’s first letter only and based on that employee details will be 
--served.  

ALTER PROCEDURE PR_DETAIL_6
	@GENDER VARCHAR(100)
	--@GENDER NVARCHAR(1)
AS
BEGIN
	SELECT * FROM EMPLOYEE
	WHERE GENDER LIKE @GENDER+'%'
END

EXEC PR_DETAIL_6 'M'

--7. Create a Procedure that accepts First Name or Department Name as input and based on that employee 
--data will come.  

CREATE PROCEDURE PR_DETAILS_7
	@FIRSTNAME VARCHAR(50)=null,
	@DEPARTMENTNAME VARCHAR(50)=null
AS
BEGIN
	SELECT *
	FROM EMPLOYEE E JOIN DEPARTMENTS D
	ON E.DEPARTMENTID = D.DEPARTMENTID
	WHERE E.FIRSTNAME = @FIRSTNAME or D.DEPARTMENTNAME = @DEPARTMENTNAME
END

EXEC PR_DETAILS_7 'JOHN','IT'

--8. Create a procedure that will accepts location, if user enters a location any characters, then he/she will 
--get all the departments with all data. 

CREATE or alter PROCEDURE PR_DETAILS_8
	@LOCATION VARCHAR(100)
AS
BEGIN
	SELECT * FROM DEPARTMENTS
	WHERE LOCATION LIKE '%'+@LOCATION+'%'
END

EXEC PR_DETAILS_8 'A'



				--PART – C 

--9. Create a procedure that will accepts From Date & To Date and based on that he/she will retrieve Project 
--related data.  

CREATE PROCEDURE PR_DETAILS_9
	@STARTDATE DATETIME,
	@ENDDATE DATETIME
AS
BEGIN
	SELECT * FROM PROJECTS
	WHERE STARTDATE = @STARTDATE AND ENDDATE = @ENDDATE
END

EXEC PR_DETAILS_9  '2022-01-01', '2022-12-31'

--10. Create a procedure in which user will enter project name & location and based on that you must 
--provide all data with Department Name, Manager Name with Project Name & Starting Ending Dates.  

CREATE PROCEDURE PR_DETAILS_10
	@PROJECTNAME VARCHAR(100),
	@LOCATION VARCHAR(100)
AS
BEGIN
	SELECT * FROM
	EMPLOYEE E JOIN DEPARTMENTS D
	ON E.DEPARTMENTID = D.DEPARTMENTID
	JOIN PROJECTS P
	ON D.DEPARTMENTID = P.DEPARTMENTID
	WHERE PROJECTNAME = @PROJECTNAME AND LOCATION = @LOCATION
END

EXEC PR_DETAILS_10 'Project Gamma','Los Angeles'