SELECT
    MC.nr_contrato AS N_CONTRATO,
    IC.COD_EMITENTE,
    E.nome_abrev,
    E.nome_emit,
    MC.num_seq_item,
    IC.it_codigo,
    I.desc_item,
    MC.numero_ordem,
    O.num_pedido,
    MC.num_seq_medicao,
    MC.dat_prev_medicao,
    MC.val_medicao,
    UM.nome_usuar,
    CF.dec_2,
    CF.dt_ini_validade,
    CF.dt_ter_validade,
    CF.ind_sit_contrat
FROM STGDB.STG_ELEK_MGMOV_MEDICAO_CONTRAT MC
LEFT JOIN STGDB.stg_elek_mgcad_item_contrat IC ON IC.nr_contrato = mc.nr_contrato and IC.num_seq_item = MC.num_seq_item
LEFT JOIN STGDB.STG_ELEK_mgmov_ordem_compra O ON O.numero_ordem = MC.numero_ordem
LEFT JOIN STGDB.STG_ELEK_MGCAD_EMITENTE E ON IC.COD_EMITENTE = E.COD_EMITENTE
LEFT JOIN STGDB.STG_ELEK_MGCAD_ITEM I ON IC.IT_CODIGO = I.IT_CODIGO
LEFT JOIN STGDB.STG_ELEK_MGCAD_USUAR_MASTER UM ON UM.COD_USUARIO = MC.responsavel
LEFT JOIN stgdb.stg_elek_mgcad_contrato_for CF ON CF.nr_contrato = MC.nr_contrato;