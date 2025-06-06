CREATE TABLE DEPARTMENT ( 
DepartmentID INT PRIMARY KEY, 
DepartmentName VARCHAR(100) NOT NULL UNIQUE 
);

CREATE TABLE DESIGNATION ( 
DesignationID INT PRIMARY KEY, 
DesignationName VARCHAR(100) NOT NULL UNIQUE 
); 

CREATE TABLE PERSON ( 
PersonID INT PRIMARY KEY IDENTITY(101,1), 
FirstName VARCHAR(100) NOT NULL, 
LastName VARCHAR(100) NOT NULL, 
Salary DECIMAL(8, 2) NOT NULL, 
JoiningDate DATETIME NOT NULL, 
DepartmentID INT NULL, 
DesignationID INT NULL, 
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID), 
FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)�
);

				--Part � A 

--1. Department, Designation & Person Table�s INSERT, UPDATE & DELETE Procedures. 

		--DESIGNATION INSERT
CREATE PROCEDURE PR_DESIGNATION_INSERT
	@DESIGNATIONID INT,
	@DESIGNATIONNAME VARCHAR(100)
AS
BEGIN
	INSERT INTO DESIGNATION
	(DESIGNATIONID,DESIGNATIONNAME)
	VALUES (@DESIGNATIONID,@DESIGNATIONNAME)
END

EXEC PR_DESIGNATION_INSERT 11,'JOBBER'
EXEC PR_DESIGNATION_INSERT 12,'WELDER'
EXEC PR_DESIGNATION_INSERT 13,'CLERK'
EXEC PR_DESIGNATION_INSERT 14,'MANAGER'
EXEC PR_DESIGNATION_INSERT 15,'CEO'

SELECT * FROM DESIGNATION

		--DEPARTMENT INSERT
CREATE PROCEDURE PR_DEPARTMENT_INSERT
	@DEPARTMENTID INT,
	@DEPARTMENTNAME VARCHAR(100)
AS
BEGIN
	INSERT INTO DEPARTMENT
	(DEPARTMENTID,DEPARTMENTNAME)
	VALUES (@DEPARTMENTID,@DEPARTMENTNAME)
END

EXEC PR_DEPARTMENT_INSERT 1,'ADMIN'
EXEC PR_DEPARTMENT_INSERT 2,'IT'
EXEC PR_DEPARTMENT_INSERT 3,'HR'
EXEC PR_DEPARTMENT_INSERT 4,'ACCOUNT'

SELECT * FROM DEPARTMENT

		--PERSON INSERT
CREATE PROCEDURE PR_PERSON_INSERT
	@FIRTSNAME VARCHAR(100),
	@LASTNAME VARCHAR(100),
	@SALARY DECIMAL(8,2),
	@JOININGDATE DATETIME,
	@DEPARTMENTID INT,
	@DESIGNATIONID INT
AS
BEGIN
	INSERT INTO PERSON
	(FIRSTNAME,LASTNAME,SALARY,JOININGDATE,DEPARTMENTID,DESIGNATIONID)
	VALUES (@FIRTSNAME,@LASTNAME,@SALARY,@JOININGDATE,@DEPARTMENTID,@DESIGNATIONID)
END

EXEC PR_PERSON_INSERT 'RAHUL','ANSHU',56000,'1990-01-01',1,12
EXEC PR_PERSON_INSERT 'HARDIK','HINSU',18000,'1990-09-25',2,11
EXEC PR_PERSON_INSERT 'BHAVIN','KAMANI',25000,'1991-05-14',NULL,11
EXEC PR_PERSON_INSERT 'BHOOMI','PATEL',39000,'2014-02-20',1,13
EXEC PR_PERSON_INSERT 'ROHIT','RAJGOR',17000,'1990-07-23',2,15
EXEC PR_PERSON_INSERT 'PRIYA','MEHTA',25000,'1990-10-18',2,NULL
EXEC PR_PERSON_INSERT 'NEHA','TRIVEDI',18000,'2014-02-20',3,15

SELECT * FROM PERSON


		--DESIGNATION UPDATE
CREATE PROCEDURE PR_DESIGNATION_UPDATE
	@DESIGNATIONID INT,
	@DESIGNATIONNAME VARCHAR(100)
AS
BEGIN
	UPDATE DESIGNATION
	SET DESIGNATIONNAME = @DESIGNATIONNAME
	WHERE DESIGNATIONID = @DESIGNATIONID
END

EXEC PR_DESIGNATION_UPDATE 12,'VANITA'

SELECT * FROM DESIGNATION

		--DEPARTMENT UPDATE
CREATE PROCEDURE PR_DEPARTMENT_UPDATE
	@DEPARTMENTID INT,
	@DEPARTMENTNAME VARCHAR(100)
AS
BEGIN
	UPDATE DEPARTMENT
	SET DEPARTMENTNAME = @DEPARTMENTNAME
	WHERE DEPARTMENTID = @DEPARTMENTID
END

EXEC PR_DEPARTMENT_UPDATE 2,'ME'

SELECT * FROM DEPARTMENT

		--PERSON UPDATE
CREATE PROCEDURE PR_PERSON_UPDATE
	@PERSONID INT,
	@FIRTSNAME VARCHAR(100)
	--@LASTNAME VARCHAR(100),
	--@SALARY DECIMAL(8,2),
	--@JOININGDATE DATETIME,
	--@DEPARTMENTID INT,
	--@DESIGNATIONID INT
AS
BEGIN
	UPDATE PERSON
	SET FIRSTNAME = @FIRTSNAME
	WHERE PERSONID = @PERSONID
END

EXEC PR_PERSON_UPDATE 102,'KHUSHI'

SELECT * FROM PERSON


		--DESIGNATION DELETE
CREATE PROCEDURE PR_DESIGNATION_DELETE
	@DESIGNATIONID INT
AS
BEGIN
	DELETE FROM DESIGNATION
	WHERE DESIGNATIONID = @DESIGNATIONID
END

EXEC PR_DESIGNATION_DELETE 14

SELECT * FROM DESIGNATION

		--DEPARTMENT DELETE
CREATE PROCEDURE PR_DEPARTMENT_DELETE
	@DEPARTMENTID INT
AS
BEGIN
	DELETE FROM DEPARTMENT
	WHERE DEPARTMENTID = @DEPARTMENTID
END

EXEC PR_DEPARTMENT_DELETE 4

SELECT * FROM DEPARTMENT


		--PERSON DELETE
CREATE PROCEDURE PR_PERSON_DELETE
	@PERSONID INT
AS
BEGIN
	DELETE FROM PERSON
	WHERE PERSONID = @PERSONID
END

EXEC PR_PERSON_DELETE 102

SELECT * FROM PERSON




--2. Department, Designation & Person Table�s SELECTBYPRIMARYKEY 

			--DESIGNATION TABLE
CREATE PROCEDURE PR_DESIGNATION_SELECT
	@DESIGNATIONID INT
AS
BEGIN
	SELECT * FROM DESIGNATION
	WHERE DESIGNATIONID = @DESIGNATIONID;
END

EXEC PR_DESIGNATION_SELECT 11

			--DEPARTMENT TABLE
CREATE PROCEDURE PR_DEPARTMENT_SELECT
	@DEPARTMENTID INT
AS
BEGIN
	SELECT * FROM DEPARTMENT
	WHERE DEPARTMENTID = @DEPARTMENTID;
END

EXEC PR_DEPARTMENT_SELECT 1


			--PERSON TABLE
CREATE PROCEDURE PR_PERSON_SELECT
	@PERSONID INT
AS
BEGIN
	SELECT * FROM PERSON
	WHERE PERSONID = @PERSONID
END

EXEC PR_PERSON_SELECT 101

--3. Department, Designation & Person Table�s (If foreign key is available then do write join and take 
--columns on select list) 

CREATE PROCEDURE PR_SELECT_LIST
	
AS
BEGIN
	SELECT DEPARTMENT.DepartmentName,DESIGNATION.DesignationName,PERSON.FirstName
	FROM PERSON JOIN DESIGNATION
	ON PERSON.DESIGNATIONID = DESIGNATION.DESIGNATIONID
	JOIN DEPARTMENT
	ON DEPARTMENT.DEPARTMENTID = PERSON.DepartmentID
END

EXEC PR_SELECT_LIST 


--4. Create a Procedure that shows details of the first 3 persons.

CREATE PROCEDURE PR_PERSON_DETAILS
AS
BEGIN
	SELECT TOP 3 *
	FROM PERSON JOIN DESIGNATION
	ON PERSON.DESIGNATIONID = DESIGNATION.DESIGNATIONID
	JOIN DEPARTMENT
	ON DEPARTMENT.DEPARTMENTID = PERSON.DepartmentID
END

EXEC PR_PERSON_DETAILS



				--PART � B 

--5. Create a Procedure that takes the department name as input and returns a table with all workers 
--working in that department. 

CREATE PROCEDURE PR_DETAIL_1
	@DEPARTMENTNAME VARCHAR(100)
AS
BEGIN
	SELECT P.FIRSTNAME
	FROM PERSON P JOIN DEPARTMENT D
	ON P.DEPARTMENTID = D.DEPARTMENTID
	WHERE DEPARTMENTNAME = @DEPARTMENTNAME
END

EXEC PR_DETAIL_1 'HR'

--6. Create Procedure that takes department name & designation name as input and returns a table with 
--worker�s first name, salary, joining date & department name. 

CREATE PROCEDURE PR_DETAIL_2
	@DEPARTMENTNAME VARCHAR(100),
	@DESIGNATIONNAME VARCHAR(100)
AS
BEGIN
	SELECT P.FIRSTNAME,P.SALARY,P.JOININGDATE,D.DEPARTMENTNAME
	FROM PERSON P JOIN DEPARTMENT D
	ON P.DEPARTMENTID = D.DEPARTMENTID
	JOIN DESIGNATION DE
	ON P.DESIGNATIONID = DE.DESIGNATIONID
	WHERE D.DEPARTMENTNAME = @DEPARTMENTNAME AND DE.DESIGNATIONNAME = @DESIGNATIONNAME
END

EXEC PR_DETAIL_2 'ADMIN','CLERK'

--7. Create a Procedure that takes the first name as an input parameter and display all the details of the 
--worker with their department & designation name.

CREATE or alter PROCEDURE PR_DETAIL_3
	@FIRSTNAME VARCHAR(100)
AS
BEGIN
	SELECT *
	FROM PERSON P JOIN DEPARTMENT D
	ON P.DEPARTMENTID = D.DEPARTMENTID
	JOIN DESIGNATION DE
	ON P.DESIGNATIONID = DE.DESIGNATIONID
	WHERE P.FIRSTNAME = @FIRSTNAME
END

EXEC PR_DETAIL_3 'RAHUL'

--8. Create Procedure which displays department wise maximum, minimum & total salaries. 

CREATE PROCEDURE PR_SALARY
AS
BEGIN
	SELECT D.DEPARTMENTNAME,MAX(P.SALARY),MIN(P.SALARY),SUM(P.SALARY)
	FROM PERSON P JOIN DEPARTMENT D
	ON P.DEPARTMENTID = D.DEPARTMENTID
	GROUP BY D.DEPARTMENTNAME
END

EXEC PR_SALARY

--9. Create Procedure which displays designation wise average & total salaries.

CREATE PROCEDURE PR_SALARYS_1
AS
BEGIN
	SELECT D.DESIGNATIONNAME,AVG(P.SALARY),SUM(P.SALARY)
	FROM PERSON P JOIN DESIGNATION D
	ON P.DESIGNATIONID = D.DESIGNATIONID
	GROUP BY D.DESIGNATIONNAME
END

EXEC PR_SALARYS_1

SELECT * FROM PERSON


			--PART � C 

--10. Create Procedure that Accepts Department Name and Returns Person Count. 
--11. Create a procedure that takes a salary value as input and returns all workers with a salary greater than 
--input salary value along with their department and designation details.
CREATE or alter PROCEDURE PR_Person_GetWorkersWithSalaryAbove 
    @Salary DECIMAL(8,2) 
AS 
BEGIN 
    SELECT P.*, D.DepartmentName, G.DesignationName 
    FROM Person P 
    INNER JOIN Department D ON P.DepartmentID = D.DepartmentID 
    INNER JOIN Designation G ON P.DesignationID = G.DesignationID 
    WHERE  P.Salary > 25000; 
END; 

exec PR_Person_GetWorkersWithSalaryAbove 30000

--12. Create a procedure to find the department(s) with the highest total salary among all departments. 
--13. Create a procedure that takes a designation name as input and returns a list of all workers under that 
--designation who joined within the last 10 years, along with their department. 
--14. Create a procedure to list the number of workers in each department who do not have a designation 
--assigned. 
--15. Create a procedure to retrieve the details of workers in departments where the average salary is above 
--12000.