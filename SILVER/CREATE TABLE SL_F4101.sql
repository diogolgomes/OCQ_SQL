CREATE TABLE SL_F4101
(
    COD_ITEM INT NULL,                      --  BR_F4101.IMITM - Código do item (número curto)
    COD_ITEM_SECUNDARIO NCHAR(25) NULL,     --  BR_F4101.IMLITM - Código secundário do item
    COD_ITEM_TERCIARIO NCHAR(25) NULL,      --  BR_F4101.IMAITM - Código terciário do item
    DESCRICAO1 NCHAR(30) NULL,              --  BR_F4101.IMDSC1 - Descrição linha 1
    DESCRICAO2 NCHAR(30) NULL,              --  BR_F4101.IMDSC2 - Descrição linha 2
    TEXTO_BUSCA NCHAR(30) NULL,             --  BR_F4101.IMSRTX - Texto para busca
    TEXTO_BUSCA_COMPACTADO NCHAR(30) NULL,  --  BR_F4101.IMALN - Texto para busca compactado
    
    -- Categorias de vendas
    CAT_VENDA_SECAO NCHAR(3) NULL,          -- BR_F4101.IMSRP1 - Seção do catálogo de vendas
    CAT_VENDA_SUBSECAO NCHAR(3) NULL,       -- BR_F4101.IMSRP2 - Subseção
    CAT_VENDA_COD3 NCHAR(3) NULL,           -- BR_F4101.IMSRP3 - Código de categoria de venda 3
    CAT_VENDA_COD4 NCHAR(3) NULL,           -- BR_F4101.IMSRP4 - Código de categoria de venda 4
    CAT_VENDA_COD5 NCHAR(3) NULL,           -- BR_F4101.IMSRP5 - Código de categoria de venda 5
    CAT_VENDA_COD6 NCHAR(6) NULL,           -- BR_F4101.IMSRP6 - Código de categoria 6
    CAT_VENDA_COD7 NCHAR(6) NULL,           -- BR_F4101.IMSRP7 - Código de categoria 7
    CAT_VENDA_COD8 NCHAR(6) NULL,           -- BR_F4101.IMSRP8 - Código de categoria 8
    CAT_VENDA_COD9 NCHAR(6) NULL,           -- BR_F4101.IMSRP9 - Código de categoria 9
    CAT_VENDA_COD10 NCHAR(6) NULL,          -- BR_F4101.IMSRP0 - Código de categoria 10
    
    -- Categorias de compras/produto
    CLASSE_PRODUTO NCHAR(3) NULL,           -- BR_F4101.IMPRP1 - Classe de commodity
    SUBCLASSE_PRODUTO NCHAR(3) NULL,        -- BR_F4101.IMPRP2 - Subclasse de commodity
    COD_REBATE_FORNECEDOR NCHAR(3) NULL,    -- BR_F4101.IMPRP3 - Código de rebate do fornecedor
    FAMILIA_PLAN_MAESTRO NCHAR(3) NULL,     -- BR_F4101.IMPRP4 - Família de planejamento mestre
    CAT_COMPRA_COD5 NCHAR(3) NULL,          -- BR_F4101.IMPRP5 - Código de categoria de compra 5
    GRUPO_DIMENSAO_ITEM NCHAR(6) NULL,      -- BR_F4101.IMPRP6 - Grupo - dimensão do item
    GRUPO_PROCESSO_ARM1 NCHAR(6) NULL,      -- BR_F4101.IMPRP7 - Grupo - processo de armazém 1
    GRUPO_PROCESSO_ARM2 NCHAR(6) NULL,      -- BR_F4101.IMPRP8 - Grupo - processo de armazém 2
    GRUPO_PROCESSO_ARM3 NCHAR(6) NULL,      -- BR_F4101.IMPRP9 - Grupo - processo de armazém 3
    POOL_ITENS NCHAR(6) NULL,               -- BR_F4101.IMPRP0 - Pool de itens
    
    -- Outras classificações
    COD_COMODITY NCHAR(15) NULL,            -- BR_F4101.IMCDCD - Código de commodity
    GRUPO_PRODUTO NCHAR(3) NULL,            -- BR_F4101.IMPDGR - Grupo de produto
    GRUPO_DESPACHO NCHAR(3) NULL,           -- BR_F4101.IMDSGP - Grupo de despacho
    GRUPO_PRECO_ITEM NCHAR(8) NULL,         -- BR_F4101.IMPRGR - Grupo de preço do item
    CAT_REPREC_BASE NCHAR(8) NULL,          -- BR_F4101.IMRPRC - Categoria de reprice (cesta)
    CAT_REPREC_PEDIDO NCHAR(8) NULL,        -- BR_F4101.IMORPR - Categoria de reprice de pedido
    
    -- Informações de compras
    COD_COMPRADOR INT NULL,                 -- BR_F4101.IMBUYR - Código do comprador
    NUM_DESENHO NCHAR(20) NULL,             -- BR_F4101.IMDRAW - Número do desenho
    ULT_REVISAO NCHAR(2) NULL,              -- BR_F4101.IMRVNO - Último número de revisão
    TAM_DESENHO NCHAR(1) NULL,              -- BR_F4101.IMDSZE - Tamanho do desenho
    
    -- Dimensões e transporte
    VOLUME DECIMAL(15,4) NULL,              -- BR_F4101.IMVCUD - Dimensões cúbicas (volume)
    COD_TRANSPORTADORA INT NULL,            -- BR_F4101.IMCARS - Código da transportadora
    TRANSP_PREF_COMPRAS INT NULL,           -- BR_F4101.IMCARP - Transportadora preferencial (compras)
    CONDICOES_FRETE NCHAR(3) NULL,          -- BR_F4101.IMSHCN - Código de condições de frete
    CLASSE_FRETE NCHAR(3) NULL,             -- BR_F4101.IMSHCM - Classe de commodity de frete
    
    -- Unidades de medida
    UNIDADE_MEDIDA_PRIMARIA NCHAR(2) NULL,   -- BR_F4101.IMUOM1 - Unidade de medida primária
    UNIDADE_MEDIDA_SECUNDARIA NCHAR(2) NULL, -- BR_F4101.IMUOM2 - Unidade de medida secundária
    UNIDADE_MEDIDA_COMPRAS NCHAR(2) NULL,    -- BR_F4101.IMUOM3 - Unidade de medida de compras
    UNIDADE_MEDIDA_PRECO NCHAR(2) NULL,      -- BR_F4101.IMUOM4 - Unidade de medida de preço
    UNIDADE_MEDIDA_EXPEDICAO NCHAR(2) NULL,  -- BR_F4101.IMUOM6 - Unidade de medida de expedição
    UNIDADE_MEDIDA_PRODUCAO NCHAR(2) NULL,   -- BR_F4101.IMUOM8 - Unidade de medida de produção
    UNIDADE_MEDIDA_COMPONENTE NCHAR(2) NULL, -- BR_F4101.IMUOM9 - Unidade de medida de componente
    UNIDADE_MEDIDA_PESO NCHAR(2) NULL,       -- BR_F4101.IMUWUM - Unidade de medida de peso
    UNIDADE_MEDIDA_VOLUME1 NCHAR(2) NULL,    -- BR_F4101.IMUVM1 - Unidade de medida de volume
    UNIDADE_MEDIDA_ESTOQUE NCHAR(2) NULL,    -- BR_F4101.IMSUTM - Unidade de medida de estoque
    TIPO_UNIDADE_MEDIDA NCHAR(1) NULL,       -- BR_F4101.IMUMVW - Tipo de unidade (volume/peso)
    
    -- Controle de estoque
    CAT_CONTROLE_CICLICO NCHAR(3) NULL,     -- BR_F4101.IMCYCL - Categoria de contagem cíclica
    CATEGORIA_CONTABIL NCHAR(4) NULL,       -- BR_F4101.IMGLPT - Categoria contábil
    NIVEL_PRECO_BASE NCHAR(1) NULL,         -- BR_F4101.IMPLEV - Nível de preço base de venda
    NIVEL_PRECO_COMPRA NCHAR(1) NULL,       -- BR_F4101.IMPPLV - Nível de preço de compra
    NIVEL_CUSTO_ESTOQUE NCHAR(1) NULL,      -- BR_F4101.IMCLEV - Nível de custo de estoque
    PRECIFICACAO_POTENCIA NCHAR(1) NULL,    -- BR_F4101.IMPRPO - Precificação por grau/potência
    VERIF_DISPONIBILIDADE NCHAR(1) NULL,    -- BR_F4101.IMCKAV - Verificar disponibilidade (S/N)
    TIPO_EMBALAGEM NCHAR(1) NULL,           -- BR_F4101.IMBPFG - Flag bulk/embalado
    CODIGO_ORIGEM NCHAR(1) NULL,            -- BR_F4101.IMSRCE - Código de origem
    
    -- Controle de qualidade
    CONTROLE_POTENCIA NCHAR(1) NULL,        -- BR_F4101.IMOT1Y  - Controle de potência
    CONTROLE_GRAU NCHAR(1) NULL,            -- BR_F4101.IMOT2Y  - Controle de grau
    POTENCIA_PADRAO DECIMAL(7,3) NULL,      -- BR_F4101.IMSTDP  - Potência padrão
    POTENCIA_DE DECIMAL(7,3) NULL,          -- BR_F4101.IMFRMP  - Potência de
    POTENCIA_ATE DECIMAL(7,3) NULL,         -- BR_F4101.IMTHRP  - Potência até
    GRAU_PADRAO NCHAR(3) NULL,              -- BR_F4101.IMSTDG  - Grau padrão
    GRAU_DE NCHAR(3) NULL,                  -- BR_F4101.IMFRGD  - Grau de
    GRAU_ATE NCHAR(3) NULL,                 -- BR_F4101.IMTHGD  - Grau até
    
    -- Tipo de item
    TIPO_COMPONENTE NCHAR(1) NULL,          -- BR_F4101.IMCOTY - Tipo de componente
    TIPO_ESTOQUE NCHAR(1) NULL,             -- BR_F4101.IMSTKT - Tipo de estoque
    TIPO_LINHA NCHAR(2) NULL,               -- BR_F4101.IMLNTY - Tipo de linha
    ITEM_CONTRATO NCHAR(1) NULL,            -- BR_F4101.IMCONT - Item de contrato
    PERMITE_BACKORDER NCHAR(1) NULL,        -- BR_F4101.IMBACK - Permite backorders (S/N)
    MENSAGEM_FLASH NCHAR(2) NULL,           -- BR_F4101.IMIFLA - Mensagem flash do item
    CONVERSAO_UNIDADE_PADRAO NCHAR(2) NULL, -- BR_F4101.IMTFLA - Conversão padrão de unidade de medida
    MENSAGEM_IMPRESSAO NCHAR(10) NULL,      -- BR_F4101.IMINMG - Mensagem para impressão
    
    -- Classificação ABC
    COD_ABC_VENDAS NCHAR(1) NULL,            -- BR_F4101.IMABCS - Código ABC 1 (vendas/estoque)
    COD_ABC_MARGEM NCHAR(1) NULL,            -- BR_F4101.IMABCM - Código ABC 1 (margem/estoque)
    COD_ABC_INVESTIMENTO NCHAR(1) NULL,      -- BR_F4101.IMABCI - Código ABC 3 (investimento/estoque)
    SOBRESCRITA_ABC NCHAR(1) NULL,           -- BR_F4101.IMOVR - Indicador de sobrescrita ABC
    
    -- Garantia e comissão
    TIPO_GARANTIA NCHAR(8) NULL,            -- BR_F4101.IMWARR - Tipo de garantia
    CATEGORIA_COMISSAO NCHAR(8) NULL,       -- BR_F4101.IMCMCG - Categoria de comissão
    
    -- Controle de série/lote
    NUMERO_SERIE_OBRIGATORIO NCHAR(1) NULL,  -- BR_F4101.IMSRNR - Número de série obrigatório
    METODO_PRECIFICACAO_KIT NCHAR(1) NULL,   -- BR_F4101.IMPMTH - Método de precificação de kit/configurador
    PROCESSAMENTO_FIFO NCHAR(1) NULL,        -- BR_F4101.IMFIFO - Processamento FIFO
    STATUS_LOTE NCHAR(1) NULL,               -- BR_F4101.IMLOTS - Código de status de lote
    DIAS_VIDA_UTIL INT NULL,                 -- BR_F4101.IMSLD - Dias de vida útil (shelf life)
    
    -- Planejamento
    COD_PLANEJADOR INT NULL,                 -- BR_F4101.IMANPL - Número do planejador
    CODIGO_PLANEJAMENTO NCHAR(1) NULL,       -- BR_F4101.IMMPST - Código de planejamento
    PERCENTUAL_MARGEM DECIMAL(7,3) NULL,     -- BR_F4101.IMPCTM - Percentual de margem
    MARGEM_MINIMA DECIMAL(7,3) NULL,         -- BR_F4101.IMMMPC - Margem mínima (%)
    STATUS_MATERIAL NCHAR(2) NULL,           -- BR_F4101.IMPTSC - Status do material
    ARREDONDAR_NUMERO_INTEIRO NCHAR(1) NULL, -- BR_F4101.IMSNS - Arredondar para número inteiro
    
    -- Lead times
    NIVEL_LEAD_TIME INT NULL,               -- BR_F4101.IMLTLV - Nível de lead time
    LEAD_TIME_FABRICACAO INT NULL,          -- BR_F4101.IMLTMF - Lead time de fabricação
    LEAD_TIME_ACUMULADO INT NULL,           -- BR_F4101.IMLTCM - Lead time acumulado
    
    -- Políticas de pedido
    CODIGO_POLITICA_PEDIDO NCHAR(1) NULL,    -- BR_F4101.IMOPC - Código de política de pedido
    VALOR_POLITICA_PEDIDO INT NULL,          -- BR_F4101.IMOPV - Valor da política de pedido
    QUANTIDADE_CUSTO_CONTABIL INT NULL,      -- BR_F4101.IMACQ - Quantidade para custo contábil
    QUANTIDADE_LEAD_FABRICACAO INT NULL,     -- BR_F4101.IMMLQ - Quantidade para lead time de fabricação
    LEAD_TIME_POR_UNIDADE DECIMAL(5,2) NULL, -- BR_F4101.IMLTPU - Lead time por unidade
    
    -- Regras de planejamento
    REGRA_LIMITE_PLANEJAMENTO NCHAR(1) NULL, -- BR_F4101.IMMPSP - Regra de limite de tempo de planejamento
    TIPO_LEAD_TIME NCHAR(1) NULL,            -- BR_F4101.IMMRPP - Lead time fixo ou variável
    CODIGO_TIPO_ISSUE NCHAR(1) NULL,         -- BR_F4101.IMITC - Código de tipo de issue
    
    -- Limites de tempo
    DIAS_LIMITE_PLANEJAMENTO1 INT NULL,     -- BR_F4101.IMMTF1 - Dias de limite de planejamento 1
    DIAS_LIMITE_PLANEJAMENTO2 INT NULL,     -- BR_F4101.IMMTF2 - Dias de limite de planejamento 2
    DIAS_LIMITE_PLANEJAMENTO3 INT NULL,     -- BR_F4101.IMMTF3 - Dias de limite de planejamento 3
    DIAS_LIMITE_PLANEJAMENTO4 INT NULL,     -- BR_F4101.IMMTF4 - Dias de limite de planejamento 4
    DIAS_OFFSET_LEAD_EXPEDICAO INT NULL,    -- BR_F4101.IMMTF5 - Dias de offset para lead time de expedição
    
    -- Amortecedores
    DIAS_AMORTECEDOR_EXPEDICAO INT NULL,    -- BR_F4101.IMEXPD - Dias de amortecedor para expedição
    DIAS_AMORTECEDOR_DIFERIMENTO INT NULL,  -- BR_F4101.IMDEFD - Dias de amortecedor para diferimento
    LEAD_TIME_SEGURANCA INT NULL,           -- BR_F4101.IMSFLT - Lead time de segurança
    
    -- Fabricação/compra
    TIPO_FABRICACAO NCHAR(1) NULL,          -- BR_F4101.IMMAKE - Código make/buy
    TIPO_COPRODUTO NCHAR(1) NULL,           -- BR_F4101.IMCOBY - Coprodutos/subprodutos/intermediários
    CODIGO_NIVEL_BAIXO INT NULL,            -- BR_F4101.IMLLX - Código de nível baixo
    
    -- Compromisso
    METODO_COMPROMISSO NCHAR(1) NULL,       -- BR_F4101.IMCMGL - Método de compromisso
    DIAS_COMPROMISSO_ESPECIFICO INT NULL,   -- BR_F4101.IMCOMH - Dias de compromisso específico
    
    -- Campos reservados
    CODIGO_RESERVADO_USUARIO NCHAR(2) NULL,      -- BR_F4101.IMURCD - Código reservado do usuário
    DATA_RESERVADA_USUARIO NUMERIC(6) NULL,      -- BR_F4101.IMURDT - Data reservada do usuário
    VALOR_RESERVADO_USUARIO DECIMAL(15,2) NULL,  -- BR_F4101.IMURAT - Valor reservado do usuário
    NUMERO_RESERVADO_USUARIO INT NULL,           -- BR_F4101.IMURAB - Número reservado do usuário
    REFERENCIA_RESERVADA_USUARIO NCHAR(15) NULL, -- BR_F4101.IMURRF - Referência reservada do usuário
    
    -- Auditoria
    USUARIO NCHAR(10) NULL,                  -- BR_F4101.IMUSER - ID do usuário
    PROGRAMA NCHAR(10) NULL,                 -- BR_F4101.IMPID - ID do programa
    ESTACAO_TRABALHO NCHAR(10) NULL,         -- BR_F4101.IMJOBN - ID da estação de trabalho
    DATA_ATUALIZACAO NUMERIC(6) NULL,        -- BR_F4101.IMUPMJ - Data de atualização
    HORA_ATUALIZACAO INT NULL,               -- BR_F4101.IMTDAY - Hora da atualização
    
    -- Códigos de barras
    CODIGO_UPC NCHAR(13) NULL,                  -- BR_F4101.IMUPCN - Número UPC
    CODIGO_SCC_AGREGADO NCHAR(14) NULL,         -- BR_F4101.IMSCC0 - Código SCC agregado (PI=0)
    UNIDADE_MEDIDA_UPC NCHAR(2) NULL,           -- BR_F4101.IMUMUP - Unidade de medida UPC
    UNIDADE_MEDIDA_UPC_AGREGADO NCHAR(2) NULL,  -- BR_F4101.IMUMDF - Unidade de medida UPC agregado
    
    -- Unidades de medida SCC
    UNIDADE_MEDIDA_SCC0 NCHAR(2) NULL,      -- BR_F4101.IMUMS0 - Unidade de medida SCC(PI=0)
    UNIDADE_MEDIDA_SCC1 NCHAR(2) NULL,      -- BR_F4101.IMUMS1 - Unidade de medida SCC(PI=1)
    UNIDADE_MEDIDA_SCC2 NCHAR(2) NULL,      -- BR_F4101.IMUMS2 - Unidade de medida SCC(PI=2)
    UNIDADE_MEDIDA_SCC3 NCHAR(2) NULL,      -- BR_F4101.IMUMS3 - Unidade de medida SCC(PI=3)
    UNIDADE_MEDIDA_SCC4 NCHAR(2) NULL,      -- BR_F4101.IMUMS4 - Unidade de medida SCC(PI=4)
    UNIDADE_MEDIDA_SCC5 NCHAR(2) NULL,      -- BR_F4101.IMUMS5 - Unidade de medida SCC(PI=5)
    UNIDADE_MEDIDA_SCC6 NCHAR(2) NULL,      -- BR_F4101.IMUMS6 - Unidade de medida SCC(PI=6)
    UNIDADE_MEDIDA_SCC7 NCHAR(2) NULL,      -- BR_F4101.IMUMS7 - Unidade de medida SCC(PI=7)
    UNIDADE_MEDIDA_SCC8 NCHAR(2) NULL,      -- BR_F4101.IMUMS8 - Unidade de medida SCC(PI=8)
    
    -- Processamento
    TIPO_ISSUE_RECEBIMENTO NCHAR(1) NULL,       -- BR_F4101.IMPOC - Tipo de issue e recebimento
    HORAS_REPOSICAO_PADRAO DECIMAL(15,2) NULL,  -- BR_F4101.IMAVRT - Horas padrão de reposição
    CODIGO_CONTENEDOR NCHAR(5) NULL,            -- BR_F4101.IMEQTY - Código de contêiner
    PESO_ITEM_OBRIGATORIO NCHAR(1) NULL,        -- BR_F4101.IMWTRQ - Peso do item obrigatório (S/N)
    
    -- Segmentos
    TEMPLATE NCHAR(20) NULL,                -- BR_F4101.IMTMPL - Template
    SEGMENTO1 NCHAR(10) NULL,               -- BR_F4101.IMSEG1 - Segmento 1
    SEGMENTO2 NCHAR(10) NULL,               -- BR_F4101.IMSEG2 - Segmento 2
    SEGMENTO3 NCHAR(10) NULL,               -- BR_F4101.IMSEG3 - Segmento 3
    SEGMENTO4 NCHAR(10) NULL,               -- BR_F4101.IMSEG4 - Segmento 4
    SEGMENTO5 NCHAR(10) NULL,               -- BR_F4101.IMSEG5 - Segmento 5
    SEGMENTO6 NCHAR(10) NULL,               -- BR_F4101.IMSEG6 - Segmento 6
    SEGMENTO7 NCHAR(10) NULL,               -- BR_F4101.IMSEG7 - Segmento 7
    SEGMENTO8 NCHAR(10) NULL,               -- BR_F4101.IMSEG8 - Segmento 8
    SEGMENTO9 NCHAR(10) NULL,               -- BR_F4101.IMSEG9 - Segmento 9
    SEGMENTO10 NCHAR(10) NULL,              -- BR_F4101.IMSEG0 - Segmento 10
    
    -- Controles avançados
    CONTROLADO_MATRIZ NCHAR(1) NULL,            -- BR_F4101.IMMIC - Controlado por matriz
    INGREDIENTE_ATIVO NCHAR(1) NULL,            -- BR_F4101.IMAING - Flag de ingrediente ativo
    DIAS_PADRAO_VALIDADE INT NULL,              -- BR_F4101.IMBBDD - Dias padrão "best before"
    METODO_DATA_COMPROMISSO NCHAR(1) NULL,      -- BR_F4101.IMCMDM - Método de data de compromisso
    METODO_CALC_EXPIRACAO_LOTE NCHAR(1) NULL,   -- BR_F4101.IMLECM - Método de cálculo de data de expiração de lote
    DIAS_PADRAO_EFETIVIDADE_LOTE INT NULL,      -- BR_F4101.IMLEDD - Dias padrão de efetividade de lote
    DIAS_EFETIVIDADE_COMPRAS INT NULL,          -- BR_F4101.IMPEFD - Dias de efetividade para compras
    DIAS_PADRAO_VENDA_ATE INT NULL,             -- BR_F4101.IMSBDD - Dias padrão "sell by"
    
    -- Datas de lote personalizadas
    DIAS_PADRAO_DATA_LOTE_USR1 INT NULL,    -- BR_F4101.IMU1DD - Dias padrão para data de lote usuário 1
    DIAS_PADRAO_DATA_LOTE_USR2 INT NULL,    -- BR_F4101.IMU2DD - Dias padrão para data de lote usuário 2
    DIAS_PADRAO_DATA_LOTE_USR3 INT NULL,    -- BR_F4101.IMU3DD - Dias padrão para data de lote usuário 3
    DIAS_PADRAO_DATA_LOTE_USR4 INT NULL,    -- BR_F4101.IMU4DD - Dias padrão para data de lote usuário 4
    DIAS_PADRAO_DATA_LOTE_USR5 INT NULL,    -- BR_F4101.IMU5DD - Dias padrão para data de lote usuário 5
    
    -- Controle dual
    TOLERANCIA_DUAL DECIMAL(7,2) NULL,          -- BR_F4101.IMDLTL - Tolerância dual
    OPCAO_PROCESSO_DUAL NCHAR(1) NULL,          -- BR_F4101.IMDPPO - Opção de processo de picking dual
    ITEM_UNIDADE_MEDIDA_DUAL NCHAR(1) NULL,     -- BR_F4101.IMDUAL - Item com unidade de medida dual
    FLAG_CROSSDOCKING NCHAR(1) NULL,            -- BR_F4101.IMXDCK - Flag de cross-docking
    FLAG_AUDITORIA_LOTE NCHAR(1) NULL,          -- BR_F4101.IMLAF - Flag de auditoria de lote
    FORMATO_ESPECIAL_LOTE NCHAR(1) NULL,        -- BR_F4101.IMLTFM - Formato especial de lote
    RESTRICAO_ATRIBUICAO_LOTE NCHAR(1) NULL,    -- BR_F4101.IMRWLA - Restrição de atribuição de lote em ordens
    PRE_ATRIBUICAO_NUMERO_LOTE NCHAR(1) NULL,   -- BR_F4101.IMLNPA - Pré-atribuição de número de lote
    CODIGO_STATUS_LOTE_EXPANDIDO NCHAR(3) NULL, -- BR_F4101.IMLOTC - Código de status de lote expandido
    
    -- Planejamento avançado
    FLAG_RESTRICOES NCHAR(1) NULL,                  -- BR_F4101.IMAPSC - Flag de restrições
    UNIDADE_MEDIDA_PLANEJAMENTO_APS NCHAR(9) NULL,  -- BR_F4101.IMAUOM - Unidade de medida para planejamento APS
    ITEM_CONSUMIVEL NCHAR(1) NULL,                  -- BR_F4101.IMCONB - Item consumível
    COMPOSICAO NCHAR(1) NULL,                       -- BR_F4101.IMGCMP - Composição
    
    -- Níveis de alerta
    NIVEL_ALERTA_PRIORIDADE1 DECIMAL(15,4) NULL, -- BR_F4101.IMPRI1 - Nível de alerta prioridade 1
    NIVEL_ALERTA_PRIORIDADE2 DECIMAL(15,4) NULL, -- BR_F4101.IMPRI2 - Nível de alerta prioridade 2
    
    -- Controles de lote
    PERMITIR_EXPEDICAO_LOTES_RETIDOS NCHAR(1) NULL, -- BR_F4101.IMASHL - Permitir expedição de lotes retidos
    INVENTARIO_GERENCIADO_FORNECEDOR NCHAR(1) NULL, -- BR_F4101.IMVMINV - Inventário gerenciado pelo fornecedor
    
    -- Métodos de custeio
    METODO_CUSTEIO_CONFIGURADOR NCHAR(1) NULL,  -- BR_F4101.IMCMETH - Método de custeio do configurador
    ITEM_EXPLOSAO NCHAR(1) NULL,                -- BR_F4101.IMEXPI - Item de explosão (1/0)
    
    -- Limiares operacionais
    LIMIAR_OPERACIONAL_MINIMO DECIMAL(15,4) NULL,    -- BR_F4101.IMOPTH - Limiar operacional mínimo
    LIMIAR_CUMULATIVO_MINIMO DECIMAL(15,4) NULL,     -- BR_F4101.IMCUTH - Limiar cumulativo mínimo
    UNIDADE_MEDIDA_LIMIAR_OPERACIONAL NCHAR(3) NULL, -- BR_F4101.IMUMTH - Unidade de medida do limiar operacional
    
    -- Manufatura enxuta
    FLAG_MANUFATURA_ENXUTA NCHAR(1) NULL,           -- BR_F4101.IMLMFG - Flag de manufatura enxuta
    IDENTIFICADOR_LINHA_CELULA NCHAR(12) NULL,      -- BR_F4101.IMLINE - Identificador de linha/célula
    TEMPO_CICLO_TOTAL_PRODUTO DECIMAL(20,5) NULL,   -- BR_F4101.IMDFTPCT - Tempo total de ciclo do produto
    
    -- Kanban
    ITEM_KANBAN NCHAR(1) NULL,                       -- BR_F4101.IMKBIT - Item kanban
    FLAG_ITEM_FINAL_FLUXO_DEMANDA NCHAR(1) NULL,     -- BR_F4101.IMDFENDITM - Flag de item final de fluxo de demanda
    KANBAN_EXPLODIR_NIVEL_INFERIOR NCHAR(1) NULL,    -- BR_F4101.IMKANEXLL - Kanban explodir para nível inferior
    ITEM_VENDIVEL NCHAR(1) NULL,                     -- BR_F4101.IMSCPSELL - Item vendível
    
    -- Limiares máximos
    LIMIAR_OPERACIONAL_MAXIMO DECIMAL(15,4) NULL,   -- BR_F4101.IMMOPTH - Limiar operacional máximo
    LIMIAR_CUMULATIVO_MAXIMO DECIMAL(15,4) NULL,    -- BR_F4101.IMMCUTH - Limiar cumulativo máximo
    UNIDADE_MEDIDA_LIMIAR_CUMULATIVO NCHAR(3) NULL, -- BR_F4101.IMCUMTH - Unidade de medida do limiar cumulativo
    
    -- Regras ATP
    NOME_REGRA_ATP NCHAR(80) NULL,          -- BR_F4101.IMATPRN - Nome da regra ATP
    VERIFICAR_ATP NCHAR(1) NULL,            -- BR_F4101.IMATPCA - Verificar ATP
    COMPONENTES_ATP NCHAR(5) NULL,          -- BR_F4101.IMATPAC - Componentes ATP
    
    -- Origem e controle
    ORIGEM_PAIS_OBRIGATORIA NCHAR(1) NULL,  -- BR_F4101.IMCOORE - Flag de origem do país obrigatória
    CONTROLE_PREVISAO_ATO NCHAR(20) NULL,   -- BR_F4101.IMVCPFC - Controle de previsão ATO
    CONTROLADO_NUMERO_PRODUCAO NCHAR(1) NULL -- BR_F4101.IMPNYN - Controlado por número de produção
);

TO_DATE(TO_CHAR(SL_F5541054.DATA, 'DD/MM/YYYY') || ' ' || SL_F5541054.HORA , 'DD/MM/YYYY HH24:MI:SS')