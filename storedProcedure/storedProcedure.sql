

/*
	--Stored Procedures is database object - why?
		 Because it get stored permenantly in database.
		 If we want to use query again and again then we can use SP.
		 whenever we we can reuse it.  
		 we can pass parameters to SP .
		 SQL server creates an execution plan And stores it in the cache 
		 SP executes only once and stored cache so it will help to increase speed.
		 
	--Two Types->
		1>User Defined SP - Written by develoer and contains one or more SQL statements.
		2>System SP - Created and executed by SQl server for Administraive activities.
		
		 	  
*/

create database Employeesp;
use Employeesp;

create table EmpInfo(
	empID Int Identity Not Null,
	empName varchar(200) NOT NULL,
	deptID INT NOT NULL,
	salary float NOT NULL,
	joinYear DATE

)

insert into EmpInfo values
('John',2,30000,'2021-5-5');

insert into EmpInfo values
('Smith',1,30000,'2021-5-5'),
('King',3,40000,'2020-5-5'),
('Millia',2,60000,'2029-5-5'),
('Linda',2,55000,'2021-5-5'),
('Tony',3,32000,'2022-5-5'),
('Joshef',1,67000,'1990-5-5'),
('Alice',3,78000,'2020-5-5'),
('Mangu',2,21000,'2021-5-5'),
('David',1,11000,'2022-5-5');

select * from EmpInfo

/* Normal Query */
select * from EmpInfo where deptID=1

/* convert into SP */
create procedure spDepartList
as
begin
	select * from EmpInfo where deptID=1;
end

/* How to execute */
spDepartList
Execute spDepartList
EXEC spDepartList


/* How to Modify SP */
ALTER Proc spDepartList
as 
begin
	select * from EmpInfo where deptID=1;
	select * from EmpInfo where deptID=2;
end

/* How to Drop SP */

DROP proc spDepartList

-----PARAMETERS IN SP
--PARAMETER ARE TWO TYPES  - INPUT PARAMETER & OUTPUT PARAMETER

/*
	To make dynamic 
*/

create proc spDepartmentList
as
begin
	select * from EmpInfo where deptID=1;
	select * from EmpInfo where empName='Joshef';
end 

spDepartmentList

/* Convert into parameterized SP AND how to call*/

ALTER proc spDepartmentList
	@dept_id int,
	@emp_name varchar(200)

as
begin
	select * from EmpInfo where deptID=@dept_id;
	select * from EmpInfo where empName=@emp_name;
end 

spDepartmentList 2,'Joshef'
spDepartmentList @emp_name='Joshef', @dept_id=2

/* How to give default value to  parameters*/

ALTER proc spDepartmentList
	@dept_id int=1,
	@emp_name varchar(200)='Joshef'

as
begin
	select * from EmpInfo where deptID=@dept_id;
	select * from EmpInfo where empName=@emp_name;
end 

spDepartmentList
---default value will be ignored in this case
spDepartmentList 3,'Smith'

---CALCULATIONS iN SP
---OUTPUT PARAMETERS

create proc spAddDigit
	@Num1 INT,
	@Num2 INT,
	@Result INT OUTPUT
As
begin
	SET @Result = @Num1+@Num2;
end

Declare @EId INT 
EXEC spAddDigit 23,27,@EId OUTPUT;

SELECT @EId;

--stored Procedure security with encryption
--want be able to see result data
sp_helptext spAddDigit 

ALTER proc spAddDigit
	@Num1 INT,
	@Num2 INT,
	@Result INT OUTPUT
WITH ENCRYPTION
As
begin
	SET @Result = @Num1+@Num2;
end