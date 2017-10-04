DROP TABLE Patients CASCADE CONSTRAINTS;
DROP TABLE Rooms CASCADE CONSTRAINTS;
DROP TABLE Doctors CASCADE CONSTRAINTS;
DROP TABLE Nurses CASCADE CONSTRAINTS;
DROP TABLE Units CASCADE CONSTRAINTS;
DROP TABLE Visits CASCADE CONSTRAINTS;
DROP TABLE Admitted_for CASCADE CONSTRAINTS;
DROP TABLE Skill_types CASCADE CONSTRAINTS;
DROP TABLE Cared_for CASCADE CONSTRAINTS;
DROP TABLE Works_on CASCADE CONSTRAINTS;
CREATE TABLE Patients 
(
	ssn		char(9) PRIMARY KEY,
	fname		varchar2(15),
	lname		varchar2(15),
	contact_number	number(10) NOT NULL,
	rNum		number(3),
	admit_date	date
);
--
CREATE TABLE Rooms 
(
	rNum		number(3) PRIMARY KEY,
	uType		varchar2(15)
);
--
CREATE TABLE Doctors 
(
	dID		number(2) PRIMARY KEY,
	lname		varchar2(15)
);
--
CREATE TABLE Nurses 
(
	nID		number(2) PRIMARY KEY,
	lname		varchar2(15)
);
--
CREATE TABLE Units 
(
	uType		varchar2(15) PRIMARY KEY,
	location	varchar2(15)
);
--
CREATE TABLE Visits 
(
	visit_date	date,
	pSSN		number(9),
	cost		number(7),
	ins_payment	number(7),
	dID		number(2),
	primary key (visit_date,pSSN),
--cost of a visit must be greater than 0
CONSTRAINT vIC1 CHECK(cost > 0),
--insurance payment must be between 0 and the total cost
CONSTRAINT vIC3 CHECK(ins_payment > 0 AND ins_payment <= cost)
);
--
CREATE TABLE Admitted_for 
(
	ssn		char(9),
	admitted_for	varchar2(15),
	primary key (ssn,admitted_for),
--admitted for one of the following 12 reasons
CONSTRAINT aIC2 CHECK(Admitted_For IN ('cardiovascular', 'neurology', 'dermatology', 'psychiatry'))
);
--
CREATE TABLE Skill_types 
(
	dID		number(2),
	skill_type	varchar2(15),
	primary key (dID,skill_type),
--doctor's skills must be in the set enumerated below
CONSTRAINT dIC1 CHECK(skill_type IN ('cardiovascular', 'neurology', 'dermatology', 'psychiatry'))
);
--
CREATE TABLE Cared_for 
(
	pSSN		char(9),
	nID		number(2),
	primary key (pSSN, nID)
);
--
CREATE TABLE Works_on 
(
	nID		number(2),
	uType		varchar2(15),
	primary key (nID, uType)
);
-- Add the foreign keys
ALTER TABLE Patients
ADD FOREIGN KEY (rNum) references Rooms(rNum)
Deferrable initially deferred;
ALTER TABLE Rooms
ADD FOREIGN KEY (uType) references Units(uType)
Deferrable initially deferred;
ALTER TABLE Visits
ADD FOREIGN KEY (dID) references Doctors(dID)
Deferrable initially deferred;
ALTER TABLE Cared_for
ADD FOREIGN KEY (pSSN) references Patients(ssn)
Deferrable initially deferred;
ALTER TABLE Cared_for
ADD FOREIGN KEY (nID) references Nurses(nID)
Deferrable initially deferred;
ALTER TABLE Works_on
ADD FOREIGN KEY (nID) references Nurses(nID)
Deferrable initially deferred;
ALTER TABLE Works_on
ADD FOREIGN KEY (uType) references Units(uType)
Deferrable initially deferred;
ALTER TABLE Admitted_for
ADD FOREIGN KEY (ssn) references Patients(ssn)
Deferrable initially deferred;
ALTER TABLE Skill_types
ADD FOREIGN KEY (dId) references Doctors(dID)
Deferrable initially deferred;
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
-- --------------------------------------------------------------------
-- POPULATING THE DATABASE INSTANCE
-- --------------------------------------------------------------------
INSERT INTO Patients VALUES (000000000, 'John', 'Doe', 1234567890, 005, TO_DATE('09/05/12', 'MM/DD/YY'));
INSERT INTO Patients VALUES (121719940, 'Robin', 'Goodfellow', 8108433425, 014, TO_DATE('08/24/12', 'MM/DD/YY'));
INSERT INTO Patients VALUES (061119920, 'Inani', 'Somnus', 5712774653, 002, TO_DATE('07/11/14', 'MM/DD/YY'));
INSERT INTO Patients VALUES (060519950, 'Chrysalia', 'Hime', 9422782565, 042, TO_DATE('02/12/15', 'MM/DD/YY'));
INSERT INTO Patients VALUES (999999999, 'Johnson', 'vonJohnson', 6928746377, 999, TO_DATE('01/01/21', 'MM/DD/YY'));
INSERT INTO Patients VALUES (012420140, 'Rosalyn', 'Wynn', 5559277836, 021, TO_DATE('10/10/16', 'MM/DD/YY'));
INSERT INTO Patients VALUES (123456789, 'Neomi', 'Wynn', 5559277836, 022, TO_DATE('10/10/16', 'MM/DD/YY'));
INSERT INTO Patients VALUES (091520100, 'Ethan', 'Misdre', 2426335873, 010, TO_DATE('03/14/15', 'MM/DD/YY'));
INSERT INTO Patients VALUES (638258447, 'Haki', 'Saki', 2446424664, 033, TO_DATE('12/31/15', 'MM/DD/YY'));
INSERT INTO Patients VALUES (011110010, 'Tiny', 'Tim', 2222222222, 222, TO_DATE('12/31/15', 'MM/DD/YY'));
INSERT INTO Patients VALUES (111111111, 'Jesus', 'Christ', 8436377424, 001, TO_DATE('04/24/00', 'MM/DD/YY'));
-----------------------------------------------------------------------
INSERT INTO Doctors VALUES (02, 'Smith');
INSERT INTO Doctors VALUES (07, 'Johnson');
INSERT INTO Doctors VALUES (13, 'Anderson');
INSERT INTO Doctors VALUES (20, 'Williams');
INSERT INTO Doctors VALUES (21, 'Brown');
----------------------------------------------------------------------
INSERT INTO Nurses VALUES (01, 'Miller');
INSERT INTO Nurses VALUES (02, 'Taylor');
INSERT INTO Nurses VALUES (03, 'Garcia');
INSERT INTO Nurses VALUES (04, 'Jones');
INSERT INTO Nurses VALUES (05, 'Stephen');
----------------------------------------------------------------------
INSERT INTO Rooms VALUES (002, 'Recovery');
INSERT INTO Rooms VALUES (005, 'Recovery');
INSERT INTO Rooms VALUES (012, 'Recovery');
INSERT INTO Rooms VALUES (014, 'Recovery');
INSERT INTO Rooms VALUES (042, 'Surgery');
INSERT INTO Rooms VALUES (999, 'Surgery');
INSERT INTO Rooms VALUES (021, 'Surgery');
INSERT INTO Rooms VALUES (022, 'Surgery');
INSERT INTO Rooms VALUES (010, 'General');
INSERT INTO Rooms VALUES (033, 'General');
INSERT INTO Rooms VALUES (222, 'General');
INSERT INTO Rooms VALUES (001, 'General');
----------------------------------------------------------------------
INSERT INTO Units VALUES ('Recovery', 'North');
INSERT INTO Units VALUES ('Surgery', 'West');
INSERT INTO Units VALUES ('General', 'Center');
----------------------------------------------------------------------
INSERT INTO Admitted_for VALUES (121719940, 'neurology');
INSERT INTO Admitted_for VALUES (061119920, 'neurology');
INSERT INTO Admitted_for VALUES (060519950, 'psychiatry');
INSERT INTO Admitted_for VALUES (999999999, 'dermatology');
INSERT INTO Admitted_for VALUES (012420140, 'psychiatry');
INSERT INTO Admitted_for VALUES (123456789, 'cardiovascular');
INSERT INTO Admitted_for VALUES (091520100, 'dermatology');
INSERT INTO Admitted_for VALUES (638258447, 'dermatology');
INSERT INTO Admitted_for VALUES (011110010, 'dermatology');
INSERT INTO Admitted_for VALUES (111111111, 'psychiatry');
----------------------------------------------------------------------
INSERT INTO Skill_types VALUES (02, 'cardiovascular');
INSERT INTO Skill_types VALUES (07, 'cardiovascular');
INSERT INTO Skill_types VALUES (07, 'neurology');
INSERT INTO Skill_types VALUES (13, 'psychiatry');
INSERT INTO Skill_types VALUES (20, 'dermatology');
INSERT INTO Skill_types VALUES (21, 'dermatology');
INSERT INTO Skill_types VALUES (21, 'psychiatry');
----------------------------------------------------------------------
INSERT INTO Visits VALUES (TO_DATE('08/24/12', 'MM/DD/YY'), 121719940, 0001000, 0000500, 07);
INSERT INTO Visits VALUES (TO_DATE('07/11/14', 'MM/DD/YY'), 061119920, 0000250, 0000245, 07);
INSERT INTO Visits VALUES (TO_DATE('02/12/15', 'MM/DD/YY'), 060519950, 0015000, 0007500, 13);
INSERT INTO Visits VALUES (TO_DATE('01/01/21', 'MM/DD/YY'), 999999999, 0001000, 0000001, 21);
INSERT INTO Visits VALUES (TO_DATE('10/10/16', 'MM/DD/YY'), 012420140, 0005000, 0001000, 21);
INSERT INTO Visits VALUES (TO_DATE('10/10/16', 'MM/DD/YY'), 123456789, 0050000, 0003000, 02);
INSERT INTO Visits VALUES (TO_DATE('03/14/15', 'MM/DD/YY'), 091520100, 0000100, 0000001, 20);
INSERT INTO Visits VALUES (TO_DATE('12/31/15', 'MM/DD/YY'), 638258447, 0004500, 0000450, 20);
INSERT INTO Visits VALUES (TO_DATE('12/31/15', 'MM/DD/YY'), 011110010, 0000200, 0000010, 20);
INSERT INTO Visits VALUES (TO_DATE('04/24/00', 'MM/DD/YY'), 111111111, 0999999, 0000250, 21);
----------------------------------------------------------------------
INSERT INTO works_on VALUES (01, 'Recovery');
INSERT INTO works_on VALUES (02, 'Surgery');
INSERT INTO works_on VALUES (03, 'General');
INSERT INTO works_on VALUES (04, 'Recovery');
INSERT INTO works_on VALUES (05, 'General');
----------------------------------------------------------------------
INSERT INTO cared_for VALUES (061119920, 01);
INSERT INTO cared_for VALUES (000000000, 01);
INSERT INTO cared_for VALUES (121719940, 04);
INSERT INTO cared_for VALUES (060519950, 02);
INSERT INTO cared_for VALUES (999999999, 02);
INSERT INTO cared_for VALUES (012420140, 02);
INSERT INTO cared_for VALUES (123456789, 02);
INSERT INTO cared_for VALUES (091520100, 05);
INSERT INTO cared_for VALUES (638258447, 02);
INSERT INTO cared_for VALUES (011110010, 02);
INSERT INTO cared_for VALUES (111111111, 05);
----------------------------------------------------------------------
COMMIT;
----------------------------------------------------------------------
--Find the last name and room number of every patient treated by Dr. Johnson
--"a join involving at least four relations"
SELECT P.lname, R.rNum
FROM Visits V, Doctors D, Rooms R, Patients P
WHERE V.pSSN=P.ssn AND V.dID=D.dID AND P.rNum=R.rNum AND D.lname='Johnson'
ORDER BY P.lname;
----------------------------------------------------------------------
--Find the first and last names and admit dates of pairs of patients that were admitted on the same day
--"self-join query"
SELECT P1.fname, P1.lname, P2.fname, P2.lname, P1.admit_date
FROM Patients P1, Patients P2
WHERE P1.admit_date=P2.admit_date AND P1.ssn < P2.ssn
ORDER BY P1.admit_date;
----------------------------------------------------------------------
--find the average cost of a visit to this hospital
--"query involving AVG"
SELECT AVG(cost)
FROM Visits;
----------------------------------------------------------------------
--select patients that are cared for by Dr. Brown and Nurse Stephen
--"intersect query"
--Patients with nurse '05'
SELECT P.fname, P.lname
FROM Cared_for C, Patients P, Nurses N
WHERE C.pSSN = P.ssn AND
	C.nID = N.nID AND
	N.lname = 'Stephen'
INTERSECT
--Patients with doctor '21' 
SELECT P.fname, P.lname
FROM Visits V, Doctors D, Patients P
WHERE V.pSSN = P.ssn AND
	V.dID = D.dID AND
	D.lname = 'Brown';
----------------------------------------------------------------------
--Find the dID and number of appointments/visits by doctors who treat more than one patient
--"GROUP BY, ORDER BY, and HAVING in the same query"
SELECT D.dID, COUNT(*)
FROM Doctors D, Visits V, Patients P
WHERE D.dID=V.dID AND V.pSSN=P.ssn
GROUP BY D.dID
HAVING COUNT(*) > 1
ORDER BY D.dID;
----------------------------------------------------------------------
--Find the doctor ID and patient ssn of patients that are treated for nuerology problems
--"correlated subquery"
SELECT DISTINCT V.dID, P.ssn
FROM Patients P, Visits V
WHERE EXISTS(SELECT V.dID
		FROM Skill_types S, Doctors D
		WHERE S.dID=D.dID AND V.dID=D.dID AND S.skill_type='neurology');
----------------------------------------------------------------------
--find the last name of the patient in room 21, if there is a patient with a last name with a n' 
--in it
--"non correlated subsquery"
SELECT P.lname
FROM Patients P
WHERE P.rNum=021 AND EXISTS(SELECT * 
				FROM Patients P
				WHERE P.lname LIKE '%n%');
----------------------------------------------------------------------
--Find the name and ID of every doctor who treats every patient with neurological issues
--"division query"
SELECT D.dID, D.lname
FROM Doctors D
WHERE NOT EXISTS((SELECT V.visit_date, V.pSSN
			FROM Visits V, Admitted_for A
			WHERE A.admitted_for='neurology' AND V.pSSN=A.ssn )
			MINUS (SELECT V.visit_date, V.pSSN
				              FROM Skill_types S, Visits V, Admitted_for A
					WHERE D.dID=S.dID AND 
					D.dID=V.dID AND 
					A.ssn=V.pSSN AND
					S.skill_type='neurology' ));
----------------------------------------------------------------------
--List all the rooms and if they have a patient in them, list the patient's last name
SELECT R.rNum, P.lname
FROM Rooms R LEFT OUTER JOIN Patients P ON R.rNum=p.rNum
ORDER BY R.rNum;
----------------------------------------------------------------------
/*
--checks illness can be treated by doctor
CREATE OR REPLACE TRIGGER vIC1
BEFORE INSERT OR UPDATE OF Admitted_for ON Admitted_for
FOR EACH ROW
BEGIN
--patient is being treated by wrong doctor
IF EXISTS (SELECT * 
			FROM Admitted_for A, Doctors D, Skill_types S, Visits V
			WHERE V.dID=D.dID AND A.Admitted_for<>S.Skill_types
				AND S.dID=D.dID)
THEN
	     RAISE_APPLICATION_ERROR(-20001, 'Patient is being treated by wrong doctor'); 
END IF;
END;
*/
