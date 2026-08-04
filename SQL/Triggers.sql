-- Triggers and Events

#triggers - block of code that executes automatically when an event takes places on a table 

#when people are hired they are added to demographic table
#when someone is added to salary we want to add them to demographic as well - update
#example - ron in dem is not in salary

SELECT * 
FROM employee_demographics; 

SELECT * 
FROM employee_salary;

DELIMITER $$
CREATE TRIGGER employee_insert #can be found on the employee_salary dropdown on the left under triggers
	AFTER INSERT ON employee_salary #after keyword, you can also do BEFORE (deletion), etc. 
    FOR EACH ROW 
    #insert four times (not optimal), this will run four times, some like microsoft sql have batch triggers
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES(NEW.employee_id, NEW.first_name, NEW.last_name); #events that are inserted
    #only get the new values, there is OLD keyword for deleted ones as well
END
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, 'John-Ralph' , 'Sappy', 'Entertainment 720 CEO', 1000000, NULL);

SHOW TRIGGERS;