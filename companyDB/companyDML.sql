
-- File: companyDML-b-solution 
-- SQL/DML HOMEWORK (on the COMPANY database)
/*
Every query is worth 2 point. There is no partial credit for a
partially working query - think of this hwk as a large program and each query is a small part of the program.
--
IMPORTANT SPECIFICATIONS
--
(A)
-- Download the script file company.sql and use it to create your COMPANY database.
-- Dowlnoad the file companyDBinstance.pdf; it is provided for your convenience when checking the results of your queries.
(B)
Implement the queries below by ***editing this file*** to include
your name and your SQL code in the indicated places.   
--
(C)
IMPORTANT:
-- Don't use views
-- Don't use inline queries in the FROM clause - see our class notes.
--
(D)
After you have written the SQL code in the appropriate places:
** Run this file (from the command line in sqlplus).
** Print the resulting spooled file (companyDML-b.out) and submit the printout in class on the due date.
--
**** Note: you can use Apex to develop the individual queries. However, you ***MUST*** run this file from the command line as just explained above and then submit a printout of the spooled file. Submitting a printout of the webpage resulting from Apex will *NOT* be accepted.
--
*/
-- Please don't remove the SET ECHO command below.
SPOOL companyDML.out
SET ECHO ON
-- ------------------------------------------------------------
-- 
-- Name: Tyler Paquet
--
-- -------------------------------------------------------------
--
-- NULL AND SUBSTRINGS -------------------------------
--
/*(10B)
Find the ssn and last name of every employee whose ssn contains two consecutive 8's, and has a supervisor. Sort the results by ssn.
*/
SELECT SSN, LNAME
FROM EMPLOYEE
WHERE SSN LIKE '%88%' AND
      SUPER_SSN IS NOT NULL
ORDER BY SSN;
--
-- JOINING 3 TABLES ------------------------------
-- 
/*(11B)
For every employee who works for more than 20 hours on any project that is controlled by the research department: Find the ssn, project number,  and number of hours. Sort the results by ssn.
*/
SELECT W.Essn, W.Pno, W.Hours
FROM WORKS_ON W, PROJECT P, DEPARTMENT D
WHERE Hours > 20 AND
      W.Pno = P.Pnumber AND
      P.Dnum = D.Dnumber AND
      D.Dname = 'Research'
ORDER BY W.Essn;
--
-- JOINING 3 TABLES ---------------------------
--
/*(12B)
Write a query that consists of one block only.
For every employee who works less than 10 hours on any project that is controlled by the department he works for: Find the employee's lname, his department number, project number, the number of the department controlling it, and the number of hours he works on that project. Sort the results by lname.
*/
SELECT E.Lname, E.DNo, W.PNo, P.Dnum, W.Hours
FROM EMPLOYEE E, WORKS_ON W, PROJECT P
WHERE W.Hours < 10 AND
      E.Dno = P.Dnum AND
      P.Pnumber = W.Pno AND
      E.Ssn = W.Essn
ORDER BY E.Lname;
--
-- JOINING 4 TABLES -------------------------
--
/*(13B)
For every employee who works on any project that is located in Houston: Find the employees ssn and lname, and the names of his/her dependent(s) and their relationship(s) to the employee. Notice that there will be one row per qualyfing dependent. Sort the results by employee lname.
*/
SELECT DISTINCT E.Ssn, E.Lname, D.Dependent_name, D.Relationship
FROM EMPLOYEE E, PROJECT P, WORKS_ON W, DEPENDENT D
WHERE E.Ssn = W.Essn AND
      W.Pno = P.Pnumber AND
      P.Plocation = 'Houston' AND
      E.Ssn = D.Essn
ORDER BY E.Lname;
--
-- SELF JOIN -------------------------------------------
-- 
/*(14B)
Write a query that consists of one block only.
For every employee who works for a department that is different from his supervisor's department: Find his ssn, lname, department number; and his supervisor's ssn, lname, and department number. Sort the results by ssn.  
*/
SELECT E1.Ssn, E1.Lname, E1.Dno, E2.Ssn, E2.Lname, E2.Dno
FROM EMPLOYEE E1, EMPLOYEE E2
WHERE E1.Super_ssn = E2.Ssn AND
      E1.Dno <> E2.Dno
ORDER BY E1.Ssn;
--
-- USING MORE THAN ONE RANGE VARIABLE ON ONE TABLE -------------------
--
/*(15B)
Find pairs of employee lname's such that the two employees in the pair work on the same project for the same number of hours. List every pair once only. Sort the result by the lname in the left column in the result. 
*/
SELECT DISTINCT E1.Lname, E2.Lname
FROM EMPLOYEE E1, EMPLOYEE E2, WORKS_ON W1, WORKS_ON W2
WHERE E1.Ssn = W1.Essn AND
      E2.Ssn = W2.Essn AND
      W1.Pno = W2.Pno AND
      W1.Hours = W2.Hours AND
      E1.Ssn < E2.Ssn
ORDER BY E1.Lname;

--
/*(16B)
For every employee who has more than one dependent: Find the ssn, lname, and number of dependents. Sort the result by lname
*/
SELECT E.Ssn, E.Lname, COUNT(*) AS "Number of Dependents"
FROM EMPLOYEE E, DEPENDENT D
WHERE E.Ssn = D.Essn
GROUP BY E.Ssn, E.Lname
Having COUNT (D.Essn) > 1
ORDER BY E.Lname;
-- 
/*(17B)
For every project that has more than 2 employees working on and the total hours worked on it is less than 40: Find the project number, project name, number of employees working on it, and the total number of hours worked by all employees on that project. Sort the results by project number.
*/
SELECT W.Pno, P.Pname, COUNT(*) AS "Num of Eployees", SUM(W.Hours) AS "Total Hours Worked"
FROM WORKS_ON W, PROJECT P
WHERE W.Pno = P.Pnumber
GROUP BY W.Pno, P.Pname
Having COUNT(W.Pno) > 2
ORDER BY W.Pno;
--
-- CORRELATED SUBQUERY --------------------------------
--
/*(18B)
For every employee whose salary is above the average salary in his department: Find the dno, ssn, lname, and salary. Sort the results by department number.
*/
SELECT E1.Dno, E1.Ssn, E1.Lname, E1.Salary
FROM EMPLOYEE E1
WHERE E1.Salary > (Select AVG(E2.Salary)
                   FROM EMPLOYEE E2
                   WHERE E1.Dno = E2.Dno)
ORDER BY E1.Dno;
--
-- CORRELATED SUBQUERY -------------------------------
--
/*(19B)
For every employee who works for the research department but does not work on any one project for more than 20 hours: Find the ssn and lname. Sort the results by lname
*/
SELECT E.Ssn, E.Lname
FROM EMPLOYEE E
WHERE E.Dno = (SELECT DISTINCT D.Dnumber
               FROM DEPARTMENT D
               WHERE D.Dname = 'Research') AND
      E.Ssn = (SELECT DISTINCT W.Essn
               FROM WORKS_ON W
               WHERE W.Hours < 20 AND
               E.Ssn = W.Essn) AND
      NOT EXISTS(SELECT W.Essn
                 FROM WORKS_ON W
                 WHERE W.Hours > 20 AND
                 E.Ssn = W.Essn)
ORDER BY E.Lname;
--
-- DIVISION ---------------------------------------------
--
/*(20B) Hint: This is a DIVISION query
For every employee who works on every project that is controlled by department 4: Find the ssn and lname. Sort the results by lname
*/
SELECT E.Ssn, E.Lname
FROM EMPLOYEE E
WHERE NOT EXISTS((SELECT P.Pnumber
                  FROM PROJECT P
                  WHERE P.Dnum = 4)
                 MINUS
                  (SELECT W.Pno
                   FROM WORKS_ON W, PROJECT P
                   WHERE E.Ssn = W.Essn AND
                         P.Pnumber = W.Pno AND
                         P.Dnum = 4))
ORDER BY E.Lname;
--
SET ECHO OFF
SPOOL OFF


