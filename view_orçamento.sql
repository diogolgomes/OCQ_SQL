  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PUBDB"."JDE_ORCAMENTO" ("ANO", "COD_CENTRO_CUST", "CENTRO_CUST", "CONTA_CONT", "LIVRO", "MES", "VALOR", "CONTA", "GMMCU", "GMOBJ", "GMSUB") AS 
  Select "ANO","COD_CENTRO_CUST","CENTRO_CUST","CONTA_CONT","LIVRO","MES","VALOR","CONTA","GMMCU","GMOBJ","GMSUB" from  (
    select 
        B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'1' MES, GBAN01 VALOR
        ,GMMCU||'.'||GMOBJ||'.'||GMSUB CONTA
        ,G.GMMCU
        ,G.GMOBJ
        ,G.GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
        B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'2' MES, GBAN02 VALOR
        ,GMMCU||'.'||GMOBJ||'.'||GMSUB CONTA
        ,G.GMMCU
        ,G.GMOBJ
        ,G.GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
        B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'3' MES, GBAN03 VALOR
        ,GMMCU||'.'||GMOBJ||'.'||GMSUB CONTA
        ,G.GMMCU
        ,G.GMOBJ
        ,G.GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
        B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'4' MES, GBAN04 VALOR
        ,GMMCU||'.'||GMOBJ||'.'||GMSUB CONTA
        ,G.GMMCU
        ,G.GMOBJ
        ,G.GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
        B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'5' MES, GBAN05 VALOR
        ,GMMCU||'.'||GMOBJ||'.'||GMSUB CONTA
        ,G.GMMCU
        ,G.GMOBJ
        ,G.GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
        B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'6' MES, GBAN06 VALOR
        ,GMMCU||'.'||GMOBJ||'.'||GMSUB CONTA
        ,G.GMMCU
        ,G.GMOBJ
        ,G.GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
        B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'7' MES, GBAN07 VALOR
        ,GMMCU||'.'||GMOBJ||'.'||GMSUB CONTA
        ,G.GMMCU
        ,G.GMOBJ
        ,G.GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
        B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'8' MES, GBAN08 VALOR
        ,GMMCU||'.'||GMOBJ||'.'||GMSUB CONTA
        ,G.GMMCU
        ,G.GMOBJ
        ,G.GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
        B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'9' MES, GBAN09 VALOR
        ,GMMCU||'.'||GMOBJ||'.'||GMSUB CONTA
        ,G.GMMCU
        ,G.GMOBJ
        ,G.GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
        B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'10' MES, GBAN10 VALOR
        ,GMMCU||'.'||GMOBJ||'.'||GMSUB CONTA
        ,G.GMMCU
        ,G.GMOBJ
        ,G.GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
        B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'11' MES, GBAN11 VALOR
        ,GMMCU||'.'||GMOBJ||'.'||GMSUB CONTA
        ,G.GMMCU
        ,G.GMOBJ
        ,G.GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    union all
    select 
        B.GBFY AS ANO
        ,TRIM(F.MCMCU) COD_CENTRO_CUST
        ,F.MCDL01 CENTRO_CUST
        ,G.GMDL01 CONTA_CONT
        ,B.gblt AS LIVRO
        ,'12' MES, GBAN12 VALOR
        ,GMMCU||'.'||GMOBJ||'.'||GMSUB CONTA
        ,G.GMMCU
        ,G.GMOBJ
        ,G.GMSUB
    from proddta.F0902 B
    LEFT JOIN proddta.F0006 F ON B.GBMCU = F.MCMCU
    LEFT JOIN proddta.F0901 G ON B.GBMCU = G.GMMCU AND B.GBOBJ = G.GMOBJ AND B.GBSUB = G.GMSUB
        WHERE gblt = 'BA'
        AND B.GBFY > '21'
    ) ORACADO;
    

COMMIT;

