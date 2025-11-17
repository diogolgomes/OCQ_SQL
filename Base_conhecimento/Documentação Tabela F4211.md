# Documentação Tabela F4211

## Tabela F4211 - Detalhamento de Linhas de Pedidos de Vendas (Sales Order Detail)

A tabela F4211 (também conhecida como Sales Order Detail File) é uma das tabelas mais importantes no sistema JD Edwards EnterpriseOne (JDE). Ela armazena todas as linhas de pedidos de vendas, contendo informações detalhadas sobre os itens solicitados, preços, quantidades, condições comerciais, datas, status e muito mais. Essa tabela está diretamente relacionada à F4201 (cabeçalho do pedido de venda), onde cada linha na F4211 está vinculada a um registro na F4201.

## Principais Características da Tabela F4211

- Armazena dados transacionais: Registra todas as linhas de pedidos de vendas, incluindo itens, quantidades, preços e condições.
- Relacionamento com outras tabelas:
  - F4201 (Cabeçalho do Pedido de Venda) → Chave: SDDOCO (Nº Documento) + SDDCTO (Tipo Documento) + SDKCOO (Companhia).
  - F4101 (Cadastro de Itens) → Chave: SDITM (Nº Item).
  - F0101 (Cadastro de Clientes) → Chave: SDAN8 (Endereço do Cliente).
- Estrutura flexível: Permite múltiplas linhas por pedido, com diferentes tipos de itens (produtos, serviços, kits, etc.).
- Histórico de movimentações: Registra alterações de status, quantidades, preços e datas ao longo do ciclo de vida do pedido.

## Principais Campos e Seus Significados

A tabela F4211 possui centenas de campos, mas podemos agrupá-los em categorias principais:

1.Identificação do Pedido e Linha

| Campo (F4211) | Descrição |
| --- | --- |
| SDDOCO | Número do documento (pedido) |
| SDDCTO | Tipo de documento (ex: "SO" para Sales Order) |
| SDLNID | Identificador único da linha |
| SDKCOO | Código da companhia |
| SDITM | Número do item (relacionado à F4101) |
| SDLITM | Descrição secundária do item |

2.Informações do Item e Quantidades

| Campo (F4211) | Descrição |
| --- | --- |
| SDUOM | Unidade de medida (ex: "UN", "KG") |
| SDUORG | Quantidade original solicitada |
| SDSOQS | Quantidade em estoque reservada |
| SDSOBK | Quantidade em backorder (não atendida) |
| SDQTYT | Quantidade total processada |

3\. Preços e Custos

| Campo (F4211) | Descrição |
| --- | --- |
| SDUPRC | Preço unitário definido pelo usuário |
| SDORPR | Preço unitário original |
| SDUNCS | Custo unitário padrão |
| SDECST | Custo total calculado (quantidade × custo unitário) |

4.Datas e Prazos

| Campo (F4211) | Descrição |
| --- | --- |
| SDDRQJ | Data solicitada pelo cliente (formato juliano) |
| SDADDJ | Data de criação da linha (formato juliano) |
| SDPDDJ | Data de entrega prometida (formato juliano) |
| SDIVD | Data de faturamento (formato juliano) |

5\. Status e Fluxo do Pedido

| Campo (F4211) | Descrição |
| --- | --- |
| SDNXTR | Próximo status no fluxo (ex: "540" para faturado) |
| SDLTTR | Último status processado (ex: "520" para enviado) |
| SDBACK | Indica se há backorder ("Y" ou "N") |
| SDAPTS | Código de aprovação do pedido |

6.Informações de Entrega e Logística

| Campo (F4211) | Descrição |
| --- | --- |
| SDSHAN | Endereço de entrega (relacionado a F0101) |
| SDCARS | Transportadora responsável |
| SDROUT | Rota de entrega |
| SDSTOP | Ponto de parada no roteiro |

7.Campos de Auditoria e Controle

| Campo (F4211) | Descrição |
| --- | --- |
| SDUSER | Usuário que criou/modificou a linha |
| SDUPMJ | Data da última atualização (formato juliano) |
| SDJOBN | Nome do job que processou a linha |
| SDPID | Programa que gerou a transação |

Relacionamentos Chave

A F4211 está conectada a várias tabelas importantes:

F4201 (Cabeçalho do Pedido) → SDDOCO + SDDCTO + SDKCOO

F4101 (Itens Mestre) → SDITM

F0101 (Clientes) → SDAN8 (Endereço do Cliente)

F0116 (Endereços) → SDSHAN (Endereço de Entrega)

## Conclusão

A F4211 é essencial para:

Gestão de pedidos: Rastreamento de itens, quantidades e status.

Análise comercial: Cálculo de receitas, margens e desempenho de vendas.

Logística: Planejamento de entregas e controle de estoque.

Integração com ERP: Fluxo entre vendas, estoque e faturamento.

### Tabela JDE - F4211

0 - Tabela Bronze - BRONZE.BR_ F4211

0 - Tabela Silver - SILVER.SL_ F4211 (campo data tratado)

| CAMPO BRONZE (BR_F4211) | CAMPO SILVER | DESCRIÇÃO |
| --- | --- | --- |
| SDPNS | numero_sequencia_pedido | Número de sequência do pedido |
| SDUNCD | unidade_negocio | Unidade de negócio |
| SDCRMD | COD_MOEDA | Código da moeda |
| SDCRCD | COD_transacao_credito | Código da transação de crédito |
| SDCRR | TAXA_CAMBIO | Taxa de câmbio |
| SDFPRC | PRECO_UNITARIO | Preço unitário |
| SDFUP | fator_preco_unitario | Fator de preço unitário |
| SDFEA | valor_estendido | Valor estendido |
| SDFUC | CUSTO_UNITARIO | Custo unitário |
| SDFEC | custo_estendido | Custo estendido |
| SDURCD | COD_USUARIO | Código do usuário |
| SDURDT | data_ultima_revisao | Data da última revisão |
| SDURAT | tipo_ultima_revisao | Tipo da última revisão |
| SDURAB | descricao_ultima_revisao | Descrição da última revisão |
| SDURRF | referencia_ultima_revisao | Referência da última revisão |
| SDTORG | TIPO_ORIGEM | Tipo de origem |
| SDUSER | USUARIO | Usuário |
| SDPID | ID_PROGRAMA | ID do programa |
| SDJOBN | NOME_JOB | Nome do job |
| SDUPMJ | DATA_ATUALIZACAO | Data da última atualização (formato juliano) |
| SDTDAY | HORA_ATUALIZACAO | Hora da última atualização |
| SDSO16 | campo_sobressalente_16 | Campo sobressalente 16 |
| SDSO17 | campo_sobressalente_17 | Campo sobressalente 17 |
| SDSO18 | campo_sobressalente_18 | Campo sobressalente 18 |
| SDSO19 | campo_sobressalente_19 | Campo sobressalente 19 |
| SDSO20 | campo_sobressalente_20 | Campo sobressalente 20 |
| SDIR01 | campo_reservado_interno_01 | Campo reservado interno 01 |
| SDIR02 | campo_reservado_interno_02 | Campo reservado interno 02 |
| SDIR03 | campo_reservado_interno_03 | Campo reservado interno 03 |
| SDIR04 | campo_reservado_interno_04 | Campo reservado interno 04 |
| SDIR05 | campo_reservado_interno_05 | Campo reservado interno 05 |
| SDSOOR | numero_pedido_original | Número do pedido original |
| SDVR03 | versao_aplicativo | Versão do aplicativo |
| SDDEID | id_dispositivo_eletronico | ID do dispositivo eletrônico |
| SDPSIG | assinatura_pagamento | Assinatura de pagamento |
| SDRLNU | numero_relacionamento | Número de relacionamento |
| SDPMDT | data_pagamento | Data de pagamento |
| SDRLTM | hora_relacionamento | Hora do relacionamento |
| SDRLDJ | data_relacionamento_juliana | Data do relacionamento (formato juliano) |
| SDDRQT | DATA_REQUISITADA | Data requisitada |
| SDADTM | DATA_APROVACAO | Data de aprovação |
| SDOPTT | hora_operacao | Hora da operação |
| SDPDTT | data_programada | Data programada |
| SDPSTM | hora_processamento | Hora de processamento |
| SDXDCK | numero_documento_externo | Número do documento externo |
| SDXPTY | tipo_pedido_externo | Tipo de pedido externo |
| SDDUAL | indicador_dual | Indicador dual |
| SDBSC | base_calculo | Base de cálculo |
| SDCBSC | codigo_base_calculo | Código da base de cálculo |
| SDCORD | numero_contrato | Número do contrato |
| SDDVAN | numero_van | Número da van |
| SDPEND | indicador_pendente | Indicador pendente |
| SDRFRV | valor_referencia | Valor de referência |
| SDMCLN | numero_linha_mestre | Número da linha mestre |
| SDSHPN | numero_parte_entrega | Número da parte de entrega |
| SDRSDT | data_reserva | Data de reserva |
| SDPRJM | numero_projeto | Número do projeto |
| SDOSEQ | sequencia_ordem | Sequência da ordem |
| SDMERL | nivel_mercadologico | Nível mercadológico |
| SDHOLD | codigo_retencao | Código de retenção |
| SDHDBU | unidade_negocio_entrega | Unidade de negócio de entrega |
| SDDMBU | unidade_negocio_demanda | Unidade de negócio de demanda |
| SDBCRC | codigo_retencao_backorder | Código de retenção de backorder |
| SDODLN | numero_linha_original | Número da linha original |
| SDOPDJ | data_operacao_juliana | Data da operação (formato juliano) |
| SDXKCO | companhia_origem | Companhia de origem |
| SDXORN | numero_ordem_origem | Número da ordem de origem |
| SDXCTO | tipo_ordem_origem | Tipo de ordem de origem |
| SDXLLN | numero_linha_origem | Número da linha de origem |
| SDXSFX | sufixo_origem | Sufixo de origem |
| SDPOE | processamento_ordem_entrada | Processamento de ordem de entrada |
| SDPMTO | metodo_pagamento | Método de pagamento |
| SDANBY | aprovado_por | Aprovado por |
| SDPMTN | numero_parcela_pagamento | Número da parcela de pagamento |
| SDNUMB | numero | Número |
| SDAAID | id_autorizacao | ID de autorização |
| SDSPATTN | atencao_entrega | Atenção de entrega |
| SDPRAN8 | endereco_principal | Endereço principal |
| SDPRCIDLN | linha_endereco_principal | Linha do endereço principal |
| SDCCIDLN | linha_endereco_cobranca | Linha do endereço de cobrança |
| SDSHCCIDLN | linha_endereco_entrega | Linha do endereço de entrega |
| SDOPPID | id_operador | ID do operador |
| SDOSTP | passo_ordem_servico | Passo da ordem de serviço |
| SDUKID | id_unico | ID único |
| SDCATNM | nome_categoria | Nome da categoria |
| SDALLOC | codigo_alocacao | Código de alocação |
| SDFULPID | id_preenchimento | ID de preenchimento |
| SDALLSTS | status_alocacao | Status de alocação |
| SDOSCORE | pontuacao_ordem_servico | Pontuação da ordem de serviço |
| SDOSCOREO | pontuacao_original_ordem_servico | Pontuação original da ordem de serviço |
| SDCMCO | companhia_comissionada | Companhia comissionada |
| SDKITID | id_kit | ID do kit |
| SDKITAMTDOM | valor_kit_domestico | Valor do kit doméstico |
| SDKITAMTFOR | valor_kit_estrangeiro | Valor do kit estrangeiro |
| SDKITDIRTY | indicador_kit_modificado | Indicador de kit modificado |
| SDOCITT | cidade_cartao_credito | Cidade do cartão de crédito |
| SDOCCARDNO | numero_cartao_credito | Número do cartão de crédito |
| SDPMPN | numero_parte_principal | Número da parte principal |
| SDUPRC | preco_unitario_usuario | Preço unitário do usuário |
| SDAEXP | data_expiracao_autorizacao | Data de expiração da autorização |
| SDAOPN | data_abertura_autorizacao | Data de abertura da autorização |
| SDPROV | codigo_provedor | Código do provedor |
| SDTPC | tipo_codigo_preco | Tipo de código de preço |
| SDAPUM | preco_unitario_medio_aprovado | Preço unitário médio aprovado |
| SDLPRC | preco_unitario_lista | Preço unitário de lista |
| SDUNCS | custo_unitario_padrao | Custo unitário padrão |
| SDECST | custo_estendido_calculado | Custo estendido calculado |
| SDCSTO | custo_estendido_original | Custo estendido original |
| SDTCST | custo_total | Custo total |
| SDINMG | COD_GRUPO_ITEM | Código do grupo do item |
| SDPTC | tipo_codigo_produto | Tipo de código do produto |
| SDRYIN | ano_entrada | Ano de entrada |
| SDDTBS | data_base | Data base |
| SDTRDC | COD_TRANSACAO | Código de transação |
| SDFUN2 | campo_flexivel_2 | Campo flexível 2 |
| SDASN | numero_aviso_remessa | Número do aviso de remessa |
| SDPRGR | grupo_preco | Grupo de preço |
| SDCLVL | nivel_cliente | Nível do cliente |
| SDCADC | COD_CLIENTE_ADICIONAL | Código do cliente adicional |
| SDKCO | COMPANHIA | Companhia |
| SDDOC | numero_documento | Número do documento |
| SDDCT | tipo_documento | Tipo de documento |
| SDODOC | numero_documento_original | Número do documento original |
| SDODCT | tipo_documento_original | Tipo do documento original |
| SDOKC | companhia_original | Companhia original |
| SDPSN | numero_sequencia_pedido | Número de sequência do pedido |
| SDDELN | numero_linha_entrega | Número da linha de entrega |
| SDTAX1 | codigo_imposto_1 | Código do imposto 1 |
| SDTXA1 | area_imposto_1 | Área do imposto 1 |
| SDEXR1 | taxa_imposto_1 | Taxa do imposto 1 |
| SDATXT | texto_imposto | Texto do imposto |
| SDPRIO | prioridade | Prioridade |
| SDRESL | COD_RESULTADO | Código do resultado |
| SDBACK | indicador_backorder | Indicador de backorder |
| SDSBAL | saldo_secundario | Saldo secundário |
| SDAPTS | COD_APROVACAO | Código de aprovação |
| SDLOB | linha_negocios | Linha de negócios |
| SDEUSE | COD_USO_ELETRONICO | Código de uso eletrônico |
| SDDTYS | tipo_destino | Tipo de destino |
| SDNTR | numero_transporte | Número de transporte |
| SDVEND | COD_VENDEDOR | Código do vendedor |
| SDCARS | COD_CARRIER | Código do carrier |
| SDMOT | MOTIVO | Motivo |
| SDROUT | ROTA | Rota |
| SDSTOP | ponto_parada | Ponto de parada |
| SDZON | ZONA | Zona |
| SDCNID | id_conhecimento | ID do conhecimento |
| SDFRTH | frete_terceiro | Frete de terceiro |
| SDSHCM | codigo_metodo_entrega | Código do método de entrega |
| SDSHCN | numero_container_entrega | Número do container de entrega |
| SDSERN | numero_serie | Número de série |
| SDUOM1 | unidade_medida_primaria | Unidade de medida primária |
| SDPQOR | quantidade_pedido | Quantidade do pedido |
| SDUOM2 | unidade_medida_secundaria | Unidade de medida secundária |
| SDSQOR | quantidade_secundaria | Quantidade secundária |
| SDUOM4 | unidade_medida_quaternaria | Unidade de medida quaternária |
| SDITWT | peso_item | Peso do item |
| SDWTUM | unidade_medida_peso | Unidade de medida de peso |
| SDITVL | volume_item | Volume do item |
| SDVLUM | unidade_medida_volume | Unidade de medida de volume |
| SDRPRC | preco_unitario_real | Preço unitário real |
| SDORPR | preco_unitario_original | Preço unitário original |
| SDORP | preco_original | Preço original |
| SDCMGP | grupo_comissao | Grupo de comissão |
| SDGLC | codigo_centro_custo | Código do centro de custo |
| SDCTRY | codigo_pais | Código do país |
| SDFY | ano_fiscal | Ano fiscal |
| SDSO01 | campo_sobressalente_01 | Campo sobressalente 01 |
| SDSO02 | campo_sobressalente_02 | Campo sobressalente 02 |
| SDSO03 | campo_sobressalente_03 | Campo sobressalente 03 |
| SDSO04 | campo_sobressalente_04 | Campo sobressalente 04 |
| SDSO05 | campo_sobressalente_05 | Campo sobressalente 05 |
| SDSO06 | campo_sobressalente_06 | Campo sobressalente 06 |
| SDSO07 | campo_sobressalente_07 | Campo sobressalente 07 |
| SDSO08 | campo_sobressalente_08 | Campo sobressalente 08 |
| SDSO09 | campo_sobressalente_09 | Campo sobressalente 09 |
| SDSO10 | campo_sobressalente_10 | Campo sobressalente 10 |
| SDSO11 | campo_sobressalente_11 | Campo sobressalente 11 |
| SDSO12 | campo_sobressalente_12 | Campo sobressalente 12 |
| SDSO13 | campo_sobressalente_13 | Campo sobressalente 13 |
| SDSO14 | campo_sobressalente_14 | Campo sobressalente 14 |
| SDSO15 | campo_sobressalente_15 | Campo sobressalente 15 |
| SDACOM | codigo_comissao | Código de comissão |
| SDCMCG | grupo_comissao_cliente | Grupo de comissão do cliente |
| SDRCD | codigo_receita | Código de receita |
| SDGRWT | peso_bruto | Peso bruto |
| SDGWUM | unidade_medida_peso_bruto | Unidade de medida de peso bruto |
| SDSBL | sublinha | Sublinha |
| SDSBLT | tipo_sublinha | Tipo de sublinha |
| SDLCOD | codigo_localizacao | Código de localização |
| SDUPC1 | codigo_produto_universal_1 | Código do produto universal 1 |
| SDUPC2 | codigo_produto_universal_2 | Código do produto universal 2 |
| SDUPC3 | codigo_produto_universal_3 | Código do produto universal 3 |
| SDSWMS | codigo_wms | Código WMS |
| SDKCOO | companhia_ordem_original | Companhia da ordem original |
| SDDOCO | numero_documento_original | Número do documento original |
| SDDCTO | tipo_documento_original | Tipo do documento original |
| SDLNID | id_linha_original | ID da linha original |
| SDSFXO | sufixo_original | Sufixo original |
| SDMCU | FILIAL | Unidade de negócio |
| SDCO | centro_operacao | Centro de operação |
| SDOKCO | companhia_ordem_original | Companhia da ordem original |
| SDOORN | numero_ordem_original | Número da ordem original |
| SDOCTO | tipo_ordem_original | Tipo da ordem original |
| SDOGNO | numero_grade_original | Número da grade original |
| SDRKCO | companhia_referencia | Companhia de referência |
| SDRORN | numero_ordem_referencia | Número da ordem de referência |
| SDRCTO | tipo_ordem_referencia | Tipo da ordem de referência |
| SDRLLN | numero_linha_referencia | Número da linha de referência |
| SDDMCT | codigo_cliente_demanda | Código do cliente de demanda |
| SDDMCS | subcodigo_cliente_demanda | Subcódigo do cliente de demanda |
| SDAN8 | endereco | Endereço |
| SDSHAN | endereco_entrega | Endereço de entrega |
| SDPA8 | endereco_pagamento | Endereço de pagamento |
| SDDRQJ | data_requisitada_juliana | Data requisitada (formato juliano) |
| SDTRDJ | data_transacao_juliana | Data da transação (formato juliano) |
| SDPDDJ | data_prometida_juliana | Data prometida (formato juliano) |
| SDADDJ | data_adicionada_juliana | Data adicionada (formato juliano) |
| SDIVD | data_invoice_juliana | Data do invoice (formato juliano) |
| SDCNDJ | data_cancelamento_juliana | Data de cancelamento (formato juliano) |
| SDDGL | data_geral_ledger | Data geral do ledger |
| SDRSDJ | data_reserva_juliana | Data de reserva (formato juliano) |
| SDPEFJ | data_producao_efetiva_juliana | Data de produção efetiva (formato juliano) |
| SDPPDJ | data_proposta_pagamento_juliana | Data proposta de pagamento (formato juliano) |
| SDVR01 | campo_variavel_01 | Campo variável 01 |
| SDVR02 | campo_variavel_02 | Campo variável 02 |
| SDITM | numero_item | Número do item |
| SDLITM | numero_item_descricao | Número do item (descrição) |
| SDAITM | numero_item_alternativo | Número do item alternativo |
| SDLOCN | localizacao | Localização |
| SDLOTN | numero_lote | Número do lote |
| SDFRGD | data_entrega_grupo | Data de entrega do grupo |
| SDTHGD | data_recebimento_grupo | Data de recebimento do grupo |
| SDFRMP | metodo_entrega | Método de entrega |
| SDTHRP | metodo_recebimento | Método de recebimento |
| SDEXDP | dias_expedicao | Dias de expedição |
| SDDSC1 | descricao_item_1 | Descrição do item 1 |
| SDDSC2 | descricao_item_2 | Descrição do item 2 |
| SDLNTY | tipo_linha | Tipo de linha |
| SDNXTR | proximo_status | Próximo status |
| SDLTTR | ultimo_status | Último status |
| SDEMCU | unidade_negocio_embarque | Unidade de negócio de embarque |
| SDRLIT | item_relacionado | Item relacionado |
| SDKTLN | numero_linha_kit | Número da linha do kit |
| SDCPNT | componente | Componente |
| SDRKIT | kit_relacionado | Kit relacionado |
| SDKTP | tipo_kit | Tipo de kit |
| SDSRP1 | codigo_representante_vendas_1 | Código do representante de vendas 1 |
| SDSRP2 | codigo_representante_vendas_2 | Código do representante de vendas 2 |
| SDSRP3 | codigo_representante_vendas_3 | Código do representante de vendas 3 |
| SDSRP4 | codigo_representante_vendas_4 | Código do representante de vendas 4 |
| SDSRP5 | codigo_representante_vendas_5 | Código do representante de vendas 5 |
| SDPRP1 | codigo_propriedade_1 | Código da propriedade 1 |
| SDPRP2 | codigo_propriedade_2 | Código da propriedade 2 |
| SDPRP3 | codigo_propriedade_3 | Código da propriedade 3 |
| SDPRP4 | codigo_propriedade_4 | Código da propriedade 4 |
| SDPRP5 | codigo_propriedade_5 | Código da propriedade 5 |
| SDUOM | unidade_medida | Unidade de medida |
| SDUORG | quantidade_original | Quantidade original |
| SDSOQS | quantidade_sobressalente | Quantidade sobressalente |
| SDSOBK | quantidade_backorder | Quantidade de backorder |
| SDSOCN | quantidade_cancelada | Quantidade cancelada |
| SDSONE | quantidade_nao_entregue | Quantidade não entregue |
| SDUOPN | quantidade_aberta | Quantidade aberta |
| SDQTYT | quantidade_total | Quantidade total |
| SDQRLV | quantidade_liberada | Quantidade liberada |
| SDCOMM | comentarios | Comentários |
| SDOTQY | quantidade_outlier | Quantidade outlier |