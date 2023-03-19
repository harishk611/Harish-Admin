create table publisher(pub_id number(5)primary key,
pub_name varchar2(30),
city varchar2(10),
state varchar2(10),
operating_since date);

insert all into publisher values(25,'Penguine Publications','Banglore','KA','15-Aug-75')

           into publisher values(26,'Vivekananda Publications','Banglore','KA','18-Aug-80')
           select* from dual;
           
drop table publisher; 

select*from publisher;

 alter session set nls_date_format = 'dd-mon-yy';
 
 create table author(auth_id number(5)primary key,
 first_name varchar2(10),
 last_name varchar2(10),
 auth_dob date);
 
 insert all into author values(50,'Stephan','c','10-Feb-70')
           
            into author values(51,'Jhon','M','15-Nov-75')       
            
            into author values(52,'Ram','K','20-Mar-98')
            select*from dual;


 alter session set nls_date_format = 'dd-mon-yy';

select* from author;

create table book (book_id number(5)primary key,
book_name varchar2(40),
category varchar2(15),
pub_date date,book_mrp number(5));

insert all into book values(100,'Seven Ways of Effective People','self help','10-Feb-15',600)

           into book values(101,'Qualities to become great','self help','14-Mar-19',300)
           
           into book values(102,'Become Great in 500 days','self help','16-Mar-2020',800)
            
           into book values(103,'Mountain Healer','Fiction','15-Mar-2021',300)
           select*from dual;
             
alter table book
add pub_id number(10);


 alter session set nls_date_format = 'dd-mon-yy';             
select*from book;           

update book
set pub_id = 26
where book_id = 103;
           
drop table book;

create table book_author(b_a_id number(5) primary key,
book_id number references book (book_id),
auth_id number references author (auth_id));


insert all into book_author values(1,100,50)
 
           into book_author values(2,101,50)
           
           into book_author values(3,102,50)
           
           into book_author values(4,102,51)
           
           into book_author values(5,103,53)
           select * from dual;

select* from book_author;
commit;

---which gives all the books which cost more than 500---

select book_name
from book
where book_mrp >500;

--Display books which are launched within the year of 2020--

select book_name,pub_date
from book
where extract(year from pub_date) <'2020';

--Display the author name and the number of books--

select  first_name||last_name,count(a.auth_id)
from author a inner join book_author b
on a.auth_id = b.auth_id
group by first_name||last_name;

--Display the unique books names--

select  distinct book_name from book;

--------------and-------------

select  distinct  first_name||last_name from author;

--find the author who's published more books--

select  first_name||last_name,count(b.book_id)
from author a inner join book_author b
on a.auth_id = b.auth_id
group by first_name||last_name 
having count(b.book_id)>2;

--Display the books which name starts with either ‘S’ or ‘M’ and cost is more than 600--

select book_name
from book
where book_name like 'S%' or book_name like 'M' and book_mrp >'300';

--Display the author name,book name who's born and which book published in month of February --

select first_name||last_name,book_name
from author a inner join book_author b 
on a.auth_id=b.auth_id 
inner join book c 
on c.book_id=b.book_id
where to_char (auth_dob,'mon')='feb' and to_char(pub_date,'mon')='feb';

---display the author name who's born in the year between 1968 to 1980---

select first_name||last_name
from author
where to_char(auth_dob,'yy')>=68 and to_char (auth_dob,'yy')<=80;

--------------or-----------

select first_name||last_name
from author
where to_char (auth_dob,'yy')between (68) and (80);

commit;

---------

rename book to books;
rename books to book;
