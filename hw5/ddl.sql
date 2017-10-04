SPOOL ddl.out
SET ECHO ON
--
-- Author: Tyler Paquet
--
-- IMPORTANT: use the names IC-1, IC-2, etc. as given below.
-- --------------------------------------------------------------------
-- The two DROP commands below are placed here for convenience in
-- order to drop the tables if they exist. If the tables don't
-- exist, you'll get an error - just ignore the error.
--
--

--
-- ----------------------------------------------------------------
-- TESTING THE SCHEMA
-- ----------------------------------------------------------------
INSERT INTO Orders VALUES (10, 'high', 2400);
INSERT INTO Orders VALUES (20, 'high', 1900);
INSERT INTO Orders VALUES (30, 'high', 2100);
INSERT INTO Orders VALUES (40, 'medium', 700);
INSERT INTO Orders VALUES (50, 'low', 1100);
INSERT INTO Orders VALUES (60, 'low', 900);
SELECT * from Orders;
-- ----------------------------------------------------------------
INSERT INTO OrderLine VALUES (10, 1, 'AAA', 200);
INSERT INTO OrderLine VALUES (10, 2, 'BBB', 300);
INSERT INTO OrderLine VALUES (60, 1, 'CCC', 5);
INSERT INTO OrderLine VALUES (15, 1, 'AAA', 7);
SELECT * FROM OrderLine;
--
DELETE FROM Orders WHERE orderNum = 10;
SELECT * From Orders;
SELECT * FROM OrderLine;
--
SET ECHO OFF
SPOOL OFF
