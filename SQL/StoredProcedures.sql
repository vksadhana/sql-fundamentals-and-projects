-- Stored Procedures, kind of like functios, save sql code and reuse over and over again

# you can specific which database you want to use USE parks_and_recreation

#USE parks_and_recreation;
#DROP procedure IF EXISTS 'New-procedure';

CREATE PROCEDURE large_salaries()
SELECT * 
FROM employee_salary
WHERE salary >= 50000; #creates but not called, this will be created under stored procedures on the left

# calling the procedure
CALL large_salaries(); 

-- this is not the best practice way to do this - because it's just one select

CREATE PROCEDURE another_large_salaries()
SELECT * 
FROM employee_salary
WHERE salary >= 50000;
SELECT * 
FROM employee_salary
WHERE salary >= 10000; #here the first is creating the procedure and the second select is just a random query

-- we need to use a delimiter, not a semi-colon

# you can make numerous ones like // $$(used by data engineers), etc.
DELIMITER $$
CREATE PROCEDURE large_salaries3()
BEGIN
	SELECT * 
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT * 
	FROM employee_salary
	WHERE salary >= 10000; #here the first is creating the procedure and the second select is just a random query
END $$ #create procedure, begin and end with the delimiter to indicate the end
DELIMITER ; # at the end make sure to change it because then you would have to use $$ for the rest

CALL large_salaries3(); #gives us two results

#you can also go to stored procedure on the left and click create new procedure

-- PARAMETERS, variables that are passed as inputs in the stored procedures

DELIMITER $$
CREATE PROCEDURE another_function(parameter_employee_id INT) #name and data type
#naming convention - employee_id_param or p_employee_id
BEGIN
	SELECT salary
	FROM employee_salary
    WHERE employee_id = parameter_employee_id;
END $$
DELIMITER ;

CALL another_function(1); #passing an employee_id and get their salary


