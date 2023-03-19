create table product(p_id number , p_name varchar(20), p_family varchar(20), price number,  cost number,  launched_date date ); 

insert into product values(100,'MAKER','STATIONARY',25,22,'15-JAN-08') 

insert into product values(101,'MOUSE','COMPUTER',450,350,'16-APR-09') 

insert into product values(102,'WHITE_BOARD','STATIONARY',450,375,'20-AUG-10')

insert into product values(103,'SONY VAIO','COMPUTER',35000,42000,'21-SEP-10')

Insert Into Product Values(104,'DESKTOP','COMPUTER',20000,25000,'21-sep-10')

insert into product values(105,'LAPTOP','COMPUTER',40000,45000,'21-dec-10')

insert into product values(106,'MONITOR','COMPUTER',40000,45000,'21-jan-23')

insert into product values(107,'AIRPODS','COMPUTER',40000,45000,'21-MAR-23');

select * from Product

----delete condition---

delete from product
where p_name='DESKTOP';

delete from product
where p_name='LAPTOP';

delete from product
where p_name='MONITOR';

delete from product
where p_name='AIRPODS';

select * from product

--Write the select statement which gives all the products which costs more than Rs 250--

select p_name
from product
where cost > 250;

----or----

select *
from product
where cost > 250;
-------------------

---Write the select statement which gives product name, cost, price and profit. (profit formula is price – cost)----

select p_name,cost,price,price-cost profit
from product; 


--Find the products which give less profit than product Mouse--

select p_name
from product
where price-cost<(select price-cost from product where p_name = 'MOUSE')

--Find the products which give more profit than product Mouse--   :  --no one having more profit than mouse--result is null--

select p_name
from product
where price-cost>(select price-cost from product where p_name = 'MOUSE')

--Display the products which give the profit greater than 100 Rs-- : --no one having more profit greater than 100 rs--result is null--

select p_name,price,cost
from product
where price-cost>100;

--Display the products which are not from Stationary and Computer family--

select p_name,p_family
from product
where p_family not in ('STATIONARY','COMPUTER');

                         --or--

select p_name,p_family
from product
where p_family<>'STATIONARY' and p_family<>'COMPUTER';

--Display the products which give more profit than the p_id 102--

select p_name,p_id
from product
where price-cost>'102';

select * from product;

--Display products which are launched in the year of 2010--

select p_name,launched_date
from product
where extract(year from launched_date) = '2010';

desc product;

--Display the products which name starts with either ‘S’ or ‘W’ and which belongs to Stationary and cost more than 300 Rs--


select p_name
from product
where p_name like 'S%' or p_name like 'W%' and p_family='STATIONARY' and cost >'300' ;

--Display the products which are launching next month--

select *
from product
where to_char(launched_date,'mon-yy')=to_char(add_months(sysdate,1),'mon-yy');

---------OR----------

select *
from product
where to_char(launched_date,'yy')=to_char(add_months(sysdate,1),'yy');

-------JANAUARY MONTH PRODUCTS----------

select *
from product
where to_char(launched_date,'mon')=to_char(add_months(sysdate,1),'mon');



--Display product name which has the maximum price in the entire product table--

select max(price)
from product;

--Display product name which has the minimum price in the entire product table--

select min(price)
from product;

--List the product name, cost, price, profit and percentage of profit we get in each product--

select p_name,cost,price,((price-cost)/cost) *100 profit
from product;


--Display how many products we have in Computer family which has the price range between 2000 and 50000--


select p_name,p_family,price
from product
where p_family ='COMPUTER' and price>= 2000 and price<= 50000;

COMMIT;




create table product_bp as select * from Product;

select * from Product_bp;


select sum(price) from product
group by p_id;

select sum(cost) from product
group by p_id;

select p_name,price rank() over(order by price desc)ranking-------sum(cost) over(partition by p_id)p_id_pc
from product;

select p_id,price,cost, rank() over(order by price desc)ranking
                    ,dense_rank() over (order by price desc) dense_ranking
from product

/


select  p_name,price, rank() over(order by price desc)ranking
from product;

-----
select rownum,rowid 
from product;

commit;
/
select * from employee;
select * from(
select employee.*,dense_rank() over(order by emp_id,emp_sal desc)r from employee)
where r=1;

commit;

select rownum,rowid from product; 

select rownum,rowid,p.* from product p;
commit; 



