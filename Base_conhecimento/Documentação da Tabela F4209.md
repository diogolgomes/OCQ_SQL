# Documentação da Tabela F4209

A tabela F4209 no JD Edwards 9.2 é a tabela de cabeçalho de ordens de venda (Sales Order Header). Ela armazena informações principais sobre as ordens de venda criadas no sistema.

Principais Campos e Descrições:

* HOKCOO - Company (Número da empresa)
* HODOCO - Order Number (Número da ordem)
* HODCTO - Order Type (Tipo de ordem)
* HOSFXO - Order Suffix (Sufixo da ordem)
* HOAN8 - Customer Number (Número do cliente)
* HOMCU - Business Unit (Unidade de negócios)
* HOTRDJ - Transaction Date (Julian) (Data da transação em formato Julian)
* HODRQJ - Requested Date (Julian) (Data solicitada em formato Julian)
* HOPDDJ - Promised Delivery Date (Julian) (Data prometida de entrega em formato Julian)
* HOCTYP - Contract Type (Tipo de contrato)
* HORDB - Base Order Number (Número da ordem base)
* HORDJ - Date - Order (Julian) (Data da ordem em formato Julian)
* HOASTS - Status Code (Código de status)
* HOEDEI - EDI Order Number (Número da ordem EDI)

DE-PARA para Camada Silver (SL\_F4209)

Aqui está uma sugestão de mapeamento dos campos para a camada Silver com nomes mais descritivos:

|**Campo Original**|**Campo Silver (Inglês)**|**Campo Silver (Português)**|**Tipo de Dado**|**Descrição**|
| :- | :- | :- | :- | :- |
|HOHCOD|header\_code|COD\_CABECALHO|String|Código do cabeçalho|
|HORPER|price\_period|periodo\_preco|String|Período de preço|
|HOAN8|customer\_number|COD\_CLIENTE|Integer|Número do cliente|
|HOMCU|business\_unit|COD\_FILIAL|String|Unidade de negócios|
|HOKCOO|company\_code|COD\_EMPRESA|String|Código da empresa|
|HODOCO|order\_number|PEDIDO|Integer|Número da ordem|
|HODCTO|order\_type|TIPO\_PEDIDO|String|Tipo de ordem|
|HOSFXO|order\_suffix|sufixo\_ordem|String|Sufixo da ordem|
|HOLNID|line\_id|ID\_LINHA|Integer|ID da linha|
|HOITM|item\_number\_short|numero\_item\_curto|Integer|Número do item (curto)|
|HOLITM|item\_number|numero\_item|String|Número do item|
|HOAITM|item\_number\_3rd\_party|numero\_item\_terceiro|String|Número do item de terceiro|
|HOTRDJ|transaction\_date\_julian|DATA\_PEDIDO|DATE|Data da transação (Juliano)|
|HODRQJ|requested\_date\_julian|DATA\_SOLICITACAO|DATE|Data solicitada (Juliano)|
|HOPDDJ|promised\_date\_julian|DATA\_PROMETIDA|Integer|Data prometida (Juliano)|
|HOCTYP|contract\_type|tipo\_contrato|String|Tipo de contrato|
|HORDC|order\_category|categoria\_ordem|String|Categoria da ordem|
|HORDB|base\_order\_number|numero\_ordem\_base|Integer|Número da ordem base|
|HORDJ|order\_date\_julian|data\_ordem\_juliana|Integer|Data da ordem (Juliano)|
|HORDT|order\_time|hora\_ordem|Time|Hora da ordem|
|HOARTG|agreement\_type|tipo\_acordo|String|Tipo de acordo|
|HOASTS|status\_code|COD\_STATUS|String|Código de status|
|HOATY|adjustment\_type|tipo\_ajuste|String|Tipo de ajuste|
|HOEDEI|edi\_order\_number|numero\_ordem\_edi|String|Número da ordem EDI|
|HODLNID|delivery\_line\_id|id\_linha\_entrega|Integer|ID da linha de entrega|
|HOPA8|payer\_number|numero\_pagador|Integer|Número do pagador|
|HOSHAN|handling\_code|codigo\_manuseio|String|Código de manuseio|


SQL para Criação da Tabela Silver

~~~sql

CREATE OR REPLACE TABLE SL_F4209 AS
SELECT 
	HOHCOD AS codigo_cabecalho,
	HORPER AS periodo_preco,
	HOAN8 AS numero_cliente,
	HOMCU AS unidade_negocio,
	HOKCOO AS codigo_empresa,
	HODOCO AS PEDIDO,
	HODCTO AS TIPO_ORDEM,
	HOSFXO AS sufixo_ordem,
	HOLNID AS id_linha,
	HOITM AS numero_item_curto,
	HOLITM AS numero_item,
	HOAITM AS numero_item_terceiro,
	HOTRDJ AS data_transacao_juliana,
	HODRQJ AS data_solicitada_juliana,
	HOPDDJ AS data_prometida_juliana,
	HOCTYP AS tipo_contrato,
	HORDC AS categoria_ordem,
	HORDB AS numero_ordem_base,
	HORDJ AS dataH_ordem_juliana,
	HORDT AS hora_ordem,
	HOARTG AS tipo_acordo,
	HOASTS AS codigo_status,
	HOATY AS tipo_ajuste,
	HOEDEI AS numero_ordem_edi,
	HODLNID AS id_linha_entrega,
	HOPA8 AS numero_pagador,
	HOSHAN AS codigo_manuseio
FROM BR_F4209;

~~~

Recomendações para a Camada Silver:

Considere adicionar campos calculados como datas convertidas do formato Julian para formato DATE

Pode ser útil adicionar campos de metadados como data\_de\_carregamento e fonte\_dados

Avalie a necessidade de aplicar alguma limpeza básica nos dados

Considere adicionar chaves estrangeiras para relacionamento com outras tabelas dimensionais

Precisa de alguma adaptação ou informação adicional sobre algum campo específico?
