# Documentação Tabela F0006

## Tabela F0006 - Business Unit Master File (Unidades de Negócio)

A tabela F0006 (também conhecida como Business Unit Master File) no JD Edwards EnterpriseOne (JDE) armazena informações sobre unidades de negócio (Business Units - BUs), que são estruturas organizacionais usadas para agrupar departamentos, filiais, centros de custo ou locais físicos dentro de uma empresa.

## Principais Características da Tabela F0006

- Armazena dados mestres: Contém informações sobre todas as unidades de negócio cadastradas no sistema.
- Usada para controle financeiro e operacional: Vincula-se a diversas transações (estoque, contabilidade, vendas, etc.).
- Estrutura hierárquica: Permite organizar BUs em níveis (ex: matriz → filial → departamento).
- Flexível: Suporta configurações específicas por BU, como moeda, endereço, centro de custo, etc.

### Tabela JDE - F0006

0 - Tabela Bronze - BRONZE.BR_ F0006

0 - Tabela Silver - SILVER.SL_ F0006 (campo data tratado)

| **TABELA** | **ALIAS** | **CAMPO** | **Campo Original** |   **Campo Silver (Inglês)**   |  **Campo Silver (Português)** | **Tipo de Dado** |             **Descrição**            |
|------------|-----------|-----------|--------------------|-------------------------------|-------------------------------|------------------|--------------------------------------|
| F0006      | MC        | MCU       | MCMCU              | business_unit                 | COD_FILIAL                    | String           | Código único da unidade de negócio (chave primária) |
| F0006      | MC        | STYL      | MCSTYL             |                               | TIPO_UNI_NEGOCIO              | String           | Tipo da unidade de negócio (ex: filial, departamento) |
| F0006      | MC        | DC        | MCDC               | document_code                 | NOME_CURTO                    | String           | Descrição resumida da unidade        |
| F0006      | MC        | LDM       | MCLDM              |                               | NIVEL_DETALHE_UNI             | Character        | Nível de detalhe da unidade de negócio |
| F0006      | MC        | CO        | MCCO               |                               | COD_EMPRESA                   | String           | Código da empresa associada          |
| F0006      | MC        | AN8       | MCAN8              |                               | COD_CADASTRO                  | Numeric          | Número do endereço no cadastro       |
| F0006      | MC        | AN8O      | MCAN8O             |                               | NUMERO_END_CONTA_RECEBER      | Numeric          | Número do endereço para contas a receber |
| F0006      | MC        | CNTY      | MCCNTY             |                               | MUNICIPIO                     | String           | Município/localização                |
| F0006      | MC        | ADDS      | MCADDS             |                               | ESTADO                        | String           | Estado/Província                     |
| F0006      | MC        | DL01      | MCDL01             |                               | DESCRICAO1                    | String           | Descrição principal da unidade       |
| F0006      | MC        | DL02      | MCDL02             |                               | DESCRICAO2                    | String           | Descrição adicional linha 2          |
| F0006      | MC        | DL03      | MCDL03             |                               | DESCRICAO3                    | String           | Descrição adicional linha 3          |
| F0006      | MC        | DL04      | MCDL04             |                               | DESCRICAO4                    | String           | Descrição adicional linha 4          |
| F0006      | MC        | RP01      | MCRP01             |                               | DIVISAO                       | String           | Divisão organizacional               |
| F0006      | MC        | RP02      | MCRP02             |                               | REGIAO                        | String           | Região geográfica                    |
| F0006      | MC        | RP03      | MCRP03             |                               | GRUPO                         | String           | Grupo corporativo                    |
| F0006      | MC        | RP04      | MCRP04             |                               | ESCRITORIO_REGIONAL           | String           | Escritório regional/filial           |
| F0006      | MC        | RP05      | MCRP05             |                               | TIPO_DEPARTAMENTO             | String           | Tipo de departamento                 |
| F0006      | MC        | RP06      | MCRP06             |                               | RESPONSAVEL                   | String           | Pessoa responsável                   |
| F0006      | MC        | RP07      | MCRP07             |                               | LINHA_NEGOCIO                 | String           | Linha de negócio principal           |
| F0006      | MC        | RP08      | MCRP08             |                               | CAT_UNIDADE_08                | String           | Códigos de categoria 8               |
| F0006      | MC        | RP09      | MCRP09             |                               | CAT_UNIDADE_09                | String           | Códigos de categoria 9               |
| F0006      | MC        | RP10      | MCRP10             |                               | CAT_UNIDADE_10                | String           | Códigos de categoria 10              |
| F0006      | MC        | RP11      | MCRP11             |                               | CAT_UNIDADE_11                | String           | Códigos de categoria 11              |
| F0006      | MC        | RP12      | MCRP12             |                               | CAT_UNIDADE_12                | String           | Códigos de categoria 12              |
| F0006      | MC        | RP13      | MCRP13             |                               | CAT_UNIDADE_13                | String           | Códigos de categoria 13              |
| F0006      | MC        | RP14      | MCRP14             |                               | CAT_UNIDADE_14                | String           | Códigos de categoria 14              |
| F0006      | MC        | RP15      | MCRP15             |                               | CAT_UNIDADE_15                | String           | Códigos de categoria 15              |
| F0006      | MC        | RP16      | MCRP16             |                               | CAT_UNIDADE_16                | String           | Códigos de categoria 16              |
| F0006      | MC        | RP17      | MCRP17             |                               | CAT_UNIDADE_17                | String           | Códigos de categoria 17              |
| F0006      | MC        | RP18      | MCRP18             |                               | CAT_UNIDADE_18                | String           | Códigos de categoria 18              |
| F0006      | MC        | RP19      | MCRP19             |                               | CAT_UNIDADE_19                | String           | Códigos de categoria 19              |
| F0006      | MC        | RP20      | MCRP20             |                               | CAT_UNIDADE_20                | String           | Códigos de categoria 20              |
| F0006      | MC        | RP21      | MCRP21             |                               | CAT_UNIDADE_21                | String           | Códigos de categoria 21              |
| F0006      | MC        | RP22      | MCRP22             |                               | CAT_UNIDADE_22                | String           | Códigos de categoria 22              |
| F0006      | MC        | RP23      | MCRP23             |                               | CAT_UNIDADE_23                | String           | Códigos de categoria 23              |
| F0006      | MC        | RP24      | MCRP24             |                               | CAT_UNIDADE_24                | String           | Códigos de categoria 24              |
| F0006      | MC        | RP25      | MCRP25             |                               | CAT_UNIDADE_25                | String           | Códigos de categoria 25              |
| F0006      | MC        | RP26      | MCRP26             |                               | CAT_UNIDADE_26                | String           | Códigos de categoria 26              |
| F0006      | MC        | RP27      | MCRP27             |                               | CAT_UNIDADE_27                | String           | Códigos de categoria 27              |
| F0006      | MC        | RP28      | MCRP28             |                               | CAT_UNIDADE_28                | String           | Códigos de categoria 28              |
| F0006      | MC        | RP29      | MCRP29             |                               | CAT_UNIDADE_29                | String           | Códigos de categoria 29              |
| F0006      | MC        | RP30      | MCRP30             |                               | CAT_UNIDADE_30                | String           | Códigos de categoria 30              |
| F0006      | MC        | RP31      | MCRP31             |                               | CAT_UNIDADE_31                | String           | Código de categoria 31               |
| F0006      | MC        | RP32      | MCRP32             |                               | CAT_UNIDADE_32                | String           | Código de categoria 32               |
| F0006      | MC        | RP33      | MCRP33             |                               | CAT_UNIDADE_33                | String           | Código de categoria 33               |
| F0006      | MC        | RP34      | MCRP34             |                               | CAT_UNIDADE_34                | String           | Código de categoria 34               |
| F0006      | MC        | RP35      | MCRP35             |                               | CAT_UNIDADE_35                | String           | Código de categoria 35               |
| F0006      | MC        | RP36      | MCRP36             |                               | CAT_UNIDADE_36                | String           | Código de categoria 36               |
| F0006      | MC        | RP37      | MCRP37             |                               | CAT_UNIDADE_37                | String           | Código de categoria 37               |
| F0006      | MC        | RP38      | MCRP38             |                               | CAT_UNIDADE_38                | String           | Código de categoria 38               |
| F0006      | MC        | RP39      | MCRP39             |                               | CAT_UNIDADE_39                | String           | Código de categoria 39               |
| F0006      | MC        | RP40      | MCRP40             |                               | CAT_UNIDADE_40                | String           | Código de categoria 40               |
| F0006      | MC        | RP41      | MCRP41             |                               | CAT_UNIDADE_41                | String           | Código de categoria 41               |
| F0006      | MC        | RP42      | MCRP42             |                               | CAT_UNIDADE_42                | String           | Código de categoria 42               |
| F0006      | MC        | RP43      | MCRP43             |                               | CAT_UNIDADE_43                | String           | Código de categoria 43               |
| F0006      | MC        | RP44      | MCRP44             |                               | CAT_UNIDADE_44                | String           | Código de categoria 44               |
| F0006      | MC        | RP45      | MCRP45             |                               | CAT_UNIDADE_45                | String           | Código de categoria 45               |
| F0006      | MC        | RP46      | MCRP46             |                               | CAT_UNIDADE_46                | String           | Código de categoria 46               |
| F0006      | MC        | RP47      | MCRP47             |                               | CAT_UNIDADE_47                | String           | Código de categoria 47               |
| F0006      | MC        | RP48      | MCRP48             |                               | CAT_UNIDADE_48                | String           | Código de categoria 48               |
| F0006      | MC        | RP49      | MCRP49             |                               | CAT_UNIDADE_49                | String           | Código de categoria 49               |
| F0006      | MC        | RP50      | MCRP50             |                               | CAT_UNIDADE_50                | String           | Código de categoria 50               |
| F0006      | MC        | BPTP      | MCBPTP             |                               | TIPO_RAMO                     | String           | Tipo de ramo/filial                  |
| F0006      | MC        | APSB      | MCAPSB             |                               | FLAG_UNI_APS                  | Character        | Indicador de unidade APS (S/N)       |
| F0006      | MC        | TSBU      | MCTSBU             |                               | UNI_NEGOCIO_DESTINO           | String           | Unidade de negócio alvo/destino      |
| F0006      | MC        | EEO       | MCEEO              |                               | COD_IGUALDADE_EMPREGO         | Character        | Código de igualdade de oportunidades |
| F0006      | MC        | ERC       | MCERC              |                               | COD_TAXA_EQUIPAMENTO          | String           | Código de taxa de equipamento        |
| F0006      | MC        | PC        | MCPC               |                               | PERCENT_CONCLUSAO             | Numeric          | Percentual de conclusão              |
| F0006      | MC        | PCA       | MCPCA              |                               | PERCENT_CONCLUSAO_AGREGADO    | Numeric          | Percentual de conclusão agregado     |
| F0006      | MC        | PCC       | MCPCC              |                               | VALOR_CUSTO_CONCLUSAO         | Numeric          | Valor do custo para conclusão (obsoleto) |
| F0006      | MC        | INTA      | MCINTA             |                               | COD_CALCULO_JUROS_RECEBER     | String           | Código para cálculo de juros (A/R)   |
| F0006      | MC        | INTL      | MCINTL             |                               | COD_CALCULO_JUROS_ATRASO      | String           | Código para cálculo de juros por atraso |
| F0006      | MC        | DOCO      | MCDOCO             |                               | PEDIDO                        | Numeric          | Número do documento (pedido, fatura, etc.) |
| F0006      | MC        | FMOD      | MCFMOD             |                               | FLAG_MODELO_CONTABIL          | Character        | Flag de modelo contábil e consolidação |
| F0006      | MC        | TA        | MCTA               |                               | AREA_TRIBUTARIA               | String           | Área tributária associada            |
| F0006      | MC        | TXJS      | MCTXJS             |                               | ENTIDADE_TRIBUTARIA           | Numeric          | Entidade tributária                  |
| F0006      | MC        | TXA1      | MCTXA1             |                               | TAXA_AREA_TRIBUTARIA          | String           | Taxa/Área tributária                 |
| F0006      | MC        | EXR1      | MCEXR1             |                               | COD_EXPLICACAO_TRIBUTO_1      | String           | Código de explicação tributária 1    |
| F0006      | MC        | TC01      | MCTC01             |                               | COD_TRIBUTO_DEDUCAO_01        | String           | Códigos de tributos/deduções 01      |
| F0006      | MC        | TC02      | MCTC02             |                               | COD_TRIBUTO_DEDUCAO_02        | String           | Códigos de tributos/deduções 02      |
| F0006      | MC        | TC03      | MCTC03             |                               | COD_TRIBUTO_DEDUCAO_03        | String           | Códigos de tributos/deduções 03      |
| F0006      | MC        | TC04      | MCTC04             |                               | COD_TRIBUTO_DEDUCAO_04        | String           | Códigos de tributos/deduções 04      |
| F0006      | MC        | TC05      | MCTC05             |                               | COD_TRIBUTO_DEDUCAO_05        | String           | Códigos de tributos/deduções 05      |
| F0006      | MC        | TC06      | MCTC06             |                               | COD_TRIBUTO_DEDUCAO_06        | String           | Códigos de tributos/deduções 06      |
| F0006      | MC        | TC07      | MCTC07             |                               | COD_TRIBUTO_DEDUCAO_07        | String           | Códigos de tributos/deduções 07      |
| F0006      | MC        | TC08      | MCTC08             |                               | COD_TRIBUTO_DEDUCAO_08        | String           | Códigos de tributos/deduções 08      |
| F0006      | MC        | TC09      | MCTC09             |                               | COD_TRIBUTO_DEDUCAO_09        | String           | Códigos de tributos/deduções 09      |
| F0006      | MC        | TC10      | MCTC10             |                               | COD_TRIBUTO_DEDUCAO_10        | String           | Códigos de tributos/deduções 10      |
| F0006      | MC        | ND01      | MCND01             |                               | COD_DISTRIBUICAO_TRIBUTARIA_01 | Character       | Códigos de distribuição tributária   |
| F0006      | MC        | ND02      | MCND02             |                               | COD_DISTRIBUICAO_TRIBUTARIA_02 | Character       | Códigos de distribuição tributária   |
| F0006      | MC        | ND03      | MCND03             |                               | COD_DISTRIBUICAO_TRIBUTARIA_03 | Character       | Códigos de distribuição tributária   |
| F0006      | MC        | ND04      | MCND04             |                               | COD_DISTRIBUICAO_TRIBUTARIA_04 | Character       | Códigos de distribuição tributária   |
| F0006      | MC        | ND05      | MCND05             |                               | COD_DISTRIBUICAO_TRIBUTARIA_05 | Character       | Códigos de distribuição tributária   |
| F0006      | MC        | ND06      | MCND06             |                               | COD_DISTRIBUICAO_TRIBUTARIA_06 | Character       | Códigos de distribuição tributária   |
| F0006      | MC        | ND07      | MCND07             |                               | COD_DISTRIBUICAO_TRIBUTARIA_07 | Character       | Códigos de distribuição tributária   |
| F0006      | MC        | ND08      | MCND08             |                               | COD_DISTRIBUICAO_TRIBUTARIA_08 | Character       | Códigos de distribuição tributária   |
| F0006      | MC        | ND09      | MCND09             |                               | COD_DISTRIBUICAO_TRIBUTARIA_09 | Character       | Códigos de distribuição tributária   |
| F0006      | MC        | ND10      | MCND10             |                               | COD_DISTRIBUICAO_TRIBUTARIA_10 | Character       | Códigos de distribuição tributária   |
| F0006      | MC        | CC01      | MCCC01             |                               | STATUS_CALC_TRIBUTO_01         | Character       | Status de cálculo de tributos        |
| F0006      | MC        | CC02      | MCCC02             |                               | STATUS_CALC_TRIBUTO_02         | Character       | Status de cálculo de tributos        |
| F0006      | MC        | CC03      | MCCC03             |                               | STATUS_CALC_TRIBUTO_03         | Character       | Status de cálculo de tributos        |
| F0006      | MC        | CC04      | MCCC04             |                               | STATUS_CALC_TRIBUTO_04         | Character       | Status de cálculo de tributos        |
| F0006      | MC        | CC05      | MCCC05             |                               | STATUS_CALC_TRIBUTO_05         | Character       | Status de cálculo de tributos        |
| F0006      | MC        | CC06      | MCCC06             |                               | STATUS_CALC_TRIBUTO_06         | Character       | Status de cálculo de tributos        |
| F0006      | MC        | CC07      | MCCC07             |                               | STATUS_CALC_TRIBUTO_07         | Character       | Status de cálculo de tributos        |
| F0006      | MC        | CC08      | MCCC08             |                               | STATUS_CALC_TRIBUTO_08         | Character       | Status de cálculo de tributos        |
| F0006      | MC        | CC09      | MCCC09             |                               | STATUS_CALC_TRIBUTO_09         | Character       | Status de cálculo de tributos        |
| F0006      | MC        | CC10      | MCCC10             |                               | STATUS_CALC_TRIBUTO_10         | Character       | Status de cálculo de tributos        |
| F0006      | MC        | PECC      | MCPECC             |                               | COD_EDICAO_LANCAMENTO          | Character       | Código de edição para lançamentos    |
| F0006      | MC        | ALS       | MCALS              |                               | METODO_SUM_ALOCACAO            | Character       | Método de sumarização de alocação    |
| F0006      | MC        | ISS       | MCISS              |                               | METODO_SUM_FATURA              | Character       | Método de sumarização de faturas     |
| F0006      | MC        | GLBA      | MCGLBA             |                               | CONTA_BANCO_CONTABIL           | String          | Conta bancária contábil              |
| F0006      | MC        | ALCL      | MCALCL             |                               | NIVEL_ALOCACAO                 | String          | Nível de alocação de custos          |
| F0006      | MC        | LMTH      | MCLMTH             |                               | METODO_DISTRIBUICAO_CUSTO      | Character       | Método de distribuição de custos     |
| F0006      | MC        | LF        | MCLF               |                               | MULTIPLICADOR_DISTRIBUICAO     | Numeric         | Multiplicador de distribuição        |
| F0006      | MC        | OBJ1      | MCOBJ1             |                               | CONTA_OBJETO_CUSTO             | String          | Conta objeto para custos             |
| F0006      | MC        | OBJ2      | MCOBJ2             |                               | CONTA_OBJETO_PREMIO            | String          | Conta objeto para prêmios            |
| F0006      | MC        | OBJ3      | MCOBJ3             |                               | CONTA_OBJETO_ENCARGO           | String          | Conta objeto para encargos           |
| F0006      | MC        | SUB1      | MCSUB1             |                               | SUB_ENCARGO                    | String          | Subsidiária para encargos            |
| F0006      | MC        | TOU       | MCTOU              |                               | TOTAL_UNIDADES                 | Numeric         | Total de unidades produzidas         |
| F0006      | MC        | D1J       | MCD1J              |                               | DATA_INICIO_PLANEJADO          | Date            | Data planejada de início             |
| F0006      | MC        | D2J       | MCD2J              |                               | DATA_INICIO_REAL               | Date            | Data real de início                  |
| F0006      | MC        | D3J       | MCD3J              |                               | DATA_CONCLUSAO_PLANEJADA       | Date            | Data planejada de conclusão          |
| F0006      | MC        | D4J       | MCD4J              |                               | DATA_CONCLUSAO_REAL            | Date            | Data real de conclusão               |
| F0006      | MC        | D5J       | MCD5J              |                               | DATA_ADICIONAL_05              | Date            | Data adicional 5 (uso variado)       |
| F0006      | MC        | D6J       | MCD6J              |                               | DATA_ADICIONAL_06              | Date            | Data adicional 6 (uso variado)       |
| F0006      | MC        | FPDJ      | MCFPDJ             |                               | DATA_PAGAMENTO_FINAL           | Date            | Data do pagamento final              |
| F0006      | MC        | CAC       | MCCAC              |                               | CUSTO_CONCLUSAO                | Numeric         | Custo total na conclusão             |
| F0006      | MC        | PAC       | MCPAC              |                               | LUCRO_CONCLUSAO                | Numeric         | Lucro total na conclusão             |
| F0006      | MC        | CT        | MCCT               |                               | TIPO_CONTRATO                  | String          | Tipo de contrato associado           |
| F0006      | MC        | CERT      | MCCERT             |                               | CONTRATO_CERTIFICADO           | Character       | Indicador de contrato certificado    |
| F0006      | MC        | PCTN      | MCPCTN             |                               | NUMERO_CONTRATO_PRINCIPAL      | Numeric         | Número do contrato principal         |
| F0006      | MC        | CLNU      | MCCLNU             |                               | NIVEL_CONTRATO                 | Numeric         | Nível do contrato                    |
| F0006      | MC        | USER      | MCUSER             | USER_ID                       | ID_USUARIO                     | String          | ID do usuário que fez a última alteração |
| F0006      | MC        | PID       | MCPID              | program_id                    | ID_PROGRAMA                    | String          | ID do programa que fez a última alteração |
| F0006      | MC        | UPMJ      | MCUPMJ             | last_update_date_julian       | DATA_ATUALIZACAO               | Date            | Data da última atualização           |
| F0006      | MC        | JOBN      | MCJOBN             | workstation_id                | ESTACAO_TRABALHO               | String          | ID da estação de trabalho            |
| F0006      | MC        | UPMT      | MCUPMT             | last_update_time              | HORA_ATUALIZACAO               | Numeric         | Hora da última atualização           |
| F0006      | MC        | AN8GCA1   | MCAN8GCA1          |                               | NUM_END_RELACIONADO_1          | Numeric         | Endereço relacionado 1               |
| F0006      | MC        | AN8GCA2   | MCAN8GCA2          |                               | NUM_END_RELACIONADO_2          | Numeric         | Endereço relacionado 2               |
| F0006      | MC        | AN8GCA3   | MCAN8GCA3          |                               | NUM_END_RELACIONADO_3          | Numeric         | Endereço relacionado 3               |
| F0006      | MC        | AN8GCA4   | MCAN8GCA4          |                               | NUM_END_RELACIONADO_4          | Numeric         | Endereço relacionado 4               |
| F0006      | MC        | AN8GCA5   | MCAN8GCA5          |                               | NUM_END_RELACIONADO_5          | Numeric         | Endereço relacionado 5               |
| F0006      | MC        | RMCU1     | MCRMCU1            |                               | UNI_NEGOCIO_RELACIONADA        | String          | Unidade de negócio relacionada       |
| F0006      | MC        | BUCA      | MCBUCA             |                               | CAT_ENCARGO                    | String          | Categoria de encargo/ônus            |
| F0006      | MC        | ADJENT    | MCADJENT           |                               | FLAG_LANCAMENTO_AJUSTE         | Character       | Indicador de lançamento de ajuste (S/N) |
| F0006      | MC        | UAFL      | MCUAFL             |                               | FLAG_NAO_PERMITIDO_FAR         | Character       | Flag de item não permitido (FAR)     |
| F0006      | MC        | SBLI      | MCSBLI             | subledger_inactive            | FLAG_SUBLEDGER_INATIVO         | Character       | Indicador de subledger inativo (S/N) |
| F0006      | MC        | ANPA      | MCANPA             |                               | NUMERO_ENDERECO_SUPERVISOR     | Numeric         | Número de endereço do supervisor     |
| F0006      | MC        | MCUS      | MCMCUS             |                               | UNI_NEGOCIO_SUBSEQUENTE        | String          | Unidade de negócio subsequente       |
| F0006      | MC        | BTYP      | MCBTYP             |                               | TIPO_FATURAMENTO               | Character       | Tipo de faturamento da unidade       |

## Principais Relacionamentos

[F0010](documentacao_tabela_F0010.md) (Company Master): MCCO (Centro de custo) → COCO (Companhia).

[F0101](documentacao_tabela_F0101.md) (Address Book): MCAN8 (Endereço associado).

[F41021](documentacao_tabela_F41021.md) (Location Master): MCMCU → LILOCN (Localização de estoque).

## Casos de Uso Comuns

Hierarquia Organizacional: Mapeamento de filiais, departamentos e centros de custo.

Controle Financeiro: Vinculação de transações contábeis à BU correta.

Gestão de Estoques: Definição de locais físicos e métodos de avaliação.

Relatórios Gerenciais: Agregação de dados por unidade de negócio.

Observações Importantes

**Formato de datas**: Muitos campos usam data juliana (ex: MCD1J).

**Campos flexíveis**: MCRPxx são reservados para uso customizado (ex: MCRP01 para moeda).

**Integração**: Essa tabela é referenciada em F4211 (Pedidos de Venda), F4111 (Movimentação de Estoque), etc.