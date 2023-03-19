create table doctor(doc_id varchar2(4) primary key,fname varchar2(20),lname varchar2(20),specialty varchar2(20),phone number(10));


insert into doctor values('d1','arun','patel','ortho',9675093453)

insert into doctor values('d2','tim','patil','general',9674560453)

insert into doctor values('d3','abhay','sharma','heart',9675993453)

select* from dual;

select* from doctor;

create table patient(pat_id varchar2(4) primary key,fname varchar2(20),lname varchar2(20),ins_comp varchar2(20),phone number(10));
 

insert into patient values('p1','akul','shankar','y',9148752347)

insert into patient values('p2','aman','shetty','y',9512896317)

insert into patient values('p3','ajay','shetty','n',9987321564)

insert into patient values('p4','akshay','pandit','y',9112255889)

insert into patient values('p5','adi','shankar','n',9177788821)

select* from dual;

select* from patient;

create table case(admission_date date,pat_id varchar2(4) references patient(pat_id),
doc_id varchar2(4) references doctor(doc_id),diagnosis varchar2(40),constraint con_cpk primary key(admission_date,pat_id));

insert into case values('10-jun-16','p1','d1','fracture')

insert into case values('03-may-16','p2','d1','bone cancer')

insert into case values('17-apr-16','p2','d2','fever')

insert into case values('28-oct-15','p3','d2','cough')

insert into case values('10-jun-16','p3','d1','fracture')

insert into case values('1-jan-16','p3','d1','bone cramp')

insert into case values('11-sep-15','p3','d3','heart attack')

insert into case values('30-nov-15','p4','d3','heart hole')

insert into case values('10-nov-15','p4','d3','angioplasty')

insert into case values('1-jan-16','p5','d3','angiogram')

select * from dual;

select * from case;

--Find all the patients who are treated in the first week of this month.--

select *
from patient p inner join case c
on c.pat_id = p.pat_id
where to_char(admission_date,'w-mm-yy')=to_char(trunc(sysdate,'mm'),'w-mm-yy');

select trunc(sysdate,'mm') from dual;
/
--Find all the doctors who have more than 3 admissions today--

select d.fname
from doctor d inner join case c on d.doc_id = c.doc_id 
where to_char(admission_date,'dd-mm-yy')=to_char(sysdate,'dd-mm-yy') group by d.fname having count(*)>3;


--Find the patient name (first,last) who got admitted today where the doctor is ‘TIM’--

select d.fname||d.lname as full_name
from doctor d 
inner join case c 
on d.doc_id = c.doc_id 
inner join patient p
on c.pat_id = p.pat_id 
where to_char(admission_date,'dd-mm-yy')= to_char(sysdate,'dd-mm-yy') and d.fname = 'arun';



--Display the doctors who don’t have any cases registered this week--

select  fname
from doctor
where doc_id not in (select distinct doc_id 
from case
where  to_char(admission_date,'w-mm-yy')=to_char(sysdate,'w-mm-yy'));
--------------------------------------
--Find the Doctors whose phone numbers were not update (phone number is null)--

select *
from doctor
where phone not in 
(select distinct phone from doctor);

select * from doctor
where phone is null;

--Display the doctors whose specialty is same as Doctor ‘arun’--

select fname,specialty 
from doctor
where specialty =
(select distinct specialty 
from doctor
where fname='arun');

select * from doctor1;
select * from patient1;
select * from case;

commit;

update case set 
insert into case values('1-nov-22','p4','d3','neurology');

rollback;

update case
set diagnosis = 'neurology'
where admission_date='01-11-22';

select * from doctor;
select * from patient;
select * from case;

commit;

--Find out the number of cases monthly wise for the current year--

select to_char(admission_date,'mon')month,count(1) from case where to_char(admission_date,'yy')=to_char(sysdate,'yy') 
group by to_char(admission_date,'mon');


select count(1)as month from case where to_char(admission_date,'yy')=to_char(sysdate,'yy') group by to_char(admission_date,'mon');
commit;
---------------------------------------------
--Display Doctor Name, Patient Name, Diagnosis for all the admissions which happened on 1st of Jan this year----result is null--

select d.fname as doctor,p.fname as patient,admission_date
from doctor d inner join case c on d.doc_id = c.doc_id 
inner join patient p on c.pat_id = p.pat_id
where to_char(admission_date,'dd-mm-yy')= to_char(trunc(sysdate,'yy'),'dd-mm-yy');

select admission_date from case where 
select * from case;


--Display Doctor Name, patient count based on the cases registered in the hospital--

select p.fname,count(admission_date)
from doctor d inner join case c on d.doc_id = c.doc_id 
inner join patient p on p.pat_id = c.pat_id group by p.fname;

--Display the Patient_name, phone, insurance company, insurance code (first 3 characters of insurance company)--

select fname,phone,ins_comp
from patient;

select * from patient;
select * from doctor;

--Create a view which gives the doctors whose specialty is ‘ORTHO’ and call it as ortho_doctors--

select fname as ortho_doctor 
from doctor ;


select phone ,replace(phone,'9675093453',6477383273) from doctor;

select book_mrp , replace(book_mrp,'400',300) from book;

commit;

  