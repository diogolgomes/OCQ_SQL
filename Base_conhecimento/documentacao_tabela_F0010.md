# Documentação Tabela F0010 (Company Constants)

A tabela F0010 (Company Constants), ou Company Master, armazena os dados mestres e os parâmetros de configuração para cada empresa (entidade legal) cadastrada no JD Edwards. 🏢 Ela é a base para o módulo de Contabilidade Geral (General Ledger) e define regras cruciais como o calendário fiscal, a moeda padrão e os períodos contábeis abertos para lançamento.
Visão Geral da Tabela F0010

Principais Características
* Tabela de Dimensão: Contém dados mestres que raramente mudam (dados cadastrais).
* Base Financeira: É o ponto de partida para a estruturação do plano de contas (F0901) e dos lançamentos contábeis (F0911).
* Controle de Período: Define o ano fiscal corrente e quais períodos estão abertos para transações, uma função vital para o fechamento contábil.
* Configuração Central: Centraliza parâmetros que afetam toda a companhia, como moeda e calendários.

Arquitetura Medalhão: F0010
* **Tabela Bronze** - BRONZE.BR_F0010
  * Cópia fiel (1:1) da tabela PRODDTA.F0010. Os dados são mantidos em seu formato original, incluindo datas julianas e códigos.
* **Tabela Silver** - SILVER.SL_F0010
  * Versão tratada e enriquecida, pronta para consumo analítico.
  * Principais Transformações:
  * Conversão de Datas: Campos de data juliana são convertidos para o formato de data padrão.
  * Nomenclatura Amigável: Colunas recebem nomes claros e padronizados.
  * Enriquecimento: Adição de campos calculados (ex: Ano Fiscal Atual) e descrições de outras tabelas.



**DE-PARA Completo para Camada Silver (SL_F0010)**

| **TABELA** | **ALIAS** | **CAMPO** | **Campo Original** |   **Campo Silver (Inglês)**   |  **Campo Silver (Português)** | **Tipo de Dado** |             **Descrição**            |
|------------|-----------|-----------|--------------------|-------------------------------|-------------------------------|------------------|--------------------------------------|
| F0010 | CC | JOBN | CCJOBN | WORKSTATION_ID | ID_ESTACAO_TRABALHO | VARCHAR2(10) | Estação de trabalho ou job que processou a última alteração. |
| F0010 | CC | DPRC | CCDPRC | DECIMAL_PRECISION_DIGITS | DIGITOS_PRECISAO_DECIMAL | DECIMAL(1,0) | Dígitos de precisão decimal utilizados pela companhia. |
| F0010 | CC | USER | CCUSER | USER_ID | ID_USUARIO | VARCHAR2(10) | ID do usuário que fez a última alteração no registro. |
| F0010 | CC | UPMT | CCUPMT | LAST_UPDATE_TIME | HORA_ULTIMA_ATUALIZACAO | DECIMAL(6,0) | Hora da última atualização (formato HHMMSS). |
| F0010 | CC | TXBO | CCTXBO | TAX_CALCULATION_METHOD | METODO_CALCULO_IMPOSTO | VARCHAR2(1) | Método de cálculo do imposto. |
| F0010 | CC | TXBM | CCTXBM | TAX_BASE_METHOD | METODO_BASE_IMPOSTO | VARCHAR2(1) | Método para base de cálculo do imposto (G=Gross/Bruto, N=Net/Líquido). |
| F0010 | CC | TSID | CCTSID | TRADING_PARTNER_SITE_ID | ID_PARCEIRO_COMERCIAL | VARCHAR2(25) | Identificador do parceiro comercial. |
| F0010 | CC | TSCO | CCTSCO | TAKE_TAX_ON_COST_FLAG | FLAG_IMPOSTO_SOBRE_CUSTO | VARCHAR2(1) | Flag que indica se o imposto incide sobre o custo. |
| F0010 | CC | AN8C | CCAN8C | INTERCOMPANY_CLIENT_ID | ID_CLIENTE_INTERCOMPANHIA | DECIMAL(8,0) | ID do cliente (Address Book) para transações intercompanhia. |
| F0010 | CC | SMU | CCSMU | SUPPLEMENTAL_MEASUREMENT_UNIT | UNIDADE_MEDIDA_SUPLEMENTAR_1 | VARCHAR2(2) | Unidade de medida para dados suplementares. |
| F0010 | CC | SMS | CCSMS | SUPPLEMENTAL_DATA_STATUS | STATUS_DADOS_SUPLEMENTARES | VARCHAR2(1) | Status para uso de dados suplementares. |
| F0010 | CC | SMI | CCSMI | SUPPLEMENTAL_DATA_ITEM_TYPE | TIPO_DADOS_SUPLEMENTARES | VARCHAR2(1) | Tipo de item para dados suplementares. |
| F0010 | CC | THCO | CCTHCO | THIRD_PARTY_CONTRACT_HOLD_FLAG | FLAG_CONTRATO_TERCEIROS | VARCHAR2(1) | Flag que indica retenção em contratos de terceiros. |
| F0010 | CC | SGBK | CCSGBK | BOOKKEEPING_TYPE_FLAG | FLAG_CONTABILIDADE_GERENCIAL | VARCHAR2(1) | Flag que indica se a contabilidade é gerencial ou estatutária. |
| F0010 | CC | CRYC | CCCRYC | CURRENT_FISCAL_CENTURY | SECULO_FISCAL_ATUAL | DECIMAL(2,0) | Século do ano fiscal atual (ex: 20 para 20xx). |
| F0010 | CC | PID | CCPID | PROGRAM_ID | ID_PROGRAMA | VARCHAR2(10) | Programa (aplicação JDE) que fez a última alteração. |
| F0010 | CC | STMT | CCSTMT | BANK_STATEMENT_INSTRUCTIONS_FLAG | FLAG_INSTRUCOES_BANCARIAS | VARCHAR2(1) | Flag para instruções em extratos bancários. |
| F0010 | CC | PTCO | CCPTCO | COUNTRY_CODE | CODIGO_PAIS | VARCHAR2(3) | Código do país da companhia. |
| F0010 | CC | ABIN | CCABIN | ACCOUNT_BALANCE_INQUIRY_FORMAT | FORMATO_NUMERO_CONTA | VARCHAR2(1) | Define o formato de exibição do número da conta contábil. |
| F0010 | CC | PNF | CCPNF | FUTURE_PERIODS_NUMBER | NUM_PERIODOS_FUTUROS | DECIMAL(2,0) | Número de períodos futuros permitidos para lançamento contábil. |
| F0010 | CC | PNC | CCPNC | ACCOUNTING_PERIODS_NUMBER | NUM_PERIODOS_CONTABEIS | DECIMAL(2,0) | Número total de períodos contábeis no ano (ex: 12, 13). |
| F0010 | CC | ARPN | CCARPN | AR_REPORTING_PERIOD_NUMBER | PERIODO_RELATORIO_AR | DECIMAL(2,0) | Período de relatório atual para o Contas a Receber. |
| F0010 | CC | APPN | CCAPPN | AP_REPORTING_PERIOD_NUMBER | PERIODO_RELATORIO_AP | DECIMAL(2,0) | Período de relatório atual para o Contas a Pagar. |
| F0010 | CC | FP | CCFP | CURRENT_ACCOUNTING_PERIOD | PERIODO_CONTABIL_ATUAL | DECIMAL(2,0) | Número do período contábil atual dentro do ano fiscal. |
| F0010 | CC | CALD | CCCALD | FISCAL_DATE_PATTERN_CODE | TIPO_CALENDARIO_FISCAL | VARCHAR2(1) | Código do padrão de data fiscal (FK para F0008). |
| F0010 | CC | NAME | CCNAME | COMPANY_NAME | NOME_COMPANHIA | VARCHAR2(30) | Nome oficial da empresa. |
| F0010 | CC | X2 | CCX2 | GENERIC_FIELD_2 | CAMPO_GENERICO_2 | VARCHAR2(15) | Campo de referência cruzada para uso genérico/customizado. |
| F0010 | CC | X1 | CCX1 | GENERIC_FIELD_1 | CAMPO_GENERICO_1 | VARCHAR2(15) | Campo de referência cruzada para uso genérico/customizado. |
| F0010 | CC | DTPN | CCDTPN | DATE_PATTERN | PADRAO_DATA | VARCHAR2(1) | Padrão de data. |
| F0010 | CC | DFF | CCDFF | DEFAULT_DATE_FORMAT | FORMATO_DATA_PADRAO | VARCHAR2(1) | Formato de data padrão para a empresa. |
| F0010 | CC | GLIE | CCGLIE | GL_INTERCOMPANY_TYPE | TIPO_INTERCOMPANHIA_GL | VARCHAR2(1) | Define o tipo de transação intercompanhia no GL. |
| F0010 | CC | BKTX | CCBKTX | BRACKETED_TAXES_FLAG | FLAG_SUPORTE_IMPOSTO_BRACKET | VARCHAR2(1) | Flag que indica se a empresa usa impostos por faixas ("brackets"). |
| F0010 | CC | DNLT | CCDNLT | DUPLICATE_NUMBER_LEAD_TIME | NIVEL_CONTROLE_DUPLICIDADE | DECIMAL(3,0) | Tempo (em dias) para verificação de números de documentos duplicados. |
| F0010 | CC | MCUB | CCMCUB | AP_BUSINESS_UNIT_CODE | COD_FILIAL_CONTAS_PAGAR | VARCHAR2(12) | Filial (MCU) padrão para o módulo de Contas a Pagar (AP). |
| F0010 | CC | MCUD | CCMCUD | INVENTORY_BUSINESS_UNIT_CODE | COD_FILIAL_ESTOQUE | VARCHAR2(12) | Filial (MCU) padrão para o módulo de Estoque (IM). |
| F0010 | CC | MCUA | CCMCUA | AR_BUSINESS_UNIT_CODE | COD_FILIAL_CONTAS_RECEBER | VARCHAR2(12) | Filial (MCU) padrão para o módulo de Contas a Receber (AR). |
| F0010 | CC | MCUC | CCMCUC | GL_BUSINESS_UNIT_CODE | COD_FILIAL_CONTABILIDADE | VARCHAR2(12) | Filial (MCU) padrão para o módulo de Contabilidade (GL). |
| F0010 | CC | UPMJ | CCUPMJ | LAST_UPDATE_DATE | DATA_ULTIMA_ATUALIZACAO | DECIMAL(6,0) | (Juliano) Data da última atualização do registro. |
| F0010 | CC | NWXJ | CCNWXJ | NEXT_WORKING_DATE | DATA_PROXIMO_DIA_UTIL | DECIMAL(6,0) | (Juliano) Data do próximo dia útil. |
| F0010 | CC | DFYJ | CCDFYJ | FISCAL_YEAR_BEGINS_DATE | DATA_INICIO_ANO_FISCAL | DECIMAL(6,0) | (Juliano) Data de início do ano fiscal da empresa. |
| F0010 | CC | DAG | CCDAG | DUE_DATE | DATA_VENCIMENTO | DECIMAL(6,0) | (Juliano) Data de vencimento padrão. |
| F0010 | CC | ARFJ | CCARFJ | AR_REPORTING_DATE | DATA_RELATORIO_AR | DECIMAL(6,0) | (Juliano) Data do relatório de Contas a Receber. |
| F0010 | CC | APFJ | CCAPFJ | AP_REPORTING_DATE | DATA_RELATORIO_AP | DECIMAL(6,0) | (Juliano) Data do relatório de Contas a Pagar. |
| F0010 | CC | CRYR | CCCRYR | CURRENT_FISCAL_YEAR | ANO_FISCAL_ATUAL | DECIMAL(2,0) | Ano fiscal atual (formato de 2 dígitos, ex: 25). |
| F0010 | CC | CRCD | CCCRCD | CURRENCY_CODE | COD_MOEDA | VARCHAR2(3) | Código da moeda padrão da empresa (FK para F0013). |
| F0010 | CC | DOT2 | CCDOT2 | OPEN_PERIOD_END_DATE | DATA_FIM_PERIODO_ABERTO | DECIMAL(6,0) | (Juliano) Data final do range de datas aberto para lançamentos. |
| F0010 | CC | CO | CCCO | COMPANY_CODE | COD_EMPRESA | DECIMAL(5,0) | (Chave Primária) Número único que identifica a empresa. |
| F0010 | CC | ALGM | CCALGM | GL_ALLOCATION_METHOD | METODO_ALOCACAO_GL | VARCHAR2(1) | Método para alocações na contabilidade. |
| F0010 | CC | ATCS | CCATCS | AUTOMATIC_TAX_CALCULATION_FLAG | FLAG_CALCULO_AUTOMATICO_IMPOSTO | VARCHAR2(1) | Flag que habilita o cálculo automático de impostos. |
| F0010 | CC | ALTC | CCALTC | COMPANY_ALTERNATE_NAME | NOME_ALTERNATIVO_COMPANHIA | VARCHAR2(30) | Nome alternativo ou abreviado da empresa. |
| F0010 | CC | DOT1 | CCDOT1 | OPEN_PERIOD_START_DATE | DATA_INICIO_PERIODO_ABERTO | DECIMAL(6,0) | (Juliano) Data de início do range de datas aberto para lançamentos. |
| F0010 | CC | AGEM | CCAGEM | AGING_METHOD | METODO_VENCIMENTO | VARCHAR2(1) | Método de cálculo de vencimento (aging). |
| F0010 | CC | CRDY | CCCRDY | DUE_DATE_GRACE_DAYS | DIAS_TOLERANCIA_VENCIMENTO | DECIMAL(3,0) | Dias de tolerância para a data de vencimento. |
| F0010 | CC | AGR7 | CCAGR7 | AGING_RANGE_7 | FAIXA_VENCIMENTO_7 | DECIMAL(3,0) | Dias para a 7ª faixa do relatório de vencimento (aging). |
| F0010 | CC | AGR6 | CCAGR6 | AGING_RANGE_6 | FAIXA_VENCIMENTO_6 | DECIMAL(3,0) | Dias para a 6ª faixa do relatório de vencimento. |
| F0010 | CC | AGR5 | CCAGR5 | AGING_RANGE_5 | FAIXA_VENCIMENTO_5 | DECIMAL(3,0) | Dias para a 5ª faixa do relatório de vencimento. |
| F0010 | CC | AGR4 | CCAGR4 | AGING_RANGE_4 | FAIXA_VENCIMENTO_4 | DECIMAL(3,0) | Dias para a 4ª faixa do relatório de vencimento. |
| F0010 | CC | AGR3 | CCAGR3 | AGING_RANGE_3 | FAIXA_VENCIMENTO_3 | DECIMAL(3,0) | Dias para a 3ª faixa do relatório de vencimento. |
| F0010 | CC | AGR2 | CCAGR2 | AGING_RANGE_2 | FAIXA_VENCIMENTO_2 | DECIMAL(3,0) | Dias para a 2ª faixa do relatório de vencimento. |
| F0010 | CC | AGR1 | CCAGR1 | AGING_RANGE_1 | FAIXA_VENCIMENTO_1 | DECIMAL(3,0) | Dias para a 1ª faixa do relatório de vencimento. |
| F0010 | CC | AGE | CCAGE | AGE_AS_OF_DAYS | DIAS_VENCIMENTO | DECIMAL(3,0) | Dias para o envelhecimento de saldo. |
| F0010 | CC | AN8 | CCAN8 | REMIT_TO_ADDRESS_ID | ID_ENDERECO_REMETENTE | DECIMAL(8,0) | ID (Address Book) do endereço padrão para remessa de pagamentos. |
| F0010 | CC | NNP | CCNNP | NEXT_NUMBER_PERIOD | NUM_PROXIMO_PERIODO | DECIMAL(2,0) | Número do próximo período contábil. |
| F0010 | CC | FRP | CCFRP | FIRST_FISCAL_PERIOD | PRIMEIRO_PERIODO_FISCAL | DECIMAL(2,0) | Primeiro período fiscal para relatórios. |
| F0010 | CC | FRY | CCFRY | FIRST_FISCAL_YEAR | PRIMEIRO_ANO_FISCAL | DECIMAL(2,0) | Primeiro ano fiscal para relatórios. |

#### SQL para Criação da Tabela Silver

~~~sql

CREATE OR REPLACE TABLE SL_F0010 AS
SELECT
    CCJOBN AS ID_ESTACAO_TRABALHO,
    CCDPRC AS DIGITOS_PRECISAO_DECIMAL,
    CCUSER AS ID_USUARIO,
    CCUPMT AS HORA_ULTIMA_ATUALIZACAO,
    CCTXBO AS METODO_CALCULO_IMPOSTO,
    CCTXBM AS METODO_BASE_IMPOSTO,
    CCTSID AS ID_PARCEIRO_COMERCIAL,
    CCTSCO AS FLAG_IMPOSTO_SOBRE_CUSTO,
    CCAN8C AS ID_CLIENTE_INTERCOMPANHIA,
    CCSMU AS UNIDADE_MEDIDA_SUPLEMENTAR_1,
    CCSMS AS STATUS_DADOS_SUPLEMENTARES,
    CCSMI AS TIPO_DADOS_SUPLEMENTARES,
    CCTHCO AS FLAG_CONTRATO_TERCEIROS,
    CCSGBK AS FLAG_CONTABILIDADE_GERENCIAL,
    CCCRYC AS SECULO_FISCAL_ATUAL,
    CCPID AS ID_PROGRAMA,
    CCSTMT AS FLAG_INSTRUCOES_BANCARIAS,
    CCPTCO AS CODIGO_PAIS,
    CCABIN AS FORMATO_NUMERO_CONTA,
    CCPNF AS NUM_PERIODOS_FUTUROS,
    CCPNC AS NUM_PERIODOS_CONTABEIS,
    CCARPN AS PERIODO_RELATORIO_AR,
    CCAPPN AS PERIODO_RELATORIO_AP,
    CCFP AS PERIODO_CONTABIL_ATUAL,
    CCCALD AS TIPO_CALENDARIO_FISCAL,
    CCNAME AS NOME_COMPANHIA,
    CCX2 AS CAMPO_GENERICO_2,
    CCX1 AS CAMPO_GENERICO_1,
    CCDTPN AS PADRAO_DATA,
    CCDFF AS FORMATO_DATA_PADRAO,
    CCGLIE AS TIPO_INTERCOMPANHIA_GL,
    CCBKTX AS FLAG_SUPORTE_IMPOSTO_BRACKET,
    CCDNLT AS NIVEL_CONTROLE_DUPLICIDADE,
    CCMCUB AS COD_FILIAL_CONTAS_PAGAR,
    CCMCUD AS COD_FILIAL_ESTOQUE,
    CCMCUA AS COD_FILIAL_CONTAS_RECEBER,
    CCMCUC AS COD_FILIAL_CONTABILIDADE,
    CCUPMJ AS DATA_ULTIMA_ATUALIZACAO,
    CCNWXJ AS DATA_PROXIMO_DIA_UTIL,
    CCDFYJ AS DATA_INICIO_ANO_FISCAL,
    CCDAG AS DATA_VENCIMENTO,
    CCARFJ AS DATA_RELATORIO_AR,
    CCAPFJ AS DATA_RELATORIO_AP,
    CCCRYR AS ANO_FISCAL_ATUAL,
    CCCRCD AS COD_MOEDA,
    CCDOT2 AS DATA_FIM_PERIODO_ABERTO_JULIAN,
    CCCO AS COD_COMPANHIA,
    CCALGM AS METODO_ALOCACAO_GL,
    CCATCS AS FLAG_CALCULO_AUTOMATICO_IMPOSTO,
    CCALTC AS NOME_ALTERNATIVO_COMPANHIA,
    CCDOT1 AS DATA_INICIO_PERIODO_ABERTO_JULIAN,
    CCAGEM AS METODO_VENCIMENTO,
    CCCRDY AS DIAS_TOLERANCIA_VENCIMENTO,
    CCAGR7 AS FAIXA_VENCIMENTO_7,
    CCAGR6 AS FAIXA_VENCIMENTO_6,
    CCAGR5 AS FAIXA_VENCIMENTO_5,
    CCAGR4 AS FAIXA_VENCIMENTO_4,
    CCAGR3 AS FAIXA_VENCIMENTO_3,
    CCAGR2 AS FAIXA_VENCIMENTO_2,
    CCAGR1 AS FAIXA_VENCIMENTO_1,
    CCAGE AS DIAS_VENCIMENTO,
    CCAN8 AS ID_ENDERECO_REMETENTE,
    CCNNP AS NUM_PROXIMO_PERIODO,
    CCFRP AS PRIMEIRO_PERIODO_FISCAL,
    CCFRY AS PRIMEIRO_ANO_FISCAL
FROM BR_F0010;

~~~

#### Principais Relacionamentos ⚙️
* [F0911](documentacao_tabela_F0911) (General Ledger): SL_F0010.COD_COMPANHIA → F0911.GLCO (Vincula cada lançamento contábil à sua empresa).
* [F0901](documentacao_tabela_F0901) (Chart of Accounts): SL_F0010.COD_COMPANHIA → F0901.GMCO (Define a qual empresa uma conta contábil pertence).
* [F0006](documentacao_tabela_F0006) (Business Unit Master): SL_F0010.COD_COMPANHIA → F0006.MCCO (Associa uma filial/centro de custo a uma empresa).
* [F0008](documentacao_tabela_F0008) (Fiscal Date Patterns): SL_F0010.TIPO_CALENDARIO_FISCAL → F0008.DPPN (Busca a definição do calendário fiscal).
* [F0013](documentacao_tabela_F0013) (Currency Codes): SL_F0010.COD_MOEDA → F0013.CRCD (Busca a descrição e as regras da moeda).

#### Casos de Uso Comuns
* Relatórios Financeiros Consolidados: Agrupar resultados de várias filiais (F0006) sob a mesma empresa (F0010).
* Validação de Lançamentos: Verificar se a data de uma transação está dentro do período aberto (CCDOT1 e CCDOT2).
* Configuração do Sistema: Fonte de verdade para configurar novas empresas e suas regras fiscais.
* Análises Multi-Moeda: Identificar a moeda base de cada entidade legal.
---
#### Recomendações para Implementação
* Conversão de Datas Julian: Criar campos adicionais com datas convertidas para formato DATE
* Normalização: Considerar separar em tabelas relacionadas por domínio (contábil, fiscal, endereço)
* Metadados: Adicionar campos como data_carregamento e fonte_dados
* Validações: Implementar verificações para códigos de moeda, países e períodos
* Índices: Criar índices para campos de junção frequente (codigo_empresa, numero_endereco)

#### Sugestões de Melhoria para a Camada Silver (SL_F0010)
1. Criar Campo ANO_FISCAL_COMPLETO: Na camada Silver, crie um campo numérico de 4 dígitos para o ano fiscal, combinando o século e o ano.
   * Lógica SQL: (CCCRYC * 100) + CCCRYR
2. Enriquecer com Descrições:
   * Adicione DESCRICAO_MOEDA fazendo join com F0013 a partir de CCCRCD.
   * Adicione DESCRICAO_CALENDARIO_FISCAL fazendo join com F0008 a partir de CCCALD.
3. Criar TIMESTAMP_ATUALIZACAO: Combine a data (CCUPMJ) e a hora (CCUPMT) em um único campo de timestamp (DATETIME) para facilitar a ordenação e o controle de atualizações.
   * Adicionar Flags de Status: Crie um campo FLAG_PERIODO_ABERTO ('Sim'/'Não') que verifica se a data atual está entre DATA_INICIO_PERIODO_ABERTO e DATA_FIM_PERIODO_ABERTO. Isso simplifica consultas que precisam saber se a empresa pode receber lançamentos hoje.

### Create para a tbl BRONZE.BR_F0010

~~~ SQL
   CREATE TABLE BRONZE.BR_F0010
(
CCCO NCHAR(5) NULL, -- Company
CCNAME NCHAR(30) NULL, -- Name
CCALTC NCHAR(40) NULL, -- Alternate Company Name
CCDFYJ NUMERIC(6) NULL, -- Date - Fiscal Year Begins
CCPNC INT NULL -- Period Number - Current
CCDOT1 NCHAR(1) NULL -- Allow Multi-Currency Intercompany Trans.
CCCRYR NCHAR(1) NULL -- Currency Conversion Y/N/Z
CCCRYC NCHAR(1) NULL -- Search Type Security - Y/N
CCDOT2 NCHAR(1) NULL -- Computation ID
CCMCUA NCHAR(1) NULL -- Default CC - Use for Asset Cost
CCMCUD NCHAR(1) NULL -- Default CC - Use for Depreciation Exp.
CCMCUC NCHAR(1) NULL -- Default CC - Use for Accumulated Depre
CCMCUB NCHAR(1) NULL -- Default CC - Use for Revenue-Billing
CCDPRC NCHAR(1) NULL -- Voucher Redistribution Suspense
CCBKTX NCHAR(1) NULL -- Detailed Currency Restatement
CCTXBM INT NULL -- Tax Year - Beginning Month
CCTXBO INT NULL -- Tax Year - Beginning Month - Old OBSOLET
CCNWXJ NUMERIC(6) NULL -- Date - New Tax Year End
CCGLIE NCHAR(1) NULL -- Display 10 Class Codes (Y/N)
CCABIN NCHAR(1) NULL -- Post Account Balances by Currency
CCCALD NCHAR(2) NULL -- Number of Periods - Normal
CCDTPN NCHAR(1) NULL -- Fiscal Date Pattern
CCPNF INT NULL -- Period Number - Financial Reporting
CCDFF INT NULL -- Financial Reporting Year
CCCRCD NCHAR(3) NULL -- Currency Code - From
CCSMI NCHAR(1) NULL -- Symbol Used to define Item Number
CCSMU NCHAR(1) NULL -- Symbol Used to define Unit Number
CCSMS NCHAR(1) NULL -- Symbol Used to define Serial Number
CCDNLT NCHAR(1) NULL -- Delinquency Notice (Y/N)
CCSTMT NCHAR(1) NULL -- Print Statement Y/N
CCATCS NCHAR(1) NULL -- Auto Receipt (Y/N)
CCALGM NCHAR(2) NULL -- Auto Receipt Algorithm Method
CCAGEM NCHAR(1) NULL -- Aging Method (1 2 3)
CCCRDY INT NULL -- Aging Days - A/R Current
CCAGR1 INT NULL -- Aging Days - A/R 1
CCAGR2 INT NULL -- Aging Days - A/R 2
CCAGR3 INT NULL -- Aging Days - A/R 3
CCAGR4 INT NULL -- Aging Days - A/R 4
CCAGR5 INT NULL -- Aging Days - A/R 5
CCAGR6 INT NULL -- Aging Days - A/R 6
CCAGR7 INT NULL -- Aging Days - A/R 7
CCFRY INT NULL -- 52 Period Financial Reporting Year
CCFRP INT NULL -- 52 Period Number - Financial Reporting
CCNNP INT NULL -- 52 Period Number of Periods - Normal
CCFP DECIMAL(9,6) NULL -- Percentage Factor
CCAGE NCHAR(1) NULL -- Aging - Date Based On (I/D/G)
CCDAG NUMERIC(6) NULL -- Date - Age as of
CCARPN INT NULL -- Period Number - Accounts Receivable
CCAPPN INT NULL -- Period Number - Accounts Payable
CCARFJ NUMERIC(6) NULL -- Date - A/R Fiscal Year Begins
CCAPFJ NUMERIC(6) NULL -- Date - A/P Fiscal Year Begins
CCAN8 INT NULL -- Address Number
CCSGBK NCHAR(40) NULL -- Signature Block
CCPTCO NCHAR(1) NULL -- Print Company Name
CCX1 NCHAR(1) NULL -- For Future Use - Flag 1
CCX2 NCHAR(1) NULL -- For Future Use - Flag 2
CCUSER NCHAR(10) NULL -- User ID
CCPID NCHAR(10) NULL -- Program ID
CCUPMJ NUMERIC(6) NULL -- Date - Updated
CCJOBN NCHAR(10) NULL -- Work Station ID
CCUPMT INT NULL -- Time - Last Updated
CCTSID INT NULL -- Target System Identifier
CCTSCO NCHAR(5) NULL -- Target Company
CCTHCO NCHAR(3) NULL -- Source Alias System . . . . . . . . .
CCAN8C INT NULL -- Target Address Number
);
~~~