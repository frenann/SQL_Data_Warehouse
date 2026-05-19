/* Criando o Banco de Dados e Schemas:

Esse script tem como função criar o Banco de Dados 'DataWareHouse' e três schemas dentro dele: 'bronze', 'silver' e 'gold'.

/*


-- Criando o Banco de Dados 'DataWareHouse':

USE master

CREATE DATABASE DataWareHouse

USE DataWareHouse

-- Criando Schemas:

CREATE SCHEMA bronze

CREATE SCHEMA silver

CREATE SCHEMA gold
