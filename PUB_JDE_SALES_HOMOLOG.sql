
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PUBDB"."PUB_JDE_SALES_V_HOMOLOG" ("ORIGEM", "P_ICMS_FORA", "DESPESA_FRETE", "ICMS_TOTAL", "PIS", "COF", "COD_VENDEDOR", "VENDEDOR", "FRETE", "LOTE", "LINHA", "REFERENCIA_DEV", "TIPO", "ULT_ST", "PROX_ST", "DATA_FATURAMENTO", "DATA", "DATA_INCLUSAO", "MES_ANO", "DATA_CLIENTE", "SOLICITADO", "PEDIDO", "NOTA", "CODIGO_CLIENTE", "CLIENTE", "UF", "CONDICAO_PAG_CADASTRO", "COND_PAG_PEDIDO", "COD", "DESCRICAO", "UM", "QTD", "PRECO_UNITARIO", "PRECO_UNITARIO2", "PRECO_UNITARIO_NET", "MATERIAL", "CUSTO_UNITARIO", "ICMS_P", "PIS_COF_P", "IPI_P", "ST", "DIFAL", "IMNA", "RECEITA_BRUTA_TOTAL", "RECEITA_NET_TOTAL", "CUSTO_MATERIAL_TOTAL", "CUSTO_TOTAL_2", "BUSINESS_UNIT", "TECNOLOGIA", "UN_NEG", "FILIAL", "FILIAL2", "COD_TRANSP", "TRANSP", "TIPO_PEDIDO", "OBS_PED", "UM_PRINC", "ICMS_ENTRADA", "TRIB_SUBST", "DESC_REPASSE", "DESC_ZF", "FORN", "FORN_PRIMEIRO", "VALOR_IPI", "INTERCOMPANY", "RESPONSAVEL_CELULA", "RESPONSAVEL_CELULA_2", "USER_VENDEDOR", "DATA_CUSTO", "CUSTO_GERENCIAL", "LISTA", "DESCRICAO_R", "EMB", "CUSTO_EMB", "UTEIS_DIA", "UTEIS_MES", "COMPLEMENTO_RECEITA_BRUTA", "RECEITA_BRUTA_M_TOTAL", "RECEITA_LIQUIDA_M_TOTAL", "PREVISAO_RECEITA_BRUTA", "PREVISAO_RECEITA_LIQUIDA", "PREVISAO_MARGEM", "INFORMACAO_FRETE", "CIDADE", "PRAZO_MEDIO_PAG", "TON_DIA_UTIL", "PAIS", "GRUPO_ECO", "STATUS", "PREVISAO_QTD", "SEGMENTO", "CAT5", "VALOR_FRETE", "VALOR_SEGURO") AS 
  WITH temp AS (
    SELECT
        CASE
            WHEN substr(sddcto, 1, 1) IN ( 'D' )
                 AND sddrqj != '0' THEN
                sddrqj
            WHEN slb76sact = 'Y'
                 AND fdnxtr > '600'
                 AND fdnxtr NOT IN ( '996', '998' )
                 AND slb76eprd != '0' THEN
                slb76eprd
            WHEN slb76sact = 'Y'
                 AND fdnxtr > '600'
                 AND fdnxtr NOT IN ( '996', '998' )
                 AND fdissu != '0' THEN
                fdissu
            WHEN slb76sact = 'Y'
                 AND fdnxtr > '600'
                 AND fdnxtr NOT IN ( '996', '998' )
                 AND SDRSDJ != '0' THEN
                SDRSDJ
            WHEN sdnxtr > '600'
                 AND sdlttr != '980'
                 AND SDRSDJ != '0' THEN
                SDRSDJ

            WHEN sdnxtr < '600'
                 AND SDRSDJ < sdppdj
                 AND SDRSDJ != '0' THEN
                SDRSDJ
            WHEN sdnxtr < '600'
                 AND SDRSDJ > sdppdj
                 AND sdppdj != '0' THEN
                sdppdj
            ELSE
                sddrqj
        END    data,
        sddoco AS pedido,
        sdlnid AS linha,
        sddcto AS tipo,
        sdco   AS cia
    FROM
             proddta.f4211
        INNER JOIN proddta.f4101 ON imitm = sditm
        LEFT JOIN proddta.f4201 ON shco = sdco
                                         AND shdoco = sddoco
                                         AND shdcto = sddcto
        LEFT JOIN proddta.f0101 cliente ON cliente.aban8 = sdan8
        LEFT JOIN proddta.f7611b ON fddoco = sddoco
                                          AND fdco = sdco
                                          AND fdlnid = sdlnid
                                          AND fdpdct = sddcto
                                          AND sdmcu = fdmcu
                                          AND fdnxtr NOT IN ( '996', '998' )
        LEFT JOIN proddta.f7601b ON fhdct = fddct
                                          AND fhbnnf = fdbnnf
                                          AND fhn001 = fdn001
                                          AND fhco = fdco
        LEFT JOIN proddta.f0101 transp ON shCARS = transp.aban8
        LEFT JOIN proddta.f76b12te ON slbnnf = fdbnnf
                                            AND substr(slfco, 1, 2) = substr(fdco, 1, 2)
                                            AND fdn001 = sln001 /*AND SLB76NFST='A'*/
                                            AND slb76sact = 'Y'
        LEFT JOIN proddta.f0006 ON TRIM(mcstyl) = 'BP'
                                         AND (sdmcu) = (mcmcu)
    WHERE
            1 = 1

        AND sdlttr != '980'
        AND sdlnty != 'BX'
        AND sddcto IN ( 'SG', 'SX', 'SV', 'VI', 'VO',
                         'VZ', 'V5', 'V7', 'V8',
                        'VA', 'VF', 'VG', 'VH', 'SO',
                        'SO', 'DO', 'CV','VN','VY','VU','VQ','V0','V3' )
--incluido 'VQ','V0','V3', para que apareca MCLAW

and sdco!='71000'

), ref_devol AS (
     SELECT
        do.sdco                AS cia_ref,
        do.sdmcu               AS filial_ref,
        do.sddoco              AS pedido_do_ref,
        do.sdlnid              AS linha_do_ref,
        do.sditm               AS curto_do_ref,
        TRIM(shorby)           AS cod_vendedor_ref,
        TRIM(shorby)
        || '-'
        || TRIM(vended.ABALKY) AS vendedor_ref,
        fdbnnf,
        TRIM(slrorn)           pedido_rel,
        TRIM(slrcto)           AS tipo_rel,
        slrlln / 1000          AS linha_rel,
        slan8                  AS cod_cliente_rel,
        slitm                  AS curto_rel,
        sllotn                 AS lote_rel,
        f76b12te.slb76lnum     AS nf_rel,

        CASE
            WHEN f76b12te.slb76eprd != '0'
                 AND f76b12te.slb76eprd IS NOT NULL THEN
                to_char(to_date((f76b12te.slb76eprd + 1900000), 'YYYYDDD'), 'DD/MM/YYYY')
            WHEN fdissu != '0'
                 AND fdissu IS NOT NULL THEN
                to_char(to_date((fdissu + 1900000), 'YYYYDDD'), 'DD/MM/YYYY')
            ELSE
                ''
        END                    data_rel

    FROM
             proddta.f4211 do
        INNER JOIN proddta.f42199 ON to_char((sldoco)) = to_char(TRIM(do.sdoorn))
                                           AND slmcu = do.sdmcu
                                           AND do.sdogno = sllnid
                                           AND do.sdocto = sldcto
                                           AND (sldcto) = 'VL'
                                           AND do.sdco = slkcoo
                                           --AND DO.SDODOC=SLDOC
        INNER JOIN proddta.f4211    vo ON to_char(to_number((nvl(TRIM(slrorn), 0)))) = to_char(vo.sddoco)
                                             AND slrcto = vo.sddcto
                                             AND slrlln = vo.sdlnid
                                             AND slan8 = vo.sdan8
                                             AND slitm = vo.sditm
        LEFT JOIN proddta.f4201 ON shco = vo.sdco
                                         AND shdoco = vo.sddoco
                                         AND shdcto = vo.sddcto
                                         AND shmcu = vo.sdmcu
        LEFT JOIN proddta.f0101    vended ON to_char(TRIM(shorby)) = to_char(vended.aban8)
        LEFT JOIN proddta.f7611b ON fddoco = vo.sddoco
                                          AND fdco = vo.sdco
                                          AND fdlnid = vo.sdlnid
                                          AND fdmcu = vo.sdmcu
                                          AND fdpdct = vo.sddcto
                                          AND fdnxtr NOT IN ( '996', '998' )
        LEFT JOIN proddta.f76b12te f76b12te ON f76b12te.slbnnf = fdbnnf
                                                     AND f76b12te.slb76sact = 'Y'
                                                     AND fddct = f76b12te.sldct
                                                     AND fdn001 = sln001 --AND F76B12TE.SLFCO=FDCO

    WHERE
            do.sddcto = 'DO'
        AND do.sdnxtr > 600
        AND do.sdlttr != '980' 
        and FDBNNF||fddoco!='29261499285'
AND f76b12te.slb76lnum||TRIM(slrcto)||trim(do.sdmcu) not in ('370893VO111000','370894VO111000')

and do.sdco!='71000'
--AND DO.SDDOCO='51641'




), temp2 AS (
    SELECT
        sdlotn                                                             AS lote,
        TRIM(shmcu)                                                        AS un_neg,


        CASE

        WHEN substr(sddcto, 1, 1) IN ( 'D' ) and   sdtrdj =to_number(to_char(sysdate, 'YYYYDDD')) - 1900000 THEN 'DEVOLUCAO HOJE'
        WHEN    to_char(to_date(data_rel, 'DD/MM/YYYY'), 'MMYYYY') !=  to_char(to_date((sdtrdj + 1900000), 'YYYYDDD'), 'MMYYYY')

             AND  substr(sddcto, 1, 1) IN ( 'D' )
                 AND sdnxtr > '600'
                 AND sdlttr != '980' THEN
                'DEVOLUCAO ANT'

              --when substr(sddcto, 1, 1) IN ( 'D' ) and   sdtrdj =to_number(to_char(sysdate, 'YYYYDDD')) - 1900000 THEN 'DEVOLUCAO HOJE'

            WHEN substr(sddcto, 1, 1) IN ( 'D' )
                 AND sdnxtr > '600'
                 AND sdlttr != '980' THEN
                'DEVOLUCAO'
            WHEN substr(sddcto, 1, 1) IN ( 'D' )
                 AND sdnxtr < '600'
                 AND sdlttr != '980' THEN
                'DEVOLUCAO CARTEIRA'
                  WHEN sdlttr != '980'
                 AND sdnxtr > '617' AND data =to_number(to_char(sysdate, 'YYYYDDD')) - 1900000 THEN
                'FATURANDO HOJE'

                                                         WHEN sdlttr != '980'
                 AND sdnxtr >= '616' AND data >=to_number(to_char(sysdate-6, 'YYYYDDD')) - 1900000 AND data !=to_number(to_char(sysdate, 'YYYYDDD')) - 1900000 THEN
                'FATURADO'


            WHEN sdlttr != '980'
                 AND sdnxtr > '617' THEN
                'FATURADO'

                                                         WHEN sdlttr != '980'
                 AND sdnxtr = '595' 
                                                          and fdnxtr='999'
                                                         THEN
                'FATURADO'


            WHEN sdnxtr < '596' THEN
                'CARTEIRA'
            WHEN sdnxtr > '595'
                 AND sdnxtr <= '618' THEN
                'FATURANDO HOJE'
            WHEN fdnxtr > 600
                 AND fdnxtr != '996'
                 AND substr(fdpdct, 1, 1) != 'D' THEN
                'FATURADO'
            WHEN sdnxtr > 600
                 AND sdnxtr != '996'
                 AND substr(fdpdct, 1, 1) != 'D' THEN
                'FATURADO'
            ELSE
                to_char(sdnxtr
                        || '-'
                        || sddcto)
        END                                                                tipo,
        sdlttr                                                             ult_st,
        sdnxtr                                                             prox_st,
        CASE
         WHEN substr(sddcto, 1, 1) IN ( 'D' ) THEN
                to_char(to_date((sddrqj + 1900000), 'YYYYDDD'), 'DD/MM/YYYY')
            WHEN fdnxtr >= '600'
                 AND slb76eprd != '0'
                 AND slb76eprd IS NOT NULL THEN
                to_char(to_date((slb76eprd + 1900000), 'YYYYDDD'), 'DD/MM/YYYY')
            WHEN fdnxtr >= '600'
                 AND fdissu != '0'
                 AND fdissu IS NOT NULL THEN
                to_char(to_date((fdissu + 1900000), 'YYYYDDD'), 'DD/MM/YYYY')
            WHEN fdnxtr >= '600'
                 AND SDRSDJ != '0' THEN
                to_char(to_date((SDRSDJ + 1900000), 'YYYYDDD'), 'DD/MM/YYYY')
            WHEN sdnxtr > '600'
                 AND sdlttr != '980'
                 AND SDRSDJ != '0' THEN
                to_char(to_date((SDRSDJ + 1900000), 'YYYYDDD'), 'DD/MM/YYYY')

            WHEN to_number(to_char(sysdate, 'YYYYDDD')) - 1900000 > sdppdj
                 AND to_number(to_char(sysdate, 'YYYYDDD')) - 1900000 > SDRSDJ THEN
                to_char(sysdate, 'DD/MM/YYYY')
            WHEN sdppdj > SDRSDJ THEN
                to_char(to_date((sdppdj + 1900000), 'YYYYDDD'), 'DD/MM/YYYY')
            ELSE
                to_char(to_date((SDRSDJ + 1900000), 'YYYYDDD'), 'DD/MM/YYYY')
        END                                                                data,





        CASE

            WHEN fdnxtr >= '600'
                 AND slb76eprd != '0' THEN
                to_char(to_date((slb76eprd + 1900000), 'YYYYDDD'), 'DD/MM/YYYY')
            WHEN fdnxtr >= '600'
                 AND fhissu != '0' THEN
                to_char(to_date((fhissu + 1900000), 'YYYYDDD'), 'DD/MM/YYYY')
            WHEN fdnxtr >= '600'
                 AND fdissu != '0' THEN
                to_char(to_date((fdissu + 1900000), 'YYYYDDD'), 'DD/MM/YYYY')
        END                                                                data_faturamento,
        to_char(to_date((sdtrdj + 1900000), 'YYYYDDD'), 'DD/MM/YYYY')      AS data_inclusao,
        --to_char(to_date((sdtrdj + 1900000), 'YYYYDDD'), 'MM/YYYY')         mes_ano,


          CASE
           WHEN substr(sddcto, 1, 1) IN ( 'D' ) THEN
                to_char(to_date((sddrqj + 1900000), 'YYYYDDD'), 'MM/YYYY')
            WHEN fdnxtr >= '600'
                 AND slb76eprd != '0'
                 AND slb76eprd IS NOT NULL THEN
                to_char(to_date((slb76eprd + 1900000), 'YYYYDDD'), 'MM/YYYY')
            WHEN fdnxtr >= '600'
                 AND fdissu != '0'
                 AND fdissu IS NOT NULL THEN
                to_char(to_date((fdissu + 1900000), 'YYYYDDD'), 'MM/YYYY')
            WHEN fdnxtr >= '600'
                 AND SDRSDJ != '0' THEN
                to_char(to_date((SDRSDJ + 1900000), 'YYYYDDD'), 'MM/YYYY')
            WHEN sdnxtr > '600'
                 AND sdlttr != '980'
                 AND SDRSDJ != '0' THEN
                to_char(to_date((SDRSDJ + 1900000), 'YYYYDDD'), 'MM/YYYY')
            WHEN substr(sddcto, 1, 1) IN ( 'D' ) THEN
                to_char(to_date((sddrqj + 1900000), 'YYYYDDD'), 'MM/YYYY')
            WHEN to_number(to_char(sysdate, 'YYYYDDD')) - 1900000 > sdppdj
                 AND to_number(to_char(sysdate, 'YYYYDDD')) - 1900000 > SDRSDJ THEN
                to_char(sysdate, 'MM/YYYY')
            WHEN sdppdj > SDRSDJ THEN
                to_char(to_date((sdppdj + 1900000), 'YYYYDDD'), 'MM/YYYY')
            ELSE
                to_char(to_date((SDRSDJ + 1900000), 'YYYYDDD'), 'MM/YYYY')
        END                                                                mes_ano,



        to_char(to_date((SDRSDJ + 1900000), 'YYYYDDD'), 'DD/MM/YYYY')      AS data_cliente,
        sddcto                                                             AS tipo_pedido,
        sddoco                                                             AS pedido,
        sdlnid / 1000                                                      linha,
        CASE
            WHEN slb76sact = 'Y'
                 AND fdnxtr = '999'
                 AND slb76lnum IS NOT NULL
                 AND slb76lnum != '0' THEN
                slb76lnum
            WHEN fdpdct IN ( 'DO' )
                 AND fdnxtr = '999' THEN
                slb76lnum
            ELSE
                0
        END                                                                nota,
        TRIM(cliente.aban8)                                                codigo_cliente,
        TRIM(cliente.abalph)                                               AS cliente,
        TRIM(destino.aladds)                                                     uf, 
        TRIM(cad.pnptd)                                                    AS condicao_pag_cadastro,
        TRIM(ped.pnptd)                                                    AS cond_pag_pedido,
        TRIM(sdlitm)                                                       AS cod,
		CASE 
		WHEN SDAN8='3612' THEN  TRIM(sddsc1)
		ELSE 
        ( TRIM(sddsc1)
          || ' '
          || TRIM(sddsc2) )                                                 
		  END descricao,


        sduom2                                                             AS um_princ,
        sduom4                                                             AS um,
        CASE
		WHEN sddcto='CV' AND TRIM(SDLNTY) IN ('N','S') THEN 1
            WHEN sddcto = 'DO' THEN
                ( sdpqor / 10000 )
            ELSE
                sdpqor / 10000
        END                                                                qtd,




		sduprc / 10000   preco_unitario,

	 case
	 WHEN SDDCTO='SX' AND SDNXTR>'600' THEN ROUND(((((NVL(fhBFRT/100,0))/NVL(FHGDVL/100,1))*FDAEXP/100) + (((NVL(fhBSEG/100,0))/NVL(FHGDVL/100,1))*FDAEXP/100) +FDAEXP/100 ) /(FDUORG/10000),6)
	 ELSE 
	 sduprc / 10000   END preco_unitario2,

        round(nvl(iecsl,0) / 10000, 2)                                            AS material,
        councs / 10000                                                     AS custo_unitario,




        CASE
            WHEN trim(destino.aladds) IN ( 'EX' ) THEN ( sduprc / 10000 )
            WHEN fdtxr1 IS NOT NULL AND sjbcfc = 'ISE' THEN ( ( 100 - fdtxr1 / 1000 ) * 0.01 ) * ( sduprc / 10000 )
            WHEN fdtxr1 IS NOT NULL  AND sjbcfc != 'ISE' THEN ( ( 100 - fdtxr1 / 1000 - 9.25 ) * 0.01 ) * ( sduprc / 10000 )   -    (( (( 100 - fdtxr1 / 1000 ) * 0.01 ) * ( sduprc / 10000 )) *0.0925)
            WHEN com_curto.tbtxr2 IS NOT NULL  AND destino.aladds = remetent.aladds AND sjbctf != '04' AND sjbcfc = 'ISE' AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1' THEN ( ( 100 - com_curto.tbtxr1 / 1000 ) * 0.01 ) * ( sduprc / 10000 )
            WHEN com_curto.tbtxr2 IS NOT NULL  AND destino.aladds != remetent.aladds AND sjbctf != '04'  AND sjbcfc = 'ISE' AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1' THEN ( ( 100 - com_curto.tbtxr2 / 1000 ) * 0.01 ) * ( sduprc / 10000 )
            WHEN sem_curto.tbtxr2 IS NOT NULL   AND destino.aladds = remetent.aladds AND sjbctf != '04'  AND sjbcfc = 'ISE' AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1' THEN  ( ( 100 - sem_curto.tbtxr1 / 1000 ) * 0.01 ) * ( sduprc / 10000 )
            WHEN sem_curto.tbtxr2 IS NOT NULL   AND destino.aladds != remetent.aladds  AND sjbctf != '04' AND sjbcfc = 'ISE' AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1' THEN ( ( 100 - sem_curto.tbtxr2 / 1000 ) * 0.01 ) * ( sduprc / 10000 )
            WHEN com_curto.tbtxr2 IS NOT NULL  AND destino.aladds = remetent.aladds AND sjbctf != '04'  AND sjbcfc != 'ISE' AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1' THEN ( ( 100 - com_curto.tbtxr1 / 1000  ) * 0.01 ) * ( sduprc / 10000 )  -    (( ( ( 100 - com_curto.tbtxr1 / 1000  ) * 0.01 )* ( sduprc / 10000 )) *0.0925)
            WHEN com_curto.tbtxr2 IS NOT NULL  AND destino.aladds != remetent.aladds  AND sjbctf != '04'  AND sjbcfc != 'ISE' AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1' THEN ( ( 100 - com_curto.tbtxr2 / 1000  ) * 0.01 ) * ( sduprc / 10000 ) -   (( ( ( 100 - com_curto.tbtxr2 / 1000  ) * 0.01 )* ( sduprc / 10000 )) *0.0925)
            WHEN sem_curto.tbtxr2 IS NOT NULL  AND destino.aladds = remetent.aladds  AND sjbctf != '04'  AND sjbcfc != 'ISE' AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1' THEN ( ( 100 - sem_curto.tbtxr1 / 1000 - 9.25 ) * 0.01 ) * ( sduprc / 10000 )   -   (( ( ( 100 - sem_curto.tbtxr1 / 1000  ) * 0.01 )* ( sduprc / 10000 )) *0.0925)
            WHEN sem_curto.tbtxr2 IS NOT NULL  AND destino.aladds != remetent.aladds  AND sjbctf != '04'  AND sjbcfc != 'ISE' AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1' THEN  ( ( 100 - sem_curto.tbtxr2 / 1000 - 9.25 ) * 0.01 ) * ( sduprc / 10000 ) -   (( ( ( 100 - sem_curto.tbtxr2 / 1000  ) * 0.01 )* ( sduprc / 10000 )) *0.0925)


WHEN SJBCFC!='ISE' THEN (SDUPRC/10000 )*0.9075
WHEN SJBCFC='ISE'   THEN (SDUPRC/10000 ) 

		else  ( nvl(sduprc,0) / 10000 )
        END                                                                preco_unitario_net,












        CASE
            WHEN destino.aladds IN ( 'EX' ) THEN  '0%'
            WHEN fdtxr1 IS NOT NULL THEN  fdtxr1 / 1000 || '%'
            WHEN com_curto.tbtxr2 IS NOT NULL AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1'   AND destino.aladds = remetent.aladds  AND sjbctf != '04' THEN com_curto.tbtxr1 / 1000|| '%'
            WHEN com_curto.tbtxr2 IS NOT NULL AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1'  AND destino.aladds != remetent.aladds AND sjbctf != '04' THEN com_curto.tbtxr2 / 1000 || '%'
            WHEN sem_curto.tbtxr2 IS NOT NULL AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1'  AND destino.aladds = remetent.aladds AND sjbctf != '04' THEN sem_curto.tbtxr1 / 1000|| '%'
            WHEN sem_curto.tbtxr2 IS NOT NULL AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1'  AND destino.aladds != remetent.aladds AND sjbctf != '04' THEN sem_curto.tbtxr2 / 1000 || '%'
			else 0||'%'
        END                                                                icms_p,



        CASE
            WHEN sjbcfc != 'ISE' THEN
                '9,25%'
            WHEN sjbcfc = 'ISE'  THEN
                '0%'
        END                                                                pis_cof_p,
          CASE
when FDNXTR>600 THEN NVL(PIS.TDBRTXA,0)/100
WHEN SJBCFC  IN ('ISE','EXP')  THEN 0


            WHEN SJBCFC NOT IN ('ISE','EXP')  AND  destino.aladds IN ( 'EX' ) THEN
                (SDAEXP/100)*0.0165
             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  fdbicm IS NOT NULL THEN

                                                         ((SDAEXP/100)-fdbicm / 100)*0.0165
             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  sjbctf = '04' THEN
                (SDAEXP/100)*0.0165
             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  fdbicm IS NOT NULL
                 AND sddcto = 'DO' THEN
               ((SDAEXP/100)-fdbicm / 100)*0.0165

             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  com_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds = remetent.aladds
                 AND sjbctf != '04'
                 AND sddcto = 'DO' THEN
                ((SDAEXP/100)- (( com_curto.tbtxr1 / 1000 * 0.01 ) * sdaexp / 100 ))*0.0165
             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  com_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds != remetent.aladds
                 AND sjbctf != '04'
                 AND sddcto = 'DO' 
                                                         THEN 
                                                          ((SDAEXP/100)-( ( com_curto.tbtxr2 / 1000 * 0.01 ) * sdaexp / 100 ))*0.0165

             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  sem_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds = remetent.aladds
                 AND sjbctf != '04'
                 AND sddcto = 'DO' THEN
                                                           ((SDAEXP/100)-(( sem_curto.tbtxr1 / 1000 * 0.01 ) * sdaexp / 100))*0.0165

             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  sem_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds != remetent.aladds
                 AND sjbctf != '04'
                 AND sddcto = 'DO' THEN

                                                             ((SDAEXP/100)-(( sem_curto.tbtxr2 / 1000 * 0.01 ) * sdaexp / 100  ))*0.0165
             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  com_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds = remetent.aladds
                 AND sjbctf != '04' THEN
                                                             ((SDAEXP/100)-(( com_curto.tbtxr1 / 1000 * 0.01 ) * sdaexp / 100))*0.0165

             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  com_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds != remetent.aladds
                 AND sjbctf != '04' THEN
                                                           ((SDAEXP/100)-(( com_curto.tbtxr2 / 1000 * 0.01 ) * sdaexp / 100))*0.0165


             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  sem_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds = remetent.aladds
                 AND sjbctf != '04' THEN
                                                           ((SDAEXP/100)-(  ( sem_curto.tbtxr1 / 1000 * 0.01 ) * sdaexp / 100))*0.0165


             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  sem_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds != remetent.aladds
                 AND sjbctf != '04' THEN

                                                           ((SDAEXP/100)-( sem_curto.tbtxr2 / 1000 * 0.01 ) * sdaexp / 100)*0.0165


WHEN SJBCFC NOT IN ('ISE','EXP')  THEN (SDAEXP/100)*0.0165


END PIS,

     CASE
when FDNXTR>600 THEN NVL(COF.TDBRTXA,0)/100
WHEN SJBCFC  IN ('ISE','EXP')  THEN 0


            WHEN SJBCFC NOT IN ('ISE','EXP')  AND  destino.aladds IN ( 'EX' ) THEN
                (SDAEXP/100)*0.076
             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  fdbicm IS NOT NULL THEN

                                                         ((SDAEXP/100)-fdbicm /100)*0.076
             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  sjbctf = '04' THEN
                (SDAEXP/100)*0.076
             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  fdbicm IS NOT NULL
                 AND sddcto = 'DO' THEN
               ((SDAEXP/100)-fdbicm / 100)*0.076

             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  com_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds = remetent.aladds
                 AND sjbctf != '04'
                 AND sddcto = 'DO' THEN
                ((SDAEXP/100)- (( com_curto.tbtxr1 / 1000 * 0.01 ) * sdaexp / 100 ))*0.076
             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  com_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds != remetent.aladds
                 AND sjbctf != '04'
                 AND sddcto = 'DO' 
                                                          THEN 
                                                          ((SDAEXP/100)-( ( com_curto.tbtxr2 / 1000 * 0.01 ) * sdaexp / 100 ))*0.076

             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  sem_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds = remetent.aladds
                 AND sjbctf != '04'
                 AND sddcto = 'DO' THEN
                                                           ((SDAEXP/100)-(( sem_curto.tbtxr1 / 1000 * 0.01 ) * sdaexp / 100))*0.076

             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  sem_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds != remetent.aladds
                 AND sjbctf != '04'
                 AND sddcto = 'DO' THEN

                                                             ((SDAEXP/100)-(( sem_curto.tbtxr2 / 1000 * 0.01 ) * sdaexp / 100  ))*0.076
             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  com_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds = remetent.aladds
                 AND sjbctf != '04' THEN
                                                             ((SDAEXP/100)-(( com_curto.tbtxr1 / 1000 * 0.01 ) * sdaexp / 100))*0.076

             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  com_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds != remetent.aladds
                 AND sjbctf != '04' THEN
                                                           ((SDAEXP/100)-(( com_curto.tbtxr2 / 1000 * 0.01 ) * sdaexp / 100))*0.076


             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  sem_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds = remetent.aladds
                 AND sjbctf != '04' THEN
                                                           ((SDAEXP/100)-(  ( sem_curto.tbtxr1 / 1000 * 0.01 ) * sdaexp / 100))*0.076


             WHEN SJBCFC NOT IN ('ISE','EXP')  AND  sem_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds != remetent.aladds
                 AND sjbctf != '04' THEN

                                                           ((SDAEXP/100)-( sem_curto.tbtxr2 / 1000 * 0.01 ) * sdaexp / 100)*0.076


WHEN SJBCFC NOT IN ('ISE','EXP')  THEN (SDAEXP/100)*0.076

END COF,





        CASE
            WHEN sjbctf = '4' THEN
                '0%'
            ELSE
                ( fctxr1 / 1000 )
                || '%'
        END                                                                ipi_p,
        nvl(fdbvis / 100, 0)                                               AS st,
        nvl(fdbrep / 100, 0)                                               AS difal,
        fdbipi / 100                                                       AS valor_ipi,
      sdaexp / 100                                                       AS total,

        CASE
            WHEN TRIM(fhfrth) IN ( 'E', 'D' ) THEN
                sdaexp / 100
            WHEN TRIM(fhfrth) IS NOT NULL THEN
                ( ( ( sdaexp / 100 ) + ( ( fdbipi ) / 100 ) ) * 0.015 ) + sdaexp / 100
            ELSE
                sdaexp / 100
        END                                                                bruto,
        ( councs / 10000 ) * ( sdpqor / 10000 )                            AS custo_total,




        CASE
            WHEN destino.aladds IN ( 'EX' ) THEN  0
            WHEN fdbicm IS NOT NULL THEN fdbicm / 100
            WHEN sjbctf = '04' THEN   0
            WHEN fdbicm IS NOT NULL    AND sddcto = 'DO'  THEN  fdbicm / 100
            WHEN com_curto.tbtxr2 IS NOT NULL AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1'  AND destino.aladds = remetent.aladds  AND sjbctf != '04'  AND sddcto = 'DO' THEN ( com_curto.tbtxr1 / 1000 * 0.01 ) * sdaexp / 100
            WHEN com_curto.tbtxr2 IS NOT NULL AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1'  AND destino.aladds != remetent.aladds   AND sjbctf != '04'   AND sddcto = 'DO' THEN ( com_curto.tbtxr2 / 1000 * 0.01 ) * sdaexp / 100 
            WHEN sem_curto.tbtxr2 IS NOT NULL AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1' AND destino.aladds = remetent.aladds   AND sjbctf != '04' AND sddcto = 'DO' THEN ( sem_curto.tbtxr1 / 1000 * 0.01 ) * sdaexp / 100
            WHEN sem_curto.tbtxr2 IS NOT NULL AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1'  AND destino.aladds != remetent.aladds  AND sjbctf != '04' AND sddcto = 'DO' THEN ( sem_curto.tbtxr2 / 1000 * 0.01 ) * sdaexp / 100 
            WHEN com_curto.tbtxr2 IS NOT NULL AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1' AND destino.aladds = remetent.aladds AND sjbctf != '04' THEN ( com_curto.tbtxr1 / 1000 * 0.01 ) * sdaexp / 100
            WHEN com_curto.tbtxr2 IS NOT NULL AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1' AND destino.aladds != remetent.aladds AND sjbctf != '04' THEN ( com_curto.tbtxr2 / 1000 * 0.01 ) * sdaexp / 100
            WHEN sem_curto.tbtxr2 IS NOT NULL AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1'  AND destino.aladds = remetent.aladds  AND sjbctf != '04' THEN ( sem_curto.tbtxr1 / 1000 * 0.01 ) * sdaexp / 100
            WHEN sem_curto.tbtxr2 IS NOT NULL AND F7615B.TNBFII= '1' AND F76011.AIBFII = '1' AND F76B18.FCBFII='1' AND F7617B.TSBFII='1'  AND destino.aladds != remetent.aladds  AND sjbctf != '04' THEN ( sem_curto.tbtxr2 / 1000 * 0.01 ) * sdaexp / 100
       else 0
	   END   icms_total,






        TRIM(srp5.drdl01)                                                  AS marca_propria,
        TRIM(srp1.drdl01)                                                  AS business_unit,
        TRIM(srp2.drdl01)                                                  AS tecnologia,
       SHCARS                                   AS cod_transp,
        nvl(TRIM(transp.abalky), 'SEM TRANSPORTADORA')                     AS transportadora,
        nvl(TRIM(transp.abalky), 'SEM TRANSPORTADORA')                     AS transp,
        solicitado.aban8
       || '-'
        || TRIM(solicitado.abalph)                                         AS solicitado,
        TRIM(shdel1)
        || ' '
        || TRIM(shdel2)                                                    AS obs_ped,
        CASE
            WHEN pedido_rel IS NULL THEN
                ''
            ELSE
                to_char('PEDIDO: '
                        || substr(pedido_rel, 3, 10)
                        || ' / LINHA: '
                        || linha_rel
                        || ' / TIPO: '
                        || tipo_rel
                        || ' / NF: '
                        || nf_rel
                        || ' - Emissão: '
                        || data_rel)
        END                                                                referencia_dev,
        round((iecsl / 10000) *(sdpqor / 10000), 2)                        AS material_total,
        sjbori                                                             AS origem,
        TRIM(mcmcu)                                                        filial,
        TRIM(mcdl01)                                                       filial2,
        CASE
            WHEN com_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds = remetent.aladds THEN
                com_curto.tbtxr1 / 1000
            WHEN com_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds != remetent.aladds THEN
                com_curto.tbtxr2 / 1000
            WHEN sem_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds = remetent.aladds THEN
                sem_curto.tbtxr1 / 1000
            WHEN sem_curto.tbtxr2 IS NOT NULL
                 AND destino.aladds != remetent.aladds THEN
                sem_curto.tbtxr2 / 1000
        END                                                                p_icms_fora,
        CASE
            WHEN pedido_rel IS NULL THEN
                TRIM(shorby)
            ELSE
                cod_vendedor_ref
        END                                                                cod_vendedor,
        CASE
            WHEN pedido_rel IS NULL THEN
                TRIM(shorby)
                || '-'
                || TRIM(vended.ABALKY)
            ELSE
                vendedor_ref
        END                                                                vendedor,
        shFRTH                                                           AS frete,
        TRIM(sdupc3)                                                       imna,
        nvl(sem_curto.tbtxr1,0) / 1000                                            teste,
        nvl(fdbvis,0) / 100                                                       trib_subst,
        nvl(fdbrep,0) / 100                                                       desc_repasse,
        nvl(fdbdiz,0) / 100                                                       desc_zf,
        nvl(fdbfrt, 0) / 100 + nvl(fdbseg, 0) / 100 + nvl(fdbdfn, 0) / 100 AS despesa_frete,
        --Condição intercompany
        CASE
        -- condição para remover OCQ chile do intercompani solicitação do Edemir 30/01/2025
        WHEN sdan8 = 71000 THEN ''
         --caso o tipo do pedido seja VU categoriza por INTERCOMPANY
        WHEN SDDCTO ='VU' THEN 'INTERCOMPANY'
        --Caso seja tipo do pedido VH e codigo do cliente 51000 retorna vazio  
        When cliente.abalph like 'NITRIFLEX%' and imlitm like 'EST%' and SDRSDJ >= '125152' then ''
        WHEN SDDCTO='VH' and sdan8='51000' then ''
        -- Se o nome do Cliente contem NITRIFLEX e tenha 'EST', 'AAC' Intercompany revenda
        WHEN cliente.abalph LIKE 'NITRIFLEX%'
                AND TRIM(imlitm) IN ( 'EST', 'AAC' ) THEN
            'INTERCOMPANY REVENDA'
        -- Se o nome do Cliente contem MAZA e tenha 'EST' e fdmcu = 111005
        WHEN cliente.abalph LIKE 'MAZA %'
                AND TRIM(imlitm) IN ( 'EST' )
                AND TRIM(fdmcu) = '111005' THEN
            'INTERCOMPANY REVENDA'
        -- Se o nome do Cliente contem 'OSWALDO CRUZ QU', 'VETTA QUIMICA I', 'CHEMBRO QUIMICA' categoriza por INTERCOMPANY
        WHEN substr(cliente.abalph, 1, 15) IN ( 'OSWALDO CRUZ QU', 'VETTA QUIMICA I', 'CHEMBRO QUIMICA' ) THEN
            'INTERCOMPANY'

        WHEN imsrp1 = '200'
            AND TRIM(aiac10) IS NOT NULL
            AND cliente.abalph NOT LIKE 'NITRIFLEX%'
            AND cliente.abalph NOT LIKE 'MAZA %' THEN
            'INTERCOMPANY REVENDA'
        WHEN SDDCTO='VN' AND IMSRP1 IN ('200','480') THEN  'INTERCOMPANY REVENDA'
        WHEN SDDCTO ='VU' AND  IMSRP2='278' THEN 'INTERCOMPANY'
        WHEN SDDCTO ='VN' AND  IMSRP2='278' THEN 'INTERCOMPANY REVENDA'

        END                                                                intercompany


        ,destino.ALCTY1 CIDADE
                ,TRIM(destino.ALCTR) PAIS

,trim(economico.abalph) GRUPO_ECO

     , CASE
       WHEN SHHOLD = 'C1' THEN 'AG. APROV. FINANCEIRO'
       WHEN SHHOLD = 'A2' THEN 'AG. APROV. COMERCIAL' 

                 WHEN TRIM(SHHOLD) IS NOT NULL  THEN TO_CHAR(TRIM(BL.DRDL01) )
       WHEN SDNXTR = 520 THEN 'PEDIDO INCLUIDO'
       WHEN SDNXTR = 540 THEN 'AG. SEP. DE MATERIAIS' 
       WHEN SDNXTR = 560 THEN 'AG. CONF. DE CARGA'
                    WHEN SDNXTR = 542 THEN 'AG. CONF. DE CARGA'
                    WHEN SDNXTR = 555 THEN 'AG. CONF. DE CARGA'
                        WHEN SDNXTR = 550 THEN 'AG. CONF. DE CARGA'
       WHEN SDNXTR = 595 THEN 'AG. GERAÇÃO DA NOTA' 
       WHEN SDNXTR = 596 THEN 'AG. GERAÇÃO DO XML'
       END STATUS,
case when NVL(fhBFRT,0)='0' then 0 else ((NVL(fhBFRT/100,0))/NVL(FHGDVL/100,1))*FDAEXP/100 end VALOR_FRETE,
case when NVL(fhBSEG,0)='0' then 0 else ((NVL(fhBSEG/100,0))/NVL(FHGDVL/100,1))*FDAEXP/100 end VALOR_SEGURO

    FROM
        proddta.f4211
        LEFT JOIN proddta.f7611b ON fddoco = sddoco
                                          AND fdco = sdco
                                          AND fdlnid = sdlnid
                                          AND fdpdct = sddcto
                                          AND fdmcu = sdmcu
                                          AND fdnxtr NOT IN ( '996', '998' )
         LEFT JOIN  proddta.F76B011 PIS ON PIS.TDBNNF=FDBNNF AND PIS.TDBSER=FDBSER AND PIS.TDN001=FDN001 AND PIS.TDDCT=FDDCT AND PIS.TDUKID=FDUKID AND PIS.TDBRTX='05'
        LEFT JOIN  proddta.F76B011 COF ON COF.TDBNNF=FDBNNF AND COF.TDBSER=FDBSER AND COF.TDN001=FDN001 AND COF.TDDCT=FDDCT AND COF.TDUKID=FDUKID AND COF.TDBRTX='06'
        INNER JOIN proddta.f4101 ON imitm = sditm
        LEFT JOIN proddta.f4201 ON shco = sdco
                                         AND shdoco = sddoco
                                         AND shdcto = sddcto
                                         AND shmcu = sdmcu
        LEFT JOIN proddta.f0101  cliente ON cliente.aban8 = sdan8
        LEFT JOIN proddta.f7601b ON fhdct = fddct
                                          AND fhbnnf = fdbnnf
                                          AND fhn001 = fdn001
                                          AND fhco = fdco
        LEFT JOIN proddta.f0101  transp ON SHCARS = transp.aban8
        LEFT JOIN proddta.f0101  vended ON to_char(TRIM(shorby)) = to_char(vended.aban8)
        LEFT JOIN proddta.f76b12te ON slbnnf = fdbnnf
                                            AND substr(slfco, 1, 2) = substr(fdco, 1, 2)
                                            AND fdn001 = sln001 /*AND SLB76NFST='A'*/
                                            AND slb76sact = 'Y'
        LEFT JOIN proddta.f4105 ON coitm = sditm
                                         AND cocsin = 'I'
                                         AND (comcu) = (sdmcu)
        LEFT JOIN proddta.f30026 ON coitm = ieitm
                                          AND iecost = 'A1'
                                          AND TRIM(iemmcu)  IN ('111000') AND IELEDG='07'
        LEFT JOIN proddta.f76b200 ON dpbnop = fdbnop
                                           AND dpbsop = fdbsop
                                           AND dpfco = fdfco
        LEFT JOIN proddta.f0014  ped ON TRIM(ped.pnptc) = TRIM(sdptc)
        LEFT JOIN proddta.f03012 a ON cliente.aban8 = aian8
                                            AND aico = '00000'
        LEFT JOIN proddta.f0014  cad ON TRIM(aitrar) = TRIM(cad.pnptc)
        LEFT JOIN proddta.f0116  destino ON destino.alan8 = cliente.aban8
        LEFT JOIN proddta.f0006 ON mcco = sdco
                                         AND (mcmcu) = (sdmcu)
                                         AND TRIM(mcstyl) = 'BP'
        LEFT JOIN proddta.f0116  remetent ON remetent.alan8 = mcan8
        LEFT JOIN PRODCTL.F0005 ON TRIM(drsy) = '41'
                                         AND TRIM(drrt) = '05'
                                         AND imprp0 = TRIM(drdl01)
        LEFT JOIN temp ON sddoco = pedido
                          AND sdlnid = linha
                          AND sddcto = tipo
                          AND sdco = cia
        LEFT JOIN proddta.f76422 ON sjdoco = sddoco
                                          AND sjdcto = sddcto
                                          AND sjkcoo = sdco
                                          AND sjlnid = sdlnid
        LEFT JOIN proddta.f7608b com_curto ON TRIM(com_curto.tbshst) = TRIM(destino.aladds)
                                                    AND TRIM(remetent.aladds) = TRIM(com_curto.tbadds)
                                                    AND sjbori = com_curto.tbbori
                                                    AND com_curto.tbitm != '0'
                                                    AND com_curto.tbitm = sditm
                                                    AND TRIM(com_curto.tbac76) = nvl(TRIM(cliente.abac30), '*')
        LEFT JOIN proddta.f7608b sem_curto ON TRIM(sem_curto.tbshst) = TRIM(destino.aladds)
                                                    AND TRIM(remetent.aladds) = TRIM(sem_curto.tbadds)
                                                    AND sjbori = sem_curto.tbbori
                                                    AND sem_curto.tbitm = '0'
                                                    AND TRIM(sem_curto.tbac76) = nvl(TRIM(cliente.abac30), '*')
        LEFT JOIN ref_devol ON substr(to_char(TRIM(cia_ref)), 1, 2) = substr(to_char((sdco)), 1, 2)
                               AND substr(TRIM(filial_ref), 1, 2) = substr(TRIM(sdmcu), 1, 2)
                               AND to_char(sddoco) = to_char(pedido_do_ref)
                               AND to_char(linha_do_ref) = to_char(sdlnid)
                               AND to_char(curto_do_ref) = to_char(sditm)
        LEFT JOIN PRODCTL.F0005  a24 ON TRIM(a24.drsy) = '01'
                                             AND TRIM(a24.drrt) = '24'
                                             AND TRIM(a24.drky) = TRIM(aiac24)
        LEFT JOIN PRODCTL.F0005  a25 ON TRIM(a25.drsy) = '01'
                                             AND TRIM(a25.drrt) = '25'
                                             AND TRIM(a25.drky) = TRIM(aiac25)
        LEFT JOIN PRODCTL.F0005  a26 ON TRIM(a26.drsy) = '01'
                                             AND TRIM(a26.drrt) = '26'
                                             AND TRIM(a26.drky) = TRIM(aiac26)
        LEFT JOIN PRODCTL.F0005  a27 ON TRIM(a27.drsy) = '01'
                                             AND TRIM(a27.drrt) = '27'
                                             AND TRIM(a27.drky) = TRIM(aiac27)
        LEFT JOIN PRODCTL.F0005  a28 ON TRIM(a28.drsy) = '01'
                                             AND TRIM(a28.drrt) = '28'
                                             AND TRIM(a28.drky) = TRIM(aiac28)
        LEFT JOIN proddta.f0101  solicitado ON to_char(solicitado.aban8) = to_char(nvl(TRIM(shorby), 0))
        LEFT JOIN PRODCTL.F0005  srp5 ON TRIM(srp5.drsy) = '41'
                                              AND TRIM(srp5.drrt) = 'S5'
                                              AND TRIM(srp5.drky) = TRIM(imsrp5)
        LEFT JOIN PRODCTL.F0005  srp3 ON TRIM(srp3.drsy) = '41'
                                              AND TRIM(srp3.drrt) = 'S3'
                                              AND TRIM(srp3.drky) = TRIM(imsrp3)
        LEFT JOIN PRODCTL.F0005  srp1 ON TRIM(srp1.drsy) = '41'
                                              AND TRIM(srp1.drrt) = 'S1'
                                              AND TRIM(srp1.drky) = TRIM(imsrp1)
        LEFT JOIN PRODCTL.F0005  srp2 ON TRIM(srp2.drsy) = '41'
                                              AND TRIM(srp2.drrt) = 'S2'
                                              AND TRIM(srp2.drky) = TRIM(imsrp2)
        LEFT JOIN PRODCTL.F0005  prp3 ON TRIM(prp3.drsy) = '41'
                                              AND TRIM(prp3.drrt) = 'P3'
                                              AND TRIM(prp3.drky) = TRIM(imprp3)
        LEFT JOIN PRODCTL.F0005  srp7 ON TRIM(srp7.drsy) = '41'
                                              AND TRIM(srp7.drrt) = '07'
                                              AND TRIM(srp7.drky) = TRIM(imsrp7)
        LEFT JOIN PRODCTL.F0005  srp8 ON TRIM(srp8.drsy) = '41'
                                              AND TRIM(srp8.drrt) = '08'
                                              AND TRIM(srp8.drky) = TRIM(imsrp8)
        LEFT JOIN PRODCTL.F0005  ac10 ON TRIM(ac10.drsy) = '01'
                                              AND TRIM(ac10.drrt) = '10'
                                              AND TRIM(ac10.drky) = TRIM(aiac10)
        LEFT JOIN PRODCTL.F0005  BL ON TRIM(BL.drsy) = '42'
                                              AND TRIM(BL.drrt) = 'HC'
                                              AND TRIM(BL.DRKY) = TRIM(SHHOLD)

        LEFT JOIN proddta.f76b18 ON sjbclf = fcbclf

        LEFT JOIN proddta.F0150   ON MAAN8=SDAN8
        LEFT JOIN proddta.f0101  economico   ON economico.aban8 = MAPA8

 left outer join PRODDTA.F7615B  F7615B  on  SJBNOP = F7615B.TNBNOP and	 SJBSOP=F7615B.TNBSOP
 left outer join PRODDTA.F76011  F76011  on trim(SDAN8)= trim(F76011.AIAN8)
 left outer join PRODDTA.F7617B  F7617B  on  F76422.SJBCTF = F7617B.TSBCTF



    WHERE
            1 = 1

and sddoco NOT IN ('1012819','1425057','64064')

        AND sdlttr != '980'
        AND substr(sdlnty, 1, 1) != 'B'
        AND (sdlnty)!='  '
        AND sddcto IN ( 'SG', 'SX', 'SV', 'VI', 'VO',
                         'VZ', 'V5', 'V7', 'V8',
                        'VA', 'VF', 'VG', 'VH', 'SO',
                        'SO', 'DO', 'CV','VN','VY','VU','VQ','V0','V3' ) --INCLUIDO 'VQ','V0','V3' para aparecer pedidos MCLAW
        AND (sddcto)
            || sdnxtr NOT IN ( 'DO540', 'DO560', 'DO595', 'DO595', 'DO596',
                               'DO597', 'DO520' )

        AND sdaexp != '0'


and  sdco!='71000'
--AND SDDOCO='51641'
    ORDER BY
        data,
        tipo,
        pedido,
        linha,
        cliente






), grupo AS (
    SELECT DISTINCT
        fdan8v,
        TRIM(abalph) AS forn,
        TRIM(fdlotn) AS lote,
        TRIM(fdlitm) AS cod,
        fdissu
        || fdupmj
        || fdtday    AS issu
    FROM
             proddta.f7611b
        INNER JOIN proddta.f0006 ON fdan8v = mcan8
                                          AND (mcstyl) = 'BP'
        INNER JOIN proddta.f0101 ON aban8 = fdan8v
        INNER JOIN temp2 ON TRIM(cod) = TRIM(fdlitm)
                            AND TRIM(lote) = TRIM(fdlotn)



    WHERE
        fddct = 'NF'


), minimo AS (
    SELECT
        MIN(issu) issu_t,
        lote      lote_t,
        cod       cod_t
    FROM
        grupo
    GROUP BY
        lote,
        cod
), grupo2 AS (
    SELECT
        fdan8v
        || '-'
        || forn AS forn_primeiro,
        lote    AS lote_primeiro,
        cod     AS cod_primeiro
    FROM
             grupo
        INNER JOIN minimo ON issu_t = issu
                             AND lote_t = lote
                             AND cod = cod_t
), icms_entrada AS (
--------------------------------
    SELECT DISTINCT
        TRIM(fdlotn) lote_icent,
        TRIM(fdlitm) cod_icent,
        fdco         cid_icent,
        LISTAGG((fdtxr1 / 1000), ' / ') WITHIN GROUP(
        ORDER BY
            fdtxr1 / 1000
        )            icms_entrada,
        LISTAGG(TRIM(fdan8v
                     || '-'
                     || TRIM(abalph)), ' / ') WITHIN GROUP(
       ORDER BY
            fdan8v
            || '-'
            || TRIM(abalph)
        )            fornecedor
    FROM
        (
            SELECT DISTINCT
                fdlotn,
                fdlitm,
                fdco,
                fdtxr1,
               fdan8v,
                abalph
            FROM
                proddta.f7611b
                LEFT JOIN proddta.f0101 ON aban8 = fdan8v
            WHERE
                    fddct = 'NF'
                AND fdpdct = 'OP'
        )
    GROUP BY
        TRIM(fdlotn),
        TRIM(fdlitm),
        fdco

--------------------------------------

), vendas AS (
    SELECT DISTINCT
        origem,
        p_icms_fora,
        despesa_frete,
        icms_total,
		pis,
		cof,
        cod_vendedor,
        vendedor,
        frete,
        lote,
        linha,
        referencia_dev,
        tipo,
        ult_st,
        prox_st,
        to_date(data_faturamento, 'DD/MM/RRRR') AS data_faturamento,
        to_date(data, 'DD/MM/RRRR')             AS data,
        to_date(data_inclusao, 'DD/MM/RRRR')    AS data_inclusao,
        mes_ano,
        to_date(data_cliente, 'DD/MM/RRRR')     AS data_cliente,
        solicitado,
        pedido,
        nota,
        codigo_cliente,
        cliente,
        TRIM(uf)                                AS uf,
        condicao_pag_cadastro,
        cond_pag_pedido,
        cod,
        descricao,
        um,
        CASE WHEN tipo_pedido='CV' THEN 0 ELSE  qtd END qtd,





        preco_unitario,
		preco_unitario2,
         --CASE WHEN TIPO='CARTEIRA' THEN   ROUND(((TOTAL-ICMS_TOTAL) * (CASE WHEN NVL(PIS,0)!=0 THEN 0.9075  ELSE 0 END  ))  / QTD,4)    ELSE ROUND((TOTAL-ICMS_TOTAL-PIS-COF)/QTD ,4)END  PRECO_UNITARIO_NET ,

CASE when TRIM(UF)='EX' THEN preco_unitario WHEN TIPO='CARTEIRA' THEN   ROUND(((TOTAL-ICMS_TOTAL) * (CASE WHEN NVL(PIS,0)!=0 THEN 0.9075  ELSE 1 END  ))  / QTD,4) WHEN TIPO IN ('DEVOLUCAO ANT','DEVOLUCAO')   THEN -ROUND((TOTAL+ICMS_TOTAL+PIS+COF)/-QTD ,4) ELSE ROUND((TOTAL-ICMS_TOTAL-PIS-COF)/QTD ,4)END  PRECO_UNITARIO_NET ,

        material,
        CASE WHEN tipo_pedido='CV' THEN 0 ELSE  custo_unitario END custo_unitario,

        icms_p,
        pis_cof_p,
        ipi_p,
        st,
        difal,
        imna,
        round(preco_unitario * qtd, 4)          AS receita_bruta_total,
        --CASE WHEN UF='EX' THEN TOTAL  WHEN TIPO='CARTEIRA' THEN   ROUND(((TOTAL-ICMS_TOTAL) * (CASE WHEN NVL(PIS,0)!=0 THEN 0.9075  ELSE 1 END  ))  ,4)  WHEN TIPO IN ('DEVOLUCAO ANT','DEVOLUCAO')  THEN ROUND((TOTAL+ICMS_TOTAL+PIS+COF) ,4)  ELSE ROUND((TOTAL-ICMS_TOTAL-PIS-COF) ,4) END  RECEITA_NET_TOTAL ,

        CASE WHEN UF='EX' THEN TOTAL  WHEN TIPO='CARTEIRA' THEN   ROUND(((TOTAL-ICMS_TOTAL) * (CASE WHEN NVL(PIS,0)!=0 THEN 0.9075  ELSE 1 END  ))  ,4)  WHEN TIPO IN ('DEVOLUCAO ANT','DEVOLUCAO')  THEN ROUND((TOTAL+ICMS_TOTAL+PIS+COF) ,4)  ELSE ROUND((TOTAL-ICMS_TOTAL-PIS-COF) ,4) END  RECEITA_NET_TOTAL ,

		CASE WHEN tipo_pedido='CV' THEN 0 ELSE  nvl(round(material * qtd, 4),0)                END custo_material_total,
        CASE WHEN tipo_pedido='CV' THEN 0 ELSE  nvl(round(custo_unitario * qtd, 4) ,0)         END  custo_total_2,
        business_unit,
        tecnologia,
        un_neg,
        filial,
        filial2,
        cod_transp,
        transp,
        tipo_pedido,
        obs_ped,
        um_princ,
        icms_entrada,
        trib_subst,
        desc_repasse,
        desc_zf,
        TRIM(fornecedor)                        forn,
        CASE
            WHEN TRIM(fornecedor) IS NOT NULL THEN
                to_char(forn_primeiro)
            ELSE
                ''
        END                                     forn_primeiro,
        CASE
            WHEN valor_ipi IS NULL THEN
                round((round(preco_unitario * qtd, 4)) *(replace(ipi_p, '%', '') / 100), 2)
            ELSE
                valor_ipi
        END                                     valor_ipi,
        intercompany

        ,CASE WHEN LAST_DAY(to_date(data, 'DD/MM/RRRR')) >=to_date(SYSDATE, 'DD/MM/RRRR') THEN SYSDATE-1 ELSE LAST_DAY(to_date(data, 'DD/MM/RRRR')) END ULT_DATA

,CIDADE
,PAIS
,GRUPO_ECO
,STATUS
,VALOR_FRETE
,VALOR_SEGURO
    FROM
        temp2
        LEFT JOIN icms_entrada ON TRIM(lote) = lote_icent
                                  AND TRIM(cod_icent) = TRIM(cod)
                                  AND substr(cid_icent, 1, 1) = substr(filial, 1, 1)
        LEFT JOIN grupo2 ON TRIM(lote_primeiro) = TRIM(lote)
                            AND TRIM(cod_primeiro) = TRIM(cod)


), F4104_MAX AS (
SELECT max(IVUPMJ||IVTDAY) IVUPMJ2,IVCITM IVCITM2 FROM proddta.F4104 F41042 WHERE F41042.IVXRT= 'A' group by IVCITM

),F4104_MAX2 AS (
SELECT * FROM  proddta.F4104 
INNER JOIN F4104_MAX  ON IVUPMJ2=IVUPMJ||IVTDAY and IVCITM=IVCITM2

WHERE IVXRT= 'A' 
),CONVERSAO AS (


      select 
                distinct 

      ORIGEM, P_ICMS_FORA, DESPESA_FRETE, ICMS_TOTAL,pis,cof, COD_VENDEDOR, VENDEDOR, FRETE, LOTE, LINHA, REFERENCIA_DEV, TIPO, ULT_ST, PROX_ST, DATA_FATURAMENTO, DATA, DATA_INCLUSAO, MES_ANO, DATA_CLIENTE, SOLICITADO, PEDIDO, NOTA, CODIGO_CLIENTE, CLIENTE, UF, CONDICAO_PAG_CADASTRO, COND_PAG_PEDIDO, COD, DESCRICAO, UM, QTD, PRECO_UNITARIO,PRECO_UNITARIO2, PRECO_UNITARIO_NET, MATERIAL, CUSTO_UNITARIO, ICMS_P, PIS_COF_P, IPI_P, ST, DIFAL, IMNA, RECEITA_BRUTA_TOTAL, RECEITA_NET_TOTAL, CUSTO_MATERIAL_TOTAL, CUSTO_TOTAL_2, BUSINESS_UNIT, TECNOLOGIA, UN_NEG, FILIAL, FILIAL2, COD_TRANSP, TRANSP, TIPO_PEDIDO, OBS_PED, UM_PRINC, ICMS_ENTRADA, TRIB_SUBST, DESC_REPASSE, DESC_ZF, FORN, FORN_PRIMEIRO, VALOR_IPI, INTERCOMPANY, ULT_DATA,CIDADE,PAIS,GRUPO_ECO,STATUS,
trim(IVLITM) as ITEM_CONVERSAO,
trim(F4101.IMDSC1) as DESCRICAO_R,
trim(F4101.IMSEG1) as COD_R
,VALOR_FRETE
,VALOR_SEGURO
      from vendas

  left outer join F4104_MAX2 F4104  on trim(F4104.IVCITM) =  decode(instr(trim(COD),'.'),'0',trim(COD),substr(trim(COD),'1',instr(trim(COD),'.')-1))  and F4104.IVXRT= 'A' 

        left outer join proddta.F4101 F4101 on NVL2( trim(IVLITM), trim(IVLITM),COD) = trim(F4101.IMLITM)
    --  left outer join proddta.F4101 F4101 on trim(F4101S.IMSEG1) = trim(F4101.IMLITM)






),CUSTO as (

SELECT  
      B.DATA DATA_G, 
      TRIM(B.ITEM) AS COD_ITEM_G,
      TRIM(B.FILIAL) AS FILIAL_CUSTO, -- ADICIONADO FILIAL AQUI
      (TO_NUMBER(B.CUSTO_REAIS)) AS CUSTO_GERENCIAL,
      (TO_NUMBER(B.CUSTO_SERV)) AS CUSTO_SERV, 
      (TO_NUMBER(NVL(B.CUSTO_MATERIAL,0))) AS CUSTO_MATERIAL,
      B.LISTA
FROM PUBDB.TEMP_CUSTO_ULTMES B
WHERE (LISTA)='NET'


UNION ALL


SELECT  
      B.DATA DATA_G, 
      TRIM(B.ITEM) AS COD_ITEM_G,
      TRIM(B.FILIAL) AS FILIAL_CUSTO, -- ADICIONADO FILIAL AQUI
      (TO_NUMBER(B.CUSTO_REAIS)) AS CUSTO_GERENCIAL,
      (TO_NUMBER(B.CUSTO_SERV)) AS CUSTO_SERV, 
      (TO_NUMBER(NVL(B.CUSTO_MATERIAL,0))) AS CUSTO_MATERIAL,
      B.LISTA
  FROM PUBDB.TEMP_CUSTO_ULTMES B 
  WHERE   TRIM(B.LISTA)='M'

UNION ALL

SELECT  
      B.DATA DATA_G, 
      TRIM(B.ITEM) AS COD_ITEM_G,
      TRIM(B.FILIAL) AS FILIAL_CUSTO, -- ADICIONADO FILIAL AQUI
      (TO_NUMBER(B.CUSTO_REAIS)) AS CUSTO_GERENCIAL,
      (TO_NUMBER(B.CUSTO_SERV)) AS CUSTO_SERV, 
      (TO_NUMBER(NVL(B.CUSTO_MATERIAL,0))) AS CUSTO_MATERIAL,
      B.LISTA
FROM PUBDB.TEMP_CUSTO_ULTMES B 
WHERE  NOT EXISTS (
                    SELECT 1 FROM PUBDB.TEMP_CUSTO_ULTMES C 
                     WHERE (B.ITEM)=(C.ITEM) 
                        AND B.FILIAL = C.FILIAL -- Condição de Filial ADICIONADA AQUI
                        AND TRIM(C.LISTA) IN ('M') 
                        AND B.DATA=C.DATA)
AND TRIM(B.LISTA)='M1'

UNION ALL

SELECT  
      B.DATA DATA_G, 
      TRIM(B.ITEM) AS COD_ITEM_G,
      TRIM(B.FILIAL) AS FILIAL_CUSTO, -- ADICIONADO FILIAL AQUI
      (TO_NUMBER(B.CUSTO_REAIS)) AS CUSTO_GERENCIAL,
      (TO_NUMBER(B.CUSTO_SERV)) AS CUSTO_SERV, 
      (TO_NUMBER(NVL(B.CUSTO_MATERIAL,0))) AS CUSTO_MATERIAL,
      B.LISTA
FROM PUBDB.TEMP_CUSTO_ULTMES B 
WHERE  NOT EXISTS (
                    SELECT 1 FROM PUBDB.TEMP_CUSTO_ULTMES C  
                    WHERE (B.ITEM)=(C.ITEM)
                        AND B.FILIAL = C.FILIAL -- Condição de Filial ADICIONADA AQUI
                        AND TRIM(C.LISTA) IN ('M','M1') 
                        AND B.DATA=C.DATA)
AND TRIM(B.LISTA)='M2'

UNION ALL

SELECT  
      B.DATA DATA_G, 
      TRIM(B.ITEM) AS COD_ITEM_G,
      TRIM(B.FILIAL) AS FILIAL_CUSTO, -- ADICIONADO FILIAL AQUI
      (TO_NUMBER(B.CUSTO_REAIS)) AS CUSTO_GERENCIAL,
      (TO_NUMBER(B.CUSTO_SERV)) AS CUSTO_SERV, 
      (TO_NUMBER(NVL(B.CUSTO_MATERIAL,0))) AS CUSTO_MATERIAL,
      B.LISTA
FROM PUBDB.TEMP_CUSTO_ULTMES B 
WHERE  NOT EXISTS (
                    SELECT 1 FROM PUBDB.TEMP_CUSTO_ULTMES C  
                    WHERE (B.ITEM)=(C.ITEM)
                    AND B.FILIAL = C.FILIAL -- Condição de Filial ADICIONADA AQUI
                    AND TRIM(C.LISTA) IN ('M','M1','M2') 
                    AND B.DATA=C.DATA)
AND TRIM(B.LISTA)='M3'

UNION ALL

SELECT  
      B.DATA DATA_G, 
      TRIM(B.ITEM) AS COD_ITEM_G,
      TRIM(B.FILIAL) AS FILIAL_CUSTO, -- ADICIONADO FILIAL AQUI
      (TO_NUMBER(B.CUSTO_REAIS)) AS CUSTO_GERENCIAL,
      (TO_NUMBER(B.CUSTO_SERV)) AS CUSTO_SERV, 
      (TO_NUMBER(NVL(B.CUSTO_MATERIAL,0))) AS CUSTO_MATERIAL,
      B.LISTA
FROM PUBDB.TEMP_CUSTO_ULTMES B 
WHERE  NOT EXISTS (
                    SELECT 1 FROM PUBDB.TEMP_CUSTO_ULTMES C  
                    WHERE (B.ITEM)=(C.ITEM)
                    AND B.FILIAL = C.FILIAL -- Condição de Filial ADICIONADA AQUI
                    AND TRIM(C.LISTA) IN ('M','M1','M2','M3') 
                    AND B.DATA=C.DATA)
AND TRIM(B.LISTA)='PM'

union all

SELECT  
      B.DATA DATA_G, 
      TRIM(B.ITEM) AS COD_ITEM_G,
      TRIM(B.FILIAL) AS FILIAL_CUSTO, -- ADICIONADO FILIAL AQUI
      (TO_NUMBER(B.CUSTO_REAIS)) AS CUSTO_GERENCIAL,
      (TO_NUMBER(B.CUSTO_SERV)) AS CUSTO_SERV, 
      (TO_NUMBER(NVL(B.CUSTO_MATERIAL,0))) AS CUSTO_MATERIAL,
      B.LISTA
FROM PUBDB.TEMP_CUSTO_ULTMES B  
WHERE  NOT EXISTS (
                    SELECT 1 FROM PUBDB.TEMP_CUSTO_ULTMES C  
                    WHERE (B.ITEM)=(C.ITEM)
                    AND B.FILIAL = C.FILIAL -- Condição de Filial ADICIONADA AQUI
                    AND TRIM(C.LISTA) IN ('M','M1','M2','M3','PM') 
                    AND B.DATA=C.DATA)
AND (B.LISTA)='AT1'




UNION ALL

SELECT  
      B.DATA DATA_G, 
      TRIM(B.ITEM) AS COD_ITEM_G,
      TRIM(B.FILIAL) AS FILIAL_CUSTO, -- ADICIONADO FILIAL AQUI
      (TO_NUMBER(B.CUSTO_REAIS)) AS CUSTO_GERENCIAL,
      (TO_NUMBER(B.CUSTO_SERV)) AS CUSTO_SERV, 
      (TO_NUMBER(NVL(B.CUSTO_MATERIAL,0))) AS CUSTO_MATERIAL,
      B.LISTA
FROM PUBDB.TEMP_CUSTO_ULTMES B  
WHERE  NOT EXISTS (
                    SELECT 1 FROM PUBDB.TEMP_CUSTO_ULTMES C  
                    WHERE (B.ITEM)=(C.ITEM)
                    AND B.FILIAL = C.FILIAL -- Condição de Filial ADICIONADA AQUI
                    AND TRIM(C.LISTA) IN ('M','M1','M2','M3','PM','AT1') 
                    AND B.DATA=C.DATA)
AND (B.LISTA)='AT2'       


UNION ALL

SELECT  
      B.DATA DATA_G, 
      TRIM(B.ITEM) AS COD_ITEM_G,
      TRIM(B.FILIAL) AS FILIAL_CUSTO, -- ADICIONADO FILIAL AQUI
      (TO_NUMBER(B.CUSTO_REAIS)) AS CUSTO_GERENCIAL,
      (TO_NUMBER(B.CUSTO_SERV)) AS CUSTO_SERV, 
      (TO_NUMBER(NVL(B.CUSTO_MATERIAL,0))) AS CUSTO_MATERIAL,
      B.LISTA
FROM PUBDB.TEMP_CUSTO_ULTMES B
WHERE  NOT EXISTS (
                    SELECT 1 FROM PUBDB.TEMP_CUSTO_ULTMES C 
                    WHERE  (B.ITEM)= (C.ITEM)
                    AND B.FILIAL = C.FILIAL -- Condição de Filial ADICIONADA AQUI
                    AND  TRIM(C.LISTA) IN ('M','M1','M2','M3','PM','AT1','AT2') 
                    AND B.DATA=C.DATA)
AND  (B.LISTA)='PA1'              

UNION ALL

SELECT  
      B.DATA DATA_G, 
      TRIM(B.ITEM) AS COD_ITEM_G,
      TRIM(B.FILIAL) AS FILIAL_CUSTO, -- ADICIONADO FILIAL AQUI
      (TO_NUMBER(B.CUSTO_REAIS)) AS CUSTO_GERENCIAL,
      (TO_NUMBER(B.CUSTO_SERV)) AS CUSTO_SERV, 
      (TO_NUMBER(NVL(B.CUSTO_MATERIAL,0))) AS CUSTO_MATERIAL,
      B.LISTA
FROM PUBDB.TEMP_CUSTO_ULTMES B
WHERE  NOT EXISTS (
                    SELECT 1 FROM PUBDB.TEMP_CUSTO_ULTMES C  
                    WHERE  (B.ITEM)= (C.ITEM)
                    AND B.FILIAL = C.FILIAL -- Condição de Filial ADICIONADA AQUI
                    AND TRIM(C.LISTA) IN ('M','M1','M2','M3','PM','AT1','AT2','PA1') 
                    AND B.DATA=C.DATA)
AND  (B.LISTA)='PA2'                       

UNION ALL

SELECT  
      B.DATA DATA_G, 
      TRIM(B.ITEM) AS COD_ITEM_G,
      TRIM(B.FILIAL) AS FILIAL_CUSTO, -- ADICIONADO FILIAL AQUI
      (TO_NUMBER(B.CUSTO_REAIS)) AS CUSTO_GERENCIAL,
      (TO_NUMBER(B.CUSTO_SERV)) AS CUSTO_SERV, 
      (TO_NUMBER(NVL(B.CUSTO_MATERIAL,0))) AS CUSTO_MATERIAL,
      B.LISTA
FROM PUBDB.TEMP_CUSTO_ULTMES B  
WHERE  NOT EXISTS (
                    SELECT 1 FROM PUBDB.TEMP_CUSTO_ULTMES C  
                    WHERE  (B.ITEM)= (C.ITEM)
                    AND B.FILIAL = C.FILIAL -- Condição de Filial ADICIONADA AQUI
                    AND TRIM(C.LISTA) IN ('M','M1','M2','M3','PM','AT1','AT2','PA1','PA2') 
                    AND B.DATA=C.DATA)
AND  (B.LISTA)='PA5'          



), MES_UTEIS AS (

-- quantos dias uteis tem cada mes passado
SELECT  TO_CHAR(periodo,'MM/YYYY') MES_ANO_UTEIS,COUNT(periodo)  UTEIS_MES   FROM (
SELECT  trunc(last_day(sysdate)) - (level-1) periodo from dual 
connect BY level <=     to_number(   TO_DATE('31/12/2030','DD/MM/YYYY') - TO_DATE('01/01/2020','DD/MM/YYYY')    ) +30
) where TO_CHAR(periodo,'d') not in ('1','7') and TO_CHAR(periodo,'DDMM') NOT IN ('0101','2104','0105','1906','0709','1210','0211','1511','2512')  and TO_CHAR(periodo,'DDMMYY') NOT IN ('010322','200223','210223','070423','090623','080923','131023','031123','120224','130224','290324','300524','090724','201124','241224','311224','030325','040325','180425','020525','200625','090725') GROUP BY TO_CHAR(periodo,'MM/YYYY')  





),DIA_UTEIS AS (

select  TO_CHAR(SYSDATE,'MM/YYYY')  MES_HOJE_UTEIS,count(periodo)-1 UTEIS_HOJE  from (
select trunc((sysdate)) - (level-1) periodo from dual 
connect BY level <=     to_number((SYSDATE) - TO_DATE('01/'|| TO_CHAR((SYSDATE), 'MM/YYYY')   ,'DD/MM/YYYY')) + 1
) where TO_CHAR(periodo,'d') not in ('1','7') and TO_CHAR(periodo,'DDMM') NOT IN ('0101','2104','0105','1906','0709','1210','0211','1511','2512')  and TO_CHAR(periodo,'DDMMYY') NOT IN ('010322','200223','210223','070423','090623','080923','131023','031123','120224','130224','290324','300524','090724','201124','241224','311224','030325','040325','180425','020525','200625','090725') 





),ULT_TEMP AS (





SELECT
DISTINCT 

    pjs.origem,
    nvl(pjs.p_icms_fora,0) p_icms_fora,
    nvl(pjs.despesa_frete,0) despesa_frete,
    nvl(pjs.icms_total,0) icms_total,
	 nvl(pjs.pis,0) pis,
	 nvl(pjs.cof,0) cof,
    pjs.cod_vendedor,
    pjs.vendedor,
    pjs.frete,
    pjs.lote,
    pjs.linha,
    pjs.referencia_dev,
    pjs.tipo,
    pjs.ult_st,
    pjs.prox_st,
    pjs.data_faturamento,
    pjs.data,
    pjs.data_inclusao,
    pjs.mes_ano,
    pjs.data_cliente,
    pjs.solicitado,
    pjs.pedido,
    pjs.nota,
    pjs.codigo_cliente,
    pjs.cliente,
    pjs.uf,
    pjs.condicao_pag_cadastro,
    pjs.cond_pag_pedido,
    pjs.cod,
    pjs.descricao,
    pjs.um,
    nvl(pjs.qtd,0) qtd,
    nvl(pjs.preco_unitario,0) preco_unitario,
	nvl(pjs.preco_unitario2,0) preco_unitario2,
    nvl(pjs.preco_unitario_net,0) preco_unitario_net,
    nvl(pjs.material,0) material,
    nvl(pjs.custo_unitario,0) custo_unitario,
    nvl(pjs.icms_p,0) icms_p,
	case when nvl(pjs.pis,0)='0' then '0%' else  pis_cof_p end pis_cof_p,

    nvl(pjs.ipi_p,0) ipi_p,
    nvl(pjs.st,0) st,
    nvl(pjs.difal,0) difal,
    pjs.imna,
    nvl(pjs.receita_bruta_total,0) receita_bruta_total,
    nvl(pjs.receita_net_total,0) receita_net_total,
    nvl(pjs.custo_material_total,0) custo_material_total,
    nvl(pjs.custo_total_2,0) custo_total_2,
    pjs.business_unit,
    pjs.tecnologia,
    pjs.un_neg,
    pjs.filial,
    pjs.filial2,
    pjs.cod_transp,
    pjs.transp,
    pjs.tipo_pedido,
    pjs.obs_ped,
    pjs.um_princ,
    nvl(pjs.icms_entrada,0) icms_entrada,
    nvl(pjs.trib_subst,0) trib_subst,
    nvl(pjs.desc_repasse,0) desc_repasse,
    nvl(pjs.desc_zf,0) desc_zf,
    pjs.forn,
    pjs.forn_primeiro,
    nvl(pjs.valor_ipi,0) valor_ipi, 
    pjs.intercompany,
    ( SELECT lower(scrc.usuario_rede)
        FROM stgdb.stg_csv_responsavel_celula scrc
       WHERE rownum=1
         AND NVL(pjs.business_unit,'x') = NVL(scrc.classe(+),NVL(pjs.business_unit,'x'))
         AND NVL(pjs.tecnologia,'x') = NVL(scrc.sub_classe(+),NVL(pjs.tecnologia,'x'))
         AND NVL(pjs.cod,'x') = NVL(scrc.cod_produto(+),NVL(pjs.cod,'x'))
    )                          AS responsavel_celula,
    ( SELECT lower(scrc.usuario_rede_2)
        FROM stgdb.stg_csv_responsavel_celula scrc
       WHERE rownum=1
         AND NVL(pjs.business_unit,'x') = NVL(scrc.classe(+),NVL(pjs.business_unit,'x'))
         AND NVL(pjs.tecnologia,'x') = NVL(scrc.sub_classe(+),NVL(pjs.tecnologia,'x'))
         AND NVL(pjs.cod,'x') = NVL(scrc.cod_produto(+),NVL(pjs.cod,'x'))
    )                          AS responsavel_celula_2,
    ( SELECT lower(scv.usuario_rede)
        FROM stgdb.stg_csv_vendedor           scv
       WHERE rownum=1
         AND NVL(pjs.cod_vendedor,'x') = NVL(scv.cod_jde(+),NVL(pjs.cod_vendedor,'x'))
    )                          AS user_vendedor,
    pjs.ULT_DATA DATA_CUSTO,

    CASE WHEN pjs.tipo_pedido='CV' THEN 0 ELSE NVL(COALESCE(C_FULL.CUSTO_GERENCIAL, C_ROOT.CUSTO_GERENCIAL), 0) END CUSTO_GERENCIAL,
    CASE WHEN pjs.tipo_pedido='CV' THEN 0 ELSE NVL(COALESCE(C_FULL.CUSTO_SERV, C_ROOT.CUSTO_SERV), 0) END CUSTO_SERV,
    CASE WHEN pjs.tipo_pedido='CV' THEN 0 ELSE NVL(COALESCE(C_FULL.CUSTO_MATERIAL, C_ROOT.CUSTO_MATERIAL), 0) END CUSTO_MATERIAL,


    COALESCE(C_FULL.LISTA, C_ROOT.LISTA) AS LISTA
    ,case when DESCRICAO_R is null then   trim(IMDSC1) else trim(DESCRICAO_R ) end DESCRICAO_R 
     ,  CASE WHEN IMLITM LIKE '%.%' THEN SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11) END  EMB

     ,CASE 

WHEN pjs.tipo_pedido='CV' THEN 0 

WHEN E.CUSTO_GERENCIAL IS NOT NULL THEN NVL(E.CUSTO_GERENCIAL,0) 
WHEN F.CUSTO_GERENCIAL IS NOT NULL THEN NVL(F.CUSTO_GERENCIAL,0) 
WHEN TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11))='P1'   THEN 0.08
WHEN TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11))='P12' THEN 0.37
WHEN TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11))='P13' THEN 0.55
WHEN TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11))='P14' THEN 1.32
WHEN TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11))='P15' THEN 0.1
WHEN TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11))='P16' THEN 0.13
WHEN TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11))='P2' THEN 0.33
WHEN TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11))='P3' THEN 0.90
WHEN TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11))='P4'  and  to_char(to_date(pjs.data, 'DD/MM/YYYY'), 'MMYYYY')<'032022' THEN 0.62
WHEN TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11))='P5'  and  to_char(to_date(pjs.data, 'DD/MM/YYYY'), 'MMYYYY')<'032022' THEN 0.48
WHEN TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11))='P6' THEN 0.38
WHEN TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11))='P7'   and  to_char(to_date(pjs.data, 'DD/MM/YYYY'), 'MMYYYY')<'032022' THEN 0.66
WHEN TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11))='P4' THEN 0.63
WHEN TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11))='P5' THEN 0.47
WHEN TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11))='P7' THEN 0.62
ELSE NVL(E.CUSTO_GERENCIAL,0) 
 END CUSTO_EMB,

CASE WHEN TIPO='CARTEIRA' THEN '0' WHEN to_char(sysdate,'MM/YYYY')=to_char(pjs.mes_ano) THEN  TO_CHAR(UTEIS_HOJE)   ELSE TO_cHAR(UTEIS_MES) END UTEIS_DIA,
TO_cHAR(UTEIS_MES) UTEIS_MES,


CASE 
    WHEN pjs.codigo_cliente='3811' AND   IMDSC1 LIKE '% OS %'   THEN nvl(pjs.receita_bruta_total,0)/20*80
    WHEN  pjs.cod IN ('130017')  THEN nvl(pjs.receita_bruta_total,0)/20*80
    WHEN pjs.cod IN ('987248','987248.Q32','139586','139586.O1','962149','130017','130016','130016.I2','963049.A1','962837.A1','962973.J1','962697.P5','962893.A1','962951.A1','962721.A1','962973.A1','962951.M1','963016.A1','962881.A1','962984.J1','962800.A1','962926.A1','963005.A1','963049.J1','962721.J1','962767.J1','962973.M1','963093.N1','962675.P5','962767.A1','962881.J1','962951.J1','962664.E1','962870.M1','963049.M1','962951','962837.M1','962732.J1','963060.A1','962732.A1','962870.A1','962653.F1','962686.E1','962778.A1','962848.A1','962800.M1','963082.N1','962881.M1','963005.M1','963027','963049','964008.J1','962826.A1','962926.M1','964474.A1','964160.A1','962926.L1','965278.A1','962848.M1','964740.A1','962653.A1','962686.A1','962686.F1','963005.J1','962826.M1','962826.J1','963049.N1','965760.A1','962708.A1','964008.A1','962641.A1','962653.E1','964160.N1','964740.M1','962859.A1','962951','962837.J1','139586','962149','130016','963027','963049','968931.A1','962149.Q32','130016.Q50','976225') THEN nvl(pjs.receita_bruta_total,0)
    WHEN  IMDSC1 LIKE '% OS %' AND IMSRP1 IN ('110','120','180') THEN nvl(pjs.receita_bruta_total,0)
    WHEN  IMDSC1 LIKE '%GARD 4%'  THEN nvl(pjs.receita_bruta_total,0)
ELSE 0 END COMPLEMENTO_RECEITA_BRUTA,

case
    WHEN TRIM(FRETE)='A' THEN 'CIF - EMPRESA ENTREGA NO CLIENTE (A)'
    WHEN TRIM(FRETE)='B' THEN 'FOB - EMPRESA ENTREGA NA TRANSP (B)'
    WHEN TRIM(FRETE)='D' THEN 'FOB - TRANSP DO CLIENTE RETIRA (D)'
    WHEN TRIM(FRETE)='E' THEN 'FOB - CLIENTE RETIRA (E)'
    WHEN TRIM(FRETE)='F' THEN 'SEM FRETE - FRETE CORTESIA (F)'
    WHEN TRIM(FRETE)='G' THEN 'FOB - EMPRESA ENTREGA NO TERMINAL (G)'
    WHEN TRIM(FRETE)='H' THEN 'SEM FRETE - NF COMPLEM  NÃO ENVIAR PRODUTO (H)'
    WHEN TRIM(FRETE)='E' THEN 'FOB - TRANSP DO CLIENTE ENT NO TERMI (I)'
    WHEN TRIM(FRETE)='J' THEN 'CIF - EWNYKIMA ENTREGA NO CLIENTE (J)'
END INFORMACAO_FRETE,
CIDADE,
PAIS,

CASE 
WHEN TRIM(COND_PAG_PEDIDO)='07/14' THEN 10.5
WHEN TRIM(COND_PAG_PEDIDO)='7/14' THEN 10.5
WHEN TRIM(COND_PAG_PEDIDO)='10/20' THEN 15
WHEN TRIM(COND_PAG_PEDIDO)='0/15' THEN 7.5
WHEN TRIM(COND_PAG_PEDIDO)='0/30/60' THEN 30
WHEN TRIM(COND_PAG_PEDIDO)='03 DDL' THEN 3
WHEN TRIM(COND_PAG_PEDIDO)='07 DDL' THEN 7
WHEN TRIM(COND_PAG_PEDIDO)='07/14/21' THEN 14
WHEN TRIM(COND_PAG_PEDIDO)='07/14/21/28' THEN 17.5
WHEN TRIM(COND_PAG_PEDIDO)='10 DDL' THEN 10
WHEN TRIM(COND_PAG_PEDIDO)='10/20/30/40/50/60/70/80/90' THEN 50
WHEN TRIM(COND_PAG_PEDIDO)='100DDL Pagto Terça-Feira' THEN 100
WHEN TRIM(COND_PAG_PEDIDO)='103/108/113' THEN 108
WHEN TRIM(COND_PAG_PEDIDO)='110 DDL' THEN 110
WHEN TRIM(COND_PAG_PEDIDO)='110/120/130' THEN 120
WHEN TRIM(COND_PAG_PEDIDO)='12 DDL' THEN 12
WHEN TRIM(COND_PAG_PEDIDO)='120 DDL' THEN 120
WHEN TRIM(COND_PAG_PEDIDO)='120 DDL - Pagto 05 e 20' THEN 120
WHEN TRIM(COND_PAG_PEDIDO)='14 DDL' THEN 14
WHEN TRIM(COND_PAG_PEDIDO)='14/21' THEN 17.5
WHEN TRIM(COND_PAG_PEDIDO)='14/21/28' THEN 21
WHEN TRIM(COND_PAG_PEDIDO)='14/21/28/35' THEN 24.5
WHEN TRIM(COND_PAG_PEDIDO)='14/21/28/35/42/49            ' THEN 28
WHEN TRIM(COND_PAG_PEDIDO)='14/21/28/35/42/49/56' THEN 35
WHEN TRIM(COND_PAG_PEDIDO)='14/28' THEN 21
WHEN TRIM(COND_PAG_PEDIDO)='15 DDL' THEN 15
WHEN TRIM(COND_PAG_PEDIDO)='15/20/30/35                  ' THEN 25
WHEN TRIM(COND_PAG_PEDIDO)='15/21/28/35' THEN 24.75
WHEN TRIM(COND_PAG_PEDIDO)='15/25                        ' THEN 15
WHEN TRIM(COND_PAG_PEDIDO)='15/30' THEN 22.5
WHEN TRIM(COND_PAG_PEDIDO)='15/30/45                     ' THEN 30
WHEN TRIM(COND_PAG_PEDIDO)='15/30/45/60                  ' THEN 37.5
WHEN TRIM(COND_PAG_PEDIDO)='15/30/45/60/75' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='18/25/32/39/43' THEN 31.4
WHEN TRIM(COND_PAG_PEDIDO)='180 DDL' THEN 180
WHEN TRIM(COND_PAG_PEDIDO)='2 DDL' THEN 2
WHEN TRIM(COND_PAG_PEDIDO)='20 DDL Pagto 3a 4a 5a 6a' THEN 20
WHEN TRIM(COND_PAG_PEDIDO)='20/30/40' THEN 30
WHEN TRIM(COND_PAG_PEDIDO)='20/30/40/50/60' THEN 40
WHEN TRIM(COND_PAG_PEDIDO)='20/40' THEN 30
WHEN TRIM(COND_PAG_PEDIDO)='20/40/60' THEN 40
WHEN TRIM(COND_PAG_PEDIDO)='20/40/60/80' THEN 50
WHEN TRIM(COND_PAG_PEDIDO)='21 DDL' THEN 21
WHEN TRIM(COND_PAG_PEDIDO)='21/28' THEN 24.5
WHEN TRIM(COND_PAG_PEDIDO)='21/28/35' THEN 28
WHEN TRIM(COND_PAG_PEDIDO)='21/28/35/42' THEN 31.5
WHEN TRIM(COND_PAG_PEDIDO)='21/28/35/42/49' THEN 35
WHEN TRIM(COND_PAG_PEDIDO)='21/28/35/42/49/56' THEN 38.5
WHEN TRIM(COND_PAG_PEDIDO)='21/28/35/42/49/56/63' THEN 42
WHEN TRIM(COND_PAG_PEDIDO)='21/28/35/42/49/56/63/70' THEN 45.5
WHEN TRIM(COND_PAG_PEDIDO)='21/28/35/42/49/56/63/70/77/84' THEN 52.5
WHEN TRIM(COND_PAG_PEDIDO)='21/35/42' THEN 32.66666667
WHEN TRIM(COND_PAG_PEDIDO)='21/42                        ' THEN 31.5
WHEN TRIM(COND_PAG_PEDIDO)='21/42/56' THEN 39.66666667
WHEN TRIM(COND_PAG_PEDIDO)='23/46' THEN 34.5
WHEN TRIM(COND_PAG_PEDIDO)='24/31/38/45                  ' THEN 34.5
WHEN TRIM(COND_PAG_PEDIDO)='24/34/44/54/64/74' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='25 DDL' THEN 25
WHEN TRIM(COND_PAG_PEDIDO)='25/35/42                     ' THEN 35
WHEN TRIM(COND_PAG_PEDIDO)='27/34' THEN 30.5
WHEN TRIM(COND_PAG_PEDIDO)='270 DDL' THEN 270
WHEN TRIM(COND_PAG_PEDIDO)='28 DDL' THEN 28
WHEN TRIM(COND_PAG_PEDIDO)='28 DDL Pagto 01 e 16' THEN 28
WHEN TRIM(COND_PAG_PEDIDO)='28 DDL Pagto Quarta-feira' THEN 28
WHEN TRIM(COND_PAG_PEDIDO)='28/35' THEN 31.5
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42' THEN 35
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42 Pgto Quarta Feira' THEN 35
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49' THEN 38.5
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49 Pgto Qua-Sex' THEN 38.5
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56' THEN 42
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/62/69         ' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/62/69/75/82/89' THEN 58.7
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/63' THEN 45.5
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/63 SEXTA' THEN 45.5
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/63/70' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/63/70 Quarta' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/63/70 ' THEN 45.5
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/63/70/77' THEN 52.5
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/63/70/77/84 ' THEN 52.5
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/63/70/77/84/91' THEN 59.5
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/57' THEN 42.2
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/60' THEN 42.8
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/65' THEN 43.8
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/50 ' THEN 35
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/56' THEN 40.25
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/56/63' THEN 44.8
WHEN TRIM(COND_PAG_PEDIDO)='28/38' THEN 33
WHEN TRIM(COND_PAG_PEDIDO)='28/42' THEN 35
WHEN TRIM(COND_PAG_PEDIDO)='28/42/56' THEN 42
WHEN TRIM(COND_PAG_PEDIDO)='28/42/56' THEN 42
WHEN TRIM(COND_PAG_PEDIDO)='28/42/56/63/70' THEN 56
WHEN TRIM(COND_PAG_PEDIDO)='28/42/56/70' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='28/42/56/70/84' THEN 56
WHEN TRIM(COND_PAG_PEDIDO)='28/42/56/70/84/98' THEN 63
WHEN TRIM(COND_PAG_PEDIDO)='28/42/56/70/84/98/112        ' THEN 70
WHEN TRIM(COND_PAG_PEDIDO)='28/42/56/77/91' THEN 58.8
WHEN TRIM(COND_PAG_PEDIDO)='28/42/70/84' THEN 46.66666667
WHEN TRIM(COND_PAG_PEDIDO)='28/45' THEN 36.5
WHEN TRIM(COND_PAG_PEDIDO)='28/45/62' THEN 36.5
WHEN TRIM(COND_PAG_PEDIDO)='28/56' THEN 42
WHEN TRIM(COND_PAG_PEDIDO)='28/56 Pagto Ter-Quin' THEN 42
WHEN TRIM(COND_PAG_PEDIDO)='28/56/84' THEN 56
WHEN TRIM(COND_PAG_PEDIDO)='28/56/84 ' THEN 42
WHEN TRIM(COND_PAG_PEDIDO)='28/56/84/112' THEN 70
WHEN TRIM(COND_PAG_PEDIDO)='29 DDL' THEN 29
WHEN TRIM(COND_PAG_PEDIDO)='30 DDL' THEN 30
WHEN TRIM(COND_PAG_PEDIDO)='30 DDL TER QUA QUI SEX' THEN 30
WHEN TRIM(COND_PAG_PEDIDO)='30/35/40/45/50/55/60' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='30/35/40/45/50/55/60/65/70/75' THEN 52.5
WHEN TRIM(COND_PAG_PEDIDO)='30/37/45/52/60               ' THEN 41
WHEN TRIM(COND_PAG_PEDIDO)='30/38/45/52/60' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='30/38/45/60' THEN 43.25
WHEN TRIM(COND_PAG_PEDIDO)='30/40                        ' THEN 35
WHEN TRIM(COND_PAG_PEDIDO)='30/40/50' THEN 40
WHEN TRIM(COND_PAG_PEDIDO)='30/40/50/60' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='30/40/50/60/70' THEN 50
WHEN TRIM(COND_PAG_PEDIDO)='30/40/50/60/70/80/90' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='30/40/50/65/70/85/106/116/126' THEN 76.44444444
WHEN TRIM(COND_PAG_PEDIDO)='30/42' THEN 36
WHEN TRIM(COND_PAG_PEDIDO)='30/45' THEN 37.5
WHEN TRIM(COND_PAG_PEDIDO)='30/45/60' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='30/45/60 Pagto Ter-Quin' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='30/45/60/75' THEN 52.5
WHEN TRIM(COND_PAG_PEDIDO)='30/45/60/75/90' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='30/45/60/75/90 TER - QUIN' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='30/45/60/75/90/105' THEN 67.5
WHEN TRIM(COND_PAG_PEDIDO)='30/52/70' THEN 50.66666667
WHEN TRIM(COND_PAG_PEDIDO)='30/60' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='30/60 Pagto dia 10 e 25' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='30/60/90' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='30/60/90 Ter - Quin' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='30/60/90/120' THEN 75
WHEN TRIM(COND_PAG_PEDIDO)='30/60/90/120/150' THEN 90
WHEN TRIM(COND_PAG_PEDIDO)='31 DDL' THEN 31
WHEN TRIM(COND_PAG_PEDIDO)='33 DDL' THEN 33
WHEN TRIM(COND_PAG_PEDIDO)='34 DDL' THEN 34
WHEN TRIM(COND_PAG_PEDIDO)='35 DDL' THEN 35
WHEN TRIM(COND_PAG_PEDIDO)='35/40/45' THEN 37.5
WHEN TRIM(COND_PAG_PEDIDO)='35/42' THEN 38.5
WHEN TRIM(COND_PAG_PEDIDO)='35/42/49' THEN 42
WHEN TRIM(COND_PAG_PEDIDO)='35/42/49/56' THEN 45.5
WHEN TRIM(COND_PAG_PEDIDO)='35/42/49/56/63' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='35/42/49/56/63 Pagto Quinta' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='35/42/49/56/63/70' THEN 52.5
WHEN TRIM(COND_PAG_PEDIDO)='35/42/49/56/63/70/77' THEN 56
WHEN TRIM(COND_PAG_PEDIDO)='35/42/49/56/63/70/77/84' THEN 59.5
WHEN TRIM(COND_PAG_PEDIDO)='35/42/49/56/63/70/77/84/91' THEN 63
WHEN TRIM(COND_PAG_PEDIDO)='35/42/49/56/63/70/77/84/91/98' THEN 66.5
WHEN TRIM(COND_PAG_PEDIDO)='35/42/49/56/63/70/77/85' THEN 59.625
WHEN TRIM(COND_PAG_PEDIDO)='35/42/50' THEN 42.333333
WHEN TRIM(COND_PAG_PEDIDO)='35/42/56' THEN 42
WHEN TRIM(COND_PAG_PEDIDO)='35/45' THEN 40
WHEN TRIM(COND_PAG_PEDIDO)='35/45/52' THEN 44
WHEN TRIM(COND_PAG_PEDIDO)='35/45/52/60' THEN 48
WHEN TRIM(COND_PAG_PEDIDO)='35/45/55' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='35/45/55 - 10/20/30' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='35/45/55/65 - 10/20/30' THEN 50
WHEN TRIM(COND_PAG_PEDIDO)='35/45/55/65/75' THEN 55
WHEN TRIM(COND_PAG_PEDIDO)='35/45/55/65/75 - 07/17/27' THEN 55
WHEN TRIM(COND_PAG_PEDIDO)='35/45/60' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='35/47/59/71/83/95/107/119/131' THEN 83
WHEN TRIM(COND_PAG_PEDIDO)='35/49/56/63/70/77/84' THEN 62
WHEN TRIM(COND_PAG_PEDIDO)='35/49/60' THEN 48
WHEN TRIM(COND_PAG_PEDIDO)='35/49/63                     ' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='35/49/63/77/91' THEN 63
WHEN TRIM(COND_PAG_PEDIDO)='35/50' THEN 42.5
WHEN TRIM(COND_PAG_PEDIDO)='35/50/65/75' THEN 56.25
WHEN TRIM(COND_PAG_PEDIDO)='35/55/75' THEN 55
WHEN TRIM(COND_PAG_PEDIDO)='35/56/77' THEN 56
WHEN TRIM(COND_PAG_PEDIDO)='35/63' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='35/63/91' THEN 63
WHEN TRIM(COND_PAG_PEDIDO)='37 DDL' THEN 37
WHEN TRIM(COND_PAG_PEDIDO)='38 DDL' THEN 38
WHEN TRIM(COND_PAG_PEDIDO)='38/45/52' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='39/59/79' THEN 59
WHEN TRIM(COND_PAG_PEDIDO)='40 DDL' THEN 40
WHEN TRIM(COND_PAG_PEDIDO)='40/50/60' THEN 50
WHEN TRIM(COND_PAG_PEDIDO)='40/50/60/70/80' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='40/50/60/70/80/90' THEN 65
WHEN TRIM(COND_PAG_PEDIDO)='40/50/60/70/80/90/100' THEN 70
WHEN TRIM(COND_PAG_PEDIDO)='40/60/75' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='41 DDL' THEN 41
WHEN TRIM(COND_PAG_PEDIDO)='42 DDL' THEN 42
WHEN TRIM(COND_PAG_PEDIDO)='42/49' THEN 45.5
WHEN TRIM(COND_PAG_PEDIDO)='42/49/56' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='42/49/56/63' THEN 52.5
WHEN TRIM(COND_PAG_PEDIDO)='42/49/56/63/70' THEN 56
WHEN TRIM(COND_PAG_PEDIDO)='42/49/56/63/70/77' THEN 59.5
WHEN TRIM(COND_PAG_PEDIDO)='42/49/56/63/70/77/84' THEN 59.5
WHEN TRIM(COND_PAG_PEDIDO)='42/49/56/63/70/77/84/91' THEN 66.5
WHEN TRIM(COND_PAG_PEDIDO)='42/56' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='42/56/65' THEN 54.33333333
WHEN TRIM(COND_PAG_PEDIDO)='42/56/70' THEN 56
WHEN TRIM(COND_PAG_PEDIDO)='42/56/70/84/98' THEN 70
WHEN TRIM(COND_PAG_PEDIDO)='42/56/70/84/98/112' THEN 77
WHEN TRIM(COND_PAG_PEDIDO)='42/70/98' THEN 70
WHEN TRIM(COND_PAG_PEDIDO)='43 DDL' THEN 43
WHEN TRIM(COND_PAG_PEDIDO)='44 DDL' THEN 44
WHEN TRIM(COND_PAG_PEDIDO)='45 DDL' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='45/50/55/60/65/70/75/80/85' THEN 62.5
WHEN TRIM(COND_PAG_PEDIDO)='45/52' THEN 48.5
WHEN TRIM(COND_PAG_PEDIDO)='45/52/59' THEN 52
WHEN TRIM(COND_PAG_PEDIDO)='45/52/59/66/73/80' THEN 59
WHEN TRIM(COND_PAG_PEDIDO)='45/52/60' THEN 52.33333333
WHEN TRIM(COND_PAG_PEDIDO)='45/53' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='45/55/65' THEN 55
WHEN TRIM(COND_PAG_PEDIDO)='45/55/65/75' THEN 55
WHEN TRIM(COND_PAG_PEDIDO)='45/60' THEN 52.5
WHEN TRIM(COND_PAG_PEDIDO)='45/60/75' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='45/60/75/90' THEN 67.5
WHEN TRIM(COND_PAG_PEDIDO)='45/60/75/90/105' THEN 67.5
WHEN TRIM(COND_PAG_PEDIDO)='45/60/75/90/115' THEN 77
WHEN TRIM(COND_PAG_PEDIDO)='45/60/90' THEN 52.5
WHEN TRIM(COND_PAG_PEDIDO)='45/70' THEN 57.5
WHEN TRIM(COND_PAG_PEDIDO)='45/75/105' THEN 75
WHEN TRIM(COND_PAG_PEDIDO)='47 DDL' THEN 47
WHEN TRIM(COND_PAG_PEDIDO)='49 DDL' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='49/56' THEN 52.5
WHEN TRIM(COND_PAG_PEDIDO)='49/56/63' THEN 56
WHEN TRIM(COND_PAG_PEDIDO)='49/56/63/70/77/84/91/98' THEN 73.5
WHEN TRIM(COND_PAG_PEDIDO)='49/63/77/98' THEN 71.75
WHEN TRIM(COND_PAG_PEDIDO)='50 DDL' THEN 50
WHEN TRIM(COND_PAG_PEDIDO)='50/60' THEN 55
WHEN TRIM(COND_PAG_PEDIDO)='50/60/70' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='50/60/70/80/90' THEN 70
WHEN TRIM(COND_PAG_PEDIDO)='50/65/80/95' THEN 72.5
WHEN TRIM(COND_PAG_PEDIDO)='52 DDL' THEN 52
WHEN TRIM(COND_PAG_PEDIDO)='53/60/67' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='55/60/65/70/75/80/85/90/95' THEN 75
WHEN TRIM(COND_PAG_PEDIDO)='56 DDL' THEN 56
WHEN TRIM(COND_PAG_PEDIDO)='56/60' THEN 58
WHEN TRIM(COND_PAG_PEDIDO)='56/63' THEN 59.5
WHEN TRIM(COND_PAG_PEDIDO)='56/63/70' THEN 63
WHEN TRIM(COND_PAG_PEDIDO)='56/63/70/120' THEN 77.25
WHEN TRIM(COND_PAG_PEDIDO)='56/70/84/98/112' THEN 84
WHEN TRIM(COND_PAG_PEDIDO)='56/84' THEN 70
WHEN TRIM(COND_PAG_PEDIDO)='60 DDL' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='60 DDL Pagto Quinta Feira' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='60 DDL Pagto Sexta Feira' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='60/63/70/73' THEN 66.5
WHEN TRIM(COND_PAG_PEDIDO)='60/67' THEN 63.5
WHEN TRIM(COND_PAG_PEDIDO)='60/67/74/81/88/95' THEN 77.5
WHEN TRIM(COND_PAG_PEDIDO)='60/70/80' THEN 70
WHEN TRIM(COND_PAG_PEDIDO)='60/70/80/90' THEN 75
WHEN TRIM(COND_PAG_PEDIDO)='60/75' THEN 67.5
WHEN TRIM(COND_PAG_PEDIDO)='60/75/90' THEN 75
WHEN TRIM(COND_PAG_PEDIDO)='60/75/90/105' THEN 82.5
WHEN TRIM(COND_PAG_PEDIDO)='60/90' THEN 75
WHEN TRIM(COND_PAG_PEDIDO)='60/90/120' THEN 90
WHEN TRIM(COND_PAG_PEDIDO)='63 DDL' THEN 63
WHEN TRIM(COND_PAG_PEDIDO)='63/70/77' THEN 70
WHEN TRIM(COND_PAG_PEDIDO)='63/70/77/84/91/98/105/112' THEN 87.5
WHEN TRIM(COND_PAG_PEDIDO)='68 DDL' THEN 68
WHEN TRIM(COND_PAG_PEDIDO)='69 DDL' THEN 69
WHEN TRIM(COND_PAG_PEDIDO)='7/14/21/28/35/42/49/56/63/70' THEN 38.5
WHEN TRIM(COND_PAG_PEDIDO)='70 DDL' THEN 70
WHEN TRIM(COND_PAG_PEDIDO)='75 DDL' THEN 75
WHEN TRIM(COND_PAG_PEDIDO)='75/90/105' THEN 90
WHEN TRIM(COND_PAG_PEDIDO)='77/84/91/98/105/112' THEN 94.5
WHEN TRIM(COND_PAG_PEDIDO)='79 DDL' THEN 79
WHEN TRIM(COND_PAG_PEDIDO)='80 DDL' THEN 80
WHEN TRIM(COND_PAG_PEDIDO)='85 DDL' THEN 85
WHEN TRIM(COND_PAG_PEDIDO)='85 DDL Pgtos dia 01 e 16' THEN 85
WHEN TRIM(COND_PAG_PEDIDO)='86 DDL' THEN 86
WHEN TRIM(COND_PAG_PEDIDO)='87DDL' THEN 87
WHEN TRIM(COND_PAG_PEDIDO)='88 DDL' THEN 88
WHEN TRIM(COND_PAG_PEDIDO)='89 DDL' THEN 89
WHEN TRIM(COND_PAG_PEDIDO)='90 DDL' THEN 90
WHEN TRIM(COND_PAG_PEDIDO)='90 DDL Pagto Sexta Feira' THEN 90
WHEN TRIM(COND_PAG_PEDIDO)='90/100/110/120' THEN 105
WHEN TRIM(COND_PAG_PEDIDO)='90/120' THEN 105
WHEN TRIM(COND_PAG_PEDIDO)='91 DDL' THEN 91
WHEN TRIM(COND_PAG_PEDIDO)='93 DDL' THEN 93
WHEN TRIM(COND_PAG_PEDIDO)='95 DDL' THEN 95
WHEN TRIM(COND_PAG_PEDIDO)='96 DDL' THEN 96
WHEN TRIM(COND_PAG_PEDIDO)='A VISTA' THEN 1
WHEN TRIM(COND_PAG_PEDIDO)='ANTECIPADO' THEN 1
WHEN TRIM(COND_PAG_PEDIDO)='REMESSA' THEN 0
WHEN TRIM(COND_PAG_PEDIDO)='RESERV. MODULO COMPRAS' THEN 0
WHEN TRIM(COND_PAG_PEDIDO)='84 DDL' THEN 84
WHEN TRIM(COND_PAG_PEDIDO)='63/70/77/84/91/98' THEN 80.5
WHEN TRIM(COND_PAG_PEDIDO)='35 DDL Pagto Ter-Qui' THEN 35
WHEN TRIM(COND_PAG_PEDIDO)='94 DDL' THEN 94
WHEN TRIM(COND_PAG_PEDIDO)='28 DDL Ter Qua Qui Sex' THEN 28
WHEN TRIM(COND_PAG_PEDIDO)='AMOSTRA GRATIS' THEN 0
WHEN TRIM(COND_PAG_PEDIDO)='27/34/41' THEN 34
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42 Pagto Quinta Feira' THEN 35
WHEN TRIM(COND_PAG_PEDIDO)='20/30/40/50/60/70' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/63/70 TER-QUIN' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='1/30 DDL' THEN 15
WHEN TRIM(COND_PAG_PEDIDO)='18 DDL' THEN 18
WHEN TRIM(COND_PAG_PEDIDO)='30/60 Pagto Quinta Feira' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='35/49/56' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/48' THEN 38
WHEN TRIM(COND_PAG_PEDIDO)='45 DDL Pagto Quinta Feira' THEN 45

WHEN TRIM(COND_PAG_PEDIDO)='56/72' THEN 64
WHEN TRIM(COND_PAG_PEDIDO)='60 Pagto dia 08 e 23' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='28/42/70/84' THEN 56
WHEN TRIM(COND_PAG_PEDIDO)='40/50' THEN 55
WHEN TRIM(COND_PAG_PEDIDO)='65 DDL' THEN 65
WHEN TRIM(COND_PAG_PEDIDO)='45/55/65/75' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='45/60/75/90/105' THEN 75
WHEN TRIM(COND_PAG_PEDIDO)='35/40/45' THEN 40
WHEN TRIM(COND_PAG_PEDIDO)='10/20/30' THEN 20
WHEN TRIM(COND_PAG_PEDIDO)='28/42/56' THEN 42
WHEN TRIM(COND_PAG_PEDIDO)='49/63/70' THEN 63
WHEN TRIM(COND_PAG_PEDIDO)='45/60/90' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='45/52/59/66/73/80' THEN 62.5
WHEN TRIM(COND_PAG_PEDIDO)='32/39/46' THEN 39
WHEN TRIM(COND_PAG_PEDIDO)='93DDL Pagto 05 e 20' THEN 93
WHEN TRIM(COND_PAG_PEDIDO)='105 DIAS 3a' THEN 105

WHEN TRIM(COND_PAG_PEDIDO)='21/35/42/63/77' THEN 47.6
WHEN TRIM(COND_PAG_PEDIDO)='45/60/75/90/105' THEN 75
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/63/70' THEN 42.57
WHEN TRIM(COND_PAG_PEDIDO)='35/40/45' THEN 40
WHEN TRIM(COND_PAG_PEDIDO)='28/42/70/84' THEN 58.57
WHEN TRIM(COND_PAG_PEDIDO)='35/49' THEN 42
WHEN TRIM(COND_PAG_PEDIDO)='25/35/42' THEN 34
WHEN TRIM(COND_PAG_PEDIDO)='20 DDL' THEN 20
WHEN TRIM(COND_PAG_PEDIDO)='80/90/100/110 DDL' THEN 96.25
WHEN TRIM(COND_PAG_PEDIDO)='45/55/65/75' THEN 57.5
WHEN TRIM(COND_PAG_PEDIDO)='60/67/74/81/88' THEN 74
WHEN TRIM(COND_PAG_PEDIDO)='30/60/90/120/150/180' THEN 90
WHEN TRIM(COND_PAG_PEDIDO)='15/30/45' THEN 30
WHEN TRIM(COND_PAG_PEDIDO)='105 DDL' THEN 105
WHEN TRIM(COND_PAG_PEDIDO)='20/30/40 SEXTA FEIRA' THEN 30
WHEN TRIM(COND_PAG_PEDIDO)='VENC 56 3a/4a/5a' THEN 56
WHEN TRIM(COND_PAG_PEDIDO)='14/21/28/63/70/77' THEN 39.83
WHEN TRIM(COND_PAG_PEDIDO)='15/46/77/105 a 442 Pgto dia 16' THEN 97.67
WHEN TRIM(COND_PAG_PEDIDO)='103 DDL' THEN 103
WHEN TRIM(COND_PAG_PEDIDO)='28/52/70/84' THEN 58.5
WHEN TRIM(COND_PAG_PEDIDO)='28/38' THEN 33
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/63/84' THEN 45.71
WHEN TRIM(COND_PAG_PEDIDO)='73 DDL' THEN 73
WHEN TRIM(COND_PAG_PEDIDO)='126 DDL' THEN 126
WHEN TRIM(COND_PAG_PEDIDO)='31/41' THEN 36
WHEN TRIM(COND_PAG_PEDIDO)='39/49/59' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='40/50 DDL Pagto Terça-Feira' THEN 45.83
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42 (exc 05/10/20/25)' THEN 37.5
WHEN TRIM(COND_PAG_PEDIDO)='31/36/38' THEN 35
WHEN TRIM(COND_PAG_PEDIDO)='26 DDL' THEN 26
WHEN TRIM(COND_PAG_PEDIDO)='45 DDL Pagto Quarta Feira' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='30/54/75 DDL' THEN 53.67
WHEN TRIM(COND_PAG_PEDIDO)='30 DDL Pagto dia 5 util' THEN 30
WHEN TRIM(COND_PAG_PEDIDO)='28/45/60' THEN 44.33
WHEN TRIM(COND_PAG_PEDIDO)='REMESSA' THEN 0
WHEN TRIM(COND_PAG_PEDIDO)='40/55/70' THEN 55
WHEN TRIM(COND_PAG_PEDIDO)='90/120/150' THEN 120
WHEN TRIM(COND_PAG_PEDIDO)='28/45/62' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='21/35' THEN 28
WHEN TRIM(COND_PAG_PEDIDO)='49/63/77/91/105' THEN 77
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/56/60/72/90/120' THEN 56.5
WHEN TRIM(COND_PAG_PEDIDO)='30/60 QUARTA' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='30/45/60/75/90/105/120' THEN 67.86
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42 sem Pgto 10/11/12' THEN 38.67
WHEN TRIM(COND_PAG_PEDIDO)='14/21/49/56/63/70' THEN 41.83
WHEN TRIM(COND_PAG_PEDIDO)='60 DDL Pagto dia 16 e 30' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='40/60' THEN 50
WHEN TRIM(COND_PAG_PEDIDO)='37/67' THEN 52
WHEN TRIM(COND_PAG_PEDIDO)='49/79/109/139/169/199 a 799' THEN 129.83
WHEN TRIM(COND_PAG_PEDIDO)='23 DDL' THEN 23
WHEN TRIM(COND_PAG_PEDIDO)='45/60/75/90/105/120' THEN 75
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/63/70/77/84' THEN 50.67
WHEN TRIM(COND_PAG_PEDIDO)='28/42/56/64/70 DDL' THEN 52.57
WHEN TRIM(COND_PAG_PEDIDO)='60 DDL Pagto Quarta-Feira' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='35/56/77' THEN 56
WHEN TRIM(COND_PAG_PEDIDO)='42/56/63/84' THEN 58.75
WHEN TRIM(COND_PAG_PEDIDO)='145 Dias - 3a' THEN 145
WHEN TRIM(COND_PAG_PEDIDO)='14/21/28/35/42/49' THEN 31.5
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/50' THEN 38.33
WHEN TRIM(COND_PAG_PEDIDO)='106 DDL' THEN 106
WHEN TRIM(COND_PAG_PEDIDO)='15/45/75' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='48 DDL' THEN 48
WHEN TRIM(COND_PAG_PEDIDO)='70/80' THEN 75
WHEN TRIM(COND_PAG_PEDIDO)='34/63' THEN 48.5
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/56/70/77/84' THEN 49.71
WHEN TRIM(COND_PAG_PEDIDO)='42/56/63' THEN 53.67
WHEN TRIM(COND_PAG_PEDIDO)='28 DDL Pagto Segunda-Feira' THEN 28
WHEN TRIM(COND_PAG_PEDIDO)='90/105/120' THEN 105
WHEN TRIM(COND_PAG_PEDIDO)='20/42/56' THEN 39.33
WHEN TRIM(COND_PAG_PEDIDO)='40/54/68/82/96/110/124' THEN 76.57
WHEN TRIM(COND_PAG_PEDIDO)='28/35 Pagto Ter-Qui' THEN 31.5
WHEN TRIM(COND_PAG_PEDIDO)='30/42/49' THEN 40.33
WHEN TRIM(COND_PAG_PEDIDO)='20/30' THEN 25
WHEN TRIM(COND_PAG_PEDIDO)='30/50' THEN 40
WHEN TRIM(COND_PAG_PEDIDO)='42/56/70/84' THEN 60.57
WHEN TRIM(COND_PAG_PEDIDO)='15/20/30/35' THEN 25
WHEN TRIM(COND_PAG_PEDIDO)='28/42/56/70/84/98/112' THEN 63.86
WHEN TRIM(COND_PAG_PEDIDO)='28/42/56/63/70' THEN 50.14
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/62/69' THEN 45.14
WHEN TRIM(COND_PAG_PEDIDO)='66 DDL' THEN 66
WHEN TRIM(COND_PAG_PEDIDO)='128 DDL' THEN 128
WHEN TRIM(COND_PAG_PEDIDO)='56/77/98/119' THEN 90
WHEN TRIM(COND_PAG_PEDIDO)='45 DDL Pagto 11 e 22' THEN 33
WHEN TRIM(COND_PAG_PEDIDO)='11 DDL' THEN 11
WHEN TRIM(COND_PAG_PEDIDO)='15/25' THEN 20
WHEN TRIM(COND_PAG_PEDIDO)='45/50/55/60/65/70/75/80/85' THEN 62.5
WHEN TRIM(COND_PAG_PEDIDO)='40/60/80/100/120' THEN 80
WHEN TRIM(COND_PAG_PEDIDO)='92 DDL' THEN 92
WHEN TRIM(COND_PAG_PEDIDO)='45/52/59/66/73/80' THEN 61.67
WHEN TRIM(COND_PAG_PEDIDO)='05/10/15/20' THEN 12.5
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42 (exc 05/10/20/25)' THEN 37.5
WHEN TRIM(COND_PAG_PEDIDO)='132 DDL' THEN 132
WHEN TRIM(COND_PAG_PEDIDO)='56/77' THEN 66.5
WHEN TRIM(COND_PAG_PEDIDO)='30/40' THEN 35
WHEN TRIM(COND_PAG_PEDIDO)='35/45/60/75/90' THEN 61
WHEN TRIM(COND_PAG_PEDIDO)='28/30/35/42/49' THEN 36.8
WHEN TRIM(COND_PAG_PEDIDO)='27/49' THEN 38
WHEN TRIM(COND_PAG_PEDIDO)='28/56/84' THEN 56
WHEN TRIM(COND_PAG_PEDIDO)='35/49/63' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='05 DDL' THEN 5
WHEN TRIM(COND_PAG_PEDIDO)='21/42/63' THEN 42
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/84' THEN 42.71
WHEN TRIM(COND_PAG_PEDIDO)='25/35/45' THEN 35
WHEN TRIM(COND_PAG_PEDIDO)='0/28' THEN 14
WHEN TRIM(COND_PAG_PEDIDO)='49/63/70' THEN 60.67
WHEN TRIM(COND_PAG_PEDIDO)='90/100/110 DDL' THEN 100
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/77/84/91' THEN 51.71
WHEN TRIM(COND_PAG_PEDIDO)='15/22/29/36/43/50' THEN 30.83
WHEN TRIM(COND_PAG_PEDIDO)='60 dias 5o Util' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='AMOSTRA GRATIS' THEN 0
WHEN TRIM(COND_PAG_PEDIDO)='45/53' THEN 49
WHEN TRIM(COND_PAG_PEDIDO)='28/35/45' THEN 36
WHEN TRIM(COND_PAG_PEDIDO)='102 DDL' THEN 102
WHEN TRIM(COND_PAG_PEDIDO)='24/31/38/45' THEN 34.5
WHEN TRIM(COND_PAG_PEDIDO)='34/62' THEN 48
WHEN TRIM(COND_PAG_PEDIDO)='29/36/43' THEN 36
WHEN TRIM(COND_PAG_PEDIDO)='28/42/63/77/91 DDL' THEN 56.2
WHEN TRIM(COND_PAG_PEDIDO)='150 DDL' THEN 150
WHEN TRIM(COND_PAG_PEDIDO)='28/42/56' THEN 42.67
WHEN TRIM(COND_PAG_PEDIDO)='28/42/56/63' THEN 49.75
WHEN TRIM(COND_PAG_PEDIDO)='28DDL 05/15/25' THEN 23.33
WHEN TRIM(COND_PAG_PEDIDO)='28/35/60' THEN 41
WHEN TRIM(COND_PAG_PEDIDO)='62 DDL' THEN 62
WHEN TRIM(COND_PAG_PEDIDO)='28/42/56/63/70/84' THEN 54.14
WHEN TRIM(COND_PAG_PEDIDO)='21/42' THEN 31.5
WHEN TRIM(COND_PAG_PEDIDO)='32 DDL' THEN 32
WHEN TRIM(COND_PAG_PEDIDO)='35/60/75/90' THEN 72.5
WHEN TRIM(COND_PAG_PEDIDO)='30/60 Pgto Segunda-Feira' THEN 45
WHEN TRIM(COND_PAG_PEDIDO)='28/35 Pagto 07/17/27' THEN 30
WHEN TRIM(COND_PAG_PEDIDO)='30/40/50/60/70/80' THEN 50
WHEN TRIM(COND_PAG_PEDIDO)='BONIFICACAO' THEN 0
WHEN TRIM(COND_PAG_PEDIDO)='49/56/63 Pagto Quinta-feira' THEN 56.67
WHEN TRIM(COND_PAG_PEDIDO)='51 DDL' THEN 51
WHEN TRIM(COND_PAG_PEDIDO)='28/35/56' THEN 39.67
WHEN TRIM(COND_PAG_PEDIDO)='30/37/45/52/60' THEN 44.67
WHEN TRIM(COND_PAG_PEDIDO)='30/40/60' THEN 43.33
WHEN TRIM(COND_PAG_PEDIDO)='20/27' THEN 23.5
WHEN TRIM(COND_PAG_PEDIDO)='45/55/65/75 Pg Ter Qua Qui Sex' THEN 63.67
WHEN TRIM(COND_PAG_PEDIDO)='138' THEN 138
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/56/63/70/77849198' THEN 49.71
WHEN TRIM(COND_PAG_PEDIDO)='37/44/55' THEN 45.33
WHEN TRIM(COND_PAG_PEDIDO)='22/29/36/43/50/57' THEN 38.83
WHEN TRIM(COND_PAG_PEDIDO)='30/60/90/120 a 750 Pgto dia 01' THEN 60.67
WHEN TRIM(COND_PAG_PEDIDO)='63/70/77/84/91' THEN 77
WHEN TRIM(COND_PAG_PEDIDO)='42/59/56' THEN 52.33
WHEN TRIM(COND_PAG_PEDIDO)='35/50' THEN 42.5
WHEN TRIM(COND_PAG_PEDIDO)='30/50/70' THEN 50
WHEN TRIM(COND_PAG_PEDIDO)='5 DDL' THEN 5
WHEN TRIM(COND_PAG_PEDIDO)='35/49/63 SPG 10/15/20/25/30/31' THEN 34.83
WHEN TRIM(COND_PAG_PEDIDO)='15/21/28' THEN 21.33
WHEN TRIM(COND_PAG_PEDIDO)='104 DDL' THEN 104
WHEN TRIM(COND_PAG_PEDIDO)='30/55/75 - 05/20/25' THEN 45.67
WHEN TRIM(COND_PAG_PEDIDO)='130 DDL' THEN 130
WHEN TRIM(COND_PAG_PEDIDO)='30/60/90/120/150 ATE 510' THEN 90.67
WHEN TRIM(COND_PAG_PEDIDO)='28/35/42/49/70' THEN 46.57
WHEN TRIM(COND_PAG_PEDIDO)='35 - 10/20/30' THEN 25
WHEN TRIM(COND_PAG_PEDIDO)='28 DDL Pagto Sexta-Feira' THEN 28
WHEN TRIM(COND_PAG_PEDIDO)='31/38/45/52/59/66/73/80/87/94' THEN 56.11
WHEN TRIM(COND_PAG_PEDIDO)='56/84/112/140' THEN 97.33
WHEN TRIM(COND_PAG_PEDIDO)='29/36' THEN 32.5
WHEN TRIM(COND_PAG_PEDIDO)='60/75/90/105/120' THEN 82.5
WHEN TRIM(COND_PAG_PEDIDO)='35/70/84' THEN 63
WHEN TRIM(COND_PAG_PEDIDO)='14/21/28/35/42 DDL' THEN 30.67
WHEN TRIM(COND_PAG_PEDIDO)='55/86/116/147/177/208 à 1120' THEN 125.67
WHEN TRIM(COND_PAG_PEDIDO)='27 DDL' THEN 27
WHEN TRIM(COND_PAG_PEDIDO)='28/42/56/84' THEN 50
WHEN TRIM(COND_PAG_PEDIDO)='56/70/84' THEN 70
WHEN TRIM(COND_PAG_PEDIDO)='45/60/90' THEN 65
WHEN TRIM(COND_PAG_PEDIDO)='60 DDL Ter Qua Qui Sex' THEN 60
WHEN TRIM(COND_PAG_PEDIDO)='42/70/84' THEN 65.33
WHEN TRIM(COND_PAG_PEDIDO)='140 DDL' THEN 140
WHEN TRIM(COND_PAG_PEDIDO)='25/30/35' THEN 30
WHEN TRIM(COND_PAG_PEDIDO)='21/42/49/56/63' THEN 44.2
WHEN TRIM(COND_PAG_PEDIDO)='15/30/45/60' THEN 37.5
WHEN TRIM(COND_PAG_PEDIDO)='7/14/21/28/35' THEN 21.4
WHEN TRIM(COND_PAG_PEDIDO)='35/42/50' THEN 42.33
WHEN TRIM(COND_PAG_PEDIDO)='38/45/52/59/66/72/79/85/92/99' THEN 61.5
WHEN TRIM(COND_PAG_PEDIDO)='100 DDL' THEN 100
WHEN TRIM(COND_PAG_PEDIDO)='129' THEN 129
WHEN TRIM(COND_PAG_PEDIDO)='35 - 15/25' THEN 20
WHEN TRIM(COND_PAG_PEDIDO)='49/56/63/84 DIAS UTEIS' THEN 60.67
WHEN TRIM(COND_PAG_PEDIDO)='0/30' THEN 15
WHEN TRIM(COND_PAG_PEDIDO)='42/84' THEN 63
WHEN TRIM(COND_PAG_PEDIDO)='133 DDL' THEN 133
WHEN TRIM(COND_PAG_PEDIDO)='25/35' THEN 30
WHEN TRIM(COND_PAG_PEDIDO)='29/37/43' THEN 36.33
WHEN TRIM(COND_PAG_PEDIDO)='108 DDL' THEN 108
WHEN TRIM(COND_PAG_PEDIDO)='44/75/106/135 à 775 Pgto 20' THEN 90
WHEN TRIM(COND_PAG_PEDIDO)='42/49/56/63/70/77/84' THEN 63
WHEN TRIM(COND_PAG_PEDIDO)='30 DDL Pagto Quarta Feira' THEN 30
WHEN TRIM(COND_PAG_PEDIDO)='33/43' THEN 38


ELSE 0 
END PRAZO_MEDIO_PAG



,GRUPO_ECO
,STATUS

,TRIM(IMSEG1) SEGMENTO
,TRIM(IMSRP5) CAT5

,VALOR_FRETE
,VALOR_SEGURO

FROM
    CONVERSAO pjs
inner join  proddta.F4101 ON  TRIM(pjs.cod)=trim(imlitm)
LEFT OUTER JOIN CUSTO C_FULL ON trim(pjs.COD) = trim(C_FULL.COD_ITEM_G) AND TO_CHAR(pjs.ULT_DATA, 'DD/MM/YYYY') = TO_CHAR(C_FULL.DATA_G, 'DD/MM/YYYY') AND ((pjs.FILIAL = '411000' AND C_FULL.FILIAL_CUSTO = '411000') OR (pjs.FILIAL != '411000'))
LEFT OUTER JOIN CUSTO C_ROOT ON trim(pjs.COD_R) = trim(C_ROOT.COD_ITEM_G) AND TO_CHAR(pjs.ULT_DATA, 'DD/MM/YYYY') = TO_CHAR(C_ROOT.DATA_G, 'DD/MM/YYYY') AND ((pjs.FILIAL = '411000' AND C_ROOT.FILIAL_CUSTO = '411000') OR (pjs.FILIAL != '411000'))
       
LEFT JOIN MES_UTEIS ON to_char(pjs.mes_ano)=to_char(MES_ANO_UTEIS)
LEFT JOIN DIA_UTEIS ON to_char(pjs.mes_ano)=to_char(MES_HOJE_UTEIS)


left join (

SELECT  
B.DATA DATA_G, 
  TRIM(B.ITEM) AS COD_ITEM_G,

          (TO_NUMBER(B.CUSTO_REAIS)) AS CUSTO_GERENCIAL
                               , (TO_NUMBER(B.CUSTO_SERV)) AS CUSTO_SERV  
							   , (TO_NUMBER(NVL(B.CUSTO_MATERIAL,0))) AS CUSTO_MATERIAL 
     ,B.LISTA
FROM  PUBDB.TEMP_CUSTO_ULTMES B  
WHERE   TRIM(B.LISTA)='NET'      

  ) E  ON     REPLACE(TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11)),'P15','A5')=trim(E.COD_ITEM_G) AND IMLITM LIKE '%.%' AND TO_CHAR(pjs.ULT_DATA, 'DD/MM/YYYY')=TO_CHAR(E.DATA_G, 'DD/MM/YYYY')

   left join (

SELECT  
B.DATA DATA_G, 
  TRIM(B.ITEM) AS COD_ITEM_G,

          (TO_NUMBER(B.CUSTO_REAIS)) AS CUSTO_GERENCIAL
                               , (TO_NUMBER(B.CUSTO_SERV)) AS CUSTO_SERV 
							   , (TO_NUMBER(NVL(B.CUSTO_MATERIAL,0))) AS CUSTO_MATERIAL 
     ,B.LISTA
FROM  PUBDB.TEMP_CUSTO_ULTMES B  
WHERE   TRIM(B.LISTA)='EMB'      

  ) F  ON     REPLACE(TRIM(SUBSTR(IMLITM,INSTR(IMLITM,'.')+1,11)),'P15','A5')=trim(F.COD_ITEM_G) AND IMLITM LIKE '%.%' AND TO_CHAR(pjs.ULT_DATA, 'DD/MM/YYYY')=TO_CHAR(F.DATA_G, 'DD/MM/YYYY')




),CONVERSOR AS (


SELECT 
CXCRR*USD_BRL CONVERSOR,
to_char(to_date((CXEFT + 1900000), 'YYYYDDD'), 'MM/YYYY') MES_ANO_C
FROM proddta.F0015
LEFT JOIN (
SELECT AVG(CXCRR) USD_BRL,
to_char(ADD_MONTHS(to_date((CXEFT + 1900000), 'YYYYDDD'),1), 'MM/YYYY') MES_ANO_BRL
FROM  proddta.F0015 WHERE CXCRCD='USD' AND CXCRDC='BRL'
GROUP BY to_char(ADD_MONTHS(to_date((CXEFT + 1900000), 'YYYYDDD'),1), 'MM/YYYY')
) ON to_char(to_date((CXEFT + 1900000), 'YYYYDDD'), 'MM/YYYY')=MES_ANO_BRL
WHERE CXCRCD='CLP' AND CXCRDC='USD'
AND to_char(to_date((CXEFT + 1900000), 'YYYYDDD'), 'DD')='01'







  )

  SELECT 
  ORIGEM, 
  P_ICMS_FORA, 
  DESPESA_FRETE, 
     CASE 
WHEN TIPO IN ('DEVOLUCAO ANT','DEVOLUCAO') THEN ICMS_TOTAL*-1
ELSE ICMS_TOTAL
END ICMS_TOTAL,
  CASE 
WHEN TIPO IN ('DEVOLUCAO ANT','DEVOLUCAO') THEN PIS*-1
ELSE PIS
END PIS,
  CASE 
WHEN TIPO IN ('DEVOLUCAO ANT','DEVOLUCAO') THEN COF*-1
ELSE COF
END COF,

  COD_VENDEDOR, 
  VENDEDOR, 
  FRETE, 
  LOTE, 
  LINHA, 
  REFERENCIA_DEV, 
  TIPO, 
  ULT_ST, 
  PROX_ST, 
  DATA_FATURAMENTO, 
  DATA, 
  DATA_INCLUSAO, 
  MES_ANO, 
  DATA_CLIENTE, 
  SOLICITADO, 
  PEDIDO, 
  NOTA, 
  CODIGO_CLIENTE, 
  CLIENTE, 
  UF, 
  CONDICAO_PAG_CADASTRO, 
  COND_PAG_PEDIDO, 
  COD, DESCRICAO, 
  UM, 
  QTD, 
  CASE 
  WHEN FILIAL='710000' AND TIPO='CARTEIRA' THEN   NVL(PRECO_UNITARIO*NVL(B.CONVERSOR,0),4)
  WHEN FILIAL='710000' THEN   NVL(PRECO_UNITARIO*NVL(A.CONVERSOR,0),4)
  ELSE PRECO_UNITARIO
  END PRECO_UNITARIO, 

 CASE 
  WHEN FILIAL='710000' AND TIPO='CARTEIRA' THEN   NVL(PRECO_UNITARIO2*NVL(B.CONVERSOR,0),4)
  WHEN FILIAL='710000' THEN   NVL(PRECO_UNITARIO2*NVL(A.CONVERSOR,0),4)
  ELSE PRECO_UNITARIO2
  END PRECO_UNITARIO2, 


  CASE 
  WHEN FILIAL='710000' AND TIPO='CARTEIRA' THEN   NVL(PRECO_UNITARIO*0.81*NVL(B.CONVERSOR,0),4)
  WHEN FILIAL='710000' THEN   NVL(PRECO_UNITARIO*0.81*NVL(A.CONVERSOR,0),4)
  ELSE PRECO_UNITARIO_NET
  END PRECO_UNITARIO_NET, 


  MATERIAL, 





  CUSTO_UNITARIO, 
  ICMS_P, 
  PIS_COF_P, 
  IPI_P, 
  ST, 
  DIFAL, 
  IMNA, 

  CASE 
  WHEN FILIAL='710000' AND TIPO='CARTEIRA' THEN   NVL(RECEITA_BRUTA_TOTAL*NVL(B.CONVERSOR,0),4)
  WHEN FILIAL='710000' THEN   NVL(RECEITA_BRUTA_TOTAL*NVL(A.CONVERSOR,0),4)
  ELSE RECEITA_BRUTA_TOTAL
  END RECEITA_BRUTA_TOTAL, 

    CASE 
  WHEN FILIAL='710000' AND TIPO='CARTEIRA' THEN   NVL(RECEITA_BRUTA_TOTAL*0.81*NVL(B.CONVERSOR,0),4)
  WHEN FILIAL='710000' THEN   NVL(RECEITA_BRUTA_TOTAL*0.81*NVL(A.CONVERSOR,0),4)
  ELSE RECEITA_NET_TOTAL
  END RECEITA_NET_TOTAL, 



  CUSTO_MATERIAL_TOTAL, 
  CUSTO_TOTAL_2 CUSTO_TOTAL_2, 

  BUSINESS_UNIT, 
  TECNOLOGIA, 
  UN_NEG, 
  FILIAL, 
  FILIAL2, 
  COD_TRANSP, 
  TRANSP, 
  TIPO_PEDIDO, 
  OBS_PED, 
  UM_PRINC, 
  ICMS_ENTRADA, 
  TRIB_SUBST, 
  DESC_REPASSE, 
  DESC_ZF, 
  FORN, 
  FORN_PRIMEIRO, 
  VALOR_IPI, 
--to_char(sysdate, 'DD/MM/YYYY HH24:MI')  LAST_UPDATE_DATE,
  INTERCOMPANY, 
  RESPONSAVEL_CELULA, 
  rESPONSAVEL_CELULA_2, 
  USER_VENDEDOR, 
  DATA_CUSTO, 
  CASE 
  WHEN BUSINESS_UNIT='BREU E DERIVADOS'  THEN  NVL(CUSTO_GERENCIAL,0)+NVL(CUSTO_SERV,0) +NVL(CUSTO_MATERIAL,0)
   WHEN BUSINESS_UNIT='POLIESTER' AND TECNOLOGIA ='ELEKO' THEN  NVL(CUSTO_GERENCIAL,0)+NVL(CUSTO_MATERIAL,0) 
     WHEN SEGMENTO IN ('981196','981746','987636','985877') THEN  NVL(CUSTO_GERENCIAL,0)+NVL(CUSTO_MATERIAL,0) 


  ELSE CUSTO_GERENCIAL END CUSTO_GERENCIAL,

  LISTA, 
  DESCRICAO_R, 
  EMB, 
  CUSTO_EMB, 
  UTEIS_DIA, 
  UTEIS_MES,
  to_number(COMPLEMENTO_RECEITA_BRUTA) COMPLEMENTO_RECEITA_BRUTA ,
TO_NUMBER(ROUND(COMPLEMENTO_RECEITA_BRUTA+RECEITA_BRUTA_TOTAL,2))  RECEITA_BRUTA_M_TOTAL ,
TO_NUMBER(ROUND(COMPLEMENTO_RECEITA_BRUTA+RECEITA_NET_TOTAL,2)) RECEITA_LIQUIDA_M_TOTAL,
CASE WHEN NVL(UTEIS_DIA,0)='0' THEN  0 when nvl(UTEIS_MES,0)='0' then 0             ELSE ROUND(TO_NUMBER(ROUND(COMPLEMENTO_RECEITA_BRUTA+RECEITA_BRUTA_TOTAL,2)) /UTEIS_DIA*UTEIS_MES,2) END PREVISAO_RECEITA_BRUTA,
TO_NUMBER(CASE WHEN NVL(UTEIS_DIA,0)='0' THEN  0 when nvl(UTEIS_MES,0)='0' then 0   ELSE ROUND((COMPLEMENTO_RECEITA_BRUTA+RECEITA_NET_TOTAL)/UTEIS_DIA*UTEIS_MES,2) END) PREVISAO_RECEITA_LIQUIDA,

TO_NUMBER(CASE WHEN NVL(UTEIS_DIA,0)='0' THEN  0 when nvl(UTEIS_MES,0)='0' then 0   



WHEN BUSINESS_UNIT='BREU E DERIVADOS'  THEN ROUND( ((COMPLEMENTO_RECEITA_BRUTA+RECEITA_NET_TOTAL)-(CUSTO_GERENCIAL*QTD+CUSTO_EMB*QTD+NVL(CUSTO_SERV,0)*QTD+NVL(CUSTO_MATERIAL,0)*QTD))/UTEIS_DIA*UTEIS_MES ,2)  
WHEN BUSINESS_UNIT='POLIESTER' AND  TECNOLOGIA ='ELEKO'  THEN ROUND( ((COMPLEMENTO_RECEITA_BRUTA+RECEITA_NET_TOTAL)-(CUSTO_GERENCIAL*QTD+CUSTO_EMB*QTD+NVL(CUSTO_MATERIAL,0) *QTD))/UTEIS_DIA*UTEIS_MES ,2)  

WHEN SEGMENTO  IN ('981196','981746','987636','985877') THEN ROUND( ((COMPLEMENTO_RECEITA_BRUTA+RECEITA_NET_TOTAL)-(CUSTO_GERENCIAL*QTD+CUSTO_EMB*QTD+NVL(CUSTO_MATERIAL,0)*QTD))/UTEIS_DIA*UTEIS_MES ,2)  


ELSE ROUND(   ((COMPLEMENTO_RECEITA_BRUTA+RECEITA_NET_TOTAL)-(CUSTO_GERENCIAL*QTD+CUSTO_EMB*QTD))/UTEIS_DIA*UTEIS_MES ,2) END)    PREVISAO_MARGEM,


INFORMACAO_FRETE,
CIDADE,
TO_NUMBER(PRAZO_MEDIO_PAG) PRAZO_MEDIO_PAG,
case when nvl(UTEIS_DIA,0)='0' then 0 when nvl(UTEIS_DIA,0)>0 then round((QTD/1000)/UTEIS_DIA,6) else 0 end  TON_DIA_UTIL,
PAIS
,GRUPO_ECO
,STATUS
,CASE WHEN NVL(UTEIS_DIA,0)='0' THEN  0 when nvl(UTEIS_MES,0)='0' then 0             ELSE ROUND(TO_NUMBER(  QTD ) /UTEIS_DIA*UTEIS_MES,2) END PREVISAO_QTD
,SEGMENTO
,CAT5
,VALOR_FRETE
,VALOR_SEGURO
FROM ULT_TEMP
LEFT JOIN CONVERSOR A ON MES_ANO=A.MES_ANO_C
LEFT JOIN CONVERSOR B ON TO_CHAR(to_date(sysdate), 'MM/YYYY')=B.MES_ANO_C;

