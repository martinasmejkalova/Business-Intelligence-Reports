CREATE DATABASE tableau_dashboards;
USE tableau_dashboards;

#Display the table

SELECT * FROM hr;

#1.How many Employees Worked with Company ?

SELECT COUNT(employee_name)
FROM hr;

#There are 303 people at the company

#2.Number of Active and Terminated Employees.
    
SELECT 
    employmentstatus, COUNT(employmentstatus)
FROM
    hr
GROUP BY employmentstatus;

#There are 199 Active employees, 88 voluntarily terminated and 16 terminated for cause

#3.How many Employees are in the different Performance scores?

SELECT 
    COUNT(employee_name) AS number_of_employees, performancescore
FROM
    hr
GROUP BY performancescore
ORDER BY number_of_employees DESC;

#236 employees fully meets score, 36 exceeds, 18 needs improvement and 13 emp are in PIP

#4.Which are the Top 5 Recruitment Sources for Company ?

SELECT COUNT(RecruitmentSource), RecruitmentSource
FROM hr
GROUP BY RecruitmentSource
ORDER BY COUNT(RecruitmentSource) DESC
LIMIT 5;

#Top 5 Recruitment Sources are Indeed (86), Linkedin (72), Google Search (46), Employee Referal (31), Fiversity Job Fair (29)

#5.Average salary offered in each Department.

SELECT round(avg(Salary),2) AS average_salary, department
FROM hr
GROUP BY department
ORDER BY average_salary DESC;

#The avg salary is highest in Executive Office (250,000), then IT/IS (97,064), then Software Engineering (94,989),
#then Admin Offices (71,791), then Sales (69,061) and last Production (60,000)

#6.Percentage of Male and Female Active Employees working.

SELECT sex, COUNT(empID) AS number_of_emp, count(*) * 100 / sum(count(*)) over() percentage
FROM hr
WHERE termd = 0
GROUP BY sex;

#There is 44% Active Males and 55% Active Females

#7.Select a year where the most Employees were hired and terminated.

SELECT 
    COUNT(employee_name),
    RIGHT(dateofhire,4), RIGHT(dateoftermination,4)
FROM
    hr
GROUP BY RIGHT(dateofhire,4), RIGHT(dateoftermination,4)
ORDER BY count(employee_name) DESC;

#In 2014 there were 51 hired and in 2016 11 people terminated

#8.Top 5 Positions on which employees are working

SELECT Position, COUNT(empID)
FROM hr
GROUP BY position
ORDER BY COUNT(empID) DESC
LIMIT 5;

#133 people are working as production technician I and 53 as PT II, then 27 Area Sales Managers, 14 Production Managers and 10 Software Engineers

#9.What is Average Satisfaction score for Active and Terminated Members ?

SELECT AVG(empsatisfaction), employmentstatus
FROM hr
GROUP BY employmentstatus;

#All employees have 3,8 average of satisfaction score

#10.Number of Employees with who are US Citizens.

SELECT COUNT(employee_name), citizendesc
FROM hr
WHERE citizendesc = "US Citizen";

#There are 287 US citizens in the company

#11.Main reasons for termination?

SELECT TermReason, COUNT(Termd) AS number_of_terminations
FROM hr
WHERE Termd = 1
GROUP BY TermReason
ORDER BY number_of_terminations DESC;

#20 people found another position, 14 were unhappy, 11 wanted more money and 9 wanted career change

#12.WHat is the MAX of absence that employee had and who?

SELECT MAX(absences), employee_name, employmentstatus, termreason
FROM hr
GROUP BY employee_name, employmentstatus, termreason
ORDER BY max(absences) DESC
LIMIT 1;

#It is 20 absences for Constance Sloan, but she left the company due to maternity leave

#13.Number of Employees Working in Different Departments.

SELECT count(empID), department
FROM hr
GROUP BY department
ORDER BY Count(empID) DESC;

#201 people are in production, 50 in IT/IS, 31 in Sales, 11 is Software Engineering, 9 Admin Offices and 1 is in Executive Office

#14.Employee Categorization on the basis of their Marital Description.

SELECT MaritalDesc, Sex, COUNT(empID)
FROM hr
GROUP BY maritaldesc, sex
ORDER BY maritaldesc;

#In the company 70 of females and 52 males are married, 73 F and 59 M are single, there are 16 F and 14 M who are divorced, 4 F and 4 M are widowed, and 8 females and 3 males are separated

#15.Percentage of Total Employees Working on Different Positions.

SELECT position, COUNT(*) * 100/SUM(COUNT(*)) over() percentage
FROM hr
GROUP BY position
ORDER BY percentage DESC;

#43% are production technicians I, 17% are production technicians II, 9% are area sales managers, 4,6% are production managers

#16.Number of Employees who are earning below average salary.

SELECT 
    COUNT(empID)
FROM
    hr
WHERE
    salary < (SELECT 
            AVG(salary)
        FROM
            hr
        WHERE
            employmentstatus = 'Active')

#There are 220 employees that are receiving less than average salary in the company

#17. Who has the highest salary? 

SELECT * FROM hr
WHERE salary = (SELECT MAX(salary) FROM hr);

#Highest salary has Janet King who is President and CEO, has 250,000 and is US citizen who was hired in 2012

#18. Who has the lowest salary?
SELECT * FROM hr
WHERE salary = (SELECT MIN(salary) FROM hr);

#Minimum salary has Coleen Zime, with 45,046 salary, she is production Technicial I, widowed, Asian, hired in 2014, her manager is David Stanley and she is quite satisfied in the company

# 19. Top 5 Managers who are having maximum Employees under their watch

SELECT managername, COUNT(employee_name)
FROM hr
GROUP BY managername
ORDER BY COUNT(employee_name) DESC;
#TOP 5 managers are Albert Michael, Sullivan Kissy, Gray Elijiah, Miller Brannon and Spriea Kelley with 22 employees under their watch

#20. Which department has lowest avg satisfaction rate?

SELECT AVG(empsatisfaction), department
FROM hr
GROUP BY department
ORDER BY avg(empsatisfaction);

#The lowest satisfaction has Executive Office (3), and then Admin offices with 3,5. The highest satisfaction is in Software Engineering (4)


