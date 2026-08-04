-- Temporary Tables, visible to the sessions that are created in
# storing intermediate results, manipulating data, etc. 

# first way

#CREATE TABLE would create on in the database

CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50), 
favorite_movie varchar(100)
); #nothing will happen when we run this, but just created

SELECT * FROM temp_table; # how we view the contents

INSERT INTO temp_table
VALUES('Sadhana' , 'Vasanthakumar' , 'Monster House');

SELECT * FROM temp_table;

SELECT * FROM employee_salary;
#make a table where the salary of the person is greater than 50,000

CREATE TEMPORARY TABLE salary_over_5k
SELECT * 
FROM employee_salary
WHERE salary >= 50000;

SELECT * FROM salary_over_5k;
#if this session is open and i copy over to the new window this will work, but if i close out and come back, it will not

