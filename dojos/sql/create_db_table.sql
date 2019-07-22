SHOW DATABASES;

-- Delete a database
DROP DATABASE IF EXISTS household_db;

-- create a database called household_db
CREATE DATABASE household_db;

-- Select the database we're gonna use
USE household_db;

-- Create columns that match 
CREATE TABLE user(
-- create a constains with primary key not null
    ID INT NOT NULL PRIMARY KEY,
    name VARCHAR (20),
    age INT (3),
    address VARCHAR (50)
    );

-- Display tables
SHOW TABLES;

-- Describe table's information
DESC user;

-- Delete a table
DROP TABLE user;

-- Load csv data into a table
LOAD DATA LOCAL INFILE 'data.csv' INTO TABLE user FIELDS TERMINATED BY ',' LINES TERMINATED BY '/n' IGNORE 1 LINES;

-- ERROR 1290 (HY000): The MySQL server is running with the --secure-file-priv option so it cannot execute this statement
-- https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_secure-file-priv
-- SHOW VARIABLES LIKE "secure_file_priv";
-- SHOW VARIABLES like "local_infile";
-- SET GLOBAL local_infile = 1;



