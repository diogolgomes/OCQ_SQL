--View retorna classe e revenda com codigo da classe/revenda
SELECT distinct
    TRIM(A.CISRP1) AS COD_CLASS,
    TRIM(A.CISRP2) AS COD_SUBCLASS,
    to_char(trim(srp1.DRDL01)) AS CLASSE,
    CASE WHEN srp1.DRDL01 = 'REVENDA' THEN to_char(TRIM(srp2.DRDL01))
    END AS SUBCLASSE
FROM 
    proddta.F5549402 A
left JOIN 
    PRODCTL.F0005 srp1 
    ON srp1.DRSY = '41' 
    AND srp1.DRRT = 'S1' 
    AND TRIM(A.CISRP1) = TRIM(srp1.DRKY)
left JOIN 
    PRODCTL.F0005 srp2 
    ON srp2.DRSY = '41' 
    AND srp2.DRRT = 'S2' 
    AND TRIM(A.CISRP2) = TRIM(srp2.DRKY)
where srp1.DRDL01 is not null
group by A.CIMCU, srp1.DRDL01,srp2.DRDL01,TRIM(A.CISRP1),TRIM(A.CISRP2);