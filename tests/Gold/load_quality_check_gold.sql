-- Checando a relação da tabela fato com as tabelas dimensão e a qualidade da chave primária:

SELECT *
FROM gold.fact_sales FS
LEFT JOIN gold.dim_customer DC
ON FS.customer_key = DC.customer_key
WHERE DC.customer_key IS NULL


SELECT *
FROM gold.fact_sales FS
LEFT JOIN gold.dim_product DP
ON FS.product_key = DP.product_key
WHERE DP.product_key IS NULL
