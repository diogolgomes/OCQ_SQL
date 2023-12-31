create table STG_ELEK_mgcad_item(
aliquota_ii numeric(17),
aliquota_ipi numeric(17)NOT NULL,
aliquota_ISS numeric(17)NOT NULL,
alt_refer varchar(1),
altura numeric(23)NOT NULL,
atu_conf varchar(1),
baixa_estoq varchar(1)NOT NULL,
calc_cons_prev integer NOT NULL,
calc_lead_time integer ,
cap_est_fabr numeric(19)NOT NULL,
capac_recip_beb integer ,
cd_folh_item varchar(16),
cd_folh_lote varchar(16),
cd_formula integer ,
cd_origem integer ,
cd_planejado varchar(24)NOT NULL,
cd_referencia varchar(8),
cd_tag varchar(32),
cd_trib_icm integer NOT NULL,
cd_trib_ipi integer NOT NULL,
cd_trib_iss integer NOT NULL,
cdn_emit_benef integer ,
char_1 varchar(400),
char_2 varchar(400),
check_sum varchar(40),
ciclo_contag integer NOT NULL,
class_fiscal varchar(20)NOT NULL,
classe_repro integer NOT NULL,
classif_abc integer NOT NULL,
cod_auxiliar varchar(80),
cod_comprado varchar(24)NOT NULL,
cod_dcr_item varchar(24),
cod_destaq integer NOT NULL,
cod_estabel varchar(10)NOT NULL,
cod_imagem varchar(60),
cod_item_refugo varchar(32),
cod_lista_destino varchar(16),
cod_localiz varchar(20),
cod_malha varchar(10),
cod_obsoleto integer NOT NULL,
cod_produto varchar(32)NOT NULL,
cod_pulmao varchar(10),
cod_pulmao_proces varchar(16)NOT NULL,
cod_refer varchar(16),
cod_servico integer NOT NULL,
cod_tab_preco_aps varchar(16),
cod_tax integer ,
cod_tax_serv integer ,
cod_trib_ii integer ,
cod_unid_negoc varchar(6),
cod_workflow varchar(200),
codigo_orig integer NOT NULL,
codigo_refer varchar(40)NOT NULL,
compr_fabric integer NOT NULL,
comprim numeric(23)NOT NULL,
concentracao numeric(19)NOT NULL,
cons_consumo varchar(1),
cons_produto varchar(1),
cons_saldo varchar(1),
consumo_aad numeric(19)NOT NULL,
consumo_prev numeric(19)NOT NULL,
conta_aplicacao varchar(34),
contr_plan integer NOT NULL,
contr_qualid varchar(1)NOT NULL,
conv_tempo_seg varchar(1),
criticidade integer NOT NULL,
ct_codigo varchar(40)NOT NULL,
curva_abc varchar(1)NOT NULL,
data_1 date ,
data_2 date ,
data_base date ,
data_implant date NOT NULL,
data_liberac date NOT NULL,
data_obsol date ,
data_ult_con date ,
data_ult_ent date ,
data_ult_rep date ,
data_ult_sai date ,
de_codigo_prin varchar(32)NOT NULL,
dec_1 numeric(23),
dec_2 numeric(23),
dec_conv_fmcoml integer NOT NULL,
dec_ftcon integer NOT NULL,
demanda integer NOT NULL,
deposito_pad varchar(6)NOT NULL,
desc_inter varchar(72),
desc_item varchar(120),
desc_nacional varchar(72),
descricao_1 varchar(36)NOT NULL,
descricao_2 varchar(36)NOT NULL,
dias_estoq_aloc varchar(16),
div_ordem integer NOT NULL,
dsl_destaq varchar(4000)NOT NULL,
dt_pr_fisc date ,
dt_ult_ben date ,
emissao_ord integer NOT NULL,
enquad_beb integer ,
esp_beb integer ,
fase_medio integer ,
fator_conver numeric(20)NOT NULL,
fator_reaj_icms numeric(23),
fator_refugo numeric(17)NOT NULL,
fm_cod_com varchar(16),
fm_codigo varchar(16)NOT NULL,
fraciona varchar(1)NOT NULL,
ft_conv_fmcoml numeric(15)NOT NULL,
ft_conversao numeric(15)NOT NULL,
ge_codigo integer NOT NULL,
geracao_ordem integer ,
horiz_fixo integer NOT NULL,
id_grade varchar(1),
idi_classif_item integer ,
incentivado varchar(1),
ind_backorder varchar(1),
ind_calc_meta integer NOT NULL,
ind_confprodcom varchar(1),
ind_especifico varchar(1),
ind_imp_desc integer NOT NULL,
ind_inf_qtf varchar(1),
ind_ipi_dife varchar(1)NOT NULL,
ind_item_fat varchar(1)NOT NULL,
ind_prev_demanda integer NOT NULL,
ind_quotas varchar(1),
ind_refugo integer NOT NULL,
ind_serv_mat integer ,
inform_compl varchar(32)NOT NULL,
INT_1 integer ,
int_2 integer ,
isencao_import integer ,
it_codigo varchar(32)NOT NULL,
it_demanda varchar(32),
largura numeric(23)NOT NULL,
loc_unica varchar(1)NOT NULL,
log_1 varchar(1),
log_2 varchar(1),
log_altera_valid_lote varchar(1),
log_atualiz_via_mmp varchar(1),
log_benef varchar(1),
log_carac_tec varchar(1)NOT NULL,
log_consid_aloc_ativid varchar(1)NOT NULL,
log_control_estoq_refugo varchar(1),
log_inspec_lote varchar(1),
log_multi_malha varchar(1),
log_necessita_li varchar(1),
log_orig_ext varchar(1),
log_programac_sfc varchar(1),
log_recalc_sdo_terc varchar(1),
log_refugo_preco_fisc varchar(1),
log_tax_produc varchar(1)NOT NULL,
log_utiliza_batch_padrao varchar(1)NOT NULL,
lote_economi numeric(19)NOT NULL,
lote_minimo numeric(19)NOT NULL,
lote_multipl numeric(19)NOT NULL,
lote_mulven numeric(19)NOT NULL,
lote_repos numeric(17),
moeda_padrao integer NOT NULL,
mp_restrit varchar(1),
narrativa varchar(4000),
nat_despesa integer ,
niv_mais_bai integer NOT NULL,
niv_mps integer ,
niv_rest_fora varchar(2),
niv_rest_icms varchar(2),
nivel integer NOT NULL,
nivel_apr_compra integer ,
nivel_apr_manut integer ,
nivel_apr_requis integer ,
nivel_apr_solic integer ,
nr_item_dcr integer ,
nr_linha integer NOT NULL,
nr_pontos_quotas integer ,
Nr_ult_peca integer ,
num_id_item integer NOT NULL,
path varchar(80),
per_min_luc numeric(17),
per_ppm numeric(19),
per_rest_fora numeric(17),
per_rest_icms numeric(17)NOT NULL,
perc_demanda numeric(17),
perc_nqa numeric(18),
periodo_fixo integer NOT NULL,
perm_saldo_neg integer NOT NULL,
peso_bruto numeric(20)NOT NULL,
peso_liquido numeric(20)NOT NULL,
pm_ja_calc varchar(1)NOT NULL,
politica integer NOT NULL,
politica_aps integer ,
pr_sem_tx numeric(19)NOT NULL,
preco_base numeric(19)NOT NULL,
preco_fiscal numeric(19)NOT NULL,
preco_repos numeric(19)NOT NULL,
preco_ul_ent numeric(19)NOT NULL,
prefixo_lote varchar(10),
prioridade integer NOT NULL,
pto_repos numeric(19),
qt_max_ordem numeric(19),
qt_var_max numeric(17),
qt_var_min numeric(17),
qtd_batch_padrao numeric(19)NOT NULL,
qtd_refer_custo_dis numeric(17),
qtde_fixa numeric(19),
qtde_max numeric(19),
quant_pacote numeric(19),
quant_perda numeric(19)NOT NULL,
quant_segur numeric(19)NOT NULL,
rendimento numeric(19)NOT NULL,
rep_prod integer NOT NULL,
reporte_ggf integer NOT NULL,
reporte_mob integer NOT NULL,
res_cq_comp integer NOT NULL,
res_cq_fabri integer NOT NULL,
res_for_comp integer NOT NULL,
res_int_comp integer NOT NULL,
responsavel varchar(24)NOT NULL,
ressup_fabri integer NOT NULL,
resumo_mp integer NOT NULL,
rot_quant varchar(1),
rot_refer varchar(1),
rot_revis varchar(1),
sc_codigo varchar(40)NOT NULL,
sit_aloc integer ,
tempo_segur integer NOT NULL,
tipo_atp integer ,
tipo_con_est integer NOT NULL,
tipo_contr integer NOT NULL,
tipo_desc_nt integer NOT NULL,
tipo_est_seg integer ,
tipo_formula integer NOT NULL,
tipo_insp integer NOT NULL,
tipo_lote_ec integer NOT NULL,
tipo_recip_beb integer ,
tipo_requis integer NOT NULL,
tipo_sched integer NOT NULL,
tp_adm_lote integer ,
tp_aloc_lote integer ,
tp_cons_prev numeric(15),
tp_desp_padrao integer ,
tp_lote_econom varchar(1),
tp_lote_minimo varchar(1),
tp_lote_multiplo varchar(1),
tx_importacao numeric(18),
un varchar(4)NOT NULL,
usuario_alt varchar(24),
usuario_obsol varchar(24),
val_fator_custo_dis numeric(17)NOT NULL,
val_overlap numeric(17),
val_relac_refugo_item numeric(20),
valor_ipi_beb numeric(20),
var_mob_maior numeric(17),
var_mob_menor numeric(17),
var_rep numeric(17)NOT NULL,
var_req_maior numeric(17),
var_req_menor numeric(17),
var_transf numeric(17)NOT NULL,
variac_acum numeric(19)NOT NULL,
vl_mat_ant numeric(19)NOT NULL,
vl_mob_ant numeric(19)NOT NULL,
vl_var_max numeric(17),
vl_var_min numeric(17),
volume numeric(20)NOT NULL
)