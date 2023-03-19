create table city(city_id number(2) primary key,city_name varchar2(20),city_population varchar2(20));


insert into city values(10,'bangalore',2367890)

insert into city values(20,'chennai',6474854)

insert into city values(30,'mumbai',783983736)

select * from dual;

select* from city;

create table branch(b_id number(4) primary key,b_name varchar2(20),b_address varchar2(20),b_phone number(10),city_id number(2) references city(city_id));


insert into branch values(500,'btm layout','185, ring road',9786543211,10)

insert into branch values(501,'jayanagar','44,15th main',9765420134,10)

insert into branch values(502,'ashok nagar','ashoka pillar',8896044567,20)

insert into branch values(503,'mount road','nandanam',9976540987,20)

insert into branch values(504,'jp nagar','South end circle',8800997766,20)

select *from dual;

select* from city;

select * from branch;


--Write a query to list the cities which have more population than Bangalore--

select city_name
from city
where city_population > (select city_population from city where city_name = 'bangalore');

--Display all the branch names from Chennai--

select b_name 
from branch b inner join city c on b.city_id = c.city_id
where city_name = 'chennai';

--Display a city name which does not have any branches--

select city_name 
from city 
where city_id not in (select distinct city_id from branch);

--Display branch name, address and phone number of all the branches where the name starts with either B or M and the city name starts with either B or C.--

select b_name,b_address,b_phone,city_name 
from branch b inner join city c on b.city_id=c.city_id 
where (b_name like 'b%' or b_name like 'm%')and (city_name like 'b%' or city_name like 'c%') ;

--How many branches we have in Bangalore--
select count(b_name) as count 
from branch b inner join city c on b.city_id=c.city_id 
where city_name ='bangalore';

--Display the branches which are in the Ring road of any city--

select b_name 
from branch 
where b_address like '%ring road%';

--Display the city name, branch name. Order the data based on the city name.--

select city_name,b_name 
from city c inner join branch b 
on c.city_id = b.city_id
order by city_name asc  ;

--Display the city name and the number of branches in each city--

select city_name , count(b_name)
from city .city inner join branch  branch
on city.city_id = branch.city_id
group by city_name;

--Display the city name which has most number of branches--

select city_name,count(b_id)
from branch a, city b
where a.city_id=b.city_id
group by city_name
having count(*)=(select max(count(b_id))
 from branch
group by city_id);

--Display the city name, population, number of branches in each city--

select city_name , city_population , count(b_name) number_of_branches
from city
inner join branch
on city.city_id = branch.city_id
group by city_name,city_population ;

commit;



