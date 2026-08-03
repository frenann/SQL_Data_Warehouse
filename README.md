# Data WareHouse Project

**📋 Visão Geral**

Este projeto tem como objetivo a construção de um Data Warehouse utilizando SQL Server, aplicando conceitos de Engenharia de Dados e Business Intelligence para transformar dados brutos em informações confiáveis e prontas para análise.

Nesse projeto, dados provenientes de sistemas ERP e CRM são integrados, tratados e modelados para apoiar a tomada de decisão estratégica.

Durante o desenvolvimento foram aplicados conceitos de ETL, arquitetura Medallion e modelagem dimensional.
<br>

**🏗️ Arquitetura da Solução**

O projeto foi desenvolvido seguindo a arquitetura Medallion, organizada em três camadas:
<br>
<br>
**🥉 Bronze Layer**

Camada responsável pela ingestão dos dados brutos.

Características:

- Dados armazenados sem transformações.
- Preservação da estrutura original das fontes.

<br>

**🥈 Silver Layer**

Camada destinada ao tratamento e padronização dos dados.

Transformações realizadas:

- Remoção de duplicidades.
- Tratamento de valores nulos.
- Padronização de formatos.
- Correção de inconsistências.
<br>

**🥇 Gold Layer**

Camada analítica destinada ao consumo por ferramentas de BI.

Componentes:

- Tabelas Dimensão
- Tabela Fato
- Modelo Star Schema
<br>

🔄 Pipeline de Dados

A documentação detalhada da pipeline, incluindo as etapas de carga, tratamento e modelagem dos dados, pode ser acessada no link abaixo:

[🔄**Pipeline de Dados**](docs/data_flow.png)

<br>

🔗**Projetos Relacionados**

Este projeto faz parte de uma iniciativa mais ampla de Engenharia e Análise de Dados.

Após a construção do Data Warehouse e da camada analítica, os dados foram utilizados em um projeto de Análise Exploratória de Dados (EDA), com o objetivo de identificar padrões, tendências e gerar insights de negócio relacionados a vendas, clientes e produtos.



➡️ [Projeto de Análise Exploratória](https://github.com/frenann/sql_data_analytics)


