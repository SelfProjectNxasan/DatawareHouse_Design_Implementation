/*
==========================================================================
CREATE DATABASE SCHEMA'S AND DATABASES IF ALREADY EXISTS IT WILL DROP 
==========================================================================

WARNIG:
1. DECAREFUL IT WOULD DROP AND RECREATE A DATABASE

*/
/*
IF  EXISTS(SELECT * FROM sys.databases d WHERE d.name = 'DataWareHouse') 
ALTER DATABASE DataWareHouse SET SINGLE_USERR WITH IMMIDIATE ROLLBACK 
DROP DATABASE DataWareHouse

CREATE DATABASE DataWareHouse

USE [DataWareHouse]
*/

IF  EXISTS(SELECT * FROM sys.databases d WHERE d.name = 'DataWareHouse') 
BEGIN
ALTER DATABASE DataWareHouse SET SINGLE_USERR WITH IMMIDIATE ROLLBACK 
DROP DATABASE DataWareHouse
END
GO
BEGIN TRY
   EXEC(N'CREATE SCHEMA bronze') 
END TRY

BEGIN CATCH
    PRINT'ALREADY EXISTS'
END CATCH

BEGIN TRY
   EXEC(N'CREATE SCHEMA silver') 
END TRY

BEGIN CATCH
    PRINT'ALREADY EXISTS'
END CATCH

BEGIN TRY
   EXEC(N'CREATE SCHEMA gold') 
END TRY

BEGIN CATCH
    PRINT'ALREADY EXISTS'
END CATCH 

IF OBJECT_ID(N'bronze.crm_cust_info','U') IS NOT NULL
BEGIN
   DROP TABLE bronze.crm_cust_info
END 

CREATE TABLE bronze.crm_cust_info
(
  cst_id INT
 ,cst_key VARCHAR(MAX)
 ,cst_first_name NVARCHAR(500)
 ,cst_lastname NVARCHAR(500)
 ,cst_marital_status VARCHAR(100)
 ,cst_gndr VARCHAR(100)
 ,cst_create_date VARCHAR(MAX)
);

GO
IF OBJECT_ID(N'bronze.prd_info','U') IS NOT NULL
BEGIN
   DROP TABLE bronze.prd_info
END 
CREATE TABLE bronze.prd_info
(
  prd_id INT
 ,prd_key VARCHAR(100)
 ,prd_prd_nm NVARCHAR(100)
 ,prd_cost FLOAT
 ,prd_line VARCHAR(MAX)
 ,prd_start_dt DATE
 ,prd_end_dt DATE
);
IF OBJECT_ID(N'bronze.sales_details','U') IS NOT NULL
BEGIN
    DROP TABLE bronze.sales_details
END 
CREATE TABLE bronze.sales_details 
(
    sls_ord_num   VARCHAR(20)    ,
    sls_prd_key   VARCHAR(50)    ,
    sls_cust_id   INT            ,
    sls_order_dt  VARCHAR(MAX)           ,
    sls_ship_dt   DATE          ,
    sls_due_dt    DATE          ,
    sls_sales     DECIMAL(12,2)  ,
    sls_quantity  INT            ,
    sls_price     DECIMAL(12,2)  ,
);

IF OBJECT_ID(N'bronze.CUST_AZ12','U') IS NOT NULL
BEGIN
    DROP TABLE bronze.CUST_AZ12
END 
CREATE TABLE bronze.CUST_AZ12 (
    CID   VARCHAR(20),
    BDATE DATE,
    GEN   VARCHAR(10)
);

IF OBJECT_ID(N'bronze.LOC_A101','U') IS NOT NULL
BEGIN
    DROP TABLE bronze.LOC_A101
END 
CREATE TABLE bronze.LOC_A101
(
    CID   VARCHAR(20),
    CNTRY VARCHAR(50)
);

IF OBJECT_ID(N'bronze.PX_CAT_G1V2','U') IS NOT NULL
BEGIN
    DROP TABLE bronze.PX_CAT_G1V2
END 
CREATE TABLE bronze.PX_CAT_G1V2

(
    ID           VARCHAR(20),
    CAT          VARCHAR(50),
    SUBCAT       VARCHAR(50),
    MAINTENANCE  VARCHAR(10)
);
