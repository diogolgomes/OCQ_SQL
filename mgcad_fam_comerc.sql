CREATE TABLE STG_ELEK_mgcad_fam_comerc(
baixa_estoq integer NOT NULL,
char_1 varchar(200),
char_2 varchar(200),
check_sum varchar(40),
data_1 date ,
data_2 date ,
dec_1 numeric(23),
dec_2 numeric(23),
descricao varchar(60)NOT NULL,
fator_conver numeric(20),
fm_cod_com varchar(16)NOT NULL,
ind_imp_desc integer NOT NULL,
int_1 integer,
int_2 integer,
log_1 varchar(1),
log_2 varchar(1),
log_aloc_neg varchar(1),
tp_aloc_lote integer,
un varchar(4)NOT NULL
)