-- Create the Customers table 
CREATE TABLE CUSTOMERS ( 
Customer_id INT PRIMARY KEY,                 
Customer_Name VARCHAR(250) NOT NULL,         
Email VARCHAR(50) UNIQUE                     
); 

-- Create the Orders table 
CREATE TABLE ORDERS ( 
Order_id INT PRIMARY KEY,                    
Customer_id INT,                             
Order_date DATE NOT NULL,                    
FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)  
); 




			--PART – A 

--1. Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error. 

BEGIN TRY
	DECLARE @N1 INT, @N2 INT
	SET @N1=10
	SET @N2=5
	PRINT(@N1/@N2)
END TRY
BEGIN CATCH
	PRINT 'Error occurs that is - Divide by zero error.'
END CATCH

--2. Try to convert string to integer and handle the error using try…catch block. 

BEGIN TRY
	DECLARE @S VARCHAR(30),@N INT
	SET @S='123a'
	SET @N= CAST(@S AS INT)
	PRINT(@N)
END TRY
BEGIN CATCH
	PRINT 'Error occurs that is - String can not be converted.'
END CATCH

--3. Create a procedure that prints the sum of two numbers: take both numbers as integer & handle 
--exception with all error functions if any one enters string value in numbers otherwise print result. 

CREATE PROCEDURE PR_INTEGER_SUM
@S1 VARCHAR(20),
@S2 VARCHAR(20)
AS
BEGIN
	BEGIN TRY
		DECLARE @N1 INT,@N2 INT
		SET @N1 = CAST(@S1 AS INT)
		SET @N2 = CAST(@S2 AS INT)
		PRINT(@N1+@N2)
	END TRY
	BEGIN CATCH
		PRINT 'String can not be converted.'
	END CATCH
END

EXEC PR_INTEGER_SUM '1','2'

--4. Handle a Primary Key Violation while inserting data into customers table and print the error details 
--such as the error message, error number, severity, and state. 

BEGIN TRY
		INSERT INTO CUSTOMERS VALUES(1,'VANITA','v@gmail.com')
		INSERT INTO CUSTOMERS VALUES(1,'VANITA','khushiiiii@gmail.com')
END TRY
BEGIN CATCH
	PRINT('ERROR NUMBER : '+ CAST(ERROR_NUMBER() AS VARCHAR(20)))
	PRINT('ERROR SEVERITY : '+ CAST(ERROR_SEVERITY() AS VARCHAR(20)))
	PRINT('ERROR STATE : '+ CAST(ERROR_STATE() AS VARCHAR(20)))
	PRINT('ERROR MESSAGE : '+ ERROR_MESSAGE())
END CATCH

--5. Throw custom exception using stored procedure which accepts Customer_id as input & that throws 
--Error like no Customer_id is available in database.


CREATE OR ALTER  PROCEDURE PR_THROW_ERROR
@CUSTOMERID INT
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM CUSTOMERS WHERE Customer_id = @CUSTOMERID)
		THROW 50001,' Customer_id is not available in database',1
	ELSE
		PRINT 'CUSTOMER ID IS AVAILABLE'
END

EXEC PR_THROW_ERROR 5


			--PART – B 

--6. Handle a Foreign Key Violation while inserting data into Orders table and print appropriate error 
--message. 

BEGIN TRY
		INSERT INTO ORDERS VALUES(1,9,'2025-01-01')
END TRY
BEGIN CATCH
	PRINT('ERROR NUMBER : '+ CAST(ERROR_NUMBER() AS VARCHAR(20)))
	PRINT('ERROR SEVERITY : '+ CAST(ERROR_SEVERITY() AS VARCHAR(20)))
	PRINT('ERROR STATE : '+ CAST(ERROR_STATE() AS VARCHAR(20)))
	PRINT('ERROR MESSAGE : '+ ERROR_MESSAGE())
END CATCH

--7. Throw custom exception that throws error if the data is invalid. 

CREATE OR ALTER PROCEDURE PR_CUSTOM_EXCEPTION
@CUTOMER INT
AS
BEGIN
	IF (@CUTOMER <0 OR NOT EXISTS (SELECT * FROM CUSTOMERS WHERE Customer_id = @CUTOMER))
		THROW 50002,'Invalid Order_id',2
	ELSE
		PRINT 'Available'
END

EXEC PR_CUSTOM_EXCEPTION -3

--8. Create a Procedure to Update Customer’s Email with Error Handling

CREATE OR ALTER PROCEDURE PR_CUSTOM_EXCEPTION_EMAIL
@CUTOMER INT,
@EMAIL VARCHAR(100)
AS
BEGIN
	IF (NOT EXISTS (SELECT * FROM CUSTOMERS WHERE Customer_id = @CUTOMER))
		THROW 50003,'Invalid Email',3
	ELSE
		UPDATE CUSTOMERS
		SET Email = @EMAIL
		WHERE Customer_id = @CUTOMER
END

EXEC PR_CUSTOM_EXCEPTION_EMAIL 1,'VVVVVVVVVV@GMAIL.COM'
SELECT * FROM CUSTOMERS


			--PART – C
			
--9. Create a procedure which prints the error message that “The Customer_id is already taken. Try another 
--one”. 


CREATE OR ALTER PROCEDURE PR_ERROR_MESSAGE
@CUSTOMERID INT
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM CUSTOMERS WHERE Customer_id = @CUSTOMERID)
		INSERT INTO CUSTOMERS VALUES(@CUSTOMERID,'DISHA','disha@gmail.com')
	ELSE
		PRINT 'The Customer_id is already taken. Try another one.' 
END

EXEC PR_ERROR_MESSAGE 4
SELECT * FROM CUSTOMERS

--10. Handle Duplicate Email Insertion in Customers Table. 

CREATE or alter PROCEDURE PR_HANDLE_DUPLICATE_EMAIL
@CUSTOMERID INT,
@NAME VARCHAR(100),
@EMAILID VARCHAR(100)
AS
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT * FROM CUSTOMERS WHERE Email = @EMAILID)
			THROW 50005, 'DUPLICATE EMAILID',4
		ELSE
			INSERT INTO CUSTOMERS VALUES(@CUSTOMERID,@NAME,@EMAILID)
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
	END CATCH
END

EXEC PR_HANDLE_DUPLICATE_EMAIL 6,'priya','P@GMAIL.COM'
SELECT * FROM CUSTOMERS