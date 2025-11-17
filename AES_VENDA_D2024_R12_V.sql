
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PUBDB"."AES_VENDA_D2024_R12_V" ("EMPRESA", "TIPO", "DATA_DO_BI", "DATA_INCLUSAO1", "PC_CLIENTE", "PEDIDO", "NOTA", "CODIGO_CLIENTE", "COND_PAG_PEDIDO", "CODIGO", "UM", "QTD", "PRECO_UNITARIO1", "PRECO_UNITARIO_NET", "ICMS_P", "PIS_COF_P", "IPI_P", "TIPO_FRETE", "MATERIAL", "PRECO_LISTA", "TOTAL_BRUTO", "TOTAL_LIQUIDO", "VALOR_ICMS_R") AS 
  select
    'AES TECH' AS EMPRESA,
    case
        when VENDA_DETALHE.SDDCTO IN ('S3', 'SF')
        AND VENDA_DETALHE.SDNXTR > '600'
        AND VENDA_DETALHE.SDLTTR != '980' THEN 'BONIFICAÇÃO/AMOSTRA'
        when VENDA_DETALHE.SDDCTO IN ('DO')
        AND VENDA_DETALHE.SDNXTR > '600'
        AND VENDA_DETALHE.SDLTTR != '980' THEN 'DEVOLUCAO'
        when NFe_STATUS.SLB76SACT = 'Y'
        AND VENDA_DETALHE.SDNXTR > '617'
        AND VENDA_DETALHE.SDLTTR != '980' THEN 'FATURADO'
        WHEN VENDA_DETALHE.SDNXTR < '596' THEN 'CARTEIRA'
        when VENDA_DETALHE.SDNXTR > '595'
        AND VENDA_DETALHE.SDNXTR < '618' THEN 'FATURANDO HOJE'
    END AS TIPO,
    TO_DATE (
        case
            when NFe_STATUS.SLB76SACT = 'Y'
            AND NFe_STATUS.SLB76NFST = 'A'
            AND NOTA_DETALHE.FDNXTR = '999'
            AND NOTA_DETALHE.FDPDCT IN (
        'VO',
        'V7',
        'V5',
        'DO',
        'SG',
        'SX',
        'S3',
        'SF',
        'VA',
        'SG',
        'SX',
        'VI',
        'VO',
        'VQ',
        'VZ',
        'V5',
        'V7',
        'V8',
        'VA',
        'VF',
        'VG',
        'VH'
    ) THEN TO_CHAR(
                TO_DATE((NFe_STATUS.SLB76EPRD + 1900000), 'YYYYDDD'),
                'DD/MM/YYYY'
            )
            when VENDA_DETALHE.SDDCTO IN ('DO')
            AND VENDA_DETALHE.SDNXTR = '999'
            AND VENDA_DETALHE.SDLTTR != '980' THEN TO_CHAR(
                TO_DATE((VENDA_DETALHE.SDPDDJ + 1900000), 'YYYYDDD'),
                'DD/MM/YYYY'
            )
            when TO_NUMBER(TO_CHAR(sysdate, 'YYYYDDD')) -1900000 > VENDA_DETALHE.SDPPDJ
            and TO_NUMBER(TO_CHAR(sysdate, 'YYYYDDD')) -1900000 > VENDA_DETALHE.SDPDDJ then to_char(sysdate, 'DD/MM/YYYY')
            WHEN VENDA_DETALHE.SDPPDJ > VENDA_DETALHE.SDPDDJ THEN TO_CHAR(
                TO_DATE((VENDA_DETALHE.SDPPDJ + 1900000), 'YYYYDDD'),
                'DD/MM/YYYY'
            )
            ELSE TO_CHAR(
                TO_DATE((VENDA_DETALHE.SDPDDJ + 1900000), 'YYYYDDD'),
                'DD/MM/YYYY'
            )
        END,
        'DD/MM/YYYY'
    ) AS DATA_DO_BI,
    TO_DATE((VENDA_DETALHE.SDTRDJ + 1900000), 'YYYYDDD') AS DATA_INCLUSAO1,
    VENDA_CABECALHO.SHVR01 AS PC_CLIENTE,
    CAST(VENDA_DETALHE.SDDOCO AS CHAR(99)) AS PEDIDO,
    CAST(
        CASE
            when NFe_STATUS.SLB76SACT = 'Y'
            AND NFe_STATUS.SLB76NFST = 'A'
            AND NOTA_DETALHE.FDNXTR = '999'
            AND NOTA_DETALHE.FDPDCT IN ('VO', 'V7', 'V5', 'SG', 'SX', 'S3', 'SF') THEN NFe_STATUS.SLB76LNUM
            when NOTA_DETALHE.FDPDCT IN ('DO')
            AND NOTA_DETALHE.FDNXTR = '999' THEN NFe_STATUS.SLB76LNUM
            ELSE 0
        END AS CHAR(10)
    ) AS NOTA,
    TRIM(VENDA_DETALHE.SDAN8) AS CODIGO_CLIENTE,
    TRIM(COND_PAGAMENTO.PNPTD) AS COND_PAG_PEDIDO,
    TRIM(VENDA_DETALHE.SDLITM) AS CODIGO,
    VENDA_DETALHE.SDUOM4 AS UM,
    CASE
        WHEN VENDA_DETALHE.SDDCTO = 'DO' THEN (VENDA_DETALHE.SDPQOR / 10000)
        ELSE VENDA_DETALHE.SDPQOR / 10000
    END QTD,
    CAST(VENDA_DETALHE.SDUPRC / 10000 AS DECIMAL(12, 3)) PRECO_UNITARIO1,
    /*PREÇO UNITARIO NET */
    CAST(
        (
            CASE
                WHEN ENDERECO.ALADDS = 'SP' THEN CAST(VENDA_DETALHE.SDUPRC / 10000 AS numeric) * ((1 -0.18) *(1 -0.0925))
                WHEN ENDERECO.ALADDS = 'EX' THEN (CAST(VENDA_DETALHE.SDUPRC / 10000 AS numeric)) * 1
                WHEN TAG_DETALHE.SJBORI IN ('1', '2', '3', '8') THEN (CAST(VENDA_DETALHE.SDUPRC / 10000 AS numeric)) * ((1 -0.04) * (1 -0.0925))
                WHEN ENDERECO.ALADDS IN ('RJ', 'MG', 'SC', 'RS', 'PR') THEN (CAST(VENDA_DETALHE.SDUPRC / 10000 AS numeric)) * ((1 -0.12) * (1 -0.0925))
                ELSE (CAST(VENDA_DETALHE.SDUPRC / 10000 as numeric)) * ((1 -0.07) * (1 -0.0925))
            END
        ) AS DECIMAL(12, 3)
    ) AS PRECO_UNITARIO_NET,
    /*IMPOSTOS % ICMS, PIS , CONFINS */
    /*ICMS */
    CASE
        WHEN ENDERECO.ALADDS IN ('EX') THEN 0
        when TAG_DETALHE.SJBCTF in ('03', '04') then 0
        WHEN ENDERECO.ALADDS IN ('SP')
        AND TAG_DETALHE.SJBCTF not in ('03', '04') THEN 0.18
        WHEN ENDERECO.ALADDS IN ('MG', 'PR', 'RS', 'SC', 'RJ')
        and TAG_DETALHE.SJBORI != '3'
        AND TAG_DETALHE.SJBCTF not in ('03', '04') THEN 0.12
        WHEN ENDERECO.ALADDS not IN ('EX', 'SP')
        and TAG_DETALHE.SJBORI = '3'
        AND TAG_DETALHE.SJBCTF not in ('03', '04') THEN 0.04
        WHEN ENDERECO.ALADDS IN (
            'SC',
            'BA',
            'CE',
            'MT',
            'SE',
            'RO',
            'RS',
            'PR',
            'MG',
            'MA',
            'AC',
            'RR',
            'ES',
            'AL',
            'MS',
            'DF',
            'RN',
            'PA',
            'AM',
            'AP',
            'RJ',
            'PI',
            'TO',
            'PB',
            'PE',
            'ME',
            'GO',
            'MG',
            'PR',
            'RS',
            'SC',
            'RJ'
        )
        and TAG_DETALHE.SJBORI != '3'
        AND TAG_DETALHE.SJBCTF not in ('03', '04') THEN 0.07
        else NOTA_DETALHE.FDTXR1 / 100000
    end ICMS_P,
    /*PIS CONF */
    CASE
        WHEN TAG_DETALHE.SJBCFC != 'ISE' THEN 0.0925
        WHEN TAG_DETALHE.SJBCFC = 'ISE' THEN 0
    END PIS_COF_P,
    /*IPI */
    CASE
        WHEN TAG_DETALHE.SJBCTF = '4' THEN 0
        ELSE (IPI_TAXAS.FCTXR1 / 100000)
    END IPI_P,
    TRIM(VENDA_CABECALHO.SHFRTH) AS TIPO_FRETE,

    /*
    CMV FORMULA 
     */
     CASE WHEN CMV.CUSTO IS NULL THEN CMV_ONLINE.IECSL/10000 else CMV.CUSTO end AS MATERIAL,



    PRECO_FULL.CUSTO AS PRECO_LISTA,
    /*CALCULO DO TOTAL BRUTO POR LINHA */
    (
        CASE
            WHEN VENDA_DETALHE.SDDCTO = 'DO' THEN (VENDA_DETALHE.SDPQOR / 10000)
            ELSE VENDA_DETALHE.SDPQOR / 10000
        END
    ) * CAST(VENDA_DETALHE.SDUPRC / 10000 AS DECIMAL(12, 3)) AS TOTAL_BRUTO,
    /*CALCULO DO TOTAL LIQUIDO POR LINHA */
    (
        CASE
            WHEN VENDA_DETALHE.SDDCTO = 'DO' THEN (VENDA_DETALHE.SDPQOR / 10000)
            ELSE VENDA_DETALHE.SDPQOR / 10000
        END
    ) * CAST(
        (
            CASE
                WHEN ENDERECO.ALADDS = 'SP' THEN CAST(VENDA_DETALHE.SDUPRC / 10000 AS numeric) * ((1 -0.18) *(1 -0.0925))
                WHEN ENDERECO.ALADDS = 'EX' THEN (CAST(VENDA_DETALHE.SDUPRC / 10000 AS numeric)) * 1
                WHEN TAG_DETALHE.SJBORI IN ('1', '2', '3', '8') THEN (CAST(VENDA_DETALHE.SDUPRC / 10000 AS numeric)) * ((1 -0.04) * (1 -0.0925))
                WHEN ENDERECO.ALADDS IN ('RJ', 'MG', 'SC', 'RS', 'PR') THEN (CAST(VENDA_DETALHE.SDUPRC / 10000 AS numeric)) * ((1 -0.12) * (1 -0.0925))
                ELSE (CAST(VENDA_DETALHE.SDUPRC / 10000 as numeric)) * ((1 -0.07) * (1 -0.0925))
            END
        ) AS DECIMAL(12, 3)
    ) AS TOTAL_LIQUIDO,
    /*INICIO DO CALCULO EM VALOR ICMS */
    CAST(
        REPLACE(
            CASE
                WHEN ENDERECO.ALADDS IN ('EX') THEN 0
                when TAG_DETALHE.SJBCTF in ('03', '04') then 0
                WHEN ENDERECO.ALADDS IN ('SP')
                AND TAG_DETALHE.SJBCTF not in ('03', '04') THEN 0.18
                WHEN ENDERECO.ALADDS IN ('MG', 'PR', 'RS', 'SC', 'RJ')
                and TAG_DETALHE.SJBORI != '3'
                AND TAG_DETALHE.SJBCTF not in ('03', '04') THEN 0.12
                WHEN ENDERECO.ALADDS not IN ('EX', 'SP')
                and TAG_DETALHE.SJBORI = '3'
                AND TAG_DETALHE.SJBCTF not in ('03', '04') THEN 0.04
                WHEN ENDERECO.ALADDS IN (
                    'SC',
                    'BA',
                    'CE',
                    'MT',
                    'SE',
                    'RO',
                    'RS',
                    'PR',
                    'MG',
                    'MA',
                    'AC',
                    'RR',
                    'ES',
                    'AL',
                    'MS',
                    'DF',
                    'RN',
                    'PA',
                    'AM',
                    'AP',
                    'RJ',
                    'PI',
                    'TO',
                    'PB',
                    'PE',
                    'ME',
                    'GO',
                    'MG',
                    'PR',
                    'RS',
                    'SC',
                    'RJ'
                )
                and TAG_DETALHE.SJBORI != '3'
                AND TAG_DETALHE.SJBCTF not in ('03', '04') THEN 0.07
                else NOTA_DETALHE.FDTXR1 / 100000
            end,
            ',',
            '.'
        ) AS FLOAT
    ) * 1 AS VALOR_ICMS_R 
    /*INICIO DO FROM*/
from
    PRODDTA.f4211 VENDA_DETALHE
    /*     CABEÇALHO DE VENDA*/
    LEFT JOIN PRODDTA.F4201 VENDA_CABECALHO on VENDA_CABECALHO.SHCO = VENDA_DETALHE.SDCO
    AND VENDA_CABECALHO.SHDOCO = VENDA_DETALHE.SDDOCO
    and VENDA_CABECALHO.SHDCTO = VENDA_DETALHE.SDDCTO
    /*DETALHE DE PREÇO ATUAL*/
    LEFT JOIN PRODDTA.F30026 CMV_ONLINE ON CMV_ONLINE.IELITM = VENDA_DETALHE.SDLITM
    AND TRIM(CMV_ONLINE.IEMMCU) = '511000'
    AND CMV_ONLINE.IELEDG = '07'
    AND CMV_ONLINE.IECOST = 'A1'
    /*DETALHE DE NOTA*/
    LEFT JOIN PRODDTA.F7611B NOTA_DETALHE ON NOTA_DETALHE.FDDOCO = VENDA_DETALHE.SDDOCO
    AND NOTA_DETALHE.FDCO = VENDA_DETALHE.SDCO
    AND NOTA_DETALHE.FDLNID = VENDA_DETALHE.SDLNID
    AND NOTA_DETALHE.FDPDCT = VENDA_DETALHE.SDDCTO
    AND NOTA_DETALHE.FDNXTR NOT IN ('996', '998')
    /*DETALHE DE STATUS NFE*/
    LEFT JOIN PRODDTA.F76B12TE NFe_STATUS ON NFe_STATUS.SLBNNF = NOTA_DETALHE.FDBNNF
    AND NFe_STATUS.SLFCO = NOTA_DETALHE.FDfCO
    AND NOTA_DETALHE.FDN001 = NFe_STATUS.SLN001
    AND NFe_STATUS.SLB76SACT = 'Y'
    /*DETALHE DE CONDICAO DE PAGAMENTO */
    LEFT JOIN PRODDTA.F0014 COND_PAGAMENTO ON TRIM(COND_PAGAMENTO.PNPTC) = trim(VENDA_DETALHE.SDPTC)
    /*DETALHE DE TAG DETALHE */
    LEFT JOIN PRODDTA.F76422 TAG_DETALHE ON SJDOCO = VENDA_DETALHE.SDDOCO
    AND TAG_DETALHE.SJDCTO = VENDA_DETALHE.SDDCTO
    AND TAG_DETALHE.SJKCOO = VENDA_DETALHE.SDCO
    AND TAG_DETALHE.SJLNID = VENDA_DETALHE.SDLNID
    /*DETALHE CLIENTE */
    LEFT JOIN PRODDTA.F0101 CLIENTE ON CLIENTE.ABAN8 = VENDA_DETALHE.SDAN8
    /*DETALHE ENDEREÇO */
    LEFT JOIN PRODDTA.F0116 ENDERECO ON ENDERECO.ALAN8 = CLIENTE.ABAN8
    /*DETALHE CLIENTE */
    LEFT JOIN PRODDTA.F76B18 IPI_TAXAS ON TAG_DETALHE.SJBCLF = IPI_TAXAS.FCBCLF
    /*INICIO DO LEFT JOIN PARA CLASSIFICAÇÃO GERENCIAL*/
    LEFT JOIN (
        SELECT
            DISTINCT ROW_NUMBER() OVER(
                PARTITION BY AIAN8
                ORDER BY
                    AIAN8
            ) AS RN,
            AIAN8,
            AIARC,
            AIMCUR,
            AIOBAR,
            AIAIDR,
            AIKCOR,
            AIDCAR,
            AIDTAR,
            AICRCD,
            AITXA1,
            AIEXR1,
            AIACL,
            AIHDAR,
            AITRAR,
            AISTTO,
            AIRYIN,
            AISTMT,
            AIARPY,
            AIATCS,
            AISITO,
            AISQNL,
            AIALGM,
            AICYCN,
            AIBO,
            AITSTA,
            AICKHC,
            AIDLC,
            AIDNLT,
            AIPLCR,
            AIRVDJ,
            AIDSO,
            AICMGR,
            AICLMG,
            AIDLQT,
            AIDLQJ,
            AINBRR,
            AICOLL,
            AINBR1,
            AINBR2,
            AINBR3,
            AINBCL,
            AIAFC,
            AIFD,
            AIFP,
            AICFCE,
            AIAB2,
            AIDT1J,
            AIDFIJ,
            AIDLIJ,
            AIABC1,
            AIABC2,
            AIABC3,
            AIFNDJ,
            AIDLP,
            AIDB,
            AIDNBJ,
            AITRW,
            AITWDJ,
            AIAVD,
            AICRCA,
            AIAD,
            AIAFCP,
            AIAFCY,
            AIASTY,
            AISPYE,
            AIAHB,
            AIALP,
            AIABAM,
            AIABA1,
            AIAPRC,
            AIMAXO,
            AIMINO,
            AIOYTD,
            AIOPY,
            AIPOPN,
            AIDAOJ,
            AIAN8R,
            AIBADT,
            AICPGP,
            AIORTP,
            AITRDC,
            AIINMG,
            AIEXHD,
            AIHOLD,
            AIROUT,
            AISTOP,
            AIZON,
            AICARS,
            AIDEL1,
            AIDEL2,
            AILTDT,
            AIFRTH,
            AIAFT,
            AIAPTS,
            AISBAL,
            AIBACK,
            AIPORQ,
            AIPRIO,
            AIARTO,
            AIINVC,
            AIICON,
            AIBLFR,
            AINIVD,
            AILEDJ,
            AIPLST,
            AIMORD,
            AICMC1,
            AICMR1,
            AICMC2,
            AICMR2,
            AIPALC,
            AIVUMD,
            AIWUMD,
            AIEDPM,
            AIEDII,
            AIEDCI,
            AIEDQD,
            AIEDAD,
            AIEDF1,
            AIEDF2,
            AISI01,
            AISI02,
            AISI03,
            AISI04,
            AISI05,
            AIURCD,
            AIURAT,
            AIURAB,
            AIURDT,
            AIURRF,
            AICP01,
            AIASN,
            AIDSPA,
            AICRMD,
            AIPLY,
            AIMAN8,
            AIARL,
            AIAMCR,
            AIAC01,
            AIAC02,
            AIAC03,
            AIAC04,
            AIAC05,
            AIAC06,
            AIAC07,
            AIAC08,
            AIAC09,
            AIAC10,
            AIAC11,
            AIAC12,
            AIAC13,
            AIAC14,
            AIAC15,
            AIAC16,
            AIAC17,
            AIAC18,
            AIAC19,
            AIAC20,
            AIAC21,
            AIAC22,
            AIAC23,
            AIAC24,
            AIAC25,
            AIAC26,
            AIAC27,
            AIAC28,
            AIAC29,
            AIAC30,
            AISLPG,
            AISLDW,
            AICFPP,
            AICFSP,
            AICFDF,
            AIRQ01,
            AIRQ02,
            AIDR03,
            AIDR04,
            AIRQ03,
            AIRQ04,
            AIRQ05,
            AIRQ06,
            AIRQ07,
            AIRQ08,
            AIDR08,
            AIDR09,
            AIRQ09,
            AIUSER,
            AIPID,
            AIUPMJ,
            AIUPMT,
            AIJOBN,
            AIPRGF,
            AIBYAL,
            AIBSC,
            AIASHL,
            AIPRSN,
            AIOPBO,
            AIAPSB,
            AITIER1,
            AIPWPCP,
            AICUSTS,
            AISTOF,
            AITERRID,
            AICIG,
            AITORG,
            AIDTEE,
            AISYNCS,
            AICAAD,
            AIGOPASF
        FROM
            PRODDTA.F03012
    )
    /*FINAL DO LEFT JOIN PARA AMARRACLASSIFICAÇÃO GERENCIAL*/
    /*AMARRAÇÃO DO LEFT CONTANDO LINHA E AMARRANDO COM CLIENTE */
    CLASSIFICACAO_GERENCIAL ON TRIM(TO_CHAR(VENDA_CABECALHO.SHAN8)) = TRIM(TO_CHAR(CLASSIFICACAO_GERENCIAL.AIAN8))
    AND CLASSIFICACAO_GERENCIAL.RN = 1
    /*LEFT JOIN PARA PEGAR O TIPO DE TABELA DE PREÇO PARA DEPOIS PEGAR O PREÇO FULL */
    LEFT JOIN PRODCTL.F0005 MERCADO ON TRIM(TO_CHAR(CLASSIFICACAO_GERENCIAL.AIAC24)) = TRIM(MERCADO.DRKY)
    AND TRIM(MERCADO.DRSY) = '01'
    AND TRIM(MERCADO.DRRT) = '24'
    /*INICIO (LEFT) DA CONSULTA TABELA DO CUSTO DE MATERIAL*/
    LEFT JOIN (
        SELECT
            TRIM(GERAL.BPLITM) AS CODIGO,
            CAST(NVL(GERAL.BPUPRC, 0) / 10000 AS FLOAT) AS CUSTO,
            GERAL.BPCRCD AS MOEDA,
            TABELA.CKCPGP AS TABELA,
            CASE
                WHEN GERAL.BPEFTJ > 140001 THEN SYSDATE
                ELSE TO_DATE(GERAL.BPEFTJ + 1900000, 'YYYYDDD')
            END AS INICIO,
            CASE
                WHEN GERAL.BPEXDJ > 140001 THEN SYSDATE
                WHEN GERAL.BPEXDJ = MAX_DATA.FIM_MAX THEN TO_DATE(140001 + 1900000, 'YYYYDDD')
                ELSE TO_DATE(GERAL.BPEXDJ + 1900000, 'YYYYDDD')
            END AS FIM
        FROM
            PRODDTA.F4106 GERAL
            left JOIN PRODDTA.F40942 TABELA ON GERAL.BPCGID = TABELA.CKCGID
            left join (
                SELECT
                    TRIM(GERAL.BPLITM) AS CODIGO,
                    MAX(GERAL.BPEXDJ) AS FIM_MAX,
                    GERAL.BPCGID AS TIPO
                FROM
                    PRODDTA.F4106 GERAL
                WHERE
                    TRIM(GERAL.BPMCU) = '511000'
                GROUP BY
                    GERAL.BPCGID,
                    GERAL.BPLITM
            ) MAX_DATA ON MAX_DATA.CODIGO = TRIM(GERAL.BPLITM)
            AND MAX_DATA.TIPO = GERAL.BPCGID
        WHERE
            TRIM(GERAL.BPMCU) = '511000'
            AND TABELA.CKCPGP = 'T99_AES'
            AND GERAL.BPEXDJ <> 144001
    )
    /*FINAL DO (LEFT) DA CONSULTA TABELA DO CUSTO DE MATERIAL*/
    /*AMARRAÇÃO DO (LEFT) DA CONSULTA TABELA DO CUSTO DE MATERIAL*/
    CMV ON TRIM(CMV.CODIGO) = TRIM(VENDA_DETALHE.SDLITM)
    and TO_DATE((VENDA_DETALHE.SDTRDJ + 1900000), 'YYYYDDD') >= CMV.INICIO
    AND TO_DATE((VENDA_DETALHE.SDTRDJ + 1900000), 'YYYYDDD') <= CMV.FIM
    /*INICIO (LEFT) DA CONSULTA TABELA DO PRECO FULL*/
    LEFT JOIN (
        SELECT
            TRIM(GERAL.BPLITM) AS CODIGO,
            CAST(NVL(GERAL.BPUPRC, 0) / 10000 AS FLOAT) AS CUSTO,
            GERAL.BPCRCD AS MOEDA,
            TABELA.CKCPGP AS TABELA,
            CASE
                WHEN GERAL.BPEFTJ > 140001 THEN SYSDATE
                ELSE TO_DATE(GERAL.BPEFTJ + 1900000, 'YYYYDDD')
            END AS INICIO,
            CASE
                WHEN GERAL.BPEXDJ > 140001 THEN SYSDATE
                WHEN GERAL.BPEXDJ = MAX_DATA.FIM_MAX THEN TO_DATE(140001 + 1900000, 'YYYYDDD')
                ELSE TO_DATE(GERAL.BPEXDJ + 1900000, 'YYYYDDD')
            END AS FIM
        FROM
            PRODDTA.F4106 GERAL
            left JOIN PRODDTA.F40942 TABELA ON GERAL.BPCGID = TABELA.CKCGID
            left join (
                SELECT
                    TRIM(GERAL.BPLITM) AS CODIGO,
                    MAX(GERAL.BPEXDJ) AS FIM_MAX,
                    GERAL.BPCGID AS TIPO
                FROM
                    PRODDTA.F4106 GERAL
                WHERE
                    TRIM(GERAL.BPMCU) = '511000'
                GROUP BY
                    GERAL.BPCGID,
                    GERAL.BPLITM
            ) MAX_DATA ON MAX_DATA.CODIGO = TRIM(GERAL.BPLITM)
            AND MAX_DATA.TIPO = GERAL.BPCGID
        WHERE
            TRIM(GERAL.BPMCU) = '511000'
            AND TABELA.CKCPGP <> 'T99_AES'
            AND GERAL.BPEXDJ <> 144001
    )
    /*FINAL DO (LEFT) DA CONSULTA TABELA DO PRECO FULL*/
    /*AMARRAÇÃO DO (LEFT) DA CONSULTA TABELA DO PRECO FULL*/
    PRECO_FULL ON TRIM(PRECO_FULL.CODIGO) = TRIM(VENDA_DETALHE.SDLITM)
    and TO_DATE((VENDA_DETALHE.SDTRDJ + 1900000), 'YYYYDDD') >= PRECO_FULL.INICIO
    AND TO_DATE((VENDA_DETALHE.SDTRDJ + 1900000), 'YYYYDDD') <= PRECO_FULL.FIM
    AND MERCADO.DRSPHD = PRECO_FULL.TABELA
WHERE
    VENDA_DETALHE.SDCO = '51000'
    AND VENDA_DETALHE.SDLTTR != '980'
    AND SUBSTR(VENDA_DETALHE.SDLNTY, 1, 1) != 'B'
    AND VENDA_DETALHE.SDDCTO IN (
        'VO',
        'V7',
        'V5',
        'DO',
        'SG',
        'SX',
        'S3',
        'SF',
        'VA',
        'SG',
        'SX',
        'VI',
        'VO',
        'VQ',
        'VZ',
        'V5',
        'V7',
        'V8',
        'VA',
        'VF',
        'VG',
        'VH'
    )
    AND TRIM(VENDA_DETALHE.SDDCTO) || VENDA_DETALHE.SDNXTR NOT IN (
        'DO540',
        'DO560',
        'DO595',
        'DO595',
        'DO596',
        'DO597',
        'DO617',
        'DO620',
        'DO520'
    )
    AND VENDA_DETALHE.SDLTTR != '980'
    AND VENDA_DETALHE.SDAN8 != '51000'
    AND VENDA_DETALHE.SDAEXP != '0'
    AND VENDA_DETALHE.SDTRDJ + 1900000 >= 2024001


   /* AND VENDA_DETALHE.SDDOCO='1354063'*/;

