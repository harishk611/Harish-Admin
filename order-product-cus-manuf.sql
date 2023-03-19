create table customert12(c_id number(5),c_name varchar2(10),c_gender varchar2(5),c_dob date,c_city varchar2(20));

alter table customert12 modify c_id number(5)primary key;

desc customert12;

drop table customert12;

--insert all into customert12 values(123,'Ragu','M','06-03-1997','Salem')

         --  into customert12 values(124,'Raju','M','09-04-1992','Electonic city')
           
          -- into customert12 values(125,'Ram','M','08-11-1994','mysore')
           
           --into customert12 values(126,'Jhoshi','F','09-01-1995','Banglore')
           --select*from dual;
           
select*from customert12;

create table manufacturet12(m_id number(5) primary key,m_name varchar2(10));

desc  manufacturet12;

select*from manufacturet12;

create table productt12(p_id number(5)primary key,p_name varchar2(10),p_price number(5),m_id number references manufacturet12 (m_id));

select*from productt12;

drop table productt12;

desc  productt12;

create table ordert12(o_id number(5)primary key,c_id number references customert12 (c_id),p_id number references productt12 (p_id),quantity varchar2(5),order_date date);         

select*from ordert12;

desc ordert12;


-----1.Get the customer names who made sales on or before 1st jan 2022.

select c_name 
from customert12 a inner join ordert12  b
on a.c_id = b.c_id 
where trunc(order_date,'dd-mm-yy')= '01-01-22';

-----2.Display manufacture name who is having highest product..


select m_name ,max(p_name) 
from manufacturet12 m inner join productt12 p 
on m.m_id = p.m_id 
group by m_name;

-----3.Get the number of customers who bought ‘ABC’ manufacturers till today...


select count(c_id) 
from ordert12 a inner join productt12 b 
on a.p_id=b.p_id inner join manufacturet12 c 
on b.m_id=c.m_id 
where order_date=sysdate;

-----4.Display the unique product names---

select  distinct p_name 
from productt12;

-----5.Display highest price product in each manufacture=--

select m_name,max(p_price) 
from productt12 a inner join manufacturet12 b 
on a.m_id=b.m_id 
group by m_name;

-----6. Display total number of products order today-----

select count(p_name) 
from productt12 a inner join ordert12 b 
on a.p_id=b.p_id  
where order_date=sysdate;

-----7.Get the details of products which has not been sold till today.----

select p_name 
from productt12 a inner join ordert12 b 
on a.p_id=b.p_id  
where o_id not in(select o_id from ordert12 where order_date=sysdate);

-----8.Display customer name who ordered highest number of products------

select c_name 
from customert12 c inner join ordert12 o 
on c.c_id = o.c_id  inner join productt12 p 
on o.p_id = p.p_id group by c_name ;
having count(p.p_id)=  

(select max(count(p.p_id)) 
from productt12 a inner join ordert12 b
on a.p_id = b.p_id 
group by c_id);

-----9. Display city which having highest number of orders----

select c_city 
from customert12 c inner join ordert12 o 
on c.c_id = o.c_id  
group by c_city  having count(o_id)=
(select max(count(o_id)) 
from customert12 c inner join ordert12 o 
on c.c_id = o.c_id 
group by o_id);


-----10.Get the total ordered value (qty*price) of each product----

select sum(o.qty*p.p_price) total_oredered  
from ordert12 o inner join productt12 p 
on o.p_id = p.p_id 
group by p_name;

commit;