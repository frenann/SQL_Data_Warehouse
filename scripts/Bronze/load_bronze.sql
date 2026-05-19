/* Load das informações nas tabelas bronze:

- Como a primeira linha da fonte de dados representa o cabeçalho, é necessário informar que o load deve começar da segunda linha. Por isso foi utilizado o comando FIRSTROW = 2
- Como o delimitador das informações dos clientes é uma vírgula, também é necessário informar antes do load. Para isso, utilizou-se o comando FIELDTERMINATOR = ','
- O comando TRUNCATE é utilizado antes do insert para evitar que a tabela contenha informações indesejadas ou que as informações sejam inseridas de forma duplicada.

*/


-- Inserindo as informações dos Clientes na tabela bronze.crm_cust_info:

TRUNCATE TABLE bronze.crm_cust_info

BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\ferna\Desktop\Renan\Projetos\SQL\DataWareHouse\cust_info.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- Para checar se as informações foram carregadas de maneira correta:

SELECT *
FROM bronze.crm_cust_info

-- Para checar se todas as linhas foram carregadas na tabela:

SELECT COUNT(*) AS 'Total de Linhas'
FROM bronze.crm_cust_info


-- Inserindo as informações dos Produtos na tabela bronze.crm_prd_info:

TRUNCATE TABLE bronze.crm_prd_info

BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\ferna\Desktop\Renan\Projetos\SQL\DataWareHouse\prd_info.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- Para checar se as informações foram carregadas de maneira correta:

SELECT *
FROM bronze.crm_prd_info

-- Para checar se todas as linhas foram carregadas na tabela:

SELECT COUNT(*) AS 'Total de Linhas'
FROM bronze.crm_prd_info


-- Inserindo as informações dos Produtos na tabela bronze.crm_sales_details:

TRUNCATE TABLE bronze.crm_sales_details

BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\ferna\Desktop\Renan\Projetos\SQL\DataWareHouse\sales_details.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- Para checar se as informações foram carregadas de maneira correta:

SELECT *
FROM bronze.crm_sales_details

-- Para checar se todas as linhas foram carregadas na tabela:

SELECT COUNT(*) AS 'Total de Linhas'
FROM bronze.crm_sales_details


-- Inserindo as informações na tabela bronze.erp_cust_az12:

TRUNCATE TABLE bronze.erp_cust_az12

BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\ferna\Desktop\Renan\Projetos\SQL\DataWareHouse\CUST_AZ12.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- Para checar se as informações foram carregadas de maneira correta:

SELECT *
FROM bronze.erp_cust_az12

-- Para checar se todas as linhas foram carregadas na tabela:

SELECT COUNT(*) AS 'Total de Linhas'
FROM bronze.erp_cust_az12


-- Inserindo as informações na tabela bronze.erp_loc_a101:

TRUNCATE TABLE bronze.erp_loc_a101

BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\ferna\Desktop\Renan\Projetos\SQL\DataWareHouse\LOC_A101.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- Para checar se as informações foram carregadas de maneira correta:

SELECT *
FROM bronze.erp_loc_a101

-- Para checar se todas as linhas foram carregadas na tabela:

SELECT COUNT(*) AS 'Total de Linhas'
FROM bronze.erp_loc_a101


-- Inserindo as informações na tabela bronze.erp_px_cat_g1v2:

TRUNCATE TABLE bronze.erp_px_cat_g1v2

BULK INSERT bronze.erp_px_cat_g1v2
FROM 'C:\Users\ferna\Desktop\Renan\Projetos\SQL\DataWareHouse\PX_CAT_G1V2.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- Para checar se as informações foram carregadas de maneira correta:

SELECT *
FROM bronze.erp_px_cat_g1v2

-- Para checar se todas as linhas foram carregadas na tabela:

SELECT COUNT(*) AS 'Total de Linhas'
FROM bronze.erp_px_cat_g1v2
