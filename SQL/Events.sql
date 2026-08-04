-- EVENTS, trigger happens when a event occurs. An event takes place when it's scheduled
#scheduled automater - like importing data on a schedule, daily or monthly cleaning etc. 

#retire people who are the over the age of 60 and give them lifetime pay
#create an event that checks every month and then if they are over 60, delete them and retire them from the table

SELECT * 
FROM employee_demographics;

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND #every 1 Month
DO 
BEGIN
	DELETE
	FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;
#jerry was removed