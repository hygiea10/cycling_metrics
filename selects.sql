/* 
Sample queries using MySQL Server version  8.0.17
Queries ran in workbench 8.0
Please send questions to dacodingregimen@gmail.com */

use cycling;

/* 1. & 2. Counts number of records in each table */
select count(*) as 'Total Rows' from metrics;
select count(*) as 'Total Rows' from persons;
select * from persons;

/* 3. Total Life time distance for Don Bauer
Answer: 2097.04
*/
select sum(distance) as 'Total Distance in Miles' from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where  first_name = 'Don' and 
	   last_name = 'Bauer' and 
       email_address = 'donbauer@gmail.com';

/* 3. Shows all the rides for each person */
select * from persons p
join metrics m on p.person_metric_id = m.person_metric_id;


/* 4. Which months are the most calories burned for Don Bauer?
Answer: September 23015.00 calories burned
*/

select first_name as 'First Name', 
	   last_name as 'Last Name', 
       monthname(date_of_ride) as 'Month', 
       sum(m.calories) as 'Total Calories' from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com'
group by MONTH(date_of_ride)
order by sum(calories) desc;

/* 5. 
Which month did the user Don Bauer cover the most miles?
Answer: September  444.75 miles
*/

select first_name as 'First Name', 
	   last_name as 'Last Name', 
       monthname(date_of_ride) as 'Month', 
       sum(distance) as 'Total Distance in Miles' from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com'
group by MONTH(date_of_ride)
order by sum(calories) desc;

/* 6. Distance break down by year for Don Bauer
Most miles completed was 2017 a total of 1029.67 miles biked
*/
select first_name as 'First Name', last_name as 'Last Name', year(date_of_ride) as 'Year', sum(distance) as 'Total Distance in Miles' from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com'
group by year(date_of_ride)
order by year(date_of_ride) desc;

/* 7. Display all rides where there were more elevation gain then loss
for Don Bauer
19 records where more climbing was done then descending
*/
select first_name  as 'First Name', 
	   last_name  as 'Last Name', 
       title as 'Name of Ride',  
       elev_gain as 'Elevation Gain', 
       elev_loss as  'Elevation Loss', 
       elev_gain - elev_loss as 'Difference'
from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where elev_gain - elev_loss > 0.0 and 
	   first_name = 'Don' and 
	   last_name = 'Bauer' and 
       email_address = 'donbauer@gmail.com'
order by elev_gain - elev_loss desc;

/* 8. Average Speed in the 5 lowest temperatures for Don Bauer
Answer: 13.50
*/

select max(avg_speed) as 'Maximum Speed'  from 
(select min_temp, avg_speed from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where min_temp > 0 and 
	  first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com'
order by min_temp asc
limit 5) temp;

/*
9. Break down of Average Speed and Levels for Don Bauer
*/
select first_name  as 'First Name', 
	   last_name  as 'Last Name', 
       title as 'Name of Ride', date_format(date_of_ride, "%M %d, %Y") as 'Date' ,
       case
		when avg_speed <= 10 then 'Happy Face Pace'
		when avg_speed > 10 and avg_speed <= 15 then 'Moderate Pace'
		when avg_speed > 15 and avg_speed <= 17 then 'Advance Moderate Pace'
		when avg_speed > 17 and avg_speed <= 19 then 'Advance Quick Spin Light Pace'
		when avg_speed >= 20 then 'Advance Quick Spin Pace'
       else 'Level not Defined'
       end as 'Cycling Level'
from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com'
order by date(date_of_ride) desc;

/* 10. For rides over 100 miles what was the average max speed
Answer: 33.40
 */
select format(avg(max_speed),2) as 'Average Maximum Speed' from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where distance > 100 and
      first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com';

/* 11. For rides 75 - 100  miles what was the average max speed for Don Bauer
Answer: 33.10
*/
select format(avg(max_speed),2) as 'Average Maximum Speed' from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where distance > 75 and 
      distance <= 100 and 
      first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com'
; 

/* 12. For rides 50 - 75  miles what was the average max speed
Answer: 35.83 */
select format(avg(max_speed),2) as 'Average Maximum Speed' from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where distance > 50 and 
      distance <= 75 and 
      first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com'; 

/* 13. For rides 25 - 50 miles what was the average max speed
Answer: 31.45 */
select format(avg(max_speed),2) as 'Average Maximum Speed' from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where distance > 25 and 
      distance <= 50 and
      first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com';

/* 14. For rides 1 - 25 miles what was the average max speed
Answer: 22.48 */

select format(avg(max_speed),2) as 'Average Maximum Speed' from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where distance > 1 and distance <= 25 and
	  first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com';

/* 15. Break down of number of rides done in each level 
Creates temp table, then selects needed data, finally drops table
*/

create temporary table levels select
       case
		when avg_speed <= 10 then 'Happy Face pace'
		when avg_speed > 10 and avg_speed <= 15 then 'Moderate Pace'
		when avg_speed > 15 and avg_speed <= 17 then 'Advance Moderate Pace'
		when avg_speed > 17 and avg_speed <= 19 then 'Advance Quick Spin Light Pace'
		when avg_speed >= 20 then 'Advance Quick Spin Pace'
       else 'Level not Defined'
       end as cycling_level
from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com';
      
select cycling_level 'Level', count(cycling_level) 'Level Count' from levels
group by cycling_level
order by count(cycling_level) desc;

drop table levels;

/* 16. Records for Don Bauer */
select 'Farest Total Distance' as 'Record Name', concat(convert(max(distance), char),' mph') as 'Record'  from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com'
union
select 'Fastest Maximum Speed' as 'Record Name', concat(convert(max(max_speed), char),' mph') as 'Record'  from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com'
union
select 'Fastest Average Speed' as 'Record Name', concat(convert(max(avg_speed), char),' mph') as 'Record'  from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com'
union
select 'Most Elevation Climbed' as 'Record Name', concat(convert(max(elev_gain), char),' ft') as 'Record'  from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com'
union
select 'Most Elevation Descended' as 'Record Name', concat(convert(max(elev_loss), char),' ft') as 'Record'  from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com'
union
select 'Coldest Minimum Temperature' as 'Record Name', concat(convert(min(min_temp), char),' F') as 'Record'  from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where min_temp > 0 and
      first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com'
union
select 'Most Calories Burned' as 'Record Name', max(calories) as 'Record'  from persons p
join metrics m on p.person_metric_id = m.person_metric_id
where min_temp > 0 and
      first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com';

/*17. Convert from imperial system to metrics system*/

select title as 'Name of Ride', 
	   distance as 'Distance in Miles', 
       format(distance * 1.60934,2)  as 'Distance in Kilometers', 
       avg_speed as 'Average Speed in Miles', 
       format(avg_speed* 1.60934,2)   as 'Average Speed in Kilometers', 
       max_speed as 'Maximum Speed in Miles' , 
       format(max_speed*1.60934,2) as 'Maximum Speed in Kilometers' from  persons p
join metrics m on p.person_metric_id = m.person_metric_id
where min_temp > 0 and
      first_name = 'Don' and 
	  last_name = 'Bauer' and 
	  email_address = 'donbauer@gmail.com'
order by distance desc;


