select * from programmer
select * from SOFTWARE
select * from studies
problems - 13, 17
--1. What is the cost of the costliest software development in 
--Basic?
select 
dcost
from 
SOFTWARE
where developin = 'basic'
and dcost = (select max(dcost) from software where developin = 'basic')

--2. Display details of Packages whose sales crossed the 2000 Mark.
select 
*, scost * sold as sales
from 
SOFTWARE
where scost * sold > 2000


--3. Who are the Programmers who celebrate their Birthdays during 
--the Current Month?
select 
*
from 
PROGRAMMER
where month(DOB) = (select month(getdate()))

--4. Display the Cost of Package Developed By each Programmer.
SELECT PNAME,SUM(DCOST) AS TOTAL_COST FROM SOFTWARE GROUP BY PNAME;

--5. Display the sales values of the Packages Developed by 
--each Programmer.
SELECT PNAME, SUM(SCOST*SOLD) FROM SOFTWARE GROUP BY PNAME

--6. Display the Number of Packages sold by Each Programmer.
SELECT pname, COUNT(TITLE) as NO_of_PACK FROM SOFTWARE 
GROUP BY pname

--7. Display each programmer’s name, costliest and cheapest 
--Packages Developed by him or her.
select p.pname, max(dcost) as  'Costliest Packages', 
min(dcost) as  'Cheapest Packages' from SOFTWARE sw 
join programmer p on sw.pname = p.pname 
group by p.pname

--8. Display each institute name with the number of Courses, Average Cost per Course.
select Institute, count(course) as 'Number of Courses', 
avg([course Fee]) as 'Average Cost per Course' from studies 
group by Institute;

--9. Display each institute Name with Number of Students.
select Institute, count(Pname) as 'Number of Students' 
from studies group by Institute;

--10. List the programmers (form the software table) and the institutes they studied.
select distinct sw.pname, s.Institute from SOFTWARE sw join studies s on sw.pname = s.pname

--11. How many packages were developed by students, who studied in institute that
--charge the lowest course fee?
select count(title) as NoPackage from SOFTWARE sw join studies s 
on sw.pname = s.pname where s.Institute = (select distinct Institute from studies 
where [course Fee] = (select min([course Fee]) from studies))

--12. What is the AVG salary for those whose software sales is more than 50,000/-.
select avg(p.salary) as 'software sales' from SOFTWARE sw 
join PROGRAMMER p on sw.pname = p.pname where scost * sold > 50000

--13. Which language listed in prof1, prof2 has not been used to develop 
-- any package.
SELECT DISTINCT PROF1 FROM programmer 
WHERE PROF1 NOT IN (SELECT DEVELOPIN FROM software)
UNION
SELECT DISTINCT PROF2 FROM programmer 
WHERE PROF2 NOT IN (SELECT DEVELOPIN FROM software)

--14. Display the total sales value of the software, institute wise.
select s.institute ,sum(scost*sold) as sold from software as sw 
join studies as s on sw.pname=s.pname group by s.institute 

--15. Display the details of the Software Developed in C 
--By female programmers of Pragathi.
select * from SOFTWARE sw join PROGRAMMER p on sw.pname=p.pname 
join studies s on s.pname=sw.pname where DEVELOPIN = 'C' 
and p.gender = 'F' and s.Institute = 'PRAGATHI'
--16. Display the details of the packages developed in Pascal 
--by the Female Programmers.
select * from software sw join PROGRAMMER p on sw.pname=p.pname 
where developin='PASCAL'  and gender='F'

--17. Which language has been stated as the proficiency by most 
--of the Programmers?
select prof1 from (
select prof1,count(prof1) as count_prof from (
select pname,prof1 from programmer
union
select pname,prof2 from programmer) as new_table group by prof1 ) as old_table
where count_prof = (select max(count_prof) from (select prof1,count(prof1) as count_prof from (
select pname,prof1 from programmer
union
select pname,prof2 from programmer) as new_table group by prof1 ) as o_table)

--18. Who is the Author of the Costliest Package?
select pname from software 
where dcost=(select max(dcost) from software)

--19. Which package has the Highest Development cost?
select title from software 
where dcost=(select max(dcost) from software)

--20. Who is the Highest Paid Female COBOL Programmer?
SELECT * FROM PROGRAMMER 
WHERE SALARY=(SELECT MAX(SALARY) FROM PROGRAMMER
WHERE gender = 'F' and (PROF1 = 'COBOL' OR PROF2 = 'COBOL')) 
and gender = 'F' and (PROF1 = 'COBOL' OR PROF2 = 'COBOL');


--21. Display the Name of Programmers and Their Packages.
select p.pname,sw.title as package from software as sw 
join PROGRAMMER as p on sw.pname=p.pname

--22. Display the Number of Packages in Each Language Except C and C++.
select developin, count(*) as total_package from software 
group by developin having developin not in ('C','CPP')

--23. Display AVG Difference between SCOST, DCOST for Each Package.
select title, dcost - scost as difference from SOFTWARE
--24. Display the total SCOST, DCOST and amount to Be Recovered 
--for each Programmer for Those Whose Cost has not yet been Recovered.
select scost, dcost, dcost - scost as 'Amount to Be Recovered' 
from SOFTWARE where scost * sold - dcost < 0

--25. Who is the Highest Paid C Programmers?
select pname from programmer 
where salary = (select max(salary) from programmer where 
prof1 ='C' or prof2='C') and (prof1 ='C' or prof2='C')

--26. Who is the Highest Paid Female COBOL Programmer?
select pname from programmer 
where salary = (select max(salary) from programmer where 
(prof1 ='COBOL' or prof2='COBOL') and gender='F')and gender='F' and 
(prof1 ='COBOL' or prof2='COBOL')