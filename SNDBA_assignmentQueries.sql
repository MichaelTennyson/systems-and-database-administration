CREATE SCHEMA HR_staff;
CREATE SCHEMA employees;

--Creation of tables for main database;
\CONNECT humanResources
;
CREATE TABLE employees (
	employee_ID VARCHAR(50) PRIMARY KEY,
	name VARCHAR ( 50 ),
	join_date TIMESTAMP NOT NULL,
	position VARCHAR ( 255 ),
	SSN VARCHAR ( 50 ) NOT NULL,
    salary INTEGER
);

CREATE TABLE stores (
	store_ID VARCHAR(50) PRIMARY KEY,
	location TEXT,
	employee_count INTEGER
);

CREATE TABLE payments (
	employee_ID VARCHAR(50),
	payment_type VARCHAR ( 50 ),
	bank_account_number VARCHAR ( 255 ),
	payment_status BOOLEAN
);

CREATE TABLE performance_appraisals (
	employee_ID VARCHAR(50),
	performance_review TEXT  NOT NULL,
	review_ratinf INTEGER NOT NULL,
	bonus TEXT
);

--Creation of user role employee and hr_staff;

CREATE USER employee;

CREATE USER hr_staff;

-- Granting employee read only privileges
GRANT SELECT * FROM payments TO employees;

GRANT SELECT * FROM performance_appraisals TO employees;

-- Granting hr_staff privileges
GRANT INSERT INTO payments TO hr_staff;
GRANT INSERT INTO performance_appraisals TO hr_staff;
GRANT UPDATE payments TO hr_staff;
GRANT DELETE * FROM performance_appraisals to hr_staff;

--run command to view postgres configuration FILE
SHOW config_file;

-- query to reload configuration FILE
SELECT pg_reload_conf();” 

--adding PGAudit extension to database
Create Extension pgaudit;

--run the command to enable Linux Huge pages for the human resources database to access
ALTER SYSTEM SET huge_pages TO ‘on’;


--creation of backup database and its tables

CREATE DATABASE humanResources_backup;


\CONNECT humanResources_backup;

CREATE TABLE employees (
	employee_ID VARCHAR(50) PRIMARY KEY,
	name VARCHAR ( 50 ),
	join_date TIMESTAMP NOT NULL,
	position VARCHAR ( 255 ),
	SSN VARCHAR ( 50 ) NOT NULL,
    salary INTEGER
);

CREATE TABLE stores (
	store_ID VARCHAR(50) PRIMARY KEY,
	location TEXT,
	employee_count INTEGER
);

CREATE TABLE payments (
	employee_ID VARCHAR(50),
	payment_type VARCHAR ( 50 ),
	bank_account_number VARCHAR ( 255 ),
	payment_status BOOLEAN
);

CREATE TABLE performance_appraisals (
	employee_ID VARCHAR(50),
	performance_review TEXT  NOT NULL,
	review_ratinf INTEGER NOT NULL,
	bonus TEXT
);

--Creation of user role employee and hr_staff;

CREATE USER employee;

CREATE USER hr_staff;

-- Granting employee read only privileges
GRANT SELECT * FROM payments TO employees;

GRANT SELECT * FROM performance_appraisals TO employees;

-- Granting hr_staff privileges
GRANT INSERT INTO payments TO hr_staff;
GRANT INSERT INTO performance_appraisals TO hr_staff;
GRANT UPDATE payments TO hr_staff;
GRANT DELETE * FROM performance_appraisals to hr_staff;

--create HR_restore DATABASE
CREATE DATABSE HR_restore;

-- running pg backup commands

SELECT pg_start_backup(‘test backup’, true);

--running command to shut off pg_backup
SELECT pg_stop_backup(); 