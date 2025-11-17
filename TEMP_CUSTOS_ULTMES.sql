/*
-- =============================================
-- Autor: Diogo Gomes
-- Data: 2025-10-22
-- Descrição: View responsavel por capturar o custo gerencial do ultimo dia do mes e pegar o ultimo dia do mes atual
--            
-- =============================================
*/


  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PUBDB"."TEMP_CUSTO_ULTMES_V" ("DATA", "FILIAL", "ITEM", "LISTA", "CUSTO_REAIS", "CUSTO_ESTRANGEIRO", "CUSTO_SERV", "CUSTO_MATERIAL", "MOEDA", "CAMBIO", "ULT_PRODUZIDA", "DATA_ULT_PRODUCAO", "DATA_CUSTO") AS 
  WITH 
  custo2 AS (
    SELECT 
        MAX(CGUPMT) AS CGUPMT,
        TRIM(CGMCU) AS FILIAL,
        to_date((CGUPMJ + 1900000), 'YYYYDDD') AS DATA,
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
    INNER JOIN proddta.f4101 ON TRIM(CGKITL) = TRIM(IMLITM)
    WHERE TRIM(CGAA03) = 'M'
    GROUP BY 
        TRIM(CGMCU),
        to_date((CGUPMJ + 1900000), 'YYYYDDD'),
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
        CGCRR, 'N', '', CGUPMJ, CGCW02/10000, IMAITM, IMSRP5
  ),
  -- ====================================================================================
  -- CTE DE RANKING SIMPLIFICADA
  -- Apenas classifica os dias dentro do mês, do mais recente para o mais antigo.
  -- ====================================================================================
  custo_ranked AS (
    SELECT
      c2.*,
      ROW_NUMBER() OVER (
        PARTITION BY TRUNC(c2.DATA, 'MM'), c2.ITEM, c2.LISTA, c2.FILIAL
        ORDER BY
          c2.DATA DESC,
          c2.CGUPMT DESC
      ) as rn
    FROM custo2 c2
  )
SELECT
    DATA,
    FILIAL,
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
FROM custo_ranked
WHERE 
    FILIAL IN ('311000','111000')
    -- ====================================================================================
    -- LÓGICA DE FILTRO ATUALIZADA
    -- Condição 1: Pega se for do mês atual (todos os dias)
    -- Condição 2: OU Pega se for o ranking 1 (último dia de meses passados)
    -- ====================================================================================
    AND (
        TRUNC(DATA, 'MM') = TRUNC(SYSDATE, 'MM')
        OR
        rn = 1
    )

UNION ALL

SELECT
    DATA,
    FILIAL,
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
FROM custo_ranked A
WHERE 
    A.FILIAL IN ('111005','111002','611000','311002','612000','411000') 
    -- ====================================================================================
    -- LÓGICA DE FILTRO ATUALIZADA (aplicada aqui também)
    -- ====================================================================================
    AND (
        TRUNC(A.DATA, 'MM') = TRUNC(SYSDATE, 'MM')
        OR
        A.rn = 1
    )
    AND NOT EXISTS (
        SELECT 1 
        FROM custo_ranked B 
        WHERE A.ITEM = B.ITEM 
        AND A.LISTA = B.LISTA  
        AND B.FILIAL IN ('311000','111000')
        -- A lógica do NOT EXISTS também deve ser atualizada
        AND (TRUNC(B.DATA, 'MM') = TRUNC(SYSDATE, 'MM') OR B.rn = 1)
    );
