CREATE TABLE bronze.crm_cust_info (
cst_id INT,
cst_key NVARCHAR (50),
cst_firstname NVARCHAR (50),
cst_lastname NVARCHAR (50),
cst_marital_status NVARCHAR (50),
cst_gender NVARCHAR (50),
cst_create_date DATE
);

--create all tables from crm and erp files name: source systme then table name

--TRUNCATE TABLE bronze.crm_cust_info;
BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\HP\Desktop\Learnings and Resources\SQL Learnings\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
	FIRSTROW= 2,-- we are telling the db that forst row starts from number 2 in the dataset because the actual first row is the col names
	FIELDTERMINATOR= ',', --mention file separators 
	TABLOCK --optional- it will lock the whole table
);
--always check the quality
SELECT
COUNT (*)
FROM bronze.crm_cust_info -- always one less row since the first row is col names
-- if i rum it again file will be loaded twice. then you truncate before bulk insert command to empty the table
-- every time more data is added into the original file you will refresh to load it in sql as well hence to avoid duplication truncate command is important

/*create stored procedures
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
input the trncate + bulk insert code
END and execute*/
--TO CHECK
--run rhis code: EXEC bronze.load_bronze

--PRINT command- to track execution, debug issues, and understand its flow
PRINT '================================='
PRINT 'loading Bronze layer'
PRINT '================================='
TRUNCATE TABLE bronze.crm_cust_info;
BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\HP\Desktop\Learnings and Resources\SQL Learnings\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
	FIRSTROW= 2,-- we are telling the db that forst row starts from number 2 in the dataset because the actual first row is the col names
	FIELDTERMINATOR= ',', --mention file separators 
	TABLOCK --optional- it will lock the whole table
);

--Try to catch errors
/* CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
BEGIN TRY
input the trncate + bulk insert code
END TRY
BEGIN CATCH
You can add PRINT to add the eroor message separator

--time of recording and duration -- see again
END CATCH
END and execute*/
