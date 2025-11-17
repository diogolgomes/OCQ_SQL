select 
P.parcela,
P.numero_ordem,
O.num_pedido,
O.cod_estabel,
C.preco_unit,
I.desc_item,
F.descricao,
U.nome_usuar,
PC.emergencial,
PC.data_pedido,
CF.nr_contrato,
P.nr_contrato,
CF.dec_2,
CF.dt_ini_validade,
CF.dt_ter_validade,
CF.ind_sit_contrat
from stgdb.STG_ELEK_mgmov_prazo_compra P
Inner JOIN stgdb.STG_ELEK_mgmov_ordem_compra O ON O.numero_ordem = P.numero_ordem
Inner JOIN stgdb.stg_elek_mgmov_pedido_compr PC ON PC.num_pedido = O.num_pedido
Inner JOIN stgdb.STG_ELEK_mgmov_cotacao_item C ON O.numero_ordem = C.numero_ordem AND  O.cod_emitente = C.cod_emitente AND O.it_codigo = O.it_codigo
Inner JOIN stgdb.stg_elek_mgcad_item I ON P.it_codigo = I.it_codigo
Inner JOIN stgdb.stg_elek_mgcad_familia F ON F.fm_codigo = I.fm_codigo
Inner JOIN stgdb.stg_elek_mgcad_mla_usuar_aprov U ON U.cod_usuar = O.cod_comprado
LEFT JOIN stgdb.stg_elek_mgcad_contrato_for CF ON CF.nr_contrato = P.nr_contrato
--WHERE P.nr_contrato <> 0
;