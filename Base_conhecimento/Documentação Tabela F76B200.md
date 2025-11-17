# Documentação Tabela F76B200

Tabela JDE - F76B200

0 - Tabela Bronze - BRONZE.BR_ F76B200

0 - Tabela Silver - SILVER.SL_ F76B200 (campo data tratado)

| CAMPO SILVER | CAMPO BRONZE | DESCRIÇÃO |
| --- | --- | --- |
| COD_NATUREZA_TRANSACAO | DPBNOP | Código numérico da natureza da transação. Chave primária ou parcial. |
| SUFIXO_NATUREZA_TRANSACAO | DPBSOP | Sufixo alfanumérico da natureza da transação. Complementa o código DPBNOP. |
| EMPRESA_ORIGEM | DPFCO | Código da empresa de origem (remetente). Formato string. |
| DATA_ENVIO | DPSHPJ | Data de envio no formato Julian. Transformação necessária: Converter para data padrão (YYYY-MM-DD). |
| COD_NATUREZA_TRANSACAO_ALT | DPBRNOP | Código alternativo da natureza da transação (formato string). |
| ID_USUARIO | DPUSER | Identificação do usuário que realizou a transação. |
| ID_PROGRAMA | DPPID | Identificação do programa ou módulo que gerou a transação. |
| ID_ESTACAO_TRABALHO | DPJOBN | Identificação da estação de trabalho (terminal/computador). |
| DATA_ATUALIZACAO | DPUPMJ | Data da última atualização no formato Julian. Transformação: Converter para YYYY-MM-DD. |
| HORA_ATUALIZACAO | DPUPMT | Hora da última atualização (formato numérico). Exemplo: 120000 = 12:00:00. |
| HORA_DIA | DPTDAY | Hora do dia registrada (formato numérico). Pode ser usada para logs. |

Observações Adicionais:

Transformações Necessárias:

Campos de data Julian (DPSHPJ, DPUPMJ) devem ser convertidos para o formato YYYY-MM-DD.

Campos de hora (DPUPMT, DPTDAY) podem precisar de formatação (ex: 120000 → 12:00:00).

Relacionamentos:

COD_NATUREZA_TRANSACAO (DPBNOP) pode ser uma chave estrangeira para outras tabelas de transações.

EMPRESA_ORIGEM (DPFCO) pode vincular a uma dimensão de empresas.

Padrões:

Prefixo DP sugere que a tabela é relacionada a "Data Processing" ou similar.

Campos críticos: DPBNOP (identificador único) e DPSHPJ (data de envio).

## Possíveis Chaves Primárias (Candidatas Naturais)

Chave Simples (Opção mais provável):

DPBNOP (Código da Natureza da Transação) + DPBSOP (Sufixo):

Justificativa: Combinam um código numérico (DPBNOP) com um sufixo string (DPBSOP), o que pode garantir unicidade.

Exemplo: DPBNOP = 1001 + DPBSOP = "A" → Chave = 1001-A.

Chave Composta Alternativa:

DPBNOP + DPFCO (Empresa de Origem) + DPSHPJ (Data de Envio):

Justificativa: Se houver múltiplas transações da mesma natureza por empresa/data.

Exemplo: 1001-COMP01-1210005.

Campo Único (Se existir garantia de unicidade):

DPBRNOP (Código Alternativo da Transação em String):

Justificativa: Pode ser um identificador único, mas depende das regras de negócio.

Observações Críticas:

Ausência de PK Explícita: A tabela não possui um campo como ID ou PK declarado, então a chave primária deve ser definida com base nas regras do sistema.

Redundância: DPBNOP (numérico) e DPBRNOP (string) podem ser variações do mesmo identificador - verifique qual é usado em relacionamentos.

Dependência de Contexto: Se esta tabela for um log ou histórico, a chave pode incluir campos de tempo (DPSHPJ + DPUPMT).