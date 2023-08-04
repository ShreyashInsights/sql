--1. How many Programmers Don’t know PASCAL and C
select 
count(pname) 
from 
PROGRAMMER 
where prof1 not in ('Pascal', 'C') 
and prof2 not in ('Pascal', 'C')

--2. Display the details of those who don’t know Clipper, COBOL or PASCAL.
select 
* 
from 
PROGRAMMER 
where prof1 not in ('Clipper', 'COBOL', 'Pascal') 
and prof2 not in ('Clipper', 'COBOL', 'Pascal')

--3. Display each language name with AVG Development Cost, AVG Selling Cost and AVG Price per Copy.
select 
developin, avg(DCOST) as 'AVG Development Cost', 
avg(SCOST) as 'AVG Selling Cost', 
sum(scost * sold) / sum(sold) as 'AVG Price per Copy' 
from 
SOFTWARE 
group by DEVELOPIN

--4. List the programmer names (from the programmer table) and No. Of Packages each has developed.
select 
p.pname, count(sw.title) as 'No of Packages'
from 
software SW
right join PROGRAMMER P
on SW.pname = P.pname 
group by p.pname

--5. List each PROFIT with the number of Programmers having that 
--PROF and the number of the packages in that PROF.

Select Developin, count(developin) as NoPackage, sum(SCOST*SoLd-DCOST) AS Prof, Count(1)
As No_prog from software where developin in((Select prof1 from 
programmer)Union all (Select prof2 from programmer)) Group by 
developin;

--6. How many packages are developed by the most experienced 
--programmer form BDPS.
select 
count(title)
from 
SOFTWARE sw
join PROGRAMMER p
on sw.pname = p.pname
join studies s
on sw.pname = s.pname
where s.Institute = 'BDPS' 
and p.doj = (select min(p.doj) from programmer p 
join studies s on p.pname = s.pname where s.Institute = 'BDPS')

--7. How many packages were developed by the female programmers 
--earning more than the highest paid male programmer?
select
sw.pname, count(title)
from software sw
join PROGRAMMER p
on sw.pname = p.pname
where p.gender = 'F' and p.salary > (select max(salary) from programmer where gender = 'M')
group by sw.pname

--8. How much does the person who developed the highest selling 
-- package earn and what course did HE/SHE undergo.
select 
sw.pname, p.SALARY, s.course
from 
SOFTWARE sw
join PROGRAMMER p
on sw.pname = p.pname
join studies s
on sw.pname = s.pname
where sold = (select max(sold) from software)

--9. In which institute did the person who developed the costliest package study?
select 
s.Institute
from 
SOFTWARE sw
join studies s
on sw.pname = s.pname
where dcost = (select max(dcost) from SOFTWARE)

--10. Display the names of the programmers who have not developed 
--any packages.
select 
*,p.pname
from 
SOFTWARE sw
right join PROGRAMMER p
on sw.pname = p.pname
where title is null

--11. Display the details of the software that has developed in the 
--language which is neither the first nor the second proficiency
Select S.*,P.Prof1,P.prof2 from software AS S,Programmer AS P
Where P.Prof1<>S.Developin And P.Prof2<> S.Developin AND
P.PName=S.PName;

--12. Display the details of the software Developed by the male programmers Born before 1965
--and female programmers born after 1975
select 
title, * 
from 
SOFTWARE sw
join PROGRAMMER P
on sw.pname = p.pname
where (p.gender = 'M' and year(p.DOB) < 1965) 
or (p.gender = 'F' and year(p.DOB) > 1975)

--13. Display the number of packages, No. of Copies Sold and sales value 
--of each programmer institute wise.
select 
s.institute, 
count(title) as No_Package, 
sum(sold) as No_Sales, 
sum(scost * sold) as Sales_Value
from 
SOFTWARE sw
right join PROGRAMMER P
on sw.pname = p.pname
right join studies s
on sw.pname = s.pname
group by s.Institute

--14. Display the details of the Software Developed by the Male
--Programmers Earning More than 3000
select 
title, *
from 
SOFTWARE sw
join PROGRAMMER P
on sw.pname = p.pname
where p.GENDER = 'M' and p.SALARY > 3000

--15. Who are the Female Programmers earning more than the Highest Paid male?
select 
pname
from 
PROGRAMMER 
where gender = 'F'
and SALARY > (select max(salary) from programmer where gender = 'M')

--16. Who are the male programmers earning below the AVG salary of Female Programmers?
select 
pname 
from 
PROGRAMMER 
where gender = 'M'
and SALARY < (select avg(salary) from programmer where gender = 'F')

--17. Display the language used by each programmer to develop the Highest Selling and
--Lowest-selling package.
select 
pname, title, developin, 'Highest' as criteria_of_sale
from 
SOFTWARE
where sold = (select max(sold) from software)
union
select 
pname, title, developin, 'lowest' as criteria_of_sale
from 
SOFTWARE
where sold = (select min(sold) from software)

--18. Display the names of the packages, which have sold less than
--the AVG number of copies.
select
title, sold 
from 
SOFTWARE
where sold < (select avg(sold) from SOFTWARE)

--19. Which is the costliest package developed in PASCAL.
select 
title
from 
SOFTWARE
where dcost = (select max(dcost) from SOFTWARE where DEVELOPIN = 'Pascal')

--20. How many copies of the package that has the least difference between development and
--selling cost were sold.
select 
title, sold, dcost - scost as difference_dc_sc
from SOFTWARE
where dcost - scost = (select min(abs(dcost - scost)) from SOFTWARE)

--21. Which language has been used to develop the package, which has the 
--highest sales amount?
select 
developin, scost*sold as 'Total Sale Amount'
from SOFTWARE
where scost*sold = (select max(scost*sold ) from SOFTWARE)

--22. Who Developed the Package that has sold the least number of copies?
select 
pname 
from 
SOFTWARE
where sold = (select min(sold) from SOFTWARE)
--23. Display the names of the courses whose fees are within 1000 (+ or -)
--of the Average Fee.
select 
course
from
studies
where [course Fee] 
between ((select avg([course Fee]) from studies) - 1000) 
and ((select avg([course Fee]) from studies) + 1000)

--24. Display the name of the Institute and Course, which has 
--below AVG course fee.
select 
Institute, course
from
studies
where [course Fee] < (select avg([course Fee]) from studies)

--25. Which Institute conducts costliest course.
select 
Institute
from
studies
where [course Fee] = (select max([course Fee]) from studies)

--26. What is the Costliest course?
select 
course
from
studies
where [course Fee] = (select max([course Fee]) from studies)