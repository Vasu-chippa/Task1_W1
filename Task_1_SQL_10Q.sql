create database task1;
use task1;

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    dept_id INT,
    salary DECIMAL(10,2),
    manager_id INT,
    join_date DATE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id),
    FOREIGN KEY (manager_id) REFERENCES Employees(emp_id)
);

CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    dept_id INT,
    budget DECIMAL(12,2),
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE EmployeeProjects (
    emp_id INT,
    project_id INT,
    hours_worked DECIMAL(8,2),
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(12,2),
    status VARCHAR(30)
);


INSERT INTO Departments (dept_id, dept_name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Sales');



INSERT INTO Employees
(emp_id, emp_name, dept_id, salary, manager_id, join_date)
VALUES
(101, 'Alice',   1, 90000.00, NULL, '2019-01-15'),
(102, 'Bob',     2, 75000.00, NULL, '2018-06-10'),
(103, 'Charlie', 3, 85000.00, NULL, '2020-03-20'),
(104, 'David',   4, 80000.00, NULL, '2019-09-05'),
(105, 'Eva',     5, 95000.00, NULL, '2017-11-12');

INSERT INTO Employees
(emp_id, emp_name, dept_id, salary, manager_id, join_date)
VALUES
(106, 'Frank',  1, 65000.00, 101, '2021-02-15'),
(107, 'Grace',  1, 70000.00, 101, '2022-05-10'),
(108, 'Henry',  2, 55000.00, 102, '2021-08-18'),
(109, 'Ivy',    3, 60000.00, 103, '2022-01-25'),
(110, 'Jack',   4, 62000.00, 104, '2020-12-01'),
(111, 'Karen',  5, 68000.00, 105, '2021-07-14'),
(112, 'Leo',    5, 72000.00, 105, '2023-03-01');


INSERT INTO Projects  (project_id, project_name, dept_id, budget)
VALUES
(201, 'Website Redesign',       1, 150000.00),
(202, 'Mobile Application',     1, 250000.00),
(203, 'Recruitment System',     2, 100000.00),
(204, 'Financial Dashboard',    3, 180000.00),
(205, 'Marketing Campaign',     4, 120000.00),
(206, 'Sales Automation',       5, 200000.00);


INSERT INTO EmployeeProjects (emp_id, project_id, hours_worked)
VALUES
(101, 201, 120.00),
(101, 202, 80.00),
(106, 201, 150.00),
(106, 202, 200.00),
(107, 202, 180.00),
(108, 203, 160.00),
(102, 203, 100.00),
(109, 204, 175.00),
(103, 204, 90.00),
(110, 205, 140.00),
(104, 205, 100.00),
(111, 206, 210.00),
(112, 206, 190.00),
(105, 206, 75.00);



INSERT INTO Orders (order_id, customer_id, order_date, amount, status)
VALUES
(1001, 501, '2024-01-05', 1200.00, 'Completed'),
(1002, 502, '2024-01-10', 850.00,  'Completed'),
(1003, 503, '2024-01-15', 2300.00, 'Pending'),
(1004, 501, '2024-02-02', 450.00,  'Completed'),
(1005, 504, '2024-02-08', 1750.00, 'Cancelled'),
(1006, 505, '2024-02-20', 3200.00, 'Completed'),
(1007, 502, '2024-03-03', 950.00,  'Pending'),
(1008, 506, '2024-03-12', 4100.00, 'Completed'),
(1009, 503, '2024-03-18', 600.00,  'Completed'),
(1010, 507, '2024-04-01', 2800.00, 'Pending');


select * from employees;
select * from departments;
select * from Projects;

/*
1. Department Salary Summary
Show department name, employee count, average, minimum and maximum salary. Include departments with no employees.  */

select  d.dept_name , count(*) as emp_count, avg(e.salary) as avg_salary, min(e.salary) as min_salary, max(e.salary) as max_salary from departments d join employees e on d.dept_id=e.dept_id group by dept_name ;

/*
2. Second Highest Salary per Department
Using a window function, return employee(s) earning the second distinct highest salary in each department.*/

select emp_name, dept_name , salary  from (
			select e.emp_name ,d.dept_name ,  e.salary, DENSE_RANK() over ( partition by d.dept_id order by salary desc) as salary_rank 
from employees e  join departments d on d.dept_id =e.dept_id )
 as ranked_emp where salary_rank =2;


/*
3. Employees Above Department Average
Find employees earning more than their own department average without hard-coding departments.*/


select emp_name , dept_id, salary from employees  e where salary >
( select avg(salary) from employees where e.salary > dept_id =e.dept_id);


/*
4. Manager vs Team Salary
For each manager, show direct-report count, total team salary and manager salary; keep managers with at least two reports.*/

select  m.emp_name , count(e.emp_id) as emp_count ,  m.salary as manager_salary , sum(e.salary) as total_salary from employees e inner join employees m on e.manager_id=m.emp_id
group by m.emp_name , m.salary having count(m.emp_id) >=1;

/*
5. Top Project Contributors
For each project, rank employees by total hours and return the top two contributors, handling ties correctly.*/




/*
6. Departments Without Active Projects
Find departments that contain employees but have no matching project.*/

select * from employees;		
select  * from projects;
select  * from  departments;

select  distinct dept_id from employees where dept_id not in (
select dept_id from projects );


/*
7. Running Order Revenue
For completed orders, show order date, daily revenue and cumulative revenue ordered by date.*/
select * from orders;
select order_date, sum(amount ) as daily_revenue, sum(sum(amount)) over ( order by order_date) as cumulative_rev from orders
where status='completed' group by order_date order by cumulative_rev desc;



/*
8. Customer Order Classification
Classify each customer by completed-order value: PLATINUM >=100000, GOLD >=50000, SILVER >=20000, else BRONZE.*/

select customer_id , sum(amount) as completed_order_val,  
case  
when sum(amount)>=2000 then 'platinum' 
when sum(amount) >=1000 then 'gold'
when sum(amount) >=500 then 'silver'
else 'bronze'
End as cust_category 
from orders where status='completed' group by customer_id order by completed_order_val desc;



/*
9. Consecutive Monthly Orders
Identify customers with at least one order in three consecutive calendar months using CTEs/window functions.*/





/*
10. Salary Gap Analysis
For each department, return highest-paid and lowest-paid employee(s) and the salary difference; preserve ties.
*/




