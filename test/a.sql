-- File: project-hospitalDB.sql
--
/* This command file creates and populates the HOSPITAL database for the 353 Final project */
--
/* AUTHORS:	Connor Butch
		Benjamin LaFeldt
		Matt Schuch
		Tyler Packet
*/
--
-- TODO: Drop tables if they exist
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
--
-- Create the tables
--
CREATE TABLE Patients (
	ssn		char(9) PRIMARY KEY,
	fname		varchar2(15),
	lname		varchar2(15),
	contact_number	number(10) NOT NULL,
	rNum		number(3),
	admit_date	date,
	dID		number(2)
--rNum is a foreign key
CONSTRAINT pIC2 FOREIGN KEY (rNum) REFERENCES Rooms(rNum) DEFERRABLE INITIALLY DEFERRED,
--dID is a foreign key
CONSTRAINT pIC3 FOREIGN KEY (dID) REFERENCES Doctors(dID) DEFERRABLE INITIALLY DEFERRED
);
--
CREATE TABLE Rooms (
	rNum		number(3) PRIMARY KEY,
	rType		varchar2(15),
	uType		varchar2(15)
--uType is a foregin key
CONSTRAINT rIC1 FOREIGN KEY (uType) references Units(uType) DEFERRABLE INITIALLY DEFERRED
);
--
CREATE TABLE Doctors (
	dID		number(2) PRIMARY KEY,
	lname		varchar2(15)
);
--
CREATE TABLE Nurses (
	nID		number(2) PRIMARY KEY,
	lname		varchar2(15)
);
--
CREATE TABLE Units (
	uType		varchar2(15) PRIMARY KEY,
	location	varchar2(15)
);
--
CREATE TABLE Visits (
	visit_date	date,
	pSSN		number(9),
	cost		number(7),
	ins_payment	number(7),
	dID		number(2),
	primary key (visit_date,pSSN)
--cost of a visit must be greater than 0
CONSTRAINT vIC1 CHECK(cost > 0),
--insurance payment must be between 0 and the total cost
CONSTRAINT vIC3 CHECK(ins_payment > 0 AND ins_payment <= cost),
--dID is a foreign key
FOREIGN KEY (dID) references Doctors(dID) DEFERRABLE INITIALLY DEFERRED
);
--
CREATE TABLE Admitted_for (
	ssn		char(9),
	admitted_for	varchar2(15),
	primary key (ssn,admitted_for)
--ssn is a foreign key
CONSTRAINT aIC1 FOREIGN KEY (ssn) REFERENCES Patients(ssn) DEFERRABLE INITIALLY DEFERRED,
--admitted for one of the following 12 reasons
CONSTRAINT aIC2 CHECK(Admitted_For IN ('heart murmur', 'heart attack', 'blood clot', 'Parkinsons', 'stroke', 'multiple sclerosis', 'skin cancer', 'burn', 'wart', 'schizophrenia', 'depression', 'alcoholism'))
);
--
CREATE TABLE Skill_types (
	dID		number(2),
	skill_type	varchar2(15),
	primary key (dID,skill_type)
--doctor's skills must be in the set enumerated below
CONSTRAINT dIC1 CHECK(skill_type IN ('cardiologist', 'neurologist', 'dermatologist', 'psychiatrist')),
--dID is a foreign key
CONSTRAINT dIC2 FOREIGN KEY (dID) REFERENCES Doctors(dID) DEFERRABLE INITIALLY DEFERRED
);
--
CREATE TABLE Cared_for (
	pSSN		char(9),
	nID		number(2),
	primary key (pSSN, nID)
--pSSN is a foreign key
CONSTRAINT cIC1 FOREIGN KEY (pSSN) references Patients(ssn) DEFERRABLE INITIALLY DEFERRED,
--nID is a foreign key
CONSTRAINT cIC2 FOREIGN KEY (nID) references Nurses(nID) DEFERRABLE INITIALLY DEFERRED
);
--
CREATE TABLE Works_on (
	nID		number(2),
	uType		varchar2(15),
	primary key (nID, uType)
--nID is a foreign key
CONSTRAINT wIC1 FOREIGN KEY (nID) references Nurses(nID) DEFERRABLE INITIALLY DEFERRED,
--uType is a foreign key
CONSTRAINT wIC2 FOREIGN KEY (uType) references Units(uType) DEFERRABLE INITIALLY DEFERRED
);




--Alsabaggh adds foreign keys with tables and names them.  To follow this convention
--I suggest we remove the following foreign keys (as they are all present above)
--
-- Add the foreign keys
--ALTER TABLE patient
--ADD FOREIGN KEY (rNum) references Rooms(rNum)
--Deferrable initially deferred;
--ALTER TABLE patient
--ADD FOREIGN KEY (dID) references Doctors(dID)
--Deferrable initially deferred;
--ALTER TABLE room
--ADD FOREIGN KEY (uType) references Units(uType)
--Deferrable initially deferred;
--ALTER TABLE visit
--ADD FOREIGN KEY (dID) references Doctors(dID)
--Deferrable initially deferred;
--ALTER TABLE cared_for
--ADD FOREIGN KEY (pSSN) references Patients(ssn)
--Deferrable initially deferred;
--ALTER TABLE cared_for
--ADD FOREIGN KEY (nID) references Nurses(nID)
--Deferrable initially deferred;
--ALTER TABLE works_on
--ADD FOREIGN KEY (nID) references Nurses(nID)
--Deferrable initially deferred;
--ADD FOREIGN KEY (uType) references Units(uType)
--Deferrable initially deferred;

-- --------------------------------------------------------------------
-- POPULATING THE DATABASE INSTANCE
-- --------------------------------------------------------------------
INSERT INTO Patients VALUES (000000000, John, Doe, 1234567890, 005, TO_DATE('09/05/12', 'MM/DD/YY'), 07);


-- --------------------------------------------------------------------
INSERT INTO Doctors VALUES (02, 'Smith');
INSERT INTO Doctors VALUES (07, 'Johnson');
INSERT INTO Doctors VALUES (13, 'Anderson');
INSERT INTO Doctors VALUES (20, 'Williams');
INSERT INTO Doctors VALUES (21, 'Brown');
-- --------------------------------------------------------------------
INSERT INTO Nurses VALUES (01, 'Miller');
INSERT INTO Nurses VALUES (02, 'Taylor');
INSERT INTO Nurses VALUES (03, 'Garcia');
INSERT INTO Nurses VALUES (04, 'Jones');
INSERT INTO Nurses VALUES (05, 'Stephen');
-- --------------------------------------------------------------------
-- Now, if no violations were detected, COMMIT all the commands in this file
COMMIT;




