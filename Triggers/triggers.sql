/*	USED TO STORE BACKUP FOR DELETED UPDATED DATA
	DML Triggers - 
		-triggers we can not run explicitly so it called as special type of SP
		-It automaically takes effect after DML events(insert,update,delete) takes place
		-Used to inforce bussiness rules and data integrity.
		-The triggers and the statement that fires it are treated as a single transaction, which can be rolled back from within the trigger.
	Types-
		1>AFTER/FOR -
			-Ececuted after the action of the INSERT, UPDATE, MERGE or DELETE statement is performed.
		2>INSTEAD OF -
			-Override the standard actions of the triggering statement.
*/
create table EmployeeTrig(
 Emp_ID INT IDENTITY PRIMARY KEY,
 Emp_name varchar(100) NOT NULL,
 Emp_Sal decimal(10,2) NOT NULL,
 Emp_DOB datetime NOT NULL,
 Emp_Experience INT NOT NULL,
 Record_DateTime datetime NOT NULL
)

create trigger dbo.triggerAInsert ON dbo.EmployeeTrig
AFTER  INSERT
as
declare @emp_dob varchar(20);
declare @age INT;
declare @Emp_Experience INT;

select @emp_dob = i.Emp_DOB from inserted i;
select @Emp_Experience = i.Emp_Experience from inserted i;

---employee age must not above  25 years
SET @Age=Year(GetDate())-Year(@emp_dob);
If @Age > 25
	begin
	Print 'Not Eligible: Age is greater  than 25'
	Rollback
	End
---Employee should have more than 5 years experience
ELSE IF @Emp_Experience < 5
	begin
	Print 'Not Eligible: Experience is less than 5'
	Rollback
	end
	
insert into EmployeeTrig values ('Smith',5000,'1990-01-03',4,GetDate()) 
insert into EmployeeTrig values ('Smith',5000,'1998-01-03',4,GetDate()) 
insert into EmployeeTrig values ('Smith',5000,'1998-01-03',6,GetDate()) 
select * from EmployeeTrig

----After Update-
create table dbo.EmployeeHistory(
	Emp_ID INT NOT NULL,
	field_name varchar(100) NOT NULL,
	old_value varchar(100) NOT NULL,
	new_value varchar(100) NOT NULL,
	Record_DateTime datetime NOT NULL
)

create trigger dbo.trgAfterUpdate ON dbo.EmployeeTrig
AFTER UPDATE
AS
declare @emp_id INT;
declare @emp_name varchar(100);
declare @old_emp_name varchar(100);
declare @emp_sal decimal(10,2);
declare @old_emp_sal decimal(10,2);

select @emp_id=i.Emp_id from inserted i;
select @emp_name=i.Emp_Name from inserted i;
select @old_emp_name=i.Emp_Name from deleted i;
select @emp_sal=i.Emp_Sal from inserted i;
select @old_emp_sal=i.Emp_Sal from deleted i;

if update(Emp_Name)
begin
insert into EmployeeHistory values (@emp_id,'Emp_Name',@old_emp_name,@emp_name,getdate())
end
if update(Emp_Sal)
begin
insert into EmployeeHistory values (@emp_id,'Emp_Name',@old_emp_name,@emp_name,getdate())
end

select * from EmployeeTrig;
update EmployeeTrig set emp_name='king' where emp_id=2

---After update
select * from EmployeeTrig;
select * from EmployeeHistory;

----After Delete--
create table EmployeeBackUp(
 Emp_ID INT NOT NULL,
 Emp_name varchar(100) NOT NULL,
 Emp_Sal decimal(10,2) NOT NULL,
 Emp_DOB datetime NOT NULL,
 Emp_Experience INT NOT NULL,
 Record_DateTime datetime NOT NULL
)


create trigger dbo.trgAfterDelete ON dbo.EmployeeTrig
AFTER DELETE
as
declare @emp_id INT;
declare @emp_name varchar(100);
declare @emp_sal decimal(10, 2);
declare @emp_dob varchar(20);
declare @age INT;
declare @Emp_Experience INT;

select @emp_id = i.emp_id from deleted i;
select @emp_name = i.Emp_Name from deleted i;
select @emp_sal = i.Emp_Sal from deleted i;
select @emp_dob = i.Emp_DOB from deleted i;
select @Emp_Experience = i.Emp_Experience from deleted i;

insert into employeeBackUP values(@emp_id,@emp_name,@emp_sal,@emp_dob,@emp_experience,getdate())
print 'Employee details inserted successfully.';

---before delete--
select * from EmployeeTrig;
select * from EmployeeBackUp;

delete from EmployeeTrig where emp_id=6

---After delete
select * from EmployeeTrig;
select * from EmployeeBackUp;
