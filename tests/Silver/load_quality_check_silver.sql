

-- Para detectar valores de ID dos Clientes (Primary Key) duplicados:

SELECT 
cst_id AS 'ID do Cliente',
COUNT (*) AS 'Total'
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT (*) > 1 OR cst_id IS NULL

-- Para checar se existem espaços indesejados:

-- Caso o fisrtname seja diferente do firstname após a aplicação da função TRIM, isso indica que existem caracteres indesejados.

SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

-- Caso o lastname seja diferente do lastname após a aplicação da função TRIM, isso indica que existem caracteres indesejados.

SELECT cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

-- Para checar a consistência dos valores de cst_gndr:

SELECT DISTINCT (cst_gndr)
FROM bronze.crm_cust_info


