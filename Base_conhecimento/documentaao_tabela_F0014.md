# Documentação da Tabela F0014

A tabela F0014 no JD Edwards 9.2 é conhecida como a tabela de \"Tipos de
Documentos\" (Document Types). Ela armazena as definições dos tipos de
documentos utilizados no sistema para diversos propósitos, como ordens
de venda, pedidos de compra, faturas, etc.

Principais Campos e Descrições:

* PNPTC - Document Type Code (Código do tipo de documento)
* PNPTD - Document Type Description (Descrição do tipo de documento)
* PNDCP - Document Category Code (Código da categoria do documento)
* PNDCD - Document Category Description (Descrição da categoria do documento)
* PNNDTP - Next Document Type (Próximo tipo de documento)
* PNDDJ - Date - Date Updated (Julian) (Data de atualização em formato Julian)
* PNNSP - Next Status (Próximo status)
* PNDTPA - Document Type Alias (Alias do tipo de documento)
* PNEIR - Error Handling (Tratamento de erro)
* PNUSER - User ID (ID do usuário)
* PNPID - Program ID (ID do programa)
* PNUPMJ - Date - Updated (Julian) (Data de atualização em formato Julian)
* PNJOBN - Work Station ID (ID da estação de trabalho)
* PNUPMT - Time - Last Updated (Hora da última atualização)
* PNPXDM - Prefix Document Message (Mensagem de prefixo do documento)
* PNPXDD - Prefix Document Description (Descrição do prefixo do documento)

## DE-PARA para Camada Silver (SL_F0014)

Aqui está a sugestão de mapeamento para a camada Silver:

| **TABELA** | **ALIAS** | **CAMPO** | **Campo Original** |   **Campo Silver (Inglês)**   |  **Campo Silver (Português)** | **Tipo de Dado** |             **Descrição**            |
|------------|-----------|-----------|--------------------|-------------------------------|-------------------------------|------------------|--------------------------------------|
| F0014      | PN        | PTC       | PNPTC              | document_type_code            | COD_TIPO_DOCUMENTO            | String           | Código do tipo de documento          |
| F0014      | PN        | PTD       | PNPTD              | document_type_description     | DESCRICAO_TIPO_DOCUMENTO      | String           | Descrição do tipo de documento       |
| F0014      | PN        | DCP       | PNDCP              | document_category_code        | COD_CATEGORIA_DOCUMENTO       | String           | Código da categoria do documento     |
| F0014      | PN        | DCD       | PNDCD              | document_category_description | DESCRICAO_CATEGORIA_DOCUMENTO | String           | Descrição da categoria do documento  |
| F0014      | PN        | NDTP      | PNNDTP             | next_document_type            | PROXIMO_TIPO_DOCUMENTO        | String           | Próximo tipo de documento            |
| F0014      | PN        | DDJ       | PNDDJ              | update_date_julian            | DATA_ATUALIZACAO              | Integer          | Data de atualização (Juliano)        |
| F0014      | PN        | NSP       | PNNSP              | next_status                   | PROXIMO_STATUS                | String           | Próximo status                       |
| F0014      | PN        | DTPA      | PNDTPA             | document_type_alias           | ALIAS_TIPO_DOCUMENTO          | String           | Alias do tipo de documento           |
| F0014      | PN        | EIR       | PNEIR              | error_handling                | TRATAMENTO_ERRO               | String           | Tratamento de erro                   |
| F0014      | PN        | USER      | PNUSER             | USER_ID                       | ID_USUARIO                    | String           | ID do usuário                        |
| F0014      | PN        | PID       | PNPID              | program_id                    | ID_PORGRAMA                   | String           | ID do programa                       |
| F0014      | PN        | UPMJ      | PNUPMJ             | last_update_date_julian       | DATA_ULTIMA_ATUALIZACAO       | Date             | Data da última atualização (Juliano) |
| F0014      | PN        | JOBN      | PNJOBN             | workstation_id                | ESTACAO_TRABALHO              | String           | ID da estação de trabalho            |
| F0014      | PN        | UPMT      | PNUPMT             | last_update_time              | HORA_ATUALIZACAO              | Time             | Hora da última atualização           |
| F0014      | PN        | PXDM      | PNPXDM             | prefix_document_message       | MSG_PREFIXO_DOCUMENTO         | String           | Mensagem de prefixo do documento     |
| F0014      | PN        | PXDD      | PNPXDD             | prefix_document_description   | DESCRICAO_PREFIXO_DOCUMENTO   | String           | Descrição                            |

SQL para Criação da Tabela Silver

~~~sql

CREATE OR REPLACE TABLE SL_F0014 AS
SELECT
    PNPTC AS COD_TIPO_DOCUMENTO,
    PNPTD AS DESCRICAO_TIPO_DOCUMENTO,
    PNDCP AS COD_CATEGORIA_DOCUMENTO,
    PNDCD AS DESCRICAO_CATEGORIA_DOCUMENTO,
    PNNDTP AS PROXIMO_TIPO_DOCUMENTO,
    PNDDJ AS DATA_ATUALIZACAO,
    PNNSP AS PROXIMO_STATUS,
    PNDTPA AS ALIAS_TIPO_DOCUMENTO,
    PNEIR AS TRATAMENTO_ERRO,
    PNUSER AS ID_USUARIO,
    PNPID AS ID_PORGRAMA,
    PNUPMJ AS DATA_ULTIMA_ATUALIZACAO,
    PNJOBN AS ESTACAO_TRABALHO,
    PNUPMT AS HORA_ATUALIZACAO,
    PNPXDM AS MSG_PREFIXO_DOCUMENTO,
    PNPXDD AS DESCRICAO_PREFIXO_DOCUMENTO
FROM BR_F0014;
~~~

### Recomendações para a Camada Silver:

* Conversão de datas: Considere adicionar campos com as datas convertidas do formato Julian para DATE
* Metadados: Adicione campos como data_de_carregamento e origem_dados
* Normalização: Esta tabela é essencialmente uma tabela de dimensão, considere criar uma chave substituta (surrogate key)
* Enriquecimento: Pode ser útil adicionar flags indicando se são documentos ativos ou inativos
* Consistência: Verifique a necessidade de aplicar trim() nos campos de texto para remover espaços em branco
