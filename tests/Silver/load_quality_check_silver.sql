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

