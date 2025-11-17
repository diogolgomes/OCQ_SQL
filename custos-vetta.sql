WITH PRIMEIRA AS (
-- Seleciona as colunas IOLOTN (número do lote), IOITM (número do item) e o menor valor de IOOHDJ (data de disponibilidade do estoque)
SELECT 
    IOLOTN,          -- Número do lote
    IOITM,           -- Número do item
    MIN(IOOHDJ) AS IOOHDJ  -- Menor data de disponibilidade do estoque (usando a função MIN para agregação)
    
-- Especifica a tabela de origem dos dados, que é a tabela F4108 no esquema PRODDTA
FROM proddta.f4108 -- Tabela F4108 (tabela de estoque por lote no JDE)
WHERE 
    IOOHDJ > 0        -- Considera apenas registros onde a data de disponibilidade é válida (maior que 0)
    
-- Agrupa os resultados pelo número do lote (IOLOTN) e pelo número do item (IOITM)
GROUP BY 
    IOLOTN,          -- Agrupa pelo número do lote
    IOITM            -- Agrupa pelo número do item


), CUSTO AS (

-- Seleciona as colunas: segmento do item (IMSEG1), data, descrição do item (IMDSC1) e custo em reais (CUSTO_REAIS)
SELECT  
    TRIM(A.IMSEG1) AS SEG,                -- Remove espaços em branco do segmento do item (IMSEG1) e renomeia como SEG
    B.DATA,                               -- Data do histórico de custo
    TRIM(A.IMDSC1) AS DESCRICAO_ITEM,     -- Remove espaços em branco da descrição do item (IMDSC1) e renomeia como DESCRICAO_ITEM
    TO_NUMBER(B.CUSTO_REAIS) AS CUSTO      -- Converte o custo em reais (CUSTO_REAIS) para um número e renomeia como CUSTO

-- Especifica as tabelas de origem dos dados: F4101 (tabela de itens) e TEMP_HISTORICO_CUSTO (tabela temporária de histórico de custos)
FROM 
    PRODDTA.F4101 A                       -- Tabela F4101 (tabela de itens no JDE), apelidada como "A"
    INNER JOIN PRODDTA.TEMP_HISTORICO_CUSTO B  -- Junção com a tabela TEMP_HISTORICO_CUSTO, apelidada como "B"
    ON TRIM(B.ITEM) = TRIM(A.IMLITM)      -- Condição de junção: o item na tabela B deve corresponder ao item na tabela A (IMLITM), removendo espaços em branco
    AND TO_CHAR(B.DATA, 'DD/MM/YYYY') = TO_CHAR(SYSDATE-1 , 'DD/MM/YYYY')  -- A data na tabela B deve corresponder à data fornecida como parâmetro (:DATA)

-- Filtra os registros com base em condições específicas
WHERE  
    INSTR(TRIM(A.IMLITM), '.') = '0'      -- Verifica se o item (IMLITM) não contém um ponto (.) em sua descrição
    AND TRIM(B.LISTA) = 'NET'             -- Filtra apenas os registros onde a lista na tabela B é igual a 'NET' (removendo espaços em branco)
    AND B.CUSTO_REAIS IS NOT NULL        -- Filtra apenas os registros onde o custo em reais (CUSTO_REAIS) não é nulo

UNION ALL


-- Seleciona os campos que serão retornados pela query
SELECT  
    TRIM(A.IMSEG1) SEG, -- Remove espaços em branco do campo IMSEG1 da tabela A e renomeia para SEG
    B.DATA, -- Seleciona o campo DATA da tabela B
    TRIM(A.IMDSC1) AS DESCRICAO_ITEM, -- Remove espaços em branco do campo IMDSC1 da tabela A e renomeia para DESCRICAO_ITEM
    TO_NUMBER(B.CUSTO_REAIS) AS CUSTO -- Converte o campo CUSTO_REAIS da tabela B para número e renomeia para CUSTO

-- Especifica as tabelas envolvidas na consulta
FROM PRODDTA.F4101 A -- Tabela F4101 (provavelmente a tabela de itens no JDE), apelidada como A
INNER JOIN PRODDTA.TEMP_HISTORICO_CUSTO B  -- Faz um JOIN com a tabela TEMP_HISTORICO_CUSTO, apelidada como B
    ON TRIM(B.ITEM) = TRIM(A.IMLITM) -- Condição de JOIN: o campo ITEM da tabela B (após remoção de espaços) deve ser igual ao campo IMLITM da tabela A (também sem espaços)
    AND TO_CHAR(B.DATA,'DD/MM/YYYY')  = TO_CHAR(SYSDATE-1 , 'DD/MM/YYYY')   -- Além disso, a data no campo DATA da tabela B deve ser igual à data fornecida como parâmetro (:DATA), ambas formatadas como 'DD/MM/YYYY'

-- Filtros adicionais para a consulta
WHERE  
    INSTR(TRIM(A.IMLITM),'.') = '0' -- Verifica se o campo IMLITM da tabela A (sem espaços) não contém o caractere '.' (ponto). INSTR retorna a posição do caractere, e se for 0, significa que o caractere não existe.
    AND TRIM(B.LISTA) = 'M' -- Filtra apenas os registros onde o campo LISTA da tabela B (sem espaços) é igual a 'M'
    AND B.CUSTO_REAIS IS NOT NULL -- Filtra apenas os registros onde o campo CUSTO_REAIS da tabela B não é nulo

UNION ALL 

-- Seleciona os campos que serão retornados pela query
SELECT  
    TRIM(A.IMSEG1) SEG, -- Remove espaços em branco do campo IMSEG1 da tabela A e renomeia para SEG
    B.DATA, -- Seleciona o campo DATA da tabela B
    TRIM(A.IMDSC1) AS DESCRICAO_ITEM, -- Remove espaços em branco do campo IMDSC1 da tabela A e renomeia para DESCRICAO_ITEM
    TO_NUMBER(B.CUSTO_REAIS) AS CUSTO -- Converte o campo CUSTO_REAIS da tabela B para número e renomeia para CUSTO

-- Especifica as tabelas envolvidas na consulta
FROM PRODDTA.F4101 A -- Tabela F4101 (tabela de itens no JDE), apelidada como A
INNER JOIN PRODDTA.TEMP_HISTORICO_CUSTO B -- Faz um JOIN com a tabela TEMP_HISTORICO_CUSTO, apelidada como B
    ON TRIM(B.ITEM) = TRIM(A.IMLITM) -- Condição de JOIN: o campo ITEM da tabela B (sem espaços) deve ser igual ao campo IMLITM da tabela A (também sem espaços)
    AND TO_CHAR(B.DATA,'DD/MM/YYYY')  = TO_CHAR(SYSDATE-1 , 'DD/MM/YYYY')   -- Além disso, a data no campo DATA da tabela B deve ser igual à data fornecida como parâmetro (:DATA), ambas formatadas como 'DD/MM/YYYY'

-- Filtros adicionais para a consulta
WHERE  
    INSTR(TRIM(A.IMLITM),'.') = '0' -- Verifica se o campo IMLITM da tabela A (sem espaços) não contém o caractere '.' (ponto). INSTR retorna a posição do caractere, e se for 0, significa que o caractere não existe.
    AND TRIM(B.LISTA) = 'AT1' -- Filtra apenas os registros onde o campo LISTA da tabela B (sem espaços) é igual a 'AT1'
    AND B.CUSTO_REAIS IS NOT NULL -- Filtra apenas os registros onde o campo CUSTO_REAIS da tabela B não é nulo
    AND NOT EXISTS ( -- Adiciona uma condição que exclui registros caso exista um registro correspondente na subconsulta
        SELECT * 
        FROM PRODDTA.TEMP_HISTORICO_CUSTO C -- Subconsulta que verifica a tabela TEMP_HISTORICO_CUSTO, apelidada como C
        WHERE 
            TRIM(B.ITEM) = TRIM(C.ITEM) -- O campo ITEM da tabela B deve ser igual ao campo ITEM da tabela C (ambos sem espaços)
            AND (TRIM(C.LISTA) = 'M') -- O campo LISTA da tabela C deve ser igual a 'M' (sem espaços)
            AND TO_CHAR(C.DATA , 'DD/MM/YYYY') = TO_CHAR(SYSDATE-1 , 'DD/MM/YYYY')   -- A data no campo DATA da tabela C deve ser igual à data fornecida como parâmetro (:DATA), ambas formatadas como 'DD/MM/YYYY'
    )



UNION ALL 

-- Seleciona os campos que serão retornados pela query
SELECT  
    TRIM(A.IMSEG1) SEG, -- Remove espaços em branco do campo IMSEG1 da tabela A e renomeia para SEG
    B.DATA, -- Seleciona o campo DATA da tabela B
    TRIM(A.IMDSC1) AS DESCRICAO_ITEM, -- Remove espaços em branco do campo IMDSC1 da tabela A e renomeia para DESCRICAO_ITEM
    TO_NUMBER(B.CUSTO_REAIS) AS CUSTO -- Converte o campo CUSTO_REAIS da tabela B para número e renomeia para CUSTO

-- Especifica as tabelas envolvidas na consulta
FROM PRODDTA.F4101 A -- Tabela F4101 (tabela de itens no JDE), apelidada como A
INNER JOIN PRODDTA.TEMP_HISTORICO_CUSTO B -- Faz um JOIN com a tabela TEMP_HISTORICO_CUSTO, apelidada como B
    ON TRIM(B.ITEM) = TRIM(A.IMLITM) -- Condição de JOIN: o campo ITEM da tabela B (sem espaços) deve ser igual ao campo IMLITM da tabela A (também sem espaços)
    AND TO_CHAR(B.DATA,'DD/MM/YYYY')  = TO_CHAR(SYSDATE-1 , 'DD/MM/YYYY')   -- Além disso, a data no campo DATA da tabela B deve ser igual à data fornecida como parâmetro (:DATA), ambas formatadas como 'DD/MM/YYYY'

-- Filtros adicionais para a consulta
WHERE  
    INSTR(TRIM(A.IMLITM),'.') = '0' -- Verifica se o campo IMLITM da tabela A (sem espaços) não contém o caractere '.' (ponto). INSTR retorna a posição do caractere, e se for 0, significa que o caractere não existe.
    AND TRIM(B.LISTA) = 'AT2' -- Filtra apenas os registros onde o campo LISTA da tabela B (sem espaços) é igual a 'AT2'
    AND B.CUSTO_REAIS IS NOT NULL -- Filtra apenas os registros onde o campo CUSTO_REAIS da tabela B não é nulo
    AND NOT EXISTS ( -- Adiciona uma condição que exclui registros caso exista um registro correspondente na subconsulta
        SELECT * 
        FROM PRODDTA.TEMP_HISTORICO_CUSTO C -- Subconsulta que verifica a tabela TEMP_HISTORICO_CUSTO, apelidada como C
        WHERE 
            TRIM(B.ITEM) = TRIM(C.ITEM) -- O campo ITEM da tabela B deve ser igual ao campo ITEM da tabela C (ambos sem espaços)
            AND (TRIM(C.LISTA) = 'M' OR TRIM(C.LISTA) = 'AT1') -- O campo LISTA da tabela C deve ser igual a 'M' ou 'AT1' (sem espaços)
            AND TO_CHAR(C.DATA , 'DD/MM/YYYY') = TO_CHAR(SYSDATE-1 , 'DD/MM/YYYY')   -- A data no campo DATA da tabela C deve ser igual à data fornecida como parâmetro (:DATA), ambas formatadas como 'DD/MM/YYYY'
    )


UNION ALL 

-- Seleciona os campos que serão retornados pela query
SELECT  
    TRIM(A.IMSEG1) SEG, -- Remove espaços em branco do campo IMSEG1 da tabela A e renomeia para SEG
    B.DATA, -- Seleciona o campo DATA da tabela B
    TRIM(A.IMDSC1) AS DESCRICAO_ITEM, -- Remove espaços em branco do campo IMDSC1 da tabela A e renomeia para DESCRICAO_ITEM
    TO_NUMBER(B.CUSTO_REAIS) AS CUSTO -- Converte o campo CUSTO_REAIS da tabela B para número e renomeia para CUSTO

-- Especifica as tabelas envolvidas na consulta
FROM PRODDTA.F4101 A -- Tabela F4101 (tabela de itens no JDE), apelidada como A
INNER JOIN PRODDTA.TEMP_HISTORICO_CUSTO B -- Faz um JOIN com a tabela TEMP_HISTORICO_CUSTO, apelidada como B
    ON TRIM(B.ITEM) = TRIM(A.IMLITM) -- Condição de JOIN: o campo ITEM da tabela B (sem espaços) deve ser igual ao campo IMLITM da tabela A (também sem espaços)
    AND TO_CHAR(B.DATA,'DD/MM/YYYY')  = TO_CHAR(SYSDATE-1 , 'DD/MM/YYYY')  -- Além disso, a data no campo DATA da tabela B deve ser igual à data fornecida como parâmetro (:DATA), ambas formatadas como 'DD/MM/YYYY'

-- Filtros adicionais para a consulta
WHERE  
    INSTR(TRIM(A.IMLITM),'.') = '0' -- Verifica se o campo IMLITM da tabela A (sem espaços) não contém o caractere '.' (ponto). INSTR retorna a posição do caractere, e se for 0, significa que o caractere não existe.
    AND TRIM(B.LISTA) = 'AT3' -- Filtra apenas os registros onde o campo LISTA da tabela B (sem espaços) é igual a 'AT3'
    AND B.CUSTO_REAIS IS NOT NULL -- Filtra apenas os registros onde o campo CUSTO_REAIS da tabela B não é nulo
    AND NOT EXISTS ( -- Adiciona uma condição que exclui registros caso exista um registro correspondente na subconsulta
        SELECT * 
        FROM PRODDTA.TEMP_HISTORICO_CUSTO C -- Subconsulta que verifica a tabela TEMP_HISTORICO_CUSTO, apelidada como C
        WHERE 
            TRIM(B.ITEM) = TRIM(C.ITEM) -- O campo ITEM da tabela B deve ser igual ao campo ITEM da tabela C (ambos sem espaços)
            AND (TRIM(C.LISTA) = 'M' OR TRIM(C.LISTA) = 'AT1' OR TRIM(C.LISTA) = 'AT2') -- O campo LISTA da tabela C deve ser igual a 'M', 'AT1' ou 'AT2' (sem espaços)
            AND TO_CHAR(C.DATA , 'DD/MM/YYYY') = TO_CHAR(SYSDATE-1 , 'DD/MM/YYYY')  -- A data no campo DATA da tabela C deve ser igual à data fornecida como parâmetro (:DATA), ambas formatadas como 'DD/MM/YYYY'
    )


UNION ALL 

-- Seleciona os campos que serão retornados pela query
SELECT  
    TRIM(A.IMSEG1) SEG, -- Remove espaços em branco do campo IMSEG1 da tabela A e renomeia para SEG
    B.DATA, -- Seleciona o campo DATA da tabela B
    TRIM(A.IMDSC1) AS DESCRICAO_ITEM, -- Remove espaços em branco do campo IMDSC1 da tabela A e renomeia para DESCRICAO_ITEM
    TO_NUMBER(B.CUSTO_REAIS) AS CUSTO -- Converte o campo CUSTO_REAIS da tabela B para número e renomeia para CUSTO

-- Especifica as tabelas envolvidas na consulta
FROM PRODDTA.F4101 A -- Tabela F4101 (tabela de itens no JDE), apelidada como A
INNER JOIN PRODDTA.TEMP_HISTORICO_CUSTO B -- Faz um JOIN com a tabela TEMP_HISTORICO_CUSTO, apelidada como B
    ON TRIM(B.ITEM) = TRIM(A.IMLITM) -- Condição de JOIN: o campo ITEM da tabela B (sem espaços) deve ser igual ao campo IMLITM da tabela A (também sem espaços)
    AND TO_CHAR(B.DATA,'DD/MM/YYYY')  = TO_CHAR(SYSDATE-1 , 'DD/MM/YYYY')   -- Além disso, a data no campo DATA da tabela B deve ser igual à data fornecida como parâmetro (:DATA), ambas formatadas como 'DD/MM/YYYY'

-- Filtros adicionais para a consulta
WHERE  
    INSTR(TRIM(A.IMLITM),'.') = '0' -- Verifica se o campo IMLITM da tabela A (sem espaços) não contém o caractere '.' (ponto). INSTR retorna a posição do caractere, e se for 0, significa que o caractere não existe.
    AND TRIM(B.LISTA) = 'AT4' -- Filtra apenas os registros onde o campo LISTA da tabela B (sem espaços) é igual a 'AT4'
    AND B.CUSTO_REAIS IS NOT NULL -- Filtra apenas os registros onde o campo CUSTO_REAIS da tabela B não é nulo
    AND NOT EXISTS ( -- Adiciona uma condição que exclui registros caso exista um registro correspondente na subconsulta
        SELECT * 
        FROM PRODDTA.TEMP_HISTORICO_CUSTO C -- Subconsulta que verifica a tabela TEMP_HISTORICO_CUSTO, apelidada como C
        WHERE 
            TRIM(B.ITEM) = TRIM(C.ITEM) -- O campo ITEM da tabela B deve ser igual ao campo ITEM da tabela C (ambos sem espaços)
            AND (TRIM(C.LISTA) = 'M' OR TRIM(C.LISTA) = 'AT1' OR TRIM(C.LISTA) = 'AT2' OR TRIM(C.LISTA) = 'AT3') -- O campo LISTA da tabela C deve ser igual a 'M', 'AT1', 'AT2' ou 'AT3' (sem espaços)
            AND TO_CHAR(C.DATA , 'DD/MM/YYYY') = TO_CHAR(SYSDATE-1 , 'DD/MM/YYYY')   -- A data no campo DATA da tabela C deve ser igual à data fornecida como parâmetro (:DATA), ambas formatadas como 'DD/MM/YYYY'
    )


)

SELECT 
TRIM(ILLITM)||TRIM(ILLOTN)||TRIM(ILMCU) CONCAT,
IMSRP1 CLASSE,
TRIM(S1.DRDL01) CLASSE_LEG,
IMSRP2 SUB_CLASSE,
TRIM(S2.DRDL01) SUBCLASSE_LEG,
TRIM(ILMCU) FILIAL,
TRIM(ILLITM) COD, 
TRIM(IMDSC1) AS DSC,
TRIM(ILLOTN) LOTE,


SUM(nvl(DECODE(ILTRUM,IMUOM1,(ILTRQT)/10000,DECODE(C.UMCONV,0,1,(C.UMCONV/10000000)*(ILTRQT)/10000)),(ILTRQT)/10000) ) QTD,
CASE WHEN IOOHDJ != 0 THEN TO_CHAR(TO_DATE((IOOHDJ+1900000), 'YYYYDDD'), 'DD/MM/YYYY') 
ELSE '01/01/1990'
END DATA_EXISTENTE,
TO_CHAR((SYSDATE-1), 'DD/MM/YYYY') DATA_CORTE,

CASE
WHEN TO_DATE(TO_CHAR((SYSDATE-1), 'DD/MM/YYYY'))   -TO_DATE((IOOHDJ+1900000), 'YYYYDDD')<=60 THEN 0
ELSE TO_DATE(TO_CHAR((SYSDATE-1), 'DD/MM/YYYY'))   -TO_DATE((IOOHDJ+1900000), 'YYYYDDD')
END  SESSENTA
,NVL(CUSTO,0) CUSTO

FROM PRODDTA.F4111 
INNER JOIN PRODDTA.F4101 ON IMLITM=ILLITM
LEFT OUTER JOIN PRODDTA.F41002 C ON IMITM = C.UMITM AND ILTRUM = C.UMUM AND IMUOM1 = C.UMRUM
LEFT JOIN PRODCTL.F0005 S1 ON TRIM(S1.DRSY)='41' AND S1.DRRT='S1' AND TRIM(S1.DRKY)=TRIM(IMSRP1)
LEFT JOIN PRODCTL.F0005 S2 ON TRIM(S2.DRSY)='41' AND S2.DRRT='S2' AND TRIM(S2.DRKY)=TRIM(IMSRP2)
LEFT JOIN PRIMEIRA ON IOLOTN=ILLOTN AND IOITM=ILITM
LEFT JOIN CUSTO ON SEG=TRIM(imseg1)

WHERE 

NVL(TRIM(ILIPCD),'S')!='X'
AND ILDGL<=TO_NUMBER(TO_CHAR((SYSDATE-1), 'YYYYDDD'))-1900000
--AND TRIM(ILLITM)='CHU' AND RTRIM(ILLOTN)='142888'
AND IOOHDJ>0
GROUP BY 
IMSRP1 ,
TRIM(S1.DRDL01) ,
IMSRP2 ,
TRIM(S2.DRDL01) ,
TRIM(ILMCU) ,
TRIM(ILLITM) , 
TRIM(IMDSC1) ,
TRIM(ILLOTN) ,
TO_CHAR(TO_DATE((IOOHDJ+1900000), 'YYYYDDD'), 'DD/MM/YYYY'),


TO_CHAR((SYSDATE-1), 'DD/MM/YYYY') ,

CASE
WHEN TO_DATE(TO_CHAR((SYSDATE-1), 'DD/MM/YYYY'))   -TO_DATE((IOOHDJ+1900000), 'YYYYDDD')<=60 THEN 0
ELSE TO_DATE(TO_CHAR((SYSDATE-1), 'DD/MM/YYYY'))   -TO_DATE((IOOHDJ+1900000), 'YYYYDDD')
END,


CUSTO;
