create table country
(country_id number(6) primary key,
country_name varchar2(20));

create table resort
(resort_id number(4) primary key,
resort_name varchar2(20),
country_id number(2) references country(country_id));

create table customer
(cust_id number(5) primary key,
cust_name varchar2(20),
phone number(10),
country_id number(2) references country(country_id));

insert all
into country values(1,'US')
into country values(2,'UK')
into country values(3,'INDIA')
select * from dual;

insert into country values(4,'MALDIVES');

insert all
into resort values(10,'Blue valley',1)
into resort values(20,'Beach front',1)
into resort values(30,'Taj Oberai',2)
into resort values(40,'Taj Maldives',4)
into resort values(50,'Golden Flowers',2)
into resort values(60,'Taj valley',1)
select * from dual;

insert all
into customer values(1001,'tim downey',345231458,1)
into customer values(1002,'ramesh k',89327648,2)
into customer values(1003,'bill price',78326753,1)
into customer values(1004,'malinga',98564231,3)
into customer values(1005,'farooq',45893121,4)
select * from dual;

COMMIT;

SELECT * FROM COUNTRY;
SELECT * FROM RESORT;
SELECT * FROM CUSTOMER;

--1.Query to find out number of resorts based on country.

SELECT COUNTRY_NAME,COUNT(RESORT_ID) AS COUNT
FROM COUNTRY C INNER JOIN RESORT R
ON C.COUNTRY_ID = R.COUNTRY_ID
GROUP BY COUNTRY_NAME;

--2.Query to display country wise customer count.

SELECT COUNTRY_NAME, COUNT(CUST_ID)
FROM COUNTRY C INNER JOIN CUSTOMER C1
ON C.COUNTRY_ID = C1.COUNTRY_ID
GROUP BY COUNTRY_NAME;

--3.Query to display country, resort count and customer count.

SELECT NVL2(RESORT1.COUNTRY_NAME,RESORT1.COUNTRY_NAME,CUSTOMER1.COUNTRY_NAME) AS COUNTRY,
       NVL(RESORT1.COUNT,0 ) AS RESORT_COUNT,
       NVL(CUSTOMER1.COUNT,0) AS CUSTOMER_COUNT
FROM
      (SELECT COUNTRY_NAME,COUNT(RESORT_ID) AS COUNT
       FROM COUNTRY C INNER JOIN RESORT R
       ON C.COUNTRY_ID = R.COUNTRY_ID
       GROUP BY COUNTRY_NAME) RESORT1
FULL JOIN
      (SELECT COUNTRY_NAME, COUNT(CUST_ID) AS COUNT
       FROM COUNTRY C INNER JOIN CUSTOMER C1
       ON C.COUNTRY_ID = C1.COUNTRY_ID
       GROUP BY COUNTRY_NAME) CUSTOMER1
ON RESORT1.COUNTRY_NAME = CUSTOMER1.COUNTRY_NAME ;

--4.Display Resort country name, resort name, customer name and customer country name

SELECT NVL2(RESORT1.COUNTRY_NAME,RESORT1.COUNTRY_NAME,CUSTOMER1.COUNTRY_NAME) AS COUNTRY_NAME,
       NVL(RESORT1.RESORT,0) AS RESORT_NAME,
       NVL(CUSTOMER1.CUSTOMER,0) AS CUSTOMER_NAME
FROM
      (SELECT COUNTRY_NAME,NVL(RESORT_NAME,0) RESORT
       FROM COUNTRY C FULL JOIN RESORT R
       ON C.COUNTRY_ID = R.COUNTRY_ID) RESORT1
FULL JOIN
      (SELECT COUNTRY_NAME,(CUST_NAME) CUSTOMER
       FROM COUNTRY C FULL JOIN CUSTOMER C1
       ON C.COUNTRY_ID = C1.COUNTRY_ID) CUSTOMER1
ON RESORT1.COUNTRY_NAME = CUSTOMER1.COUNTRY_NAME ;

--5.Display countries in which we don’t have any resorts.

SELECT COUNTRY_NAME
FROM COUNTRY 
WHERE COUNTRY_ID NOT IN (SELECT DISTINCT(COUNTRY_ID)
                         FROM RESORT)
                         
--6.Display countries in which we have minimum of 100 customers.

SELECT COUNTRY_NAME,COUNT(CUST_ID) AS CUSTOMER_COUNT
FROM COUNTRY C FULL JOIN CUSTOMER C1
ON C.COUNTRY_ID = C1.COUNTRY_ID
GROUP BY COUNTRY_NAME
HAVING COUNT(CUST_ID) > 100 ;

--7.Display how many resorts we have in the country where resort ‘Beach front’ is?

SELECT COUNTRY_NAME, COUNT(RESORT_ID) AS COUNT
FROM COUNTRY C INNER JOIN RESORT R
ON C.COUNTRY_ID = R.COUNTRY_ID
WHERE COUNTRY_NAME = (SELECT COUNTRY_NAME
                      FROM COUNTRY C INNER JOIN RESORT R
                      ON C.COUNTRY_ID = R.COUNTRY_ID 
                      WHERE RESORT_NAME = 'Beach front')
GROUP BY COUNTRY_NAME;
                    
--8.Display customers whose name starts with F or R and who are either from India or Srilanka.

SELECT CUST_NAME
FROM COUNTRY C FULL JOIN CUSTOMER C1
ON C.COUNTRY_ID = C1.COUNTRY_ID
WHERE (CUST_NAME LIKE 'f%'  OR CUST_NAME LIKE 'r%') AND
      (COUNTRY_NAME = 'INDIA' OR COUNTRY_NAME = 'SRILANKA')
      
--9.Display customer names who are from US and do not have any phone numbers.

SELECT COUNTRY_NAME
FROM COUNTRY C INNER JOIN CUSTOMER C1
ON C.COUNTRY_ID = C1.COUNTRY_ID
WHERE (COUNTRY_NAME = 'US') AND PHONE IS NULL;

--10.Display Country name, resort name. Display all the countries whether we have resorts or not

SELECT COUNTRY_NAME,NVL(RESORT_NAME,0) AS RESORT_NAME
FROM COUNTRY C FULL JOIN RESORT R
ON C.COUNTRY_ID = R.COUNTRY_ID 

--11.Display countries which have more resorts than the no of resorts in country India

SELECT COUNTRY_NAME, COUNT(RESORT_NAME)
FROM COUNTRY C INNER JOIN RESORT R
ON C.COUNTRY_ID = R.COUNTRY_ID 
GROUP BY COUNTRY_NAME
HAVING COUNT(RESORT_NAME) > ( SELECT COUNT(RESORT_NAME)
                              FROM COUNTRY C INNER JOIN RESORT R
                              ON C.COUNTRY_ID = R.COUNTRY_ID 
                              WHERE COUNTRY_NAME = 'INDIA');
                              
--12.Display all the countries and resorts, if the country doesn’t have resort display as ‘no resort’.
                              
SELECT COUNTRY_NAME,NVL(RESORT_NAME,'no resort') AS RESORT_NAME
FROM COUNTRY C FULL JOIN RESORT R
ON C.COUNTRY_ID = R.COUNTRY_ID;

--13.Display the countries as level-1,level-2 and level3 if the no of resorts in the country are more than 50 then level 1, if >30 then level 2 otherwise level 3

SELECT COUNTRY_NAME, CASE WHEN COUNT(RESORT_ID) > 50 THEN 'LEVEL 1' 
                          WHEN COUNT(RESORT_ID) > 30 THEN 'LEVEL 2'  
                          ELSE 'LEVEL 3'  
                     END "LEVEL"
FROM 
COUNTRY C FULL JOIN RESORT R
ON C.COUNTRY_ID = R.COUNTRY_ID
GROUP BY COUNTRY_NAME ;



