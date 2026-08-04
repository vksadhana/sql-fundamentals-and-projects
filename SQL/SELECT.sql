SELECT * FROM parks_and_recreation.employee_demographics;


SELECT first_name, 
last_name, 
birth_date,
age, 
(age + 10) * 10
FROM parks_and_recreation.employee_demographics;
#follows the rules of pemdas (paranthesis, exponent, multiplication, division, addition, subtraction

# distinct - the unique values within a column

SELECT DISTINCT first_name, gender #combination, distinct between both of these columns
FROM parks_and_recreation.employee_demographics;