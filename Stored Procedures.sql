use five;
create table worker(
Worker_Id INT PRIMARY KEY,
FirstName VARCHAR(25),
LastName VARCHAR(25),
Salary INT(15),
Joining_Date DATETIME,
Department VARCHAR(25)
);

insert into worker ( Worker_Id, FirstName, LastName,Salary, Joining_Date, Department) values
(1,"Alice","M",50000,"2023-01-15 09:00:00","HR"),
(2,"Michael","B",60000,"2022-07-22 09:00:00","Finance"),
(3,"Robert","D",40000,"2021-05-10 09:00:00","HR"),
(4,"Chris","Bumsted",55000,"2020-11-01 09:00:00","IT"),
(5,"David","L",70000,"2023-08-18 09:00:00","Finance");

delimiter $$
CREATE PROCEDURE AddWorker(
    IN p_Worker_Id INT,
    IN p_FirstName VARCHAR(25),
    IN p_LastName VARCHAR(25),
    IN p_Salary INT(15),
    IN p_Joining_Date DATETIME,
    IN p_Department VARCHAR(25)
)
begin
	insert into worker values(p_Worker_Id, p_FirstName, p_LastName, p_Salary, p_Joining_Date, p_Department);
end$$
delimiter ;    

call AddWorker(6,"Christian","Bale",80000,"2024-05-10 09:00:00","IT");

delimiter $$
CREATE PROCEDURE GetWorkerSalary(
    IN p_Worker_Id INT,
    OUT p_Salary INT
)
begin
	select Salary into p_Salary 
    from worker 
    where Worker_Id = p_Worker_Id;
    select @salary as salary;
end$$
delimiter ;    

set @salary=0;
call GetWorkerSalary(1,@salary);

delimiter $$
CREATE PROCEDURE UpdateWorkerDepartment(
    IN p_Worker_Id INT,
    IN p_Department VARCHAR(25)
)
begin    
	update worker
    set Department = p_Department
    where Worker_Id = p_Worker_Id;
end$$
delimiter ;    

call UpdateWorkerDepartment(1,"Finance");

delimiter $$
CREATE PROCEDURE GetWorkerCountByDepartment(
    IN p_Department VARCHAR(25),
    OUT p_workerCount INT
)
begin
	select COUNT(*) into p_workerCount
    from worker
   where Department = p_Department;
   select @count as WorkerCount;
end$$
delimiter ;  

set @count=0;
call GetWorkerCountByDepartment('HR', @count); 

delimiter $$
CREATE PROCEDURE GetAverageSalaryByDepartment(
    IN p_Department VARCHAR(25),
    OUT p_avgSalary DECIMAL(10,2)
)
begin
	select avg(Salary) into p_avgSalary
    from worker
    where Department = p_Department;
   select @avg_salary as AverageSalary;
end$$
delimiter ;

set @avg_salary=0;
call GetAverageSalaryByDepartment('HR', @avg_salary);

    
