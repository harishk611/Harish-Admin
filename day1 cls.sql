--# Question 1:
# 1) Create a Database Bank

--# Question 2:
--# 2) Create a table with the name “Bank_Inventory” with the following columns
-- Product  with string data type and size 10 --
-- Quantity with numerical data type --
-- Price with data type that can handle all real numbers
-- purcahase_cost with data type which always shows two decimal values --
-- estimated_sale_price with data type float --

CREATE TABLE BANK_INVENTORY(PRODUCT VARCHAR2(20),QUANTITY NUMBER(10),
PRICE DECIMAL(*,2),purcahase_cost DECIMAL(*,2),estimated_sale_price DECIMAL(*,2));

SELECT * FROM BANK_INVENTORY;
DROP TABLE BANK_INVENTORY;

--# Question 3:
--# 3) Display all columns and their datatype and size in Bank_Inventory

DESC BANK_INVENTORY;

# Question 4:
--# 4) Insert two records into Bank_Inventory .
-- 1st record with values --
			-- Product : PayCard
			-- Quantity: 2 
			-- price : 300.45 
			-- Puchase_cost : 8000.87
			-- estimated_sale_price: 9000.56 --
-- 2nd record with values --
			-- Product : PayPoints
			-- Quantity: 4
			-- price : 200.89 
			-- Puchase_cost : 7000.67
			-- estimated_sale_price: 6700.56

INSERT  INTO BANK_INVENTORY VALUES  ('PayCard',2,300.450,8000.8700,9000.56);
INSERT  INTO BANK_INVENTORY VALUES  ('PayPoints',4,200.89,7000.67,6700.56);

SELECT * FROM BANK_INVENTORY;

# Question 5:
--# 5) Add a column : Geo_Location to the existing Bank_Inventory table with data type varchar and size 20 

alter table BANK_INVENTORY add Geo_location varchar2(20);

select * from BANK_INVENTORY;
# Question 6:
--# 6) What is the value of Geo_Location for product : ‘PayCard’?

select Geo_Location 
from BANK_INVENTORY 
where product='PayCard';

# Question 7:
--# 7) How many characters does the  Product : ‘PayCard’ stores in the Bank_Inventory table.

select length(product)
from Bank_Inventory
where product='PayCard';

--Question 8:
---a) Update the Geo_Location field from NULL to ‘Delhi-City’ 

update Bank_Inventory set Geo_Location='Delhi-City' where Geo_Location is null;

--# b) How many characters does the  Geo_Location field value ‘Delhi-City’ stores in the Bank_Inventory table

select length(Geo_location)
from Bank_Inventory
where Geo_location='Delhi-City';

# Question 9:
--# 9) update the Product field from CHAR to VARCHAR size 10 in Bank_Inventory 

alter table Bank_Inventory modify (product varchar2(10));

select * from Bank_Inventory;
desc Bank_Inventory;
# Question 10:
--# 10) Reduce the size of the Product field from 10 to 6 and check if it is possible 

select (max(length(product))) from Bank_Inventory;

alter table Bank_Inventory modify product varchar2(9);

# Question 11:
--# 11) Bank_inventory table consists of ‘PayCard’ product details .
-- For ‘PayCard’ product, Update the quantity from 2 to 10  

alter table Bank_Inventory modify product varchar2(15);

 # Question 12:
--# 12) Create a table named as Bank_Holidays with below fields 
-- a) Holiday field which displays or accepts only date 
-- b) Start_time field which also displays or accepts date and time both.  
-- c) End_time field which also displays or accepts date and time along with the timezone also. 

CREATE TABLE Bank_Holidays (
    Holiday DATE,
    Start_time TIMESTAMP,
    End_time TIMESTAMP WITH TIME ZONE
);

select * from bank_holidays;

desc bank_holidays;

insert into bank_holidays values('04-02-2023','04-02-2023 08:00:00AM','04-02-2023 11:00:00PM');
insert into bank_holidays values('07-02-2023','07-02-2023 05:00:00AM','07-02-2023 10:00:00PM');

select * from bank_holidays;

 # Question 13:
--# 13) Step 1: Insert today’s date details in all fields of Bank_Holidays 

insert into bank_holidays values('02-04-2023','02-04-2023 12:00:00AM','02-04-2023 11:59:59PM');

select * from bank_holidays;

-- Step 2: After step1, perform the below 
-- Postpone Holiday to next day by updating the Holiday field 

UPDATE bank_holidays SET HOLIDAY='04-04-2023',START_TIME='04-04-23 12:00:00.000000000 AM',END_TIME='04-04-23 11:59:59.000000000 PM ASIA/CALCUTTA'
WHERE HOLIDAY='02-04-2023';

SELECT * FROM bank_holidays;

# Question 14:
--# 14) Modify  the Start_time data with today’s date in the Bank_Holidays table 

UPDATE bank_holidays SET START_TIME='04-04-23 01:00:00.000000000 AM'
WHERE START_TIME='04-04-23 12:00:00.000000000 AM';

select * from bank_holidays;

drop table bank_holidays;
# Question 15:
--# 15) Update the End_time with current european time in the Bank_Holidays table. 

SELECT SYSTIMESTAMP AT TIME ZONE 'Europe/London' FROM dual;
--03-04-23 8:26:50.324693000 AM EUROPE/LONDON
-------------
UPDATE bank_holidays SET END_TIME='03-04-23 8:26:50.324693000 AM EUROPE/LONDON'
WHERE END_TIME='03-04-23 6:54:33.760636000 AM Europe/London';

select * from bank_holidays;

# Question 16:
--# 16) Select all columns from Bank_Inventory without mentioning any column name

SELECT * FROM BANK_INVENTORY;


# Question 17:
--# 17)  Display output of PRODUCT field as NEW_PRODUCT in  Bank_Inventory table 

ALTER TABLE Bank_Inventory
RENAME COLUMN product TO NEW_PRODUCT;

# Question 18:
--# 18)  Display only one record from bank_Inventory 

select * from Bank_Inventory 
WHERE ROWNUM=1;
-----------------
SELECT * FROM Bank_Inventory
FETCH FIRST 1 ROW ONLY;

# Question 19:
--# 19) Display Holiday field as  DD-MM-YYYY format in Bank_holidays table. 
--  Ex: 10-February-2020

SELECT * FROM bank_holidays;

 alter session set nls_date_format = 'dd-month-yyyy';

# Question 20:
--# 20) Display the first five characters of the Geo_location field of Bank_Inventory.
SELECT substr(Geo_location, 1,5) first_5_char
FROM Bank_Inventory;


commit;