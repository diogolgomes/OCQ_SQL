# Documentação Tabela F4104

Tabela JDE - F4104

0 - Tabela Bronze - BRONZE.BR_ F4104

0 - Tabela Silver - SILVER.SL_ F4104 (campo data tratado)

| CAMPO SILVER (SL_F4104) | CAMPO BRONZE (BR_F4104) | DESCRIÇÃO |
| --- | --- | --- |
| ID_PARCEIRO | IVAN8 | Chave do parceiro de negócio (Address Book Number). ID do cliente ou fornecedor. Liga-se à SL_F0101. |
| TIPO_REFERENCIA_CRUZADA | IVXRT | Campo Crítico. Define o tipo de parceiro/referência. Exemplos: 'C' (Customer), 'V' (Vendor), 'E' (EAN), 'U' (UPC). |
| ID_ITEM_JDE | IVITM | Chave do item interno (Short Item Number). É o ID que faz a ligação com a tabela SL_F4101. |
| DATA_FIM_VIGENCIA | IVEXDJ | Data final da validade da referência cruzada. Transformação necessária: Converter do formato Julian do JDE para data padrão (YYYY-MM-DD). |
| DATA_INICIO_VIGENCIA | IVEFTJ | Data de início da validade da referência cruzada. Transformação necessária: Converter do formato Julian do JDE para data padrão (YYYY-MM-DD). |
| COD_UNIDADE_NEGOCIO | IVMCU | Chave da Unidade de Negócio/Planta (Business Unit). Indica para qual filial/centro de custo a referência se aplica. |
| COD_ITEM_PARCEIRO | IVCITM | O código de referência cruzada em si. Por exemplo, o código do seu produto no catálogo do fornecedor ou do cliente. |
| DESCRICAO1 | IVDSC1 | Linha 1 de descrição para a referência cruzada. |
| DESCRICAO2 | IVDSC2 | Linha 2 de descrição para a referência cruzada. |
| TEXTO_BUSCA | IVALN | Texto de busca (Search Text Alpha Name). |
| COD_ITEM_SECUNDARIO | IVLITM | Código secundário do item (2nd Item Number) da F4101. |
| COD_ITEM_TERCIARIO | IVAITM | Código terciário do item (3rd Item Number) da F4101. |
| ID_USUARIO_ALTERACAO | IVUSER | ID do usuário que criou ou modificou o registro. |
| ID_PROGRAMA_ALTERACAO | IVPID | ID do programa/aplicação que criou ou modificou o registro. |
| NOME_JOB_ALTERACAO | IVJOBN | Nome do Job (processo) que criou ou modificou o registro. |
| DATA_ULTIMA_ALTERACAO | IVUPMJ | Data da última atualização. Transformação necessária: Converter do formato Julian do JDE para data padrão (YYYY-MM-DD). |
| HORA_ULTIMA_ALTERACAO | IVTDAY | Hora da última atualização (formato numérico HHMMSS). Transformação necessária: Converter para formato de hora (HH:MI:SS). |
| codigo_usuario | IVURCD | Campos reservados para customizações (User Reserved Fields). Mapear se houver uso específico na sua implementação. |
| data_ultima_revisao | IVURDT | Campos reservados para customizações (User Reserved Fields). Mapear se houver uso específico na sua implementação. |
| tipo_ultima_revisao | IVURAT | Campos reservados para customizações (User Reserved Fields). Mapear se houver uso específico na sua implementação. |
| descricao_revisao | IVURAB | Campos reservados para customizações (User Reserved Fields). Mapear se houver uso específico na sua implementação. |
| referencia_revisao | IVURRF | Campos reservados para customizações (User Reserved Fields). Mapear se houver uso específico na sua implementação. |
| taxa_cambio | IVRATO | Campos relacionados a funcionalidades específicas como precificação, aprovações, etc. Devem ser analisados caso a caso. IVCARDNO por exemplo é usado para "Card Number" em alguns cenários. |
| aprovador | IVAPSP | Campos relacionados a funcionalidades específicas como precificação, aprovações, etc. Devem ser analisados caso a caso. IVCARDNO por exemplo é usado para "Card Number" em alguns cenários. |
| metodo_distribuicao | IVIDEM | Campos relacionados a funcionalidades específicas como precificação, aprovações, etc. Devem ser analisados caso a caso. IVCARDNO por exemplo é usado para "Card Number" em alguns cenários. |
| status_aprovacao | IVAPSS | Campos relacionados a funcionalidades específicas como precificação, aprovações, etc. Devem ser analisados caso a caso. IVCARDNO por exemplo é usado para "Card Number" em alguns cenários. |
| codigo_revisao | IVCIRV | Campos relacionados a funcionalidades específicas como precificação, aprovações, etc. Devem ser analisados caso a caso. IVCARDNO por exemplo é usado para "Card Number" em alguns cenários. |
| indicador_endereco | IVADIND | Campos relacionados a funcionalidades específicas como precificação, aprovações, etc. Devem ser analisados caso a caso. IVCARDNO por exemplo é usado para "Card Number" em alguns cenários. |
| indicador_backorder | IVBPIND | Campos relacionados a funcionalidades específicas como precificação, aprovações, etc. Devem ser analisados caso a caso. IVCARDNO por exemplo é usado para "Card Number" em alguns cenários. |
| numero_cartao | IVCARDNO | Campos relacionados a funcionalidades específicas como precificação, aprovações, etc. Devem ser analisados caso a caso. IVCARDNO por exemplo é usado para "Card Number" em alguns cenários. |

**Chave Primária:** A chave primária da tabela F4104 é a combinação dos campos IVMCU, IVITM, IVAN8, e IVXRT. A inclusão da Unidade de Negócio (IVMCU) é crucial, pois uma mesma referência pode existir para um item em uma filial, mas não em outra.

**Lógica de Negócio:** A lógica permanece a mesma, mas agora com os campos corretos. Para buscar o código de um produto no fornecedor, a consulta usaria IVITM, IVAN8 (ID do fornecedor) e IVXRT = 'V'.

**Relacionamentos Chave na Camada Silver:**

- SL_F4104.ID_ITEM_JDE se relaciona com SL_F4101.COD_ITEM.
- SL_F4104.ID_PARCEIRO se relaciona com SL_F0101.ID_PARCEIRO.
- SL_F4104.COD_UNIDADE_NEGOCIO se relaciona com SL_F0006.COD_UNIDADE_NEGOCIO (tabela de Unidades de Negócio).

## Casos de Uso Típicos

- Gestão de Preços: IVXRT e IVRATO para câmbio cliente-item
- Validade de Contratos: IVEXDJ para controle de prazos
- Aprovações Comerciais: IVAPSS e IVAPSP para workflow
- Dados Customizados: IVADIND e IVBPIND para regras específicas

## Lógica de Funcionamento e os Campos-Chave

A mágica da F4104 acontece pela combinação da sua chave primária, que, como vimos, é (IVMCU, IVITM, IVAN8, IVXRT). Vamos detalhar com um exemplo prático.

Nosso Item Interno:

Produto: Parafuso Sextavado de Aço Inox M6

Nosso Código (IVITM): 10010

Unidade de Negócio (IVMCU): BR30 (Fábrica de São Paulo)

Cenário 1: Comprando do Fornecedor "Aços Global"

ID do Fornecedor (IVAN8): 7890

Código do Item no Fornecedor (IVCITM): AG-77-INOX

Tipo de Referência (IVXRT): 'V' (Vendor)

Registro na F4104: (BR30, 10010, 7890, 'V') -> AG-77-INOX

Cenário 2: Vendendo para o Cliente "Montadora Brasil"

ID do Cliente (IVAN8): 456

Código do Item na Montadora (IVCITM): 998877-B

Tipo de Referência (IVXRT): 'C' (Customer)

Registro na F4104: (BR30, 10010, 456, 'C') -> 998877-B

Cenário 3: Código de Barras da Caixa

ID do Parceiro (IVAN8): Geralmente 0 ou o ID da própria empresa, pois o código de barras é universal.

Código de Barras (IVCITM): 7891234567890

Tipo de Referência (IVXRT): 'E' (EAN)

Registro na F4104: (BR30, 10010, 0, 'E') -> 7891234567890

Como você pode ver, um único item interno (10010) possui múltiplas "identidades" no mundo externo, e a F4104 organiza todas elas de forma única e sem ambiguidade.