-- =============================================
-- Autor: Diogo Gomes
-- Data: 2025-09-10
-- Descrição: VIEW para subsittuir antigo custo historico
--            
-- =============================================

/*
Este script foi desenvolvido para o departamento financeiro que alimenta os dashboards RealXOrçado, Analise vendas Marcos.
Não alterar sem autorização prévia do manager.
*/


CREATE OR REPLACE FORCE EDITIONABLE VIEW "PUBDB"."TEMP_HISTORICO_CUSTO_V" ("DATA", "ITEM", "LISTA", "CUSTO_REAIS", "CUSTO_ESTRANGEIRO", "CUSTO_SERV", "CUSTO_MATERIAL", "MOEDA", "CAMBIO", "ULT_PRODUZIDA", "DATA_ULT_PRODUCAO", "DATA_CUSTO") AS 

  WITH CUSTO2 AS (

    SELECT 

        MAX(CGUPMT) AS CGUPMT,

        TRIM(CGMCU) AS FILIAL,

        to_date((CGUPMJ + 1900000), 'YYYYDDD') AS DATA,

        -- LÓGICA AJUSTADA AQUI

        CASE 

            WHEN INSTR(TRIM(CGKITL), '.Q') > 0 THEN 

                SUBSTR(TRIM(CGKITL), 1, INSTR(TRIM(CGKITL), '.Q') - 1)

            ELSE 

                TRIM(CGKITL) 

        END AS ITEM,

        CASE 

            WHEN TRIM(IMSRP5) = 'EM' THEN 'EMB'

            WHEN TRIM(IMSRP5) = 'MP' THEN 'NET'

            ELSE to_char(CGTBM) 

        END AS LISTA,

        CGUNCS/10000 AS CUSTO_REAIS,

        CGFRRC/10000 AS CUSTO_ESTRANGEIRO,

        CGCW01/10000 AS CUSTO_SERV,

        TRIM(CGCRCD) AS MOEDA,

        CGCRR AS CAMBIO,

        'N' AS ULT_PRODUZIDA,

        '' AS DATA_ULT_PRODUCAO,

        CGUPMJ AS DATA_CUSTO,

        CGCW02/10000 AS CUSTO_MATERIAL

    FROM proddta.F5541054 

    INNER JOIN proddta.f4101 ON TRIM(CGKITL) = TRIM(IMAITM)

    WHERE TRIM(CGAA03) = 'M'

    GROUP BY 

        TRIM(CGMCU),

        to_date((CGUPMJ + 1900000), 'YYYYDDD'),

        -- E LÓGICA AJUSTADA AQUI TAMBÉM

        CASE 

            WHEN INSTR(TRIM(CGKITL), '.Q') > 0 THEN 

                SUBSTR(TRIM(CGKITL), 1, INSTR(TRIM(CGKITL), '.Q') - 1)

            ELSE 

                TRIM(CGKITL) 

        END,

        to_char(CGTBM),

        CGUNCS/10000,

        CGFRRC/10000,

        CGCW01/10000,

        TRIM(CGCRCD),

        CGCRR,

        'N',

        '',

        CGUPMJ,

        CGCW02/10000,

        IMAITM,

        IMSRP5

)

SELECT

    DATA,

    to_char(ITEM) AS ITEM,

    TO_CHAR(LISTA) AS LISTA,

    to_number(CUSTO_REAIS) AS CUSTO_REAIS,

    TO_NUMBER(CUSTO_ESTRANGEIRO) AS CUSTO_ESTRANGEIRO,

    TO_NUMBER(CUSTO_SERV) AS CUSTO_SERV,

    TO_NUMBER(CUSTO_MATERIAL) AS CUSTO_MATERIAL,

    TO_CHAR(MOEDA) AS MOEDA,

    TO_NUMBER(CAMBIO) AS CAMBIO,

    to_char(ULT_PRODUZIDA) AS ULT_PRODUZIDA,

    to_char(DATA_ULT_PRODUCAO) AS DATA_ULT_PRODUCAO,

    to_number(DATA_CUSTO) AS DATA_CUSTO 

FROM custo2 

WHERE FILIAL IN ('311000','111000')



UNION ALL



SELECT

    DATA,

    to_char(ITEM) AS ITEM,

    TO_CHAR(LISTA) AS LISTA,

    to_number(CUSTO_REAIS) AS CUSTO_REAIS,

    TO_NUMBER(CUSTO_ESTRANGEIRO) AS CUSTO_ESTRANGEIRO,

    TO_NUMBER(CUSTO_SERV) AS CUSTO_SERV,

    TO_NUMBER(CUSTO_MATERIAL) AS CUSTO_MATERIAL,

    TO_CHAR(MOEDA) AS MOEDA,

    TO_NUMBER(CAMBIO) AS CAMBIO,

    to_char(ULT_PRODUZIDA) AS ULT_PRODUZIDA,

    to_char(DATA_ULT_PRODUCAO) AS DATA_ULT_PRODUCAO,

    to_number(DATA_CUSTO) AS DATA_CUSTO

FROM custo2 A  

WHERE A.FILIAL IN ('111005','111002','611000') 

AND NOT EXISTS (

    SELECT 1 

    FROM custo2 B 

    WHERE A.ITEM = B.ITEM 

    AND A.LISTA = B.LISTA  

    AND B.FILIAL IN ('311000','111000')

);