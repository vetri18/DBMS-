/*
	System Defined Functions(SDF)-
		built-in functions
		must return value or result
		work with only input parameters
		
		e.g-> GetDate(),Cast()$Convert(),App_Name(),
		COALESCE - returns first nonnull expression among its 
			argument,
		CURRENT_USER - returns the name of the current user. 
		   This function equivalent to USER_NAME(). 
*/

select GETDATE(); --current server date time--
select APP_NAME(); --application name--
select CURRENT_USER; 

Declare @Fname varchar(50);
 SET @Fname= 'John';
select COALESCE(@Fname, 'Smith'); 

/*
	USER DEFINED Function(UDF) -
		result either scalar(single) value or result set.
		used in P, triggers and other UDFs.
		reduce network traffic.
	 1>Scalar Function
		accepts zero or more parameters and return single value
	 2>Table Valued Function
	    -"- and return a table variable.
		1>Inline table valued function -
		   contain single statement that must be a select statement.
		2>Multi-statement Table Valued function -
			multiple SQL statements encloed in Begin-End blocks. 

*/

--Scalar function --
/*
syntax -
	create function function-name(parameter optional)
	returns return -type
	as
	begin
		statement 1
		statement 2
		statement 3
		return return-value
	end
*/

create function AddDigit(@num1 int,@num2 int)
	returns int 
	as
	begin
		Declare @result int;
		set @result=@num1+@num2;
		return @result		
	end

select dbo.AddDigit(26,4)

create table student_Marks(
	RollNO int,
	Science Int,
	Math Int,
	Eng Int
)

insert into student_Marks values
(1,34,78,54),
(2,78,43,87),
(3,45,32,78),
(4,36,78,32),
(5,12,22,67),
(6,21,65,43),
(7,34,78,54),
(8,89,78,54);

select * from student_Marks;

create function GetTotal(@RollNo int)
returns int 
as
begin
   Declare @result int;
   select @result=(Science+Math+Eng) from student_Marks
     where RollNO=@RollNo;
return @result		
end

select RollNo,Science,Math,Eng, dbo.GetTotal(RollNO) as Total from student_Marks;

create function GetAvg(@RollNo int)
returns int 
as
begin
   Declare @result int;
   select @result=(Science+Math+Eng)/3 from student_Marks
     where RollNO=@RollNo;
return @result		
end

select RollNo,Science,Math,Eng, dbo.GetTotal(RollNO) as Total,
 dbo.GetAvg(RollNO) as Average from student_Marks;

------Table Valued Function ------
--Inline Table Valued function

create function GetStudentLit(@total int)
returns TABLE
As
return select * from student_Marks where (Science+Math+Eng) > @total;

select * from dbo.GetStudentLit(150)

--Multi-Statement Table valued function--
create function GetAllStudents(@RollNO int)
returns @Marksheet Table (@Stname varchar(50), RollNO INT, Eng int, Math int, Sci int, Average decimal(4,2))
As
begin
	declair @Per decimal(4,2);
	declair @Stname varchar(100);

	select @StName=tudent_name from Student where RollNO=@RollNO
	select @Per=((Eng+Math+Science)/3) from student_Marks where RollNO=@RollNO

	Insert into @MarkSheet (StName,RollNO,Eng,Math,Sci,Average)
	select @StName,RollNO,Eng,Math,Science,@Per from student_Marks where ROllNO=@ROllNO

return 
end

--select * from dbo.GetAllStudents(1)