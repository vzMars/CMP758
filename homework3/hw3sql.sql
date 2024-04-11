/*
Homework Assignment 3
Name: Marcos Gonzalez
Due Date: April 01, 2024
*/

use company;

/*
1)	Write an insert statement to add your name (the name you have listed on CUNYfirst) to the employee table. 
For the SSN field, please make up a made-up fake SSN such as 123456789. DO NOT USE your real SSN. (5 points)
You can choose any department you want for your information
*/

INSERT INTO employee (fname, lname, ssn, bdate, address, sex, salary, superssn, dno)
VALUES ('Marcos', 'Gonzalez', '123789456', '2000-06-26', '2631 University Ave, Bronx, NY', 'M', 80000.00, '111111100', 6);

/*
2) Retrieve all last names of all employees ordered alphabetically by last name. (5 points)
*/

SELECT lname 
FROM employee
ORDER BY lname;

/*
3) Retrieve the names of all employees in department 5 who work more than 10 hours per week on the ProductX project.
*/

SELECT fname, minit, lname 
FROM employee, works_on, project
WHERE employee.dno = 5 AND works_on.hours > 10 AND project.pname = 'ProductX' AND works_on.essn = employee.ssn AND works_on.pno = project.pnumber;

/*
4) Retrieve all employees in department 5 whose salary is between $25,000 and $45,000. (5 points).
*/

SELECT * 
FROM employee
WHERE dno = 5 AND (salary BETWEEN 25000 AND 45000);

/*
5) Retrieve the birth date and address of the employee(s) whose name is ‘Joyce A English’. (5 points)
*/

SELECT bdate, address
FROM employee
WHERE fname = 'Joyce' AND minit = 'A' AND lname = 'English';

/*
6) List the names of all employees who have a dependent with the same first name as themselves. (5 points)
*/

SELECT fname, minit, lname
FROM employee, dependent
WHERE employee.ssn = dependent.essn AND employee.fname = dependent.dependent_name;

/*
7) Find the names of all employees who are directly supervised by ‘Franklin Wong’. (5 points)
*/

SELECT e.fname, e.minit, e.lname
FROM employee AS e, employee AS s
WHERE e.superssn = s.ssn AND s.fname = 'Franklin' AND s.lname = 'Wong';

/*
8) For each department whose average employee salary is more than $30,000, 
   retrieve the department name and the number of employees working for that department. (5 points)
*/

SELECT dname, COUNT(*) AS number_of_employees
FROM department, employee
WHERE department.dnumber = employee.dno
GROUP BY department.dname
HAVING AVG(employee.salary) > 30000;

/*
9) Retrieve the number of male employees in each department making more than $30,000. (5 points)
*/

SELECT COUNT(*) AS number_of_male_employees
FROM employee
WHERE sex = 'M' AND salary > 30000;

/*
10) Retrieve the names of all employees who work in the department that has the employee with the highest salary among all employees. (5 points)
*/

SELECT fname, minit, lname
FROM employee
WHERE dno IN (SELECT dno FROM employee WHERE salary IN (SELECT MAX(salary) FROM employee));

/*
11) Retrieve the names of all employees who are supervised by an employee with ssn of ‘888665555’
*/

SELECT fname, minit, lname
FROM employee
WHERE superssn = '888665555';

/*
12) Show the resulting salaries if every employee working on the ‘ProductY’ project is given a 15% raise.
*/

SELECT salary * 1.15
FROM employee, works_on, project
WHERE works_on.essn = employee.ssn AND works_on.pno = project.pnumber AND project.pname = 'ProductY';

/*
13) Retrieve the name and address of all employees who work for the 'Headquarters' department.
*/

SELECT fname, minit, lname, address
FROM employee, department
WHERE employee.dno = department.dnumber AND dname = 'Headquarters';

/*
14) Write a query to update the birth date of the employee whose ssn is '123456789'. The new birth date is '1965-01-08'
*/

UPDATE employee
SET bdate = '1965-01-08'
WHERE ssn = '123456789';

/*
15) For every project located in ‘Stafford’, list the project number, the controlling department number, and the department manager’s last name, address, and birth date. (5 points)
*/

SELECT pnumber, dnum, lname, address, bdate 
FROM project, department, employee
WHERE project.plocation = 'Stafford' AND project.dnum = department.dnumber AND department.mgrssn = employee.ssn;

/*
16) For each employee, retrieve the employee’s first and last name and the first and last name of his or her immediate supervisor. (5 points)
*/

SELECT e.fname AS employee_fname, e.lname AS employee_lname, s.fname AS supervisor_fname, s.lname AS supervisor_lname
FROM employee AS e, employee AS s
WHERE e.superssn = s.ssn;

/*
17) Make a list of all project numbers for projects that involve an employee whose last name is ‘Smith’, either as a worker or as a manager of the department that controls the project. (5 points)
*/

SELECT pnumber
FROM project, employee, works_on
WHERE employee.lname = 'Smith' AND works_on.pno = project.pnumber AND works_on.essn = employee.ssn AND project.dnum = employee.dno;

/*
18) Retrieve a list of employees and the projects they are working on, ordered by department and, within each department, ordered alphabetically by last name, then first name. (5 points)
*/

SELECT dno, lname, fname, pnumber, pname
FROM employee, works_on, project
WHERE employee.ssn = works_on.essn AND project.pnumber = works_on.pno
ORDER BY dno, lname, fname;

/*
19) Write a query to insert the following new departments (5 points):
dname, dnumber mgrssn, mgrstartdate
Marketing, 11, 666666601, 2000-07-22
Human Resources, 12, 987654321, 2010-04-02
Finance, 13, 444444402, 2012-07-12
Operations, 14, 666666602, 2024-05-22
Customer Service, 15, 666666600, 2020-05-22
*/

INSERT INTO department
VALUES ('Marketing', 11, '666666601', '2000-07-22'),
('Human Resources', 12, '987654321', '2010-04-02'),
('Finance', 13, '444444402', '2012-07-12'),
('Operations', 14, '666666602', '2024-05-22'),
('Customer Service', 15, '666666600', '2020-05-22');

/*
20) Write a query to delete the ‘Operations’ department.
*/

DELETE FROM department
WHERE dname = 'Operations';