  CREATE VIEW "PUBDB"."V_CONCILIACAO_RECEBIMENTO_LIVE"  AS 
  select 
    GMAID,
    GMMCU,
    GMOBJ,
    GMSUB,
    GMDL01 AS CONTA_BANCARIA,
	RYPYR	N_Pagador,
    RYALPH	Nome_Alfa,
	CASE
        WHEN NVL(RYDGJ,0)!='0' THEN TO_DATE((RYDGJ+1900000), 'YYYYDDD')
        ELSE TO_DATE('01/01/1900','DD/MM/YYYY')
    END DT_Cont,
	CASE
        WHEN NVL(RYVLDT,0)!='0' THEN TO_DATE((RYVLDT+1900000), 'YYYYDDD')
        ELSE TO_DATE('01/01/1900','DD/MM/YYYY')
    END DT_Comp,
	CASE
        WHEN NVL(RYDMTJ,0)!='0' THEN TO_DATE((RYDMTJ+1900000), 'YYYYDDD')
        ELSE TO_DATE('01/01/1900','DD/MM/YYYY')
    END DT_Ch_Item,
	RYCKAM/100	VL_Pgto,
    RYAAP/100	VL_Aberto,
	RYEXR	Obs,
	RYCO	Cia,
	RYRYIN	Inst_Pgto,
	CASE
        WHEN NVL(RYUPMJ,0)!='0' THEN TO_DATE((RYUPMJ+1900000), 'YYYYDDD')
        ELSE TO_DATE('01/01/1900','DD/MM/YYYY')
    END DT_Atualz,
	RYICU	N_Lote,
	CASE
        WHEN NVL(RYDICJ,0)!='0' THEN TO_DATE((RYDICJ+1900000), 'YYYYDDD')
        ELSE TO_DATE('01/01/1900','DD/MM/YYYY')
    END DT_Lote,
	RYPYID	Id_Pgto,
	RYPSTQ	Cod_Est,
	RYUSER	Id_Usuario,
    1 AS COUNTROW
from PRODDTA.F03B13
left join PRODDTA.F0901 on ryglba= gmaid
where trim(gmmcu) in ('110000','310000','510000','610000','710000') and trim(gmobj) = '111020' and trim(gmsub) in ('003','001','005','007','018','034','032','068','064')
and RYFY = '24';

