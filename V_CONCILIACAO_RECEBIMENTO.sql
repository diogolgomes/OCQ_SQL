
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PUBDB"."V_CONCILIACAO_RECEBIMENTO" ("GMAID", "GMMCU", "GMOBJ", "GMSUB", "GMDL01", "N_CADASTRO", "ID_PGTO", "N_RECEBIM", "N_PAGADOR", "DT_CH_ITEM", "DT_CONT", "DT_COMP", "C_C", "S_C", "N_P", "CONTR_CONT", "ID_CONTA", "ANO_FISCAL", "N_PER", "CIA", "TIPO_LOTE", "N_LOTE", "DT_LOTE", "N_PAI", "VL_PGTO", "VL_ABERTO", "MOEDA_BASE", "EN", "COD_MD", "TX_CAMBIO", "VL_RECEBIM_ESTRANG", "VALOR_ABERTO", "CONTA_BANC_GL", "MC", "TR", "OBS", "CC", "INST_PGTO", "REF_BANC", "NOME_ALFA", "N_LCTO", "CIADOC_LCTO", "TPDOC_LCTO", "DT_ESTORNO", "CODEST", "NCTA_BANC_CLI", "REC_EIF", "BANCO_AGENCIA", "STREC", "SF", "RD", "LIST_FC", "COD_US", "DT_USUARIO", "VL_USUARIO", "N_USUARIO", "REF_USUARIO", "ORI_TRANSA", "ID_USUARIO", "DT_ATUALZ", "HR_ATUALZ", "ID_EST_TRABALHO", "REF_RENOV", "REF_RECEBIM", "N_DOC_EIF", "TP_DOC_EIF", "CV_MD", "TX_CAMBIO_TRI1", "TX_CAMBIO_TRI2", "DT_TAXA", "CG", "CIA_DOC_ESTINS", "TP_LOTE_ESTINS_FUNDOS", "N_LT_EST_FUNDOS_INS", "DT_EST_INSUF_FUNDOS_LT", "COD_EST", "DT_COMP1", "REC_AUT", "APLIC_REC_AUTOM", "R_U", "ID_EMPREGADO", "LISTA_EXEC", "IND_GENER", "IND_REM", "ID_EXEC_LOTE", "ID_USUER_ATUAL","COUNTROW") AS 
  select 
    GMAID,
    GMMCU,
    GMOBJ,
    GMSUB,
    GMDL01,
    RYAN8	N_Cadastro,
    RYPYID	Id_Pgto,
    RYCKNU	N_Recebim,
    RYPYR	N_Pagador,
    CASE
        WHEN NVL(RYDMTJ,0)!='0' THEN TO_DATE((RYDMTJ+1900000), 'YYYYDDD')
        ELSE TO_DATE('01/01/1900','DD/MM/YYYY')
    END DT_Ch_Item,
    CASE
        WHEN NVL(RYDGJ,0)!='0' THEN TO_DATE((RYDGJ+1900000), 'YYYYDDD')
        ELSE TO_DATE('01/01/1900','DD/MM/YYYY')
    END DT_Cont,
    CASE
        WHEN NVL(RYVLDT,0)!='0' THEN TO_DATE((RYVLDT+1900000), 'YYYYDDD')
        ELSE TO_DATE('01/01/1900','DD/MM/YYYY')
    END DT_Comp,
    RYPOST	C_C,
    RYISTR	S_C,
    RYEULP	N_P,
    RYGLC	Contr_Cont,
    RYAID	Id_Conta,
    RYFY	Ano_Fiscal,
    RYPN	N_Per,
    RYCO	Cia,
    RYICUT	Tipo_Lote,
    RYICU	N_Lote,
    CASE
        WHEN NVL(RYDICJ,0)!='0' THEN TO_DATE((RYDICJ+1900000), 'YYYYDDD')
        ELSE TO_DATE('01/01/1900','DD/MM/YYYY')
    END DT_Lote,
    RYPA8	N_Pai,
    RYCKAM/100	VL_Pgto,
    RYAAP/100	VL_Aberto,
    RYBCRC	Moeda_Base,
    RYCRRM	EN,
    RYCRCD	Cod_Md,
    RYCRR	TX_Cambio,
    RYFCAM	VL_Recebim_Estrang,
    RYFAP	Valor_Aberto,
    RYGLBA	Conta_Banc_GL,
    RYAM	MC,
    RYTYIN	TR,
    RYEXR	Obs,
    RYALT6	CC,
    RYRYIN	Inst_Pgto,
    RYBKTR	Ref_Banc,
    RYALPH	Nome_Alfa,
    RYDOCG	N_Lcto,
    RYKCOG	CiaDoc_Lcto,
    RYDCTG	TpDoc_Lcto,
    CASE
        WHEN NVL(RYVDGJ,0)!='0' THEN TO_DATE((RYVDGJ+1900000), 'YYYYDDD')
        ELSE TO_DATE('01/01/1900','DD/MM/YYYY')
    END DT_Estorno,
    RYVRE	CodEst,
    RYCBNK	NCta_Banc_Cli,
    RYNFVD	Rec_EIF,
    RYTNST	Banco_Agencia,
    RYASTA	StRec,
    RYDDST	SF,
    RYDCDS	RD,
    RYDREG	List_FC,
    RYURC1	Cod_Us,
    CASE
        WHEN NVL(RYURDT,0)!='0' THEN TO_DATE((RYURDT+1900000), 'YYYYDDD')
        ELSE TO_DATE('01/01/1900','DD/MM/YYYY')
    END DT_Usuario,
    RYURAT	VL_Usuario,
    RYURAB	N_Usuario,
    RYURRF	Ref_Usuario,
    RYTORG	Ori_Transa,
    RYUSER	Id_Usuario,
    CASE
        WHEN NVL(RYUPMJ,0)!='0' THEN TO_DATE((RYUPMJ+1900000), 'YYYYDDD')
        ELSE TO_DATE('01/01/1900','DD/MM/YYYY')
    END DT_Atualz,
    RYUPMT	HR_Atualz,
    RYJOBN	Id_Est_Trabalho,
    RYRRID	Ref_Renov,
    RYRREF	Ref_Recebim,
    RYDOCQ	N_Doc_EIF,
    RYDCTQ	Tp_Doc_EIF,
    RYCRCM	Cv_Md,
    RYCRR1	TX_Cambio_Tri1,
    RYCRR2	TX_Cambio_Tri2,
    CASE
        WHEN NVL(RYERDJ,0)!='0' THEN TO_DATE((RYERDJ+1900000), 'YYYYDDD')
        ELSE TO_DATE('01/01/1900','DD/MM/YYYY')
    END Dt_Taxa,
    RYISTC	CG,
    RYKCOQ	Cia_Doc_EstIns,
    RYICTQ	TP_Lote_EstIns_Fundos,
    RYICUQ	N_Lt_Est_Fundos_Ins,
    CASE
        WHEN NVL(RYDIQJ,0)!='0' THEN TO_DATE((RYDIQJ+1900000), 'YYYYDDD')
        ELSE TO_DATE('01/01/1900','DD/MM/YYYY')
    END DT_Est_Insuf_Fundos_Lt,
    RYPSTQ	Cod_Est,
    CASE
        WHEN NVL(RYDKC,0)!='0' THEN TO_DATE((RYDKC+1900000), 'YYYYDDD')
        ELSE TO_DATE('01/01/1900','DD/MM/YYYY')
    END DT_Comp1,
    RYATCS	Rec_Aut,
    RYEAAC	Aplic_Rec_Autom,
    RYEUFB	R_U,
    RYECLK	ID_Empregado,
    RYARL	Lista_Exec,
    RYGFL1	Ind_Gener,
    RYPRGF	Ind_Rem,
    RYRNID	Id_Exec_Lote,
    RYCUID	Id_Usuer_Atual,
    1 AS COUNTROW
from PRODDTA.F03B13
left join PRODDTA.F0901 on ryglba= gmaid
where trim(gmmcu) in ('110000','310000','510000','610000','710000') and trim(gmobj) = '111020' and trim(gmsub) in ('003','001','005','007','018','034','032','068','064')
and RYFY >= '23';

