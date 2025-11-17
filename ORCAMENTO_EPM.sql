
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PUBDB"."ORCAMENTO_EPM" ("ANO", "COD_CENTRO_CUST", "CENTRO_CUST", "CONTA_CONT", "LIVRO", "MES", "VALOR", "CONTA", "CIA", "GMMCU", "GMOBJ", "GMSUB", "CONTA_CONTABIL") AS 
  Select "ANO","COD_CENTRO_CUST","CENTRO_CUST","CONTA_CONT","LIVRO","MES",VALOR/100 VALOR,"CONTA",CIA,"GMMCU","GMOBJ","GMSUB",TRIM(GMOBJ)||TRIM(GMSUB) CONTA_CONTABIL from  (
    select 
        '20'||B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'01' MES, GBAN01 VALOR
        ,TRIM(GMMCU)||'.'||TRIM(GMOBJ)||'.'||TRIM(GMSUB) CONTA
        ,B.GBCO CIA
        ,TRIm(G.GMMCU) GMMCU
        ,TRIM(G.GMOBJ) GMOBJ
        ,TRIM(G.GMSUB) GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'


    union all
    select 
              '20'||B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'2' MES, GBAN02 VALOR
        ,TRIM(GMMCU)||'.'||TRIM(GMOBJ)||'.'||TRIM(GMSUB) CONTA
        ,B.GBCO CIA
        ,TRIm(G.GMMCU) GMMCU
        ,TRIM(G.GMOBJ) GMOBJ
        ,TRIM(G.GMSUB) GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
               '20'||B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'03' MES, GBAN03 VALOR
        ,TRIM(GMMCU)||'.'||TRIM(GMOBJ)||'.'||TRIM(GMSUB) CONTA
        ,B.GBCO CIA
        ,TRIm(G.GMMCU) GMMCU
        ,TRIM(G.GMOBJ) GMOBJ
        ,TRIM(G.GMSUB) GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
              '20'||B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'04' MES, GBAN04 VALOR
        ,TRIM(GMMCU)||'.'||TRIM(GMOBJ)||'.'||TRIM(GMSUB) CONTA
        ,B.GBCO CIA
        ,TRIm(G.GMMCU) GMMCU
        ,TRIM(G.GMOBJ) GMOBJ
        ,TRIM(G.GMSUB) GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
              '20'||B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'05' MES, GBAN05 VALOR
        ,TRIM(GMMCU)||'.'||TRIM(GMOBJ)||'.'||TRIM(GMSUB) CONTA
        ,B.GBCO CIA
        ,TRIm(G.GMMCU) GMMCU
        ,TRIM(G.GMOBJ) GMOBJ
        ,TRIM(G.GMSUB) GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
            '20'||B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'06' MES, GBAN06 VALOR
        ,TRIM(GMMCU)||'.'||TRIM(GMOBJ)||'.'||TRIM(GMSUB) CONTA
        ,B.GBCO CIA
        ,TRIm(G.GMMCU) GMMCU
        ,TRIM(G.GMOBJ) GMOBJ
        ,TRIM(G.GMSUB) GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
             '20'||B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'07' MES, GBAN07 VALOR
        ,TRIM(GMMCU)||'.'||TRIM(GMOBJ)||'.'||TRIM(GMSUB) CONTA
        ,B.GBCO CIA
        ,TRIm(G.GMMCU) GMMCU
        ,TRIM(G.GMOBJ) GMOBJ
        ,TRIM(G.GMSUB) GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
               '20'||B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'08' MES, GBAN08 VALOR
        ,TRIM(GMMCU)||'.'||TRIM(GMOBJ)||'.'||TRIM(GMSUB) CONTA
        ,B.GBCO CIA
        ,TRIm(G.GMMCU) GMMCU
        ,TRIM(G.GMOBJ) GMOBJ
        ,TRIM(G.GMSUB) GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
               '20'||B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'09' MES, GBAN09 VALOR
        ,TRIM(GMMCU)||'.'||TRIM(GMOBJ)||'.'||TRIM(GMSUB) CONTA
        ,B.GBCO CIA
        ,TRIm(G.GMMCU) GMMCU
        ,TRIM(G.GMOBJ) GMOBJ
        ,TRIM(G.GMSUB) GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
             '20'||B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'10' MES, GBAN10 VALOR
        ,TRIM(GMMCU)||'.'||TRIM(GMOBJ)||'.'||TRIM(GMSUB) CONTA
        ,B.GBCO CIA
        ,TRIm(G.GMMCU) GMMCU
        ,TRIM(G.GMOBJ) GMOBJ
        ,TRIM(G.GMSUB) GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
          '20'||B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'11' MES, GBAN11 VALOR
        ,TRIM(GMMCU)||'.'||TRIM(GMOBJ)||'.'||TRIM(GMSUB) CONTA
        ,B.GBCO CIA
        ,TRIm(G.GMMCU) GMMCU
        ,TRIM(G.GMOBJ) GMOBJ
        ,TRIM(G.GMSUB) GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
               '20'||B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'12' MES, GBAN12 VALOR
        ,TRIM(GMMCU)||'.'||TRIM(GMOBJ)||'.'||TRIM(GMSUB) CONTA
        ,B.GBCO CIA
        ,TRIm(G.GMMCU) GMMCU
        ,TRIM(G.GMOBJ) GMOBJ
        ,TRIM(G.GMSUB) GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    ) ORACADO;

