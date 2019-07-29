
##########################################################
##########################################################

-- SECTION: First Steps in SQL

##########################################################
##########################################################

-- LECTURE: Creating a Database - Part I

CREATE DATABASE IF NOT EXISTS Sales;

CREATE SCHEMA IF NOT EXISTS Sales; #mesmo output

###########
-- LECTURE: Creating a Database - Part II

USE sales;

###########
-- LECTURE: Fixed and Floating-Point Data Types
DROP TABLE test;

CREATE TABLE test (
    test DECIMAL(5,3) #decimal(p,s) precisao e escala (precisao = tamanho de digitos no total e escala = digitos depois da virgula)
);

INSERT test VALUES (10.5);

SELECT 
    *
FROM
    test;

INSERT INTO test VALUES (12.55555);

ALTER TABLE `test` 
ADD COLUMN `test_fl` FLOAT(5,3) NULL AFTER `test`;

INSERT INTO test(test_fl) VALUES (14.55555);

INSERT INTO test(test) VALUES (16.55555);


###########
-- LECTURE: Creating a Table

CREATE TABLE sales 
(
	purchase_number INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date_of_purchase DATE NOT NULL,     
    customer_id INT,
    item_code VARCHAR(10) NOT NULL
);

-- EXERCISE 1: Creating a Table
CREATE TABLE customers				
(
    customer_id INT,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int
);


###########
-- LECTURE: Using Databases and Tables

/* 
CREATE DATABASE IF NOT EXISTS Sales;
USE Sales;
*/

SELECT 
    *
FROM
    customers;

SELECT 
    *
FROM
    sales.customers;

-- EXERCISE 1: Using Databases and Tables
SELECT 
    *
FROM
    sales;

SELECT 
    *
FROM
    sales.sales;


###########
-- LECTURE: Additional Notes on Using Tables

/*
CREATE TABLE sales 
(
	purchase_number INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date_of_purchase DATE NOT NULL,     
    customer_id INT,
    item_code VARCHAR(10) NOT NULL
);
*/

DROP TABLE sales;


##########################################################
##########################################################

-- SECTION: MySQL Constraints

##########################################################
##########################################################


###########
-- LECTURE: PRIMARY KEY Constraint

/*
CREATE TABLE sales
(
	purchase_number INT AUTO_INCREMENT PRIMARY KEY,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10)
);
*/

CREATE TABLE sales
(
	purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
PRIMARY KEY (purchase_number)
);

DROP TABLE customers;

CREATE TABLE customers				
(
    customer_id INT,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int, 
PRIMARY KEY (customer_id)
);

CREATE TABLE items (
    item_id VARCHAR(255),
    item VARCHAR(255),
    unit_price NUMERIC(10 , 2 ),
    company_id VARCHAR(255),
PRIMARY KEY (item_id)
);

CREATE TABLE companies (
    company_id VARCHAR(255),
    company_name VARCHAR(255),
    headquarters_phone_number INT(12),
PRIMARY KEY (company_id)
);

###########
-- LECTURE: FOREIGN KEY Constraint - Part I

DROP TABLE sales; #precisamos sempre deletar a tabela antes de sobreescrever ou usamos alter table

CREATE TABLE sales
(
	purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
PRIMARY KEY (purchase_number),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE #significa a dependencia na hora da exclusao de uma linha, se excluirmos um cliente da tabela customers, as linhas referentes a esse cliente em sales tb serao excluidas
);


###########
-- LECTURE: FOREIGN KEY Constraint - Part II

DROP TABLE sales; #precisamos sempre deletar a tabela antes de sobreescrever ou usamos alter table

CREATE TABLE sales
(
	purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
PRIMARY KEY (purchase_number)
);

ALTER TABLE sales 
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;

ALTER TABLE sales
DROP FOREIGN KEY sales_ibfk_1;

DROP TABLE sales;

DROP TABLE customers;

DROP TABLE items;

DROP TABLE companies;


###########
-- LECTURE: UNIQUE KEY Constraint

/*create table customers				
(
    customer_id int,
    first_name varchar(255),
	last_name varchar(255),
	email_address varchar(255),
	number_of_complaints int,
PRIMARY KEY (customer_id)
);
*/

CREATE TABLE customers
(
    customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id),
UNIQUE KEY (email_address)
);

DROP TABLE customers;

CREATE TABLE customers 
(
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id)
);

ALTER TABLE customers
ADD UNIQUE KEY (email_address);

ALTER TABLE customers
DROP INDEX email_address;

-- EXERCISE 1: UNIQUE KEY Constraint
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id)
);

ALTER TABLE customers
ADD COLUMN gender ENUM('M', 'F') AFTER last_name;
 
INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)
VALUES ('John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0)
;


###########
-- LECTURE: DEFAULT Constraint

CREATE TABLE customers 
(
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT DEFAULT 0,
PRIMARY KEY (customer_id)
);

DROP TABLE customers;

CREATE TABLE customers 
(
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id)
);

ALTER TABLE customers
CHANGE COLUMN number_of_complaints number_of_complaints INT DEFAULT 0;

INSERT INTO customers (first_name, last_name, gender) 
VALUES	('Peter', 'Figaro', 'M')
;

SELECT 
    *
FROM
    customers;
    
ALTER TABLE customers
ALTER COLUMN number_of_complaints DROP DEFAULT;

CREATE TABLE companies
(
     company_id VARCHAR(255),
    company_name VARCHAR(255) DEFAULT 'X',
    headquarters_phone_number INT(12),
PRIMARY KEY (company_id),
UNIQUE KEY (headquarters_phone_number)
);

DROP TABLE companies;


###########
-- LECTURE: NOT NULL Constraint - Part I

CREATE TABLE companies
(
	company_id INT AUTO_INCREMENT,
    headquarters_phone_number VARCHAR(255),
    company_name VARCHAR(255) NOT NULL,
PRIMARY KEY (company_id)
);

ALTER TABLE companies
MODIFY company_name VARCHAR(255) NULL;

ALTER TABLE companies
CHANGE COLUMN company_name company_name VARCHAR(255) NOT NULL;

INSERT INTO companies (headquarters_phone_number) #erro
VALUES	('+1 (202) 555-0196')
;

INSERT INTO companies (headquarters_phone_number, company_name) #corrigindo 
VALUES	('+1 (202) 555-0196', 'Company A')
;

SELECT * FROM companies;



##########################################################
##########################################################

-- SECTION: Loading the 'employees' Database

##########################################################
##########################################################


###########
-- LECTURE: Loading the 'employees' Database

USE employees;





##########################################################
##########################################################

-- SECTION: The SQL SELECT Statement


##########################################################
##########################################################

#O comando select é o “comando base” para todos os comandos de pesquisa de informações no banco de dados.
###########
-- LECTURE: SELECT - FROM

SELECT 
    first_name, last_name
FROM
    employees;
    
SELECT 
    *
FROM
    employees;

SELECT 
    dept_no
FROM
    departments;

###########
-- LECTURE: WHERE

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis';
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';
    
    
###########
-- LECTURE: AND

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND gender = 'M';
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' AND gender = 'F'; 


###########
-- LECTURE: OR

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis';
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND gender = 'M';

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' OR first_name = 'Elvis';

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis'
        AND first_name = 'Elvis';
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie'
        OR first_name = 'Aruna'; 
    

###########
-- LECTURE: Operator Precedence

SELECT 
    *
FROM
    employees
WHERE
    last_name = 'Denis' AND gender = 'M' OR gender = 'F';

SELECT 
    *
FROM
    employees
WHERE
    last_name = 'Denis' AND (gender = 'M' OR gender = 'F');
    

SELECT 
    *
FROM
    employees
WHERE
    gender = 'F' AND (first_name = 'Kellie' OR first_name = 'Aruna');


###########
-- LECTURE: IN / NOT IN

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Cathie'
        OR first_name = 'Mark'
        OR first_name = 'Nathan';

SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Cathie' , 'Mark', 'Nathan');

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('Cathie' , 'Mark', 'Nathan');
    
  
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis' , 'Elvis');
    

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');


###########
-- LECTURE: LIKE / NOT LIKE 

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE('Mar%');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE('ar%');

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE('%ar');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE('%ar%');

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mar_');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%Mar%');


SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE('Mark%');

SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('%2000%');

SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_');
    
    
###########
-- LECTURE: BETWEEN - AND
   
SELECT 
    *
FROM
    employees
WHERE
    hire_date BETWEEN '1990-01-01' AND '2000-01-01';
    
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';    


SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;
    
SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10004' AND '10012';
    
SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';

    
###########
-- LECTURE: IS NOT NULL / IS NULL
    
SELECT 
    *
FROM
    employees
WHERE
    first_name IS NOT NULL;
    
SELECT 
    *
FROM
    employees
WHERE
    first_name IS NULL;

-- EXERCISE 1: IS NOT NULL / IS NULL
SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no IS NOT NULL;


###########
-- LECTURE: Other Comparison Operators

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Mark';
    
SELECT 
	*
FROM 
	employees
WHERE
	first_name <> 'Mark';
    
SELECT 
	*
FROM 
	employees
WHERE
	first_name != 'Mark';
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date >= '2000-01-01';

SELECT 
    *
FROM
    employees
WHERE
    hire_date < '1985-02-01';
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date <= '1985-02-01';



###########
-- LECTURE: SELECT DISTINCT

SELECT 
    gender
FROM
    employees;
    
SELECT DISTINCT
    gender
FROM
    employees;
    
SELECT DISTINCT
    hire_date
FROM
    employees;
    

###########
-- LECTURE: Introduction to Aggregate Functions    
    
SELECT 
    COUNT(emp_no)
FROM
    employees;
    
SELECT 
    *
FROM
    employees
WHERE
    first_name IS NULL;
    
SELECT 
    COUNT(first_name)
FROM
    employees;

SELECT 
    COUNT(DISTINCT first_name)
FROM
    employees;

SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 100000;
    
SELECT 
    COUNT(*)
FROM
    dept_manager;


###########
-- LECTURE: ORDER BY

SELECT 
    *
FROM
    employees
ORDER BY first_name;

SELECT 
    *
FROM
    employees
ORDER BY first_name ASC;

SELECT 
    *
FROM
    employees
ORDER BY first_name DESC;

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC;

SELECT 
    *
FROM
    employees
ORDER BY first_name , last_name ASC;



###########
-- LECTURE: GROUP BY

    
SELECT 
    first_name
FROM
    employees
GROUP BY first_name;


SELECT 
    COUNT(first_name)
FROM
    employees
GROUP BY first_name;

SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name;

SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC;


###########
-- LECTURE: Using Aliases (AS)

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC;


SELECT 
    salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary;



###########
-- LECTURE: LIMIT

SELECT 
    *
FROM
    salaries;
    
SELECT 
    *
FROM
    salaries
ORDER BY salary DESC;

SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name
LIMIT 100;



##########################################################
##########################################################

-- SECTION: MySQL Aggregate Functions

##########################################################
##########################################################


###########
-- LECTURE: COUNT()

SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10; 

SELECT 
    COUNT(salary)
FROM
    salaries;   

SELECT 
    COUNT(from_date)
FROM
    salaries;

SELECT 
    COUNT(DISTINCT from_date)
FROM
    salaries;
    
SELECT 
    COUNT(*)
FROM
    salaries;
    


###########
-- LECTURE: SUM()

SELECT 
    SUM(salary)
FROM
    salaries;
    
 

SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';


###########
-- LECTURE: MIN() and MAX()

SELECT 
    MAX(salary)
FROM
    salaries;

SELECT 
    MIN(salary)
FROM
    salaries;
    
   
SELECT 
    MIN(emp_no)
FROM
    employees;


SELECT 
    MAX(emp_no)
FROM
    employees;


###########
-- LECTURE: AVG()

SELECT 
    AVG(salary)
FROM
    salaries;


SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';


###########
-- LECTURE: ROUND()
    
SELECT 
    ROUND(AVG(salary))
FROM
    salaries;

SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries;
    
SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries
WHERE
    from_date > '1997-01-01'; 
    



##########################################################
##########################################################

-- SECTION: SQL Joins

##########################################################
##########################################################

# criando uma tabela departments_dup
#DROP TABLE IF EXISTS departments_dup;
CREATE TABLE departments_dup 
(
    dept_no CHAR(4) NULL,
    dept_name VARCHAR(40) NULL
);

INSERT INTO departments_dup
(
    dept_no,
    dept_name
)SELECT 
	*
FROM 
	departments;

INSERT INTO departments_dup (dept_name) 
VALUES 	('Public Relations');

DELETE FROM departments_dup 
WHERE
    dept_no = 'd002';  
    
INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

-- # criando uma tabela dept_manager_dup

CREATE TABLE dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
  );

INSERT INTO dept_manager_dup
select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES  (999904, '2017-01-01'),
		(999905, '2017-01-01'),
        (999906, '2017-01-01'),
       	(999907, '2017-01-01');

DELETE FROM dept_manager_dup 
WHERE
    dept_no = 'd001'; 
    
INSERT INTO departments_dup (dept_name) 
VALUES 	('Public Relations');

DELETE FROM departments_dup 
WHERE
    dept_no = 'd002';


###########
-- LECTURE: INNER JOIN - Part I

-- dept_manager_dup
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no;

-- departments_dup
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;


###########
-- LECTURE: INNER JOIN - Part II

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no;



-- ORDER BY d.dept_no
SELECT 
    m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM
    dept_manager_dup m
		JOIN
    departments_dup d ON d.dept_no = m.dept_no
ORDER BY d.dept_no;

-- ORDER BY dept_no
SELECT 
    m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM
    dept_manager_dup m
		JOIN
    departments_dup d ON d.dept_no = m.dept_no
ORDER BY dept_no;


###########
-- LECTURE: Duplicate Records

-- duplicate records
INSERT INTO dept_manager_dup 
VALUES 	('110228', 'd003', '1992-03-21', '9999-01-01');
        
INSERT INTO departments_dup 
VALUES	('d009', 'Customer Service');

-- dept_manager_dup
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no ASC;

-- departments_dup
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no ASC;

-- inner join
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY dept_no;

-- add GROUP BY m.emp_no
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY dept_no;


###########
-- LECTURE: LEFT JOIN - Part I

-- remove the duplicates from the two tables
DELETE FROM dept_manager_dup 
WHERE emp_no = '110228';
        
DELETE FROM departments_dup 
WHERE dept_no = 'd009';

-- add back the initial records
INSERT INTO dept_manager_dup 
VALUES 	('110228', 'd003', '1992-03-21', '9999-01-01');
        
INSERT INTO departments_dup 
VALUES	('d009', 'Customer Service');



SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY m.dept_no;


###########
-- LECTURE: LEFT JOIN - Part II

-- d LEFT JOIN m
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    departments_dup d
		LEFT JOIN
    dept_manager_dup m ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- SELECT d.dept_no
SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    departments_dup d
		LEFT JOIN
    dept_manager_dup m ON m.dept_no = d.dept_no
ORDER BY d.dept_no;

-- LEFT OUTER JOIN
SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    departments_dup d
        LEFT OUTER JOIN
    dept_manager_dup m ON m.dept_no = d.dept_no
ORDER BY d.dept_no;

-- m LEFT JOIN d
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- add WHERE
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
WHERE
    dept_name IS NULL
ORDER BY m.dept_no;


###########
-- LECTURE: RIGHT JOIN



-- right join
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        RIGHT JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY dept_no;

-- SELECT d.dept_no
SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        RIGHT JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY dept_no;

-- d LEFT JOIN m
SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    departments_dup d
        LEFT JOIN
    dept_manager_dup m ON m.dept_no = d.dept_no
ORDER BY dept_no;


###########
-- LECTURE: The New and the Old Join Syntax

-- JOIN
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
		INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- WHERE
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m,
    departments_dup d
WHERE
    m.dept_no = d.dept_no
ORDER BY m.dept_no;



###########
-- LECTURE: JOIN and WHERE Used Together

SELECT 
    e.emp_no, e.first_name, e.last_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.salary > 145000
;

SELECT 
    e.first_name, e.last_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.salary > 145000
;




###########
-- LECTURE: Using Aggregate Functions with Joins

SELECT 
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;    

-- SELECT e.emp_no
SELECT 
    e.emp_no, e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender; 


###########
-- LECTURE: Join more than Two Tables in SQL

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
;

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    employees e ON m.emp_no = e.emp_no
;

-- RIGHT JOIN - JOIN
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    departments d
        RIGHT JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    employees e ON m.emp_no = e.emp_no
;

-- JOIN - RIGHT JOIN
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        RIGHT JOIN
    employees e ON m.emp_no = e.emp_no
;

-- EXERCISE 1: Join more than Two Tables in SQL
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE t.title = 'Manager'
ORDER BY e.emp_no;

-- or, alternatively:
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
        AND m.from_date = t.from_date
ORDER BY e.emp_no;


-- GROUP BY dept_name
SELECT 
    d.dept_name, AVG(salary)
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY dept_name
ORDER BY d.dept_no
;


-- AVG(salary) AS aaverage_salary 
-- add back GROUP BY d.dept_name
SELECT 
    d.dept_name, AVG(salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY d.dept_no
;

-- ORDER BY AVG(salary) DESC
SELECT 
    d.dept_name, AVG(salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY AVG(salary) DESC
;

-- ORDER BY average_salary DESC
SELECT 
    d.dept_name, AVG(salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY average_salary DESC
;


-- UNION ALL
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION ALL SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
    dept_manager m;
    
-- UNION
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
    dept_manager m;

-- EXERCISE 1: UNION vs UNION ALL
SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) a
ORDER BY -a.emp_no DESC;





##########################################################
##########################################################

-- SECTION: Subqueries

##########################################################
##########################################################    


###########
-- LECTURE: Subqueries with IN nested inside WHERE

SELECT 
    *
FROM
    dept_manager;
    
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm);
            
SELECT 
    dm.emp_no
FROM
    dept_manager dm;
    
-- EXERCISE 1: Subqueries with IN nested inside WHERE
SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');




###########
-- LECTURE: The CASE Statement

SELECT 
    emp_no,
    first_name,
    last_name,
    CASE
        WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;

    departments
SELECT 
	emp_no,
	first_name,
	last_name,
	CASE gender
		WHEN 'M' THEN 'Male'
		ELSE 'Female'
	END AS gender
FROM
	employees;
    

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE dm.emp_no
        WHEN  dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990;


SELECT 
    emp_no,
    first_name,
    last_name,
    IF(gender = 'M', 'Male', 'Female') AS gender
FROM
    employees;
    

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than $30,000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 
									'Salary was raised by more than $20,000 but less than $30,000'
        ELSE 'Salary was raised by less than $20,000'
    END AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;


-- EXERCISE 1: The CASE Statement
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990;


-- EXERCISE 2: The CASE Statement
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30,000'
        ELSE 'Salary was NOT raised by more then $30,000'
    END AS salary_raise
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    IF(MAX(s.salary) - MIN(s.salary) > 30000, 'Salary was raised by more then $30,000', 'Salary was NOT raised by more then $30,000') AS gender
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;


-- EXERCISE 3: The CASE Statement
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;




-- End.
##########################################################