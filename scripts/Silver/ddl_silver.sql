/* Criando as tabelas do Banco de Dados:

Esse script tem como função criar seis tabelas dentro do Banco de Dados 'DataWareHouse'.
A nomenclatura adotada na criação das tabelas apresenta primeiramente a camada dos dados: 'silver'. Em seguida, o nome apresenta a fonte dos dados: 'crm' ou 'erp' junto do nome exato dessa fonte. 
Exemplo: silver.crm_cust_info, apresenta informações sobre os clientes obtidas da plataforma CRM.

*/

-- Criação da tabela com informação dos Clientes:


CREATE TABLE silver.crm_cust_info (
cst_id INT,
cst_key NVARCHAR(40),
cst_firstname NVARCHAR(40),
cst_lastname NVARCHAR(40),
cst_marital_status NVARCHAR(30),
cst_gndr NVARCHAR(20),
cst_create_date DATE,
dwh_create_date DATETIME2 DEFAULT GETDATE()
);


-- Criação da tabela com informação dos Produtos:


CREATE TABLE silver.crm_prd_info (
prd_id INT,
cat_id NVARCHAR(40),
prd_key NVARCHAR(40),
prd_nm NVARCHAR(40),
prd_cost INT,
prd_line NVARCHAR(40),
prd_start_dt DATE,
prd_end_dt DATE,
dwh_create_date DATETIME2 DEFAULT GETDATE()
);


-- Criação da tabela com informação das Vendas:


CREATE TABLE silver.crm_sales_details (
sls_ord_num NVARCHAR(40),
sls_prd_key NVARCHAR(40),
sls_cust_id INT,
sls_order_dt DATE,
sls_ship_dt DATE,
sls_due_dt DATE,
sls_sales INT,
sls_quantity INT,
sls_price INT,
dwh_create_date DATETIME2 DEFAULT GETDATE()
);


CREATE TABLE silver.erp_loc_a101 (
cid NVARCHAR(40),
cntry NVARCHAR(40),
dwh_create_date DATETIME2 DEFAULT GETDATE()
);


CREATE TABLE silver.erp_cust_az12 (
cid NVARCHAR(40),
bdate DATE,
gen NVARCHAR(20),
dwh_create_date DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE silver.erp_px_cat_g1v2 (
id NVARCHAR(40),
cat NVARCHAR(40),
subcat NVARCHAR(40),
maintenance NVARCHAR(20),
dwh_create_date DATETIME2 DEFAULT GETDATE()
);
