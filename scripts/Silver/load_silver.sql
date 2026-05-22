/* - A Primary Key deve possuir um valor único e sem repetições dentre todas as linhas da coluna.
- A função TRIM remove espaços desnecessários no conjunto de dados.
- A função UPPER converte todos os caracteres da string para maiúsculos.
- A função ROW_NUMBER foi utilizada para selecionar os registros mais recentes dos clientes e dessa forma, remover os duplicados. 
*/


-- Para tratar os dados da camada Bronze e inserir na Silver:

-- Carregando os dados na tabela silver.crm_cust_info:

INSERT INTO silver.crm_cust_info (
cst_id, 
cst_key,
cst_firstname,
cst_lastname,
cst_marital_status,
cst_gndr,
cst_create_date
)

SELECT
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) as cst_lastname,
CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
	 WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
	 ELSE 'N/A'
END cst_marital_status, -- Altera o estado civil dos clientes para Single 'Solteiro' e Married 'Casado'. Além disso, adiciona o termo N/A no lugar do NULL.
CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
	 WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
	 ELSE 'N/A'
END cst_gndr, -- Altera o gênero dos clientes para Female 'Feminino' e Male 'Masculino'. Além disso, adiciona o termo N/A no lugar do NULL.
cst_create_date
FROM (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS created_last
FROM bronze.crm_cust_info
WHERE cst_id IS NOT NULL
) AS t 
WHERE created_last = 1 -- Seleciona o registro mais recente do Cliente.


-- Carregando os dados na tabela silver.crm_prd_info:

INSERT INTO silver.crm_prd_info (
prd_id, 
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
)
SELECT
prd_id,
REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id, -- Extrai os primeiros 5 caracteres da coluna 'prd_key' e substitui o '-' por '_'. Essas novas colunas serão utilizadas para realizar JOINS entre diferentes tabelas.
SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key, -- Extrai do sétimo até o último caractere da coluna 'prd_key'. Essas novas colunas serão utilizadas para realizar JOINS entre diferentes tabelas.
prd_nm,
ISNULL(prd_cost, 0) AS prd_cost,
CASE WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
	 WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
	 WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
	 WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
	 ELSE 'N/A'
END AS prd_line, -- Altera os valores de 'prod_line'.
CAST(prd_start_dt AS DATE) AS prd_start_dt, -- Altera o tipo de data de 'DATETIME' para 'DATE'.
CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt ASC)-1 AS DATE) AS prd_end_dt  -- Calcula a 'prd_end_date' como um dia antes do próximo prod_start_dt.
FROM bronze.crm_prd_info


-- Carregando os dados na tabela silver.crm_sales_details:

INSERT INTO silver.crm_sales_details (
sls_ord_num, 
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
)
SELECT
sls_ord_num, 
sls_prd_key,
sls_cust_id,
CASE WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL -- A função LEN calcula quantos caracteres os dados possuem.
	 ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
END sls_order_dt,
CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE) AS sls_ship_dt, -- não é possível converter diretamente de INT para DATE. Por isso é necessário converter de INT para VARCHAR e em seguida, converter de VARCHAR para DATE.
CAST(CAST(sls_due_dt AS VARCHAR) AS DATE) AS sls_due_dt,
CASE WHEN sls_sales <= 0 OR sls_sales IS NULL OR sls_sales != sls_quantity * ABS(sls_price) 
		THEN sls_quantity * ABS(sls_price) -- Função ABS é responsável por transformar todo valor negativo em positivo
	 ELSE sls_sales 
END sls_sales,
sls_quantity,
CASE WHEN sls_price = 0 OR sls_price IS NULL THEN sls_sales / NULLIF(sls_quantity, 0) -- Função NULLIF utilizada para que não ocorra uma divisão por 0.
	 ELSE sls_price 
END sls_price
FROM bronze.crm_sales_details




INSERT INTO silver.erp_cust_az12 (
cid,
bdate,
gen
)
SELECT
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid)) -- Extrai todos os caracteres da coluna 'cid' a partir do quarto. 
	 ELSE cid
END cid,
CASE WHEN bdate > GETDATE() THEN NULL -- Altera as datas de nascimento 'bdate' no "futuro" para valores nulos.
	 ELSE bdate
END bdate,	
CASE WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
	 WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
	 ELSE 'N/A'
END gen -- -- Altera o gênero dos clientes para Female 'Feminino' e Male 'Masculino'. Além disso, adiciona o termo N/A no lugar do NULL.
FROM bronze.erp_cust_az12


