create table STG_ELEK_mgmov_pedido_compr (
bairro varchar(60),
c_cod_tabela varchar(20),
c_descr_merc varchar(324),
c_embalagem varchar(186),
c_observacao varchar(760),
c_prazo varchar(40),
cargo_ass varchar(186),
cep varchar(24),
char_1 varchar(200),
char_2 varchar(200),
check_sum varchar(40),
cidade varchar(50),
cod_cond_pag integer NOT NULL,
cod_emit_terc integer ,
cod_emitente integer NOT NULL,
cod_entrega varchar(24),
cod_estab_gestor varchar(10)NOT NULL,
cod_estabel varchar(10)NOT NULL,
cod_maq_origem integer ,
cod_mensagem integer NOT NULL,
cod_transp integer NOT NULL,
cod_usuar_alter varchar(24),
cod_usuar_criac varchar(24),
comentarios varchar(4000)NOT NULL,
compl_entrega varchar(14),
contr_forn varchar(1)NOT NULL,
dat_alter date ,
dat_criac date ,
data_1 date ,
data_2 date ,
data_pedido date NOT NULL,
de_vl_fob numeric(19)NOT NULL,
de_vl_frete_i numeric(17),
dec_1 numeric(23),
dec_2 numeric(23),
desc_forma varchar(72),
desc_via varchar(40),
dt_prev_pgto date ,
emergencial varchar(1)NOT NULL,
end_cobranca varchar(10)NOT NULL,
end_entrega varchar(10)NOT NULL,
endereco varchar(80),
endereco_text varchar(4000),
estado varchar(8),
frete integer NOT NULL,
gera_edi varchar(1)NOT NULL,
hra_alter varchar(16),
hra_criac varchar(16),
i_cod_forma integer NOT NULL,
i_cod_porto integer NOT NULL,
i_cod_via integer NOT NULL,
i_exportador integer NOT NULL,
i_importador integer NOT NULL,
i_moeda integer NOT NULL,
i_situacao integer ,
impr_pedido varchar(1)NOT NULL,
ind_orig_entrada integer ,
ind_via_envio integer ,
int_1 integer ,
int_2 integer ,
jurisdicao varchar(40),
l_classificacao integer ,
l_ind_prof varchar(1),
l_tipo_ped integer ,
local_entrega integer ,
log_1 varchar(1),
log_2 varchar(1),
mot_elimina varchar(4000)NOT NULL,
natureza integer NOT NULL,
nome_ass varchar(186),
nr_contrato integer NOT NULL,
nr_ped_venda integer ,
nr_processo integer NOT NULL,
nr_prox_ped integer NOT NULL,
nro_proc_alteracao integer ,
nro_proc_entrada integer ,
nro_proc_saida integer ,
num_id_documento integer ,
num_ped_benef integer NOT NULL,
num_pedido integer NOT NULL,
num_processo_mp integer ,
pais varchar(40),
responsavel varchar(24)NOT NULL,
situacao integer NOT NULL,
via_transp integer NOT NULL
)