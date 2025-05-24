			--PART – A 

--1. Write a function to print "hello world".

CREATE OR ALTER FUNCTION FN_HELLO_WORLD()
RETURNS VARCHAR(30)
AS
BEGIN
	RETURN 'HELLO WORLD'
END

SELECT dbo.FN_HELLO_WORLD()

--2. Write a function which returns addition of two numbers. 

CREATE OR ALTER FUNCTION FN_ADDITION(@N1 INT,@N2 INT)
RETURNS INT
AS
BEGIN
	DECLARE @ANS INT
	SET @ANS = 0
	SET @ANS = @N1 + @N2
	RETURN @ANS
END

SELECT dbo.FN_ADDITION(10,20)

--3. Write a function to check whether the given number is ODD or EVEN.

CREATE OR ALTER FUNCTION FN_ODD_EVEN(@N INT)
RETURNS VARCHAR(20)
AS
BEGIN
	IF @N%2=0
		RETURN 'EVEN'
	RETURN 'ODD'
END

SELECT dbo.FN_ODD_EVEN(6)

--4. Write a function which returns a table with details of a person whose first name starts with B. 

CREATE OR ALTER FUNCTION FN_PERSON_TABLE()
RETURNS TABLE
AS
RETURN(SELECT * FROM PERSON WHERE FIRSTNAME LIKE 'B%')

SELECT * FROM FN_PERSON_TABLE()

--5. Write a function which returns a table with unique first names from the person table.

CREATE OR ALTER FUNCTION FN_UNIQUE_NAME()
RETURNS TABLE
AS
RETURN(SELECT DISTINCT FIRSTNAME FROM PERSON)

SELECT * FROM FN_UNIQUE_NAME()

--6. Write a function to print number from 1 to N. (Using while loop) 

CREATE OR ALTER FUNCTION FN_1_TO_N(@N INT)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @ANS VARCHAR(50),@I INT
	SET @ANS=''
	SET @I=1
	WHILE(@I<=@N)
	BEGIN
		SET @ANS = @ANS+CAST(@I AS VARCHAR(50))+' '
		SET @I=@I+1
	END
	RETURN @ANS
END

SELECT dbo.FN_1_TO_N(10)

--7. Write a function to find the factorial of a given integer. 

CREATE OR ALTER FUNCTION FN_FACTORIAL(@N INT)
RETURNS INT
AS
BEGIN
	DECLARE @ANS INT
	SET @ANS=1
	WHILE(@N>0)
	BEGIN
		SET @ANS = @ANS*(@N)
		SET @N = @N-1
	END
	RETURN @ANS
END

SELECT dbo.FN_FACTORIAL(4)


			--PART – B 

--8. Write a function to compare two integers and return the comparison result. (Using Case statement) 

CREATE OR ALTER FUNCTION FN_COMPARISON(@N1 INT, @N2 INT)
RETURNS VARCHAR(30)
AS
BEGIN
	DECLARE @RESULT VARCHAR(30)
	SET @RESULT = CASE
				  WHEN @N1>@N2 THEN CAST(@N1 AS VARCHAR(30))+' IS GRATER'
				  WHEN @N1<@N2 THEN CAST(@N2 AS VARCHAR(30))+' IS GRATER'
				  ELSE 'EQUALS'
				  END
	RETURN @RESULT
END

SELECT dbo.FN_COMPARISON(10,6)

--9. Write a function to print the sum of even numbers between 1 to 20. 

CREATE OR ALTER FUNCTION FN_SUM_OF_EVEN_NUMBERS_1TO20(@N INT)
RETURNS INT
AS
BEGIN
	DECLARE @SUM INT,@I INT
	SET @SUM=0
	SET @I=1
	WHILE(@I!=@N+1)
	BEGIN
		IF(@I%2=0)
			SET @SUM = @SUM + @I
		SET @I = @I + 1
	END
	RETURN @SUM
END

SELECT dbo.FN_SUM_OF_EVEN_NUMBERS_1TO20(20)

--10. Write a function that checks if a given string is a palindrome

CREATE OR ALTER FUNCTION FN_PALINDROME_STRING(@S VARCHAR(50))
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @TEMP VARCHAR(50)
	SET @TEMP = REVERSE(@S)
	IF(@S=@TEMP)
		RETURN 'PALINDROM'
	RETURN 'NOT PALINDROM'
END

SELECT dbo.FN_PALINDROME_STRING('NYN')


			--PART – C 

--11. Write a function to check whether a given number is prime or not.

CREATE OR ALTER FUNCTION FN_PRIME(@N INT)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @COUNT INT,@I INT
	SET @COUNT=0
	SET @I=1
	WHILE(@I!=@N)
	BEGIN
		IF(@N%@I=0)
			SET  @COUNT = @COUNT+1
		SET @I=@I+1
	END
	IF(@COUNT>2)
		RETURN 'NOT PRIME'
	RETURN 'PRIME'
END

SELECT dbo.FN_PRIME(7)

--12. Write a function which accepts two parameters start date & end date, and returns a difference in days. 
--13. Write a function which accepts two parameters year & month in integer and returns total days each year. 
--14. Write a function which accepts departmentID as a parameter & returns a detail of the persons. 
--15. Write a function that returns a table with details of all persons who joined after 1-1-1991. 
