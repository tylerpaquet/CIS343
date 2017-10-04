-- File PLh20.sql
-- Author: <<< YOUR NAME >>>
-------------------------------------------------------------------
SET SERVEROUTPUT ON
SET VERIFY OFF
------------------------------------
ACCEPT rateDecrement NUMBER PROMPT 'Enter the rate decrement: '
ACCEPT allowedMinRate NUMBER PROMPT 'Enter the allowed min. rate: '
DECLARE
	p_bid	boats.bid%TYPE;
	p_bname	boats.bname%TYPE;
	p_rate	boats.rate%TYPE;
BEGIN
	SELECT bid, bname, rate
	INTO p_bid, p_bname, p_rate
	FROM boats;
	DBMS_OUTPUT.PUT_LINE('+++Boat '||p_bid||': old rate = '||p_rate);
	if
		p_rate - rateDecrement < allowedMinRate
	then
		DBMS_OUTPUT.PUT_LINE('---Boat '||p_bid||': update rejected. The new rate would have been '||(p_rate - rateDecrement));
	else
		DBMS_OUTPUT.PUT_LINE('+++Boat '||p_bid||': old rate = '||(p_rate - rateDecrement);
	end if;
END;
/