-- Para detectar valores de ID dos Clientes (Primary Key) duplicados:

SELECT 
cst_id AS 'ID do Cliente',
COUNT (*) AS 'Total'
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT (*) > 1 OR cst_id IS NULL -- Com isso, não identificamos mais IDs duplicados ou nulos.



-- Para checar se existem espaços indesejados:


-- Caso o fisrtname seja diferente do firstname após a aplicação da função TRIM, isso indica que existem caracteres indesejados.

SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

-- Caso o lastname seja diferente do lastname após a aplicação da função TRIM, isso indica que existem caracteres indesejados.

SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)


-- Caso o cst_gndr seja diferente do cst_gndr após a aplicação da função TRIM, isso indica que existem caracteres indesejados.

SELECT cst_gndr
FROM silver.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr)

-- Para checar a consistência dos valores de cst_gndr:

SELECT DISTINCT (cst_gndr)
FROM silver.crm_cust_info -- Com isso, identificamos que não existem mais valores nulos de gênero.


-- Para checar a consistência dos valores de cst_marital_status:

SELECT DISTINCT (cst_marital_status)
FROM silver.crm_cust_info -- Com isso, identificamos que não existem mais valores nulos de estado civil.



-- Para detectar valores de ID dos Produtos (Primary Key) duplicados:

SELECT 
prd_id AS 'ID do Produto',
COUNT (*) AS 'Total'
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT (*) > 1 OR prd_id IS NULL -- Com isso, não identificamos IDs duplicados ou nulos.


-- Para checar se existem espaços indesejados:

-- Caso o prd_name seja diferente do prd_name após a aplicação da função TRIM, isso indica que existem caracteres indesejados.

SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- Para checar se existem números negativos ou nulos:

SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL -- Com isso, não identificamos mais valores nulos de custo


-- Para checar se existem valores incorretos nas colunas de data:

SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt -- Com isso, não identificamos mais valores de prd_end_date mais recente que prd_start_date


-- Para checar se existem espaços indesejados:

SELECT sls_ord_num
FROM silver.crm_sales_details 
WHERE sls_ord_num != TRIM(sls_ord_num)

-- Para checar se existem valores incorretos nas colunas de data:

SELECT *
FROM silver.crm_sales_details
WHERE LEN(sls_order_dt) != 10 OR sls_order_dt IS NULL

SELECT *
FROM silver.crm_sales_details
WHERE LEN(sls_ship_dt) != 10 OR sls_order_dt IS NULL

SELECT *
FROM silver.crm_sales_details
WHERE LEN(sls_due_dt) != 10 OR sls_due_dt IS NULL


-- Para checar se existem números negativos ou nulos:

SELECT *
FROM silver.crm_sales_details
WHERE sls_sales IS NULL OR sls_sales <=0

SELECT *
FROM silver.crm_sales_details
WHERE sls_quantity IS NULL OR sls_quantity <=0

SELECT *
FROM silver.crm_sales_details
WHERE sls_price IS NULL OR sls_price <=0


SELECT 
sls_price,
sls_quantity,
sls_sales
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0 
ORDER BY sls_sales, sls_quantity, sls_price


-- Para checar se existem valores incorretos nas colunas de data:

SELECT bdate
FROM silver.erp_cust_az12
WHERE bdate > GETDATE() OR bdate < '1900-01-01'


-- Para checar a consistência dos valores de gênero:

SELECT DISTINCT gen
FROM silver.erp_cust_az12


-- Para checar a consistência dos países:

SELECT DISTINCT cntry
FROM silver.erp_loc_a101


