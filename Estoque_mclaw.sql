-- =============================================================================================
-- OBJETIVO DA CONSULTA:
-- Levantar a posição de estoque atual de itens classificados como Matéria-Prima (MP).
-- A consulta une os resultados de duas origens de estoque diferentes:
--   1. Itens em um local específico (LIKE '3767%').
--   2. Itens em filiais específicas ('191000V304', '191000V305').
-- O estoque é valorizado por dois custos: Gerencial (Ledger 43) e Contábil (Padrão 'I').
-- =============================================================================================

-- Início do primeiro bloco de seleção (filtro por Localização)
SELECT
    TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI') AS ATUALIZACAO,        -- Carimbo de data e hora de quando a consulta foi executada.
    TRIM(A.imlitm) AS COD,                                        -- Código completo (ID Longo) do item físico em estoque.
    TRIM(A.IMSEG1) AS SEGMENTO,                                   -- Código "base" ou "raiz" do item, usado para agrupar e buscar descrições/custos.
    TRIM(B.IMDSC1) AS DESCRICAO,                                  -- Descrição do item "base".
    TRIM(LIMCU) AS FILIAL,                                        -- Código da Filial/Unidade de Negócio onde o item está estocado.
    TRIM(MCDL01) AS FILIAL2,                                      -- Nome descritivo da Filial.
    SUM(LIPQOH / 10000) AS QTD,                                   -- Soma da quantidade em estoque, com ajuste de 4 casas decimais.
    SUM((LIPQOH / 10000) * NVL(G.COUNCS / 10000, 0)) AS GERENCIAL_TOTAL, -- Valor total do estoque (Quantidade x Custo Gerencial).
    B.IMUOM1 AS UM,                                               -- Unidade de medida primária do item "base".
    NVL(G.COUNCS / 10000, 0) AS GERENCIAL_UNIT,                    -- Custo unitário Gerencial (Ledger '43'), com ajuste de 4 casas decimais.
    NVL(C.COUNCS / 10000, 0) AS CONTABIL_UNIT,                     -- Custo unitário Contábil (Padrão 'I'), com ajuste de 4 casas decimais.
    TRIM(S1.DRDL01) AS CLASSE_LEG,                                 -- Descrição da Categoria de Planejamento 1 (SRP1) do item "base".
    TRIM(S2.DRDL01) AS SUB_CLASSE_LEG                              -- Descrição da Categoria de Planejamento 2 (SRP2) do item "base".

-- Definição das tabelas e seus relacionamentos
FROM PRODDTA.F41021 -- Tabela principal com os saldos de estoque atuais por item e local.
    INNER JOIN PRODDTA.F4101 A ON A.IMITM = LIITM                               -- Busca os dados mestres do item em estoque (para obter o campo IMSEG1).
    INNER JOIN PRODDTA.F4101 B ON TRIM(A.IMSEG1) = TRIM(B.IMLITM)                -- Mapeia o item em estoque (A) ao seu item "base" (B) através do campo IMSEG1.
    INNER JOIN PRODDTA.F0006 ON TRIM(MCMCU) = TRIM(LIMCU)                        -- Busca o nome da Filial.
    LEFT JOIN PRODDTA.F4105 G ON TRIM(G.COMCU) = '111000' AND G.COLEDG = '43' AND G.COLITM = B.IMLITM -- Busca o custo Gerencial (Ledger '43') do item "base" na filial 111000.
    LEFT JOIN PRODDTA.F4105 C ON TRIM(C.COMCU) = '111000' AND C.COCSIN = 'I' AND C.COLITM = B.IMLITM  -- Busca o custo Contábil padrão ('I') do item "base" na filial 111000.
    LEFT JOIN PRODCTL.F0005 S1 ON TRIM(S1.DRSY) = '41' AND TRIM(S1.DRRT) = 'P1' AND TRIM(S1.DRKY) = TRIM(B.IMSRP1) -- Busca a descrição da Classe (SRP1).
    LEFT JOIN PRODCTL.F0005 S2 ON TRIM(S2.DRSY) = '41' AND TRIM(S2.DRRT) = 'P2' AND TRIM(S2.DRKY) = TRIM(B.IMSRP2) -- Busca a descrição da Sub-Classe (SRP2).

-- Definição dos filtros de dados
WHERE
    LIPQOH != 0                 -- Considera apenas itens que possuem saldo em estoque.
    AND B.IMSRP5 = 'MP'           -- Filtra para que apenas itens "base" classificados como Matéria-Prima ('MP') sejam exibidos.
    AND B.IMSTKT != 'O'         -- Exclui itens "base" classificados como Obsoletos ('O').
    AND TRIM(LILOCN) LIKE '3767%' -- Filtro específico deste bloco: busca itens em localizações que começam com '3767'.

-- Agrupamento dos resultados para permitir as funções de soma (SUM)
GROUP BY
    TRIM(A.IMSEG1), TRIM(LIMCU), TRIM(MCDL01), NVL(G.COUNCS / 10000, 0), NVL(C.COUNCS / 10000, 0), B.IMUOM1, TRIM(B.IMDSC1),
    TRIM(S1.DRDL01), TRIM(S2.DRDL01), TRIM(A.imlitm)

UNION ALL -- Combina os resultados do bloco acima com o bloco abaixo, sem remover duplicatas.

-- Início do segundo bloco de seleção (filtro por Filial)
-- A estrutura deste bloco é idêntica à anterior, mudando apenas o filtro principal no WHERE.
SELECT
    TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI') AS ATUALIZACAO,
    TRIM(A.imlitm) AS COD,
    TRIM(A.IMSEG1) AS SEGMENTO,
    TRIM(B.IMDSC1) AS DESCRICAO,
    TRIM(LIMCU) AS FILIAL,
    TRIM(MCDL01) AS FILIAL2,
    SUM(LIPQOH / 10000) AS QTD,
    SUM((LIPQOH / 10000) * NVL(G.COUNCS / 10000, 0)) AS GERENCIAL_TOTAL,
    B.IMUOM1 AS UM,
    NVL(G.COUNCS / 10000, 0) AS GERENCIAL_UNIT,
    NVL(C.COUNCS / 10000, 0) AS CONTABIL_UNIT,
    TRIM(S1.DRDL01) AS CLASSE_LEG,
    TRIM(S2.DRDL01) AS SUB_CLASSE_LEG
FROM PRODDTA.F41021
    INNER JOIN PRODDTA.F4101 A ON A.IMITM = LIITM
    INNER JOIN PRODDTA.F4101 B ON TRIM(A.IMSEG1) = TRIM(B.IMLITM)
    INNER JOIN PRODDTA.F0006 ON TRIM(MCMCU) = TRIM(LIMCU)
    LEFT JOIN PRODDTA.F4105 G ON TRIM(G.COMCU) = '111000' AND G.COLEDG = '43' AND G.COLITM = B.IMLITM
    LEFT JOIN PRODDTA.F4105 C ON TRIM(C.COMCU) = '111000' AND C.COCSIN = 'I' AND C.COLITM = B.IMLITM
    LEFT JOIN PRODCTL.F0005 S1 ON TRIM(S1.DRSY) = '41' AND TRIM(S1.DRRT) = 'P1' AND TRIM(S1.DRKY) = TRIM(B.IMSRP1)
    LEFT JOIN PRODCTL.F0005 S2 ON TRIM(S2.DRSY) = '41' AND TRIM(S2.DRRT) = 'P2' AND TRIM(S2.DRKY) = TRIM(B.IMSRP2)
WHERE
    LIPQOH != 0
    AND B.IMSRP5 = 'MP'
    AND B.IMSTKT != 'O'
    -- Filtro específico deste bloco: busca itens em um conjunto de filiais específicas.
    AND TRIM(limcu) IN ('191000V304', '191000V305')
GROUP BY
    TRIM(A.IMSEG1), TRIM(LIMCU), TRIM(MCDL01), NVL(G.COUNCS / 10000, 0), NVL(C.COUNCS / 10000, 0), B.IMUOM1, TRIM(B.IMDSC1),
    TRIM(S1.DRDL01), TRIM(S2.DRDL01), TRIM(A.imlitm);