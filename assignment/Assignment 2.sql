--1) What is the Highest Number of copies sold by a Package?
select Max(sold) from SOFTWARE

--2) Display lowest course Fee.
select min([course fee]) from studies

--3) How old is the Oldest Male Programmer. 
select 
max(year(GETDATE()) - year(DOB))  as age 
from 
programmer

--4) What is the AVG age of Female Programmers?
select 
avg(year(GETDATE()) - year(DOB))  as age 
from 
PROGRAMMER 
where gender= 'F'

--5) Calculate the Experience in Years for each Programmer and Display with their names in Descending order.
select 
PNAME, year(getdate()) - year(DOJ) as experience 
from 
programmer 
order by PNAME desc

--6) How many programmers have done the PGDCA Course?
select 
count(P.pname)
from 
programmer P
join Studies S 
on P.pname = S.pname
where s.course='PGDCA'

--7) How much revenue has been earned thru sales of Packages Developed in C.
select 
sum((scost * sold) - dcost) as 'Total Revenue' 
from 
SOFTWARE 
where DEVELOPIN='C'

--8) How many Programmers Studied at Sabhari?
select 
count(P.pname) 
from 
PROGRAMMER P
join studies S
on p.pname = s.pname
where Institute = 'Sabhari'

--9) How many Packages Developed in DBASE?
select 
count(*) 
from SOFTWARE 
where DEVELOPIN='DBASE'

--10) How many programmers studied in Pragathi?
select 
count(P.pname) 
from 
PROGRAMMER P
join studies S
on p.pname = s.pname
where Institute = 'Pragathi'

--11) How many Programmers Paid 5000 to 10000 for their course?
select 
count(P.pname) 
from 
PROGRAMMER P
join studies S
on p.pname = s.pname
where [course fee] between 5000 and 10000

--12) How many Programmers know either COBOL or PASCAL? ******
select 
count(pname) 
from PROGRAMMER 
where prof1 in ('cobol', 'pascal') or prof2 in ('cobol', 'pascal')

--13) How many Female Programmers are there?
select 
count(pname) 
from PROGRAMMER 
where gender = 'F'

--14) What is the AVG Salary?
select 
avg(SALARY) 
from 
programmer 

--15) How many people draw salary 2000 to 4000?
select 
count(pname) 
from programmer 
where SALARY between 2000 and 4000

--16) Display the sales cost of the packages Developed by each Programmer Language wise
select 
pname, DEVELOPIN, scost 
from SOFTWARE 
order by DEVELOPIN

--17) Display the details of the software develope.25d by the male students of Sabhari.
select 
*
from 
SOFTWARE SW
join PROGRAMMER P
on SW.pname=P.pname
join Studies S
on sw.pname=s.pname
where p.GENDER='M' and s.Institute='Sabhari'

--18) Who is the oldest Female Programmer who joined in 1992? ****
select 
pname 
from PROGRAMMER 
where dob = (select min(dob) from programmer where year(doj) = 1992 and gender='F') 
and year(doj) = 1992 and gender = 'F'

--19) Who is the youngest male Programmer born in 1965?
select 
pname 
from 
programmer 
where dob = (select max(dob) from PROGRAMMER where year(dob) = 1965 and gender='M') 
and year(dob) = 1965 and gender='M'

--20) Which Package has the lowest selling cost?
select 
title 
from 
SOFTWARE 
where scost=(select min(scost) from SOFTWARE)

--21) Which Female Programmer earning more than 3000 does not know C, C++,
--ORACLE or DBASE? **
select 
* 
from 
programmer 
where gender = 'F' and salary > 3000 
and prof1 not in ('C', 'C++', 'oracal', 'DBASE') 
and prof2 not in ('C', 'C++', 'oracal', 'DBASE')
 
--22) Who is the Youngest Programmer knowing DBASE?
select 
* 
from 
programmer 
where dob = (select max(dob) from PROGRAMMER where prof1 = 'DBASE' or prof2 = 'DBASE') 
and (prof1 = 'DBASE' or prof2 = 'DBASE')

--23) Which Language is known by only one Programmer? *****


select 
prof1 
from programmer 
group by prof1 
having prof1 not in (select prof2 from PROGRAMMER) and count(prof1) = 1
union
select 
prof2 
from programmer 
group by prof2 
having prof2 not in (select prof1 from PROGRAMMER)
and count(prof2) = 1

--24) Who is the most experienced male programmer knowing PASCAL?
select 
* 
from 
programmer 
where doj = (select min(doj) from programmer where gender = 'M' and (prof1 = 'Pascal' or prof2 = 'Pascal')) 
and gender = 'M' and (prof1 = 'Pascal' or prof2 = 'Pascal')
--25) Who is the least experienced Programmer?
select 
* 
from 
programmer 
where doj = (select max(doj) from programmer)

--26) Display the Number of Packages in Each Language for which Development Cost is less
--than 1000.
select 
developin, count(title) as package_count 
from SOFTWARE 
where DCOST < 1000 
group by developin

--27) Display Highest, Lowest and Average Salaries for those earning more than 2000
select
max(salary) as 'Max Salary', min(salary) as 'Min Salary', avg(salary) as 'Avg Salary' 
from 
PROGRAMMER 
where salary > 2000