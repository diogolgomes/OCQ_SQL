# Documentação Tabela F42199

Sales Order Detail Ledger (Histórico de Linhas de Pedidos de Venda)

A tabela F42199 no JD Edwards EnterpriseOne (JDE) é uma tabela de histórico que armazena alterações nas linhas de pedidos de venda (F4211). Ela registra mudanças em campos como status, quantidades, preços e datas, permitindo rastrear o ciclo de vida completo de cada item do pedido.

## Principais Características da TBL F42199

- Tabela de histórico: Armazena snapshots das linhas de pedidos (F4211) sempre que há alterações significativas.
- Relacionamento direto com F4211: Cada registro na F42199 está vinculado a uma linha específica na F4211.
- Auditoria e compliance: Permite rastrear quem alterou um pedido, quando e qual era o valor anterior.
- Usada para relatórios analíticos: Comparação de versões, análise de mudanças de preço, etc.

## Mapeamento DE-PARA (F42199 → Silver Layer)

| Campo Silver | CampoF42199 | Descrição |
| --- | --- | --- |
| companhia | SLKCOO | Código da companhia |
| numero_pedido | SLDOCO | Número do documento/pedido |
| tipo_documento | SLDCTO | Tipo de documento (SO=Sales Order) |
| numero_linha | SLLNID | Número sequencial da linha |
| sufixo | SLSFXO | Sufixo da linha |
| unidade_negocio | SLMCU | Business Unit (Filial/Dpto) |
| centro_operacao | SLCO | Centro operacional |
| companhia_original | SLOKCO | Companhia da ordem original |
| numero_ordem_original | SLOORN | Número da ordem original |
| tipo_ordem_original | SLOCTO | Tipo da ordem original |
| numero_grade_original | SLOGNO | Número da grade original |
| companhia_referencia | SLRKCO | Companhia de referência |
| numero_ordem_referencia | SLRORN | Número da ordem de referência |
| tipo_ordem_referencia | SLRCTO | Tipo da ordem de referência |
| numero_linha_referencia | SLRLLN | Número da linha de referência |
| codigo_cliente_demanda | SLDMCT | Código do cliente de demanda |
| subcodigo_cliente | SLDMCS | Subcódigo do cliente |
| endereco_cliente | SLAN8 | Endereço master do cliente |
| endereco_entrega | SLSHAN | Endereço de entrega |
| endereco_pagamento | SLPA8 | Endereço de pagamento |
| data_requisitada | SLDRQJ | Data solicitada pelo cliente |
| data_transacao | SLTRDJ | Data da transação |
| data_prometida | SLPDDJ | Data prometida de entrega |
| data_adicionada | SLADDJ | Data de criação da linha |
| data_faturamento | SLIVD | Data de faturamento |
| data_cancelamento | SLCNDJ | Data de cancelamento |
| data_geral_ledger | SLDGL | Data do razão geral |
| data_reserva | SLRSDJ | Data de reserva de estoque |
| data_producao_efetiva | SLPEFJ | Data efetiva de produção |
| data_proposta_pagamento | SLPPDJ | Data proposta de pagamento |
| campo_variavel_01 | SLVR01 | Campo flexível 1 |
| campo_variavel_02 | SLVR02 | Campo flexível 2 |
| codigo_item | SLITM | Número do item (short) |
| descricao_item | SLLITM | Descrição do item |
| item_alternativo | SLAITM | Código alternativo do item |
| localizacao | SLLOCN | Localização no estoque |
| numero_lote | SLLOTN | Número do lote/série |
| data_entrega_grupo | SLFRGD | Data de entrega do grupo |
| data_recebimento_grupo | SLTHGD | Data de recebimento do grupo |
| metodo_entrega | SLFRMP | Método de entrega |
| metodo_recebimento | SLTHRP | Método de recebimento |
| dias_expedicao | SLEXDP | Dias para expedição |
| descricao_item_1 | SLDSC1 | Descrição linha 1 do item |
| descricao_item_2 | SLDSC2 | Descrição linha 2 do item |
| tipo_linha | SLLNTY | Tipo de linha (S=Serviço, I=Item) |
| proximo_status | SLNXTR | Próximo status esperado |
| ultimo_status | SLLTTR | Último status processado |
| unidade_negocio_embarque | SLEMCU | BU de embarque |
| item_relacionado | SLRLIT | Item relacionado |
| numero_linha_kit | SLKTLN | Número da linha do kit |
| componente | SLCPNT | Código do componente |
| kit_relacionado | SLRKIT | Kit relacionado |
| tipo_kit | SLKTP | Tipo de kit (P=Principal, C=Componente) |
| codigo_representante_1 | SLSRP1 | Código do representante 1 |
| codigo_representante_2 | SLSRP2 | Código do representante 2 |
| codigo_representante_3 | SLSRP3 | Código do representante 3 |
| codigo_representante_4 | SLSRP4 | Código do representante 4 |
| codigo_representante_5 | SLSRP5 | Código do representante 5 |
| codigo_propriedade_1 | SLPRP1 | Código da propriedade 1 |
| codigo_propriedade_2 | SLPRP2 | Código da propriedade 2 |
| codigo_propriedade_3 | SLPRP3 | Código da propriedade 3 |
| codigo_propriedade_4 | SLPRP4 | Código da propriedade 4 |
| codigo_propriedade_5 | SLPRP5 | Código da propriedade 5 |
| unidade_medida | SLUOM | Unidade de medida primária |
| quantidade_original | SLUORG | Quantidade original |
| quantidade_sobressalente | SLSOQS | Quantidade reservada |
| quantidade_backorder | SLSOBK | Quantidade em backorder |
| quantidade_cancelada | SLSOCN | Quantidade cancelada |
| quantidade_nao_entregue | SLSONE | Quantidade não entregue |
| quantidade_aberta | SLUOPN | Quantidade em aberto |
| quantidade_total | SLQTYT | Quantidade total processada |
| quantidade_liberada | SLQRLV | Quantidade liberada |
| comentarios | SLCOMM | Comentários da linha |
| quantidade_outlier | SLOTQY | Quantidade outlier |
| preco_unitario_usuario | SLUPRC | Preço unitário do usuário |
| data_expiracao_autorizacao | SLAEXP | Data de expiração da autorização |
| data_abertura_autorizacao | SLAOPN | Data de abertura da autorização |
| codigo_provedor | SLPROV | Código do provedor |
| tipo_codigo_preco | SLTPC | Tipo de código de preço |
| preco_unitario_medio_aprovado | SLAPUM | Preço médio aprovado |
| preco_unitario_lista | SLLPRC | Preço unitário de tabela |
| custo_unitario_padrao | SLUNCS | Custo unitário padrão |
| custo_estendido_calculado | SLECST | Custo estendido calculado |
| custo_estendido_original | SLCSTO | Custo estendido original |
| custo_total | SLTCST | Custo total da linha |
| codigo_grupo_item | SLINMG | Código do grupo de itens |
| tipo_codigo_produto | SLPTC | Tipo de código do produto |
| ano_entrada | SLRYIN | Ano de entrada do item |
| data_base | SLDTBS | Data base para cálculos |
| codigo_transacao | SLTRDC | Código de transação |
| campo_flexivel_02 | SLFUN2 | Campo flexível 2 |
| numero_aviso_remessa | SLASN | Número do aviso de remessa |
| grupo_preco | SLPRGR | Grupo de preço |
| nivel_cliente | SLCLVL | Nível do cliente |
| codigo_cliente_adicional | SLCADC | Código adicional do cliente |
| companhia_associada | SLKCO | Companhia associada |
| numero_documento_associado | SLDOC | Número do documento associado |
| tipo_documento_associado | SLDCT | Tipo de documento associado |
| numero_documento_original | SLODOC | Número do documento original |
| tipo_documento_original | SLODCT | Tipo do documento original |
| companhia_original_associada | SLOKC | Companhia original associada |
| numero_sequencia_pedido | SLPSN | Número de sequência do pedido |
| numero_linha_entrega | SLDELN | Número da linha de entrega |
| codigo_imposto_1 | SLTAX1 | Código do imposto 1 |
| area_imposto_1 | SLTXA1 | Área do imposto 1 |
| taxa_imposto_1 | SLEXR1 | Taxa do imposto 1 |
| texto_imposto | SLATXT | Texto do imposto |
| prioridade | SLPRIO | Prioridade do pedido |
| codigo_resultado | SLRESL | Código do resultado |
| indicador_backorder | SLBACK | Indicador de backorder (Y/N) |
| saldo_secundario | SLSBAL | Saldo secundário |
| codigo_aprovacao | SLAPTS | Código de aprovação |
| linha_negocios | SLLOB | Linha de negócios |
| codigo_uso_eletronico | SLEUSE | Código de uso eletrônico |
| tipo_destino | SLDTYS | Tipo de destino |
| numero_transporte | SLNTR | Número de transporte |
| codigo_vendedor | SLVEND | Código do vendedor |
| codigo_transportadora | SLCARS | Código da transportadora |
| motivo | SLMOT | Código do motivo |
| rota | SLROUT | Rota de entrega |
| ponto_parada | SLSTOP | Ponto de parada |
| zona | SLZON | Zona geográfica |
| id_conhecimento | SLCNID | ID do conhecimento |
| frete_terceiro | SLFRTH | Valor do frete de terceiro |
| codigo_metodo_entrega | SLSHCM | Código do método de entrega |
| numero_container | SLSHCN | Número do container |
| numero_serie | SLSERN | Número de série |
| unidade_medida_primaria | SLUOM1 | Unidade primária de medida |
| quantidade_primaria | SLPQOR | Quantidade na unidade primária |
| unidade_medida_secundaria | SLUOM2 | Unidade secundária de medida |
| quantidade_secundaria | SLSQOR | Quantidade na unidade secundária |
| unidade_medida_quaternaria | SLUOM4 | Unidade quaternária de medida |
| peso_item | SLITWT | Peso do item |
| unidade_medida_peso | SLWTUM | Unidade de medida do peso |
| volume_item | SLITVL | Volume do item |
| unidade_medida_volume | SLVLUM | Unidade de medida do volume |
| preco_unitario_real | SLRPRC | Preço unitário real |
| preco_unitario_original | SLORPR | Preço unitário original |
| preco_original | SLORP | Preço original |
| grupo_comissao | SLCMGP | Grupo de comissão |
| codigo_centro_custo | SLGLC | Código do centro de custo (GL) |
| codigo_pais | SLCTRY | Código do país |
| ano_fiscal | SLFY | Ano fiscal |
| codigo_comissao | SLACOM | Código de comissão |
| grupo_comissao_cliente | SLCMCG | Grupo de comissão do cliente |
| codigo_receita | SLRCD | Código de receita |
| peso_bruto | SLGRWT | Peso bruto do item |
| unidade_peso_bruto | SLGWUM | Unidade de medida do peso bruto |
| sublinha | SLSBL | Número da sublinha |
| tipo_sublinha | SLSBLT | Tipo de sublinha |
| codigo_localizacao | SLLCOD | Código de localização |
| codigo_upc_1 | SLUPC1 | Código Universal de Produto 1 |
| codigo_upc_2 | SLUPC2 | Código Universal de Produto 2 |
| codigo_upc_3 | SLUPC3 | Código Universal de Produto 3 |
| codigo_wms | SLSWMS | Código do Sistema de Gerenciamento de Armazém |
| unidade_negocio_cliente | SLUNCD | Unidade de negócio do cliente |
| codigo_moeda | SLCRMD | Código da moeda |
| codigo_transacao_credito | SLCRCD | Código da transação de crédito |
| taxa_cambio | SLCRR | Taxa de câmbio |
| preco_unitario_formato | SLFPRC | Preço unitário formatado |
| fator_preco_unitario | SLFUP | Fator de preço unitário |
| valor_estendido_formato | SLFEA | Valor estendido formatado |
| custo_unitario_formato | SLFUC | Custo unitário formatado |
| custo_estendido_formato | SLFEC | Custo estendido formatado |
| codigo_usuario | SLURCD | Código do usuário |
| data_ultima_revisao | SLURDT | Data da última revisão (juliana) |
| tipo_ultima_revisao | SLURAT | Tipo da última revisão |
| descricao_ultima_revisao | SLURAB | Descrição da última revisão |
| referencia_ultima_revisao | SLURRF | Referência da última revisão |
| tipo_origem | SLTORG | Tipo de origem |
| usuario | SLUSER | ID do usuário |
| programa | SLPID | ID do programa |
| estacao_trabalho | SLJOBN | ID da estação de trabalho |
| data_ultima_atualizacao | SLUPMJ | Data da última atualização (juliana) |
| hora_ultima_atualizacao | SLTDAY | Hora da última atualização |
| campo_sobressalente_01 | SLSO01 | Campo reserva 01 |
| campo_sobressalente_02 | SLSO02 | Campo reserva 02 |
| campo_sobressalente_03 | SLSO03 | Campo reserva 03 |
| campo_sobressalente_04 | SLSO04 | Campo reserva 04 |
| campo_sobressalente_05 | SLSO05 | Campo reserva 05 |
| campo_sobressalente_06 | SLSO06 | Campo reserva 06 |
| campo_sobressalente_07 | SLSO07 | Campo reserva 07 |
| campo_sobressalente_08 | SLSO08 | Campo reserva 08 |
| campo_sobressalente_09 | SLSO09 | Campo reserva 09 |
| campo_sobressalente_10 | SLSO10 | Campo reserva 10 |
| campo_sobressalente_11 | SLSO11 | Campo reserva 11 |
| campo_sobressalente_12 | SLSO12 | Campo reserva 12 |
| campo_sobressalente_13 | SLSO13 | Campo reserva 13 |
| campo_sobressalente_14 | SLSO14 | Campo reserva 14 |
| campo_sobressalente_15 | SLSO15 | Campo reserva 15 |
| campo_sobressalente_16 | SLSO16 | Campo reserva 16 |
| campo_sobressalente_17 | SLSO17 | Campo reserva 17 |
| campo_sobressalente_18 | SLSO18 | Campo reserva 18 |
| campo_sobressalente_19 | SLSO19 | Campo reserva 19 |
| campo_sobressalente_20 | SLSO20 | Campo reserva 20 |
| campo_reservado_01 | SLIR01 | Uso interno 01 |
| campo_reservado_02 | SLIR02 | Uso interno 02 |
| campo_reservado_03 | SLIR03 | Uso interno 03 |
| campo_reservado_04 | SLIR04 | Uso interno 04 |
| campo_reservado_05 | SLIR05 | Uso interno 05 |
| numero_pedido_original | SLSOOR | Número do pedido original |
| campo_variavel_03 | SLVR03 | Campo flexível 03 |
| id_dispositivo_eletronico | SLDEID | ID do dispositivo eletrônico |
| assinatura_pagamento | SLPSIG | Assinatura de pagamento |
| numero_relacionamento | SLRLNU | Número de relacionamento |
| data_pagamento | SLPMDT | Data de pagamento |
| hora_relacionamento | SLRLTM | Hora do relacionamento |
| data_relacionamento | SLRLDJ | Data do relacionamento (juliana) |
| data_requisitada | SLDRQT | Data requisitada |
| data_aprovacao | SLADTM | Data de aprovação |
| hora_operacao | SLOPTT | Hora da operação |
| data_programada | SLPDTT | Data programada |
| hora_processamento | SLPSTM | Hora de processamento |
| numero_documento_externo | SLXDCK | Número do documento externo |
| tipo_pedido_externo | SLXPTY | Tipo de pedido externo |
| indicador_dual | SLDUAL | Indicador de dualidade (Y/N) |
| base_calculo | SLBSC | Base de cálculo |
| codigo_base_calculo | SLCBSC | Código da base de cálculo |
| numero_contrato | SLCORD | Número do contrato |
| numero_van | SLDVAN | Número da van |
| indicador_pendente | SLPEND | Indicador de pendência |
| valor_referencia | SLRFRV | Valor de referência |
| numero_linha_mestre | SLMCLN | Número da linha mestre |
| numero_parte_entrega | SLSHPN | Número da parte de entrega |
| data_reserva | SLRSDT | Data de reserva |
| numero_projeto | SLPRJM | Número do projeto |
| sequencia_ordem | SLOSEQ | Sequência da ordem |
| nivel_mercadologico | SLMERL | Nível mercadológico |
| codigo_retencao | SLHOLD | Código de retenção |
| unidade_negocio_entrega | SLHDBU | Unidade de negócio de entrega |
| unidade_negocio_demanda | SLDMBU | Unidade de negócio de demanda |
| codigo_retencao_backorder | SLBCRC | Código de retenção de backorder |
| numero_linha_original | SLODLN | Número da linha original |
| data_operacao_juliana | SLOPDJ | Data da operação (juliana) |
| companhia_origem | SLXKCO | Companhia de origem |
| numero_ordem_origem | SLXORN | Número da ordem de origem |
| tipo_ordem_origem | SLXCTO | Tipo da ordem de origem |
| numero_linha_origem | SLXLLN | Número da linha de origem |
| sufixo_origem | SLXSFX | Sufixo de origem |
| processamento_ordem_entrada | SLPOE | Processamento de ordem de entrada |
| metodo_pagamento | SLPMTO | Método de pagamento |
| aprovado_por | SLANBY | Aprovado por |
| numero_parcela_pagamento | SLPMTN | Número da parcela de pagamento |
| numero | SLNUMB | Número |
| id_autorizacao | SLAAID | ID de autorização |
| atencao_entrega | SLSPATTN | Atenção para entrega |
| endereco_principal | SLPRAN8 | Endereço principal |
| linha_endereco_principal | SLPRCIDLN | Linha do endereço principal |
| linha_endereco_cobranca | SLCCIDLN | Linha do endereço de cobrança |
| linha_endereco_entrega | SLSHCCIDLN | Linha do endereço de entrega |
| id_operador | SLOPPID | ID do operador |
| passo_ordem_servico | SLOSTP | Passo da ordem de serviço |
| id_unico | SLUKID | ID único |
| nome_categoria | SLCATNM | Nome da categoria |
| codigo_alocacao | SLALLOC | Código de alocação |
| id_preenchimento | SLFULPID | ID de preenchimento |
| status_alocacao | SLALLSTS | Status de alocação |
| pontuacao_ordem_servico | SLOSCORE | Pontuação da ordem de serviço |
| pontuacao_original_ordem_servico | SLOSCOREO | Pontuação original da ordem de serviço |
| companhia_comissionada | SLCMCO | Companhia comissionada |
| id_kit | SLKITID | ID do kit |
| valor_kit_domestico | SLKITAMTDOM | Valor do kit (moeda doméstica) |
| valor_kit_estrangeiro | SLKITAMTFOR | Valor do kit (moeda estrangeira) |
| indicador_kit_modificado | SLKITDIRTY | Indicador de kit modificado |
| cidade_cartao_credito | SLOCITT | Cidade do cartão de crédito |
| numero_cartao_credito | SLOCCARDNO | Número do cartão de crédito |
| numero_parte_principal | SLPMPN | Número da parte principal |
| numero_sequencia_pedido | SLPNS | Número de sequência do pedido |

## Observações Importantes

- Campos de data: Usam formato juliano (ex: SDHDRQJ).
- Tipos de alteração (SDHCHNG):
  - STATUS (mudança de status)
  - QTY (mudança de quantidade)
  - PRICE (mudança de preço)
  - DATE (mudança de data)
- Performance: Essa tabela pode crescer rapidamente. Recomendado criar índices em SDHDOCO, SDHDATE.