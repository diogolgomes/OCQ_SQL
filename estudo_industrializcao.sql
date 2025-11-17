-- #####################################################################################
-- # Consulta Final e Completa: BI de Industrialização (Operacional + Financeiro)    #
-- # Grão: Data, Item, Filial                                                          #
-- # Combina a análise de saldo de estoque com a visão financeira do faturamento.      #
-- #####################################################################################
WITH
  -- ===========================================================================
  -- CTEs de Dimensão e Saldo Inicial (Base da Análise de Estoque)
  -- ===========================================================================
  DimensaoItem AS (
    SELECT IMITM, IMLITM, IMDSC1, IMDSC2 FROM PRODDTA.F4101
  ),
  DimensaoFilial AS (
    SELECT MCMCU, MCDL01 FROM PRODDTA.F0006
  ),
  SaldoInicialAnterior AS (
    SELECT
      ILITM AS ID_ITEM,
      ILMCU AS COD_FILIAL,
      SUM(ILTRQT / 10000.0) AS QTD_SALDO_INICIAL
    FROM PRODDTA.F4111
    WHERE ILTRDJ < (SELECT TO_CHAR(DATE '2025-01-01','YYYYDDD')-1900000 FROM DUAL) -- Saldo até a véspera do filtro
    GROUP BY ILITM, ILMCU
  ),

  -- ===========================================================================
  -- CTE FatoVendas ENRIQUECIDO (Lógica financeira inspirada na sua VIEW)
  -- ===========================================================================
  FatoVendasEnriquecido AS (
    SELECT
      TO_DATE(TO_CHAR(1900000 + SDTRDJ), 'YYYYDDD') AS DATA_MOVIMENTO,
      SDITM AS ID_ITEM,
      SDMCU AS COD_FILIAL,
      -- Quantidades (separando Vendas de Devoluções)
      SUM(CASE WHEN SDDCTO NOT IN ('CV', 'DO') THEN (SDUORG / 10000.0) ELSE 0 END) AS QTD_VENDIDA,
      SUM(CASE WHEN SDDCTO IN ('CV', 'DO') THEN (SDUORG / 10000.0) ELSE 0 END) AS QTD_DEVOLVIDA,
      
      -- Valores Financeiros
      SUM(CASE WHEN SDDCTO NOT IN ('CV', 'DO') THEN (SDAEXP / 100.0) ELSE (SDAEXP / 100.0) * -1 END) AS RECEITA_BRUTA,
      SUM(FDBICM / 100.0) AS VALOR_ICMS,
      SUM(FDBIPI / 100.0) AS VALOR_IPI,
      -- Cálculo Padrão de PIS/COFINS (9.25% sobre a base Receita Bruta - ICMS). Valide esta regra.
      SUM((SDAEXP - FDBICM) / 100.0 * 0.0925) AS VALOR_PIS_COFINS,
      -- Custo de Venda (buscando da F4105, um método mais estável)
      SUM((SDUORG / 10000.0) * (CO.COUNCS / 10000.0)) AS CUSTO_TOTAL_VENDA
    FROM
      PRODDTA.F4211 F4211
      -- Join para buscar impostos da Nota Fiscal (essencial para o financeiro)
      LEFT JOIN PRODDTA.F7611B NF_DET ON F4211.SDDOCO = NF_DET.FDDOCO AND F4211.SDDCTO = NF_DET.FDPDCT AND F4211.SDKCOO = NF_DET.FDCO AND F4211.SDLNID = NF_DET.FDLNID
      -- Join para buscar o custo padrão do item na filial
      LEFT JOIN PRODDTA.F4105 CO ON F4211.SDITM = CO.COITM AND F4211.SDMCU = CO.COMCU AND CO.COCSIN = 'I' -- 'I' para Custo Padrão de Inventário
    WHERE
      F4211.SDDCTO IN ('SG','SX','SV','VI','VO','VZ','V5','V7','V8','VA','VF','VG','VH','SO','DO','CV','VQ','V0')
    GROUP BY
      F4211.SDTRDJ, F4211.SDITM, F4211.SDMCU
  ),
  
  -- ===========================================================================
  -- CTE FatoMovimentacoesEstoque (Lógica de Produção e Consumo, sem alteração)
  -- ===========================================================================
  FatoMovimentacoesEstoque AS (
    SELECT
      TO_DATE(TO_CHAR(1900000 + ILTRDJ), 'YYYYDDD') AS DATA_MOVIMENTO,
      ILITM AS ID_ITEM,
      ILMCU AS COD_FILIAL,
      SUM(CASE WHEN ILDCT = 'IM' THEN (ILTRQT / 10000.0) ELSE 0 END) AS QTD_SAIDA_CONSUMO,
      SUM(CASE WHEN ILDCT IN ('IV', 'WO') THEN (ILTRQT / 10000.0) ELSE 0 END) AS QTD_ENTRADA_PRODUCAO
    FROM PRODDTA.F4111
    WHERE ILDCT IN ('IM', 'IV', 'WO')
    GROUP BY ILTRDJ, ILITM, ILMCU
  ),
  
  -- ===========================================================================
  -- CTEs para união e cálculo final (com pequenas adaptações)
  -- ===========================================================================
  ChavesMestras AS (
    SELECT DATA_MOVIMENTO, ID_ITEM, COD_FILIAL FROM FatoVendasEnriquecido
    UNION
    SELECT DATA_MOVIMENTO, ID_ITEM, COD_FILIAL FROM FatoMovimentacoesEstoque
  ),
  MovimentacoesDiarias AS (
    SELECT
      m.DATA_MOVIMENTO, m.ID_ITEM, m.COD_FILIAL, i.IMDSC1 AS DESCRICAO_ITEM, f.MCDL01 AS NOME_FILIAL,
      -- Métricas de Quantidade
      COALESCE(v.QTD_VENDIDA, 0) AS QTD_VENDIDA_DIA,
      COALESCE(v.QTD_DEVOLVIDA, 0) AS QTD_DEVOLVIDA_DIA,
      COALESCE(e.QTD_ENTRADA_PRODUCAO, 0) AS QTD_PRODUZIDA_DIA,
      COALESCE(e.QTD_SAIDA_CONSUMO, 0) * -1 AS QTD_CONSUMIDA_DIA,
      -- Novas Métricas Financeiras
      COALESCE(v.RECEITA_BRUTA, 0) AS RECEITA_BRUTA_DIA,
      (COALESCE(v.RECEITA_BRUTA, 0) - COALESCE(v.VALOR_ICMS, 0) - COALESCE(v.VALOR_PIS_COFINS, 0)) AS RECEITA_LIQUIDA_DIA,
      COALESCE(v.CUSTO_TOTAL_VENDA, 0) AS CUSTO_PRODUTO_VENDIDO_DIA,
      -- Movimento Líquido de Estoque (agora inclui devoluções como entrada)
      (COALESCE(e.QTD_ENTRADA_PRODUCAO, 0) + COALESCE(e.QTD_SAIDA_CONSUMO, 0) - COALESCE(v.QTD_VENDIDA, 0) + COALESCE(v.QTD_DEVOLVIDA, 0)) AS MOVIMENTO_LIQUIDO_ESTOQUE_DIA
    FROM ChavesMestras m
    LEFT JOIN FatoVendasEnriquecido v ON m.DATA_MOVIMENTO = v.DATA_MOVIMENTO AND m.ID_ITEM = v.ID_ITEM AND m.COD_FILIAL = v.COD_FILIAL
    LEFT JOIN FatoMovimentacoesEstoque e ON m.DATA_MOVIMENTO = e.DATA_MOVIMENTO AND m.ID_ITEM = e.ID_ITEM AND m.COD_FILIAL = e.COD_FILIAL
    LEFT JOIN DimensaoItem i ON m.ID_ITEM = i.IMITM
    LEFT JOIN DimensaoFilial f ON m.COD_FILIAL = f.MCMCU
    WHERE m.DATA_MOVIMENTO >= DATE '2025-01-01' AND f.MCDL01 LIKE 'MCL%'
  )
-- #############################################################################
-- # Consulta Final: Unindo tudo com Saldo Acumulado e Visão Financeira
-- #############################################################################
SELECT
  m.*,
  -- Margem de Contribuição (Exemplo de métrica financeira agora possível)
  (m.RECEITA_LIQUIDA_DIA - m.CUSTO_PRODUTO_VENDIDO_DIA) AS MARGEM_CONTRIBUICAO_DIA,
  -- Saldo Final com base no Saldo Inicial Real
  COALESCE(s.QTD_SALDO_INICIAL, 0) + SUM(m.MOVIMENTO_LIQUIDO_ESTOQUE_DIA) OVER (PARTITION BY m.ID_ITEM, m.COD_FILIAL ORDER BY m.DATA_MOVIMENTO) AS SALDO_FINAL_DIA,
  -- Saldo Inicial com base no Saldo Inicial Real
  COALESCE(s.QTD_SALDO_INICIAL, 0) + SUM(m.MOVIMENTO_LIQUIDO_ESTOQUE_DIA) OVER (PARTITION BY m.ID_ITEM, m.COD_FILIAL ORDER BY m.DATA_MOVIMENTO) - m.MOVIMENTO_LIQUIDO_ESTOQUE_DIA AS SALDO_INICIAL_DIA
FROM
  MovimentacoesDiarias m
  LEFT JOIN SaldoInicialAnterior s ON m.ID_ITEM = s.ID_ITEM AND m.COD_FILIAL = s.COD_FILIAL
ORDER BY
  m.DATA_MOVIMENTO,
  m.COD_FILIAL,
  m.ID_ITEM;