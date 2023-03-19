Select * From Bus;
Select * From Trip;
Select * From Location;

--Write a query to list the states and city count. Consider only states which has more than 4 cities	

select loc_state ,count(loc_city)
from Location
group by loc_state
having count(loc_city)>2;

--Display the bus code and registration_no for all the bus_type 'AC' or 'Sleeper' and registered in last year April month		

select bus_code,bus_reg_no,bus_type,registered_on
from bus
where (bus_type = 'AC' or BUS_TYPE='SLEEPER') and  to_char(registered_on,'mm-yy')=to_char(add_months(trunc(sysdate,'yy')-1,-8),'mm-yy');

--Display the number of buses registered in each year (consider only 5 years including current year)				

select bus_code,registered_on
from bus
where to_char (registered_on,'mm-yy')=to_char(add_months(trunc(sysdate,'yy')-1,-5),'yy');

--Find all the trips we have in the current week which are starting from Bangalore						

 

--Find all the trips where the destination is Mumbai									
--Display the trip id and trip_date which are going from Mysore to Chennai									
--Display trip_id, trip_date, bus_registration_no, trip_starting_city, trip_ending_city, trip_starting_state, trip_ending_state,									
--Find the buses which are serving interstate trips in the current month									

commit;
