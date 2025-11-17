# Documentação Detalhada: Tabela F4111 (Item Ledger File)

A tabela F4111 (Item Ledger File), ou **Cardex**, é a tabela de fatos primordial para a gestão de inventário no JD Edwards, registrando o histórico completo de todas as transações que alteram a quantidade ou o custo de um item em estoque.

* Principais Características

    * **Granularidade**: Registra cada movimentação individualmente, oferecendo o mais alto nível de detalhe.

    * **Auditoria**: Serve como a principal fonte de auditoria para todas as movimentações de estoque.

    * **Integração**: É o ponto de convergência para processos de Vendas, Compras, Manufatura e Contabilidade que afetam o inventário.

    * **Volume**: É consistentemente uma das maiores e mais ativas tabelas do sistema.

* Arquitetura Medalhão: F4111

    * **Tabela Bronze** - BRONZE.BR\_F4111

    * Cópia exata da tabela PRODDTA.F4111, contendo todos os campos originais sem tratamento.

* **Tabela Silver** - SILVER.SL\_F4111

    * Versão transformada, limpa e enriquecida. As principais transformações incluem:

        1. **Datas**: Conversão de todos os campos Julianos (xxDJ) para o formato de data (DATE ou TIMESTAMP).

        2. **Números**: Ajuste de campos de quantidade e custo, dividindo-os pelos seus respectivos fatores decimais.

        3. **Clareza**: Nomenclatura de colunas amigável e adição de campos descritivos a partir de joins (sugestões na seção de melhorias).

DE-PARA para Camada Silver (SL\_F0014)

Aqui está a sugestão de mapeamento para a camada Silver:

Mapeamento de Campos Detalhado: Bronze (F4111) para Silver (SL\_F4111)

|Campo Silver (SQL)|Campo F4111 (JDE)|Descrição|
| :- | :- | :- |
|Identificadores do Item|||
|ID\_ITEM\_CURTO|ILITM|Identificador numérico do item (Chave para F4101).|
|ID\_ITEM\_LONGO|ILLITM|Primeiro identificador alfanumérico do item.|
|ID\_ITEM\_TERCEIRO|ILAITM|Segundo identificador alfanumérico do item.|
|Localização e Lote|||
|COD\_FILIAL|ILMCU|Código da Unidade de Negócio (Filial/Centro de Custo) da transação.|
|COD\_LOCALIZACAO|ILLOCN|Localização física dentro da filial (ex: Corredor, Prateleira).|
|LOTE\_SERIAL|ILLOTN|Número do Lote ou Série do item. Essencial para rastreabilidade.|
|LOTE\_PAI|ILPLOT|Número do lote pai, usado em ambientes de manufatura.|
|STATUS\_LOTE|ILLOTS|Código de status do lote (ex: Aprovado, Quarentena).|
|Documento Principal (Origem)|||
|TIPO\_DOCUMENTO|ILDCT|Tipo de Documento que originou a transação (ex: 'SO', 'OP', 'IA').|
|NUM\_DOCUMENTO|ILDOC|Número do Documento de origem.|
|COD\_COMPANHIA\_DOC|ILKCO|Código da Companhia do documento de origem.|
|SUFIXO\_DOCUMENTO|ILSFX|Sufixo da linha do pedido, usado em casos de múltiplas linhas.|
|Integração Contábil (GL)|||
|NUM\_LOTE\_CONTABIL|ILICU|Número do lote (Batch Number) que agrupa os lançamentos na F0911.|
|TIPO\_LOTE\_CONTABIL|ILICUT|Tipo do lote (Batch Type) que agrupa os lançamentos na F0911.|
|DATA\_CONTABIL|ILDGL|(Tratado) Data contábil da transação (do formato Julian). Define o período fiscal.|
|NUM\_LINHA\_LANCAMENTO\_CONTABIL|ILJELN|Número da linha do lançamento no diário contábil (F0911).|
|COD\_CLASSE\_CONTABIL|ILGLPT|Código de classe contábil do item (G/L Class), usado pelas AAIs.|
|Documento Relacionado|||
|TIPO\_DOCUMENTO\_RELAC|ILDCTO|Tipo de Documento relacionado (ex: uma Ordem de Venda pode estar relacionada a uma Ordem de Compra).|
|NUM\_DOCUMENTO\_RELAC|ILDOCO|Número do Documento relacionado.|
|COD\_COMPANHIA\_RELAC|ILKCOO|Companhia do Documento relacionado.|
|LINHA\_DOCUMENTO\_RELAC|ILLNID|Número da linha do Documento relacionado.|
|Valores e Quantidades|||
|QTD\_TRANSACAO|ILTRQT|(Tratado) Quantidade movimentada. Atenção: Valor precisa ser dividido pelo fator decimal correto.|
|UNIDADE\_MEDIDA\_TRANSACAO|ILTRUM|Unidade de medida da QTD\_TRANSACAO (ex: 'UN', 'CX', 'KG').|
|CUSTO\_UNITARIO|ILUNCS|(Tratado) Custo unitário do item na transação. Atenção: Valor precisa ser dividido pelo fator decimal da moeda.|
|CUSTO\_TOTAL\_PAGO|ILPAID|(Tratado) Custo estendido (geralmente QTD \* CUSTO) ou valor total.|
|Datas e Auditoria|||
|DATA\_TRANSACAO|ILTRDJ|(Tratado) Data em que a transação ocorreu (do formato Julian).|
|HORA\_TRANSACAO|ILTDAY|(Tratado) Hora da transação (convertido do formato numérico do JDE).|
|ID\_USUARIO|ILUSER|ID do usuário que registrou a transação.|
|ID\_PROGRAMA|ILPID|Programa/Aplicação JDE que gerou o registro.|
|ID\_ESTACAO\_TRABALHO|ILJOBN|Nome da estação de trabalho ou job que processou a transação.|
|ID\_UNICO\_JDE|ILUKID|Chave primária única da transação, gerada internamente pelo JDE.|
|Campos Adicionais de Contexto|||
|ID\_FORNECEDOR\_CLIENTE|ILAN8|Address Book Number. Pode ser o fornecedor (em compras) ou cliente (em vendas).|
|REFERENCIA\_TRANSACAO|ILTREF|Campo de referência texto livre.|
|EXPLICACAO\_TRANSACAO|ILTREX|Campo de texto para explicação da transação (ex: "Ajuste de inventário anual").|
|CODIGO\_MOTIVO|ILRCD|Código de motivo para a transação (ex: 'DANIFICADO', 'DEVOLUÇÃO').|

### Sugestões de Melhoria (Atualizadas)

Criar CHAVE\_DOCUMENTO\_ORIGEM:  Concatene ILKCO, ILDCT, e ILDOC para criar uma chave única que identifique o documento de origem da transação. Facilita muito os joins com F4211 ou F4311.

Criar CHAVE\_DOCUMENTO\_RELACIONADO: Da mesma forma, crie uma chave para o documento relacionado concatenando ILKCOO, ILDCTO, e ILDOCO.

Enriquecer com ID\_FORNECEDOR\_CLIENTE (ILAN8): Na camada Silver, faça um join com a F0101 (Address Book) usando o campo ILAN8 para adicionar a coluna NOME\_FORNECEDOR\_CLIENTE. Isso trará um valor imenso para as análises.

Decodificar CODIGO\_MOTIVO (ILRCD): Faça um join com a F0005 (User Defined Codes) para buscar a descrição do código de motivo e adicioná-la em uma nova coluna DESCRICAO\_MOTIVO.

Este mapeamento detalhado deve fornecer uma base sólida para a transformação dos dados da F4111 para sua camada Silver.
