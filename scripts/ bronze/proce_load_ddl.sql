CREATE 
    OR
	   ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
BEGIN TRY
	DECLARE @row_loaded INT 
	       ,@start_time DATETIME
		   ,@end_time   DATETIME
	PRINT'==============================='
	PRINT'Loading Bronze Layer .......'
	PRINT'==============================='
	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.crm_cust_info

	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Users\UnathiN\Music\DWH_PROJECT\sql-data-warehouse-project\datasets\source_crm\cust_info.CSV'
	WITH (
	  FIRSTROW = 2,
	  FIELDTERMINATOR = ',',
	  TABLOCK
	);

	SET @row_loaded = @@ROWCOUNT
	PRINT'> Loaded : ['+ISNULL(CAST(@row_loaded AS VARCHAR(100)),'NULL')+'] TO TABLE ---> bronze.crm_cust_info'

	PRINT'>> Loading bronze.crm_cust_info Took : ['+ISNULL(CAST(DATEDIFF(SECOND,@start_time,GETDATE()) AS VARCHAR(100)),'NULL')+']'
	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.prd_info

	BULK INSERT bronze.prd_info
	FROM 'C:\Users\UnathiN\Music\DWH_PROJECT\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	WITH
	(
	  FIRSTROW = 2,
	  FIELDTERMINATOR = ',',
	  TABLOCK
	);

	SET @row_loaded = @@ROWCOUNT

	PRINT'> Loaded : ['+ISNULL(CAST(@row_loaded AS VARCHAR(100)),'NULL')+'] TO TABLE ---> bronze.prd_info'
	PRINT'>> Loading bronze.prd_info Took : ['+ISNULL(CAST(DATEDIFF(SECOND,@start_time,GETDATE()) AS VARCHAR(100)),'NULL')+']'
	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.sales_details

	BULK INSERT  bronze.sales_details
	FROM 'C:\Users\UnathiN\Music\DWH_PROJECT\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	WITH 
	(
	  FIRSTROW = 2,
	  FIELDTERMINATOR = ',',
	  TABLOCK 
	);

	SET @row_loaded = @@ROWCOUNT

	PRINT'> Loaded : ['+ISNULL(CAST(@row_loaded AS VARCHAR(100)),'NULL')+'] TO TABLE ---> bronze.sales_details'
	PRINT'>> Loading bronze.sales_details Took : ['+ISNULL(CAST(DATEDIFF(SECOND,@start_time,GETDATE()) AS VARCHAR(100)),'NULL')+']'

	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.CUST_AZ12
	BULK INSERT bronze.CUST_AZ12
	FROM 'C:\Users\UnathiN\Music\DWH_PROJECT\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv' 
	WITH
	(
	 FIRSTROW = 2,
	 FIELDTERMINATOR = ',',
	 TABLOCK
	);

	SET @row_loaded = @@ROWCOUNT

	PRINT'> Loaded : ['+ISNULL(CAST(@row_loaded AS VARCHAR(100)),'NULL')+'] TO TABLE --->  bronze.CUST_AZ12'
	PRINT'>> Loading bronze.CUST_AZ12 Took : ['+ISNULL(CAST(DATEDIFF(SECOND,@start_time,GETDATE()) AS VARCHAR(100)),'NULL')+']'
	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.LOC_A101
	BULK INSERT bronze.LOC_A101
	FROM 'C:\Users\UnathiN\Music\DWH_PROJECT\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv' 
	WITH
	(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
	);


	SET @row_loaded = @@ROWCOUNT

	PRINT'> Loaded : ['+ISNULL(CAST(@row_loaded AS VARCHAR(100)),'NULL')+'] TO TABLE --->  bronze.LOC_A101'
	PRINT'>> Loading bronze.LOC_A101 Took : ['+ISNULL(CAST(DATEDIFF(SECOND,@start_time,GETDATE()) AS VARCHAR(100)),'NULL')+']'
	TRUNCATE TABLE bronze.PX_CAT_G1V2
	BULK INSERT bronze.PX_CAT_G1V2
	FROM 'C:\Users\UnathiN\Music\DWH_PROJECT\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv' 
	WITH
	(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
	);

	SET @row_loaded = @@ROWCOUNT

	PRINT'> Loaded : ['+ISNULL(CAST(@row_loaded AS VARCHAR(100)),'NULL')+'] TO TABLE --->  bronze.PX_CAT_G1V2'
	PRINT'>> Loading bronze.PX_CAT_G1V2 Took : ['+ISNULL(CAST(DATEDIFF(SECOND,@start_time,GETDATE()) AS VARCHAR(100)),'NULL')+']'
	END TRY

BEGIN CATCH
     PRINT'=========================================================='
	 PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER'
	 PRINT'Error Message : '+ERROR_MESSAGE();
	 PRINT'Error NUMBER : '+CAST(ERROR_NUMBER() AS VARCHAR(100));
	 PRINT'Error LINE : '+CAST(ERROR_LINE() AS VARCHAR(100));
	 PRINT'Error OBJECT : '+CAST(ERROR_PROCEDURE() AS VARCHAR(100));
	 PRINT'========================================================='
END CATCH
END
