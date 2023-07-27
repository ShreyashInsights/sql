select * from studies
select * from PROGRAMMER
select * from SOFTWARE

--1. Find out the selling cost AVG for packages developed in Pascal.
select avg(scost) as Avg_sc from software where developin = 'Pascal'

--2. Display Names, Ages of all Programmers. 
select pname, year(getdate()) - year(DOB) as age from PROGRAMMER

--3. Display the Names of those who have done the DAP Course.
select pname from studies where course='DAP'

--4. Display the Names and Date of Births of all Programmers Born in January. 
select pname, Dob from PROGRAMMER where month(dob) = 1

--5. Display the Details of the Software Developed by Ramesh. 
select * from SOFTWARE where pname = 'ramesh'

--6. Display the Details of Packages for which Development Cost have been recovered.
select * from SOFTWARE where (Scost * sold) > dcost 

--7. Display the details of the Programmers Knowing C. 
select * from PROGRAMMER where prof1 = 'c' or prof2 = 'c'

--8. What are the Languages studied by Male Programmers?**********
select distinct prof1 as languages from PROGRAMMER where gender='M'
union
select prof2 from PROGRAMMER where gender='M'

--9. Display the details of the Programmers who joined before 1990. 
select * from programmer where year(doj) < 1990

--10. Who are the authors of the Packages, which have recovered more than double the Development cost?
select pname from software where scost*sold > 2*dcost

