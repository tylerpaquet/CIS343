Set ECHO ON
DROP TABLE Orders CASCADE CONSTRAINTS;
DROP TABLE OrderLine CASCADE CONSTRAINTS;
SET ECHO OFF

CREATE TABLE Orders
(
orderNum INTEGER PRIMARY KEY,
priority CHAR(10) NOT NULL,
cost INTEGER NOT NULL,
/*
IC1: The priority is one of: high, medium, or low
*/
CONSTRAINT IC1 CHECK (priority IN ('high', 'medium', 'low')),
/*
IC2: The cost of a high priority order is above 2000.
*/
CONSTRAINT IC2 CHECK (NOT (priority = 'high' AND cost < 2000)),
/*
IC3: The cost of a medium priority order is between 800 and 2200 (inclusive).
*/
CONSTRAINT IC3 CHECK (NOT (priority = 'medium' AND cost < 800 AND cost > 2220)),
/*
IC4: The cost of a low priority order is less than 1000.
*/
CONSTRAINT IC4 CHECK (NOT (priority = 'low' AND cost >= 1000))
);
--
--
CREATE TABLE OrderLine
(
orderNum INTEGER,
lineNum INTEGER,
item CHAR (10) NOT NULL,
quantity INTEGER,
PRIMARY KEY (orderNum, lineNum),
/*
IC5: Every order line must belong to an order in the Order table.
Also: if an order is deleted then all its order lines must be deleted.
IMPORTANT: DO NOT declare this IC as DEFERRABLE.
*/
CONSTRAINT IC5 FOREIGN KEY (orderNum) REFERENCES Orders(orderNum)
		ON DELETE CASCADE
);