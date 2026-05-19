/* Criando as tabelas do Banco de Dados:

Esse script tem como função criar seis tabelas dentro do Banco de Dados 'DataWareHouse'.
A nomenclatura adotada na criação das tabelas apresenta primeiramente a camada dos dados: 'bronze'. Em seguida, o nome apresenta a fonte dos dados: 'crm' ou 'erp' junto do nome exato dessa fonte. 
Exemplo: bronze.crm_cust_info, apresenta informações sobre os clientes obtidas da plataforma CRM.
/*

-- Criação da tabela com informação dos Clientes:


CREATE TABLE bronze.crm_cust_info (
cst_id INT,
cst_key NVARCHAR(40),
cst_firstname NVARCHAR(40),
cst_lastname NVARCHAR(40),
cst_marital_status NVARCHAR(30),
cst_gndr NVARCHAR(20),
cst_create_date DATE
);


-- Criação da tabela com informação dos Produtos:


CREATE TABLE bronze.crm_prd_info (
prd_id INT,
prd_key NVARCHAR(40),
prd_nm NVARCHAR(40),
prd_cost INT,
prd_line NVARCHAR(40),
prd_start_dt DATETIME,
prd_end_dt DATETIME
);


-- Criação da tabela com informação das Vendas:


CREATE TABLE bronze.crm_sales_details (
sls_ord_num NVARCHAR(40),
sls_prd_key NVARCHAR(40),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT
);


CREATE TABLE bronze.erp_loc_a101 (
cid NVARCHAR(40),
cntry NVARCHAR(40)
);


CREATE TABLE bronze.erp_cust_az12 (
cid NVARCHAR(40),
bdate DATE,
gen NVARCHAR(20)
);

CREATE TABLE bronze.erp_px_cat_g1v2 (
id NVARCHAR(40),
cat NVARCHAR(40),
subcat NVARCHAR(40),
maintenance NVARCHAR(20)
);
