/* 

Tabela Dimensão - Tabela com uma grande quantidade de linhas, que representam os fatos (eventos) de uma empresa. Esses fatos podem se repetir ou não.
Tabela Dimensão - Tabela que auxilia a tabela fato com dados complementares ou explicativos. Essa tabela possui informações que não se repetem. 

As tabelas crm_prd_info e erp_px_cat_g1v2 apresentam informações sobre os produtos. 

As tabelas crm_cust_info, erp_cust_az12 e erp_loc_a101 apresentam informações sobre os clientes.

A tabela crm_sales_details apresenta informações sobre as vendas.

*/

-- Para criar a view gold.dim_customer:

SELECT 
CI.cst_id,
CI.cst_key,
CI.cst_firstname,
CI.cst_lastname,
CI.cst_marital_status,
CI.cst_gndr,
CI.cst_create_date,
CA.bdate,
CA.gen,
LA.cntry
FROM silver.crm_cust_info CI
LEFT JOIN silver.erp_cust_az12 CA
ON CI.cst_key = CA.cid
LEFT JOIN silver.erp_loc_a101 LA
ON CI.cst_key = LA.cid

-- A coluna dwh_create_date não será incluída, pois pertence apenas a camada Silver.

-- Integração dos dados das colunas de gênero:


SELECT DISTINCT
	CI.cst_gndr,
	CA.gen,
	CASE WHEN CI.cst_gndr != 'N/A' THEN CI.cst_gndr -- Dados CRM são mais precisos para a coluna 'gender. Por isso, caso ocorra diferença entre o gênero de um cliente nas tabelas CRM e ERP, o gênero da tabela CRM irá prevalecer.'
		 ELSE COALESCE(CA.gen, 'N/A') -- COALESCE é utilizada para fornecer uma valor substituto para uma coluna que contenha dados ausentes.
	END new_gen
FROM silver.crm_cust_info CI
LEFT JOIN silver.erp_cust_az12 CA
ON CI.cst_key = CA.cid
LEFT JOIN silver.erp_loc_a101 LA
ON CI.cst_key = LA.cid
ORDER BY 1,2


-- Renomeando as colunas, aplicando a integração das colunas de gênero e criando a view gold.dim_customer:

CREATE VIEW gold.dim_customer AS
SELECT 
ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key, --  Cria uma coluna de ID auxiliar. Primary Key
CI.cst_id AS customer_id,
CI.cst_key AS customer_number,
CI.cst_firstname AS first_name,
CI.cst_lastname AS last_name,
CI.cst_marital_status AS mariotal_status,
CASE WHEN CI.cst_gndr != 'N/A' THEN CI.cst_gndr -- Dados CRM são mais precisos para a coluna 'gender. Por isso, caso ocorra diferença entre o gênero de um cliente nas tabelas CRM e ERP, o gênero da tabela CRM irá prevalecer.'
		 ELSE COALESCE(CA.gen, 'N/A') -- COALESCE é utilizada para fornecer uma valor substituto para uma coluna que contenha dados ausentes.
	END gender,
LA.cntry AS country,
CA.bdate AS birthdate,
CI.cst_create_date AS create_date
FROM silver.crm_cust_info CI
LEFT JOIN silver.erp_cust_az12 CA
ON CI.cst_key = CA.cid
LEFT JOIN silver.erp_loc_a101 LA
ON CI.cst_key = LA.cid


-- Para criar a view gold.dim_product:

SELECT 
PN.prd_id,
PN.prd_key,
PN.prd_nm,
PN.cat_id,
PC.cat,
PC.subcat,
PN.prd_cost,
PN.prd_line,
PC.maintenance,
PN.prd_start_dt
FROM silver.crm_prd_info PN
LEFT JOIN silver.erp_px_cat_g1v2 PC
ON PN.cat_id = PC.id
WHERE prd_end_dt IS NULL -- Com isso, é um dado atual. Dessa forma, contém apenas produtos ativos.

-- Não foi necessário realizar integração dos dados, pois não possuiam colunas com as mesmas informações.


-- Renomeando as colunas e criando a view gold.dim_product:

CREATE VIEW gold.dim_product AS
SELECT
ROW_NUMBER() OVER (ORDER BY PN.prd_start_dt, PN.prd_key) AS product_key, --  Cria uma coluna de ID auxiliar. Primary Key
PN.prd_id AS product_id,
PN.prd_key AS product_number,
PN.prd_nm AS product_name,
PN.cat_id AS category_id,
PC.cat AS category,
PC.subcat AS subcategory,
PN.prd_cost AS product_cost,
PN.prd_line AS product_line,
PC.maintenance,
PN.prd_start_dt AS start_date 
FROM silver.crm_prd_info PN
LEFT JOIN silver.erp_px_cat_g1v2 PC
ON PN.cat_id = PC.id
WHERE prd_end_dt IS NULL
