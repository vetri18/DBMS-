/*
	Used to combine records from two or more tables

	Types-
	1>Inner ->
		return rows when there is a match in both tables.
	2>Left ->
		return all rows from left table, even if there are no matches in right table
		for unmatched values in right table NULL is displayed
	3>Right ->
		return all rows from right table, even if there are no matches in left table
		for unmatched values in left table NULL is displayed
	4>Full ->
		retirn rows when there is a match in one of the table 
	5>Self ->
		is used to join a table itself as if the table were two tables, temporarily renaming at least one table in the SQL statement.
	6>Cross ->
		Produces a result set which is the number of rows in the first table multiplied by the number of rows in the econd table. Like Cartesian Product.
*/
use Employeesp

create table Employee(
	empId INT  NOT NULL,
	empName varchar(200) NOT NULL
)

insert into Employee values
(1,'Anil'),(2,'Suresh'),(3,'Mahesh'),(4,'Mohan'),(5,'Soham');



select * from Employee;

create table EmpDetails(
	empId INT  NOT NULL,
	empAge INT NOT NULL,
	empAddress varchar(200),
	empSalary decimal(8, 2)
)

Insert into EmpDetails values
(1,33,'Delhi',2923.90),
(2,43,'NCR',3444.90),
(3,22,'Haryana',3456.90),
(4,65,'UP',5433.90),
(8,34,'Delhi',4222.90),
(10,32,'Delhi',4554.90);

select * from EmpDetails;

---Inner Join--
select emp.empId,empName,empD.empAge,empD.empAddress,empD.empSalary from Employee emp 
INNER JOIN EmpDetails empD ON
emp.empId = empD.empId;

---Left join--
select emp.empId,empName,empD.empAge,empD.empAddress,empD.empSalary from Employee emp 
LEFT JOIN EmpDetails empD ON
emp.empId = empD.empId;

---right join--
select emp.empId,empName,empD.empAge,empD.empAddress,empD.empSalary from Employee emp 
RIGHT JOIN EmpDetails empD ON
emp.empId = empD.empId;

--Full join--
--combination of right and left join--
select emp.empId,empName,empD.empAge,empD.empAddress,empD.empSalary from Employee emp 
FULL JOIN EmpDetails empD ON
emp.empId = empD.empId;

--cross join--
select emp.empId,empName,empD.empAge,empD.empAddress,empD.empSalary from Employee emp 
CROSS JOIN EmpDetails empD ;

--self join--
create table company(
	empId int ,
	empName varchar(20),
	managerId Int,
	City varchar(20)
)

insert into company values
(1,'Anil',6,'Delhi'),
(2,'Sunil',2,'Delhi'),
(3,'Mahesh',4,'Delhi');

insert into company values
(4,'Suresh',3,'Delhi'),
(5,'Amit',1,'Delhi'),
(6,'Kumar',2,'Delhi');

select * from company;

select a.empID As "Emp_ID" , a.empName AS "Emp_Name", 
b.empID AS "Manager ID" , b.empName AS "Manager Name"
from company a , company b
where a.managerId = b.empId;
