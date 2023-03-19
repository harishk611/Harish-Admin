SELECT * FROM AUTHOR;
SELECT * FROM BOOK_AUTHOR;
SELECT * FROM BOOK;
SELECT * FROM PUBLISHER;

COMMIT;


--1) display the book name which mrp is greater than Mountain Healer.

SELECT BOOK_NM 
FROM BOOK
WHERE MRP > (SELECT MRP 
             FROM BOOK
             WHERE BOOK_NM = 'mountain healer');
             

--2)display author name who as written more than 2 book.

SELECT FIRST_NAME,LAST_NAME,COUNT(BOOK_NM) AS COUNT
FROM AUTHOR A INNER JOIN BOOK_AUTHOR BA
ON A.AUTH_ID = BA.AUTH_ID
INNER JOIN BOOK B
ON B.BOOK_ID = BA.BOOK_ID
GROUP BY FIRST_NAME,LAST_NAME
HAVING COUNT(BOOK_NM) > 2 ;


--3) display publisher name author name count of book published authorwise				

SELECT PUB_NAME,FIRST_NAME,LAST_NAME,COUNT(BOOK_NM) AS COUNT
FROM PUBLISHER P INNER JOIN BOOK B
ON P.PUB_ID = B.PUB_ID
INNER JOIN BOOK_AUTHOR BA
ON BA.BOOK_ID = B.BOOK_ID 
INNER JOIN AUTHOR A
ON A .AUTH_ID = BA.AUTH_ID
GROUP BY PUB_NAME, FIRST_NAME,LAST_NAME;


--4)display the book name which is order in the aug 2021			

SELECT BOOK_NM 
FROM BOOK
WHERE TO_CHAR(PUB_DATE,'MON-YYYY') = 'AUG-2021';


--5)which is the common book written by Stephan and John			

((SELECT BOOK_NM
FROM BOOK B INNER JOIN BOOK_AUTHOR BA
ON B.BOOK_ID = BA.BOOK_ID
INNER JOIN AUTHOR A
ON A.AUTH_ID = BA.AUTH_ID
WHERE FIRST_NAME = 'stephan') 
      
INTERSECT

(SELECT BOOK_NM
FROM BOOK B INNER JOIN BOOK_AUTHOR BA
ON B.BOOK_ID = BA.BOOK_ID
INNER JOIN AUTHOR A
ON A.AUTH_ID = BA.AUTH_ID
WHERE FIRST_NAME = 'john')) ;


--6)display which author written maximum books		

SELECT FIRST_NAME,LAST_NAME,COUNT(BOOK_NM) AS COUNT
FROM AUTHOR A INNER JOIN BOOK_AUTHOR BA
ON A.AUTH_ID = BA.AUTH_ID
INNER JOIN BOOK B
ON B.BOOK_ID = BA.BOOK_ID
GROUP BY FIRST_NAME,LAST_NAME
HAVING COUNT(BOOK_NM) = (SELECT MAX(COUNT)
                        FROM
                        (SELECT FIRST_NAME,LAST_NAME,COUNT(BOOK_NM) AS COUNT
                        FROM AUTHOR A INNER JOIN BOOK_AUTHOR BA
                        ON A.AUTH_ID = BA.AUTH_ID
                        INNER JOIN BOOK B
                        ON B.BOOK_ID = BA.BOOK_ID
                        GROUP BY FIRST_NAME,LAST_NAME));
                        

--7)display book names which are same MRP

SELECT BOOK_NM
FROM BOOK
WHERE MRP = (SELECT MRP
             FROM BOOK
             GROUP BY MRP
             HAVING COUNT(*) >1);
             

--8)display the author who has written 2nd highest book	

SELECT FIRST_NAME,LAST_NAME 
FROM
(SELECT FIRST_NAME,LAST_NAME,RANK() OVER(PARTITION BY FIRST_NAME,LAST_NAME ORDER BY COUNT ASC) RANK
FROM
(SELECT FIRST_NAME,LAST_NAME,COUNT(BOOK_NM) AS COUNT
FROM AUTHOR A INNER JOIN BOOK_AUTHOR BA
ON A.AUTH_ID = BA.AUTH_ID
INNER JOIN BOOK B
ON B.BOOK_ID = BA.BOOK_ID
GROUP BY FIRST_NAME,LAST_NAME
HAVING COUNT(BOOK_NM) < (SELECT MAX(COUNT) 
                        FROM
                        (SELECT FIRST_NAME,LAST_NAME,COUNT(BOOK_NM) AS COUNT
                        FROM AUTHOR A INNER JOIN BOOK_AUTHOR BA
                        ON A.AUTH_ID = BA.AUTH_ID
                        INNER JOIN BOOK B
                        ON B.BOOK_ID = BA.BOOK_ID
                        GROUP BY FIRST_NAME,LAST_NAME))))
WHERE RANK = 1; 


--9)display the book published on current year 2nd week of this month

SELECT BOOK_NM 
FROM BOOK
WHERE TO_CHAR(PUB_DATE,'MON-YY') = TO_CHAR(SYSDATE,'MM-YY') AND TO_CHAR(SYSDATE,'W') = 2;


--10)display the book names starts with 'S'		

SELECT BOOK_NM
FROM BOOK
WHERE BOOK_NM LIKE 's%';


--11)Display the book _name under self help category			

SELECT BOOK_NM
FROM BOOK
WHERE CATEGORY = 'self help';





