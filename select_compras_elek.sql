select
O.num_pedido AS PEDIDO,
CASE  
    WHEN PC.emergencial = 'True' THEN 'Emergencial'
    WHEN PC.emergencial = 'False' THEN 'Normal'
    ELSE PC.emergencial
END AS EMERGENCIAL,  
O.cod_estabel AS COD_ESTABELECIMENTO,
O.numero_ordem AS ORDEM,
P.parcela AS PARCELA,
P.it_codigo AS COD_ITEM,
I.desc_item AS DESC_ITEM,
F.descricao AS FAMILIA_COMECIAL,
P.UN AS UNIDADE,
P.quantidade AS QTD_ITEM,
O.preco_unit AS VALOR_UNITARIO,
O.qt_acum_nec * C.preco_unit AS VALOR_TOTAL,
U.nome_usuar AS COMPRADOR,
PC.data_pedido AS DATA_PEDIDO,
P.nr_contrato AS CONTRATO,
CF.dec_2 AS Valor,
CF.dt_ini_validade AS INICIO_VALIDADE,
CF.dt_ter_validade AS FIM_VALIDADE,
CASE CF.ind_sit_contrat 
    WHEN 1 THEN 'Nao'
    WHEN 1 THEN 'Emitido'
    WHEN 1 THEN 'Cancelado'
    Else 'SEM SITUACAO'
END AS SITUACAO,
O.dat_ordem AS DATA_ORDEM,
O.nr_requisicao AS SOLICITACAO,
O.data_emissao AS EMISSAO_ORDEM,
O.situacao AS COD_SITUACAO_ORDEM,
CASE O.situacao
    When '1' then 'Nao Confimada'
    When '2' then 'Confirmada'
    When '3' then 'Cotada'
    When '4' then 'Eliminada'
    When '5' then 'Em Contacao'
    Else 'Recebida'
END AS SITUACAO_ORDEM,
P.data_entrega AS DATA_ENTREGA,
O.requisitante AS SOLICITANTE,
PC.situacao AS SITUACAO_PEDIDO,
PC.natureza AS NATUREZA,
PC.cod_emitente AS FORNECEDOR,
PC.COD_USUAR_CRIAC AS CRIADOR,
PC.responsavel AS RESPONSAVEL,
PC.c_cod_tabela AS TABELA_PRECO,
PC.COD_EMIT_TERC AS EMIT_ENTREGA,
O.cod_unid_negoc AS UNEG,
I.narrativa AS NARRATIVA_ITEM,
O.narrativa AS NARRATIVA_ORDEM,
O.data_emissao AS DT_EMISSAO,
P.quantidade * O.preco_unit  AS PRECO_MERCADORIA,
((O.preco_unit*O.aliquota_ipi)+O.preco_unit)*P.quantidade  AS PRECO_TOTAL
from stgdb.STG_ELEK_mgmov_prazo_compra P
LEFT JOIN stgdb.STG_ELEK_mgmov_ordem_compra O ON O.numero_ordem = P.numero_ordem
LEFT JOIN stgdb.STG_ELEK_mgmov_cotacao_item C ON O.numero_ordem = C.numero_ordem AND  O.cod_emitente = C.cod_emitente AND O.it_codigo = O.it_codigo
LEFT JOIN stgdb.stg_elek_mgcad_item I ON P.it_codigo = I.it_codigo
LEFT JOIN stgdb.stg_elek_mgcad_familia F ON F.fm_codigo = I.fm_codigo
LEFT JOIN stgdb.stg_elek_mgcad_mla_usuar_aprov U ON U.cod_usuar = O.cod_comprado
LEFT JOIN stgdb.stg_elek_mgmov_pedido_compr PC ON PC.num_pedido = O.num_pedido
LEFT JOIN stgdb.stg_elek_mgcad_contrato_for CF ON CF.nr_contrato = P.nr_contrato
LEFT JOIN stgdb.STG_ELEK_MGCAD_EMITENTE E ON E.cod_emitente = PC.COD_EMIT_TERC;
es-me-pedido-compr 


HIERARQUIA para dados