# Documentação da Tabela F0101
A tabela F0101, conhecida como Cadastro de Endereços (Address Book Master), é uma das mais importantes e centrais do sistema JD Edwards (JDE) 9.2. Ela serve como um repositório mestre para informações fundamentais sobre qualquer entidade com a qual a empresa se relaciona, sejam eles clientes, fornecedores, funcionários, ou contatos diversos. Compreender sua estrutura e suas interações é crucial para a elaboração de documentações, relatórios e integrações eficazes.

Este guia oferece uma visão "normalizada" dos campos da F0101, traduzindo a nomenclatura técnica do JDE para uma linguagem de fácil entendimento, além de explorar as junções (joins) mais comuns com outras tabelas do sistema.

Entendendo a F0101: O Coração do Cadastro

A F0101 armazena o registro principal de cada entidade, atribuindo um número único de identificação conhecido como Address Number (AN8). A partir deste número, o sistema vincula uma vasta gama de informações transacionais e de cadastro. Em essência, se você precisa saber "quem" está envolvido em uma transação, a F0101 é o ponto de partida.

Principais Campos e Descrições:

1. **ABAN8** - Address Number (Número do endereço - chave primária)
1. **ABALPH** - Name (Nome/Descrição)
1. **ABTAX** - Tax ID (CNPJ/CPF)
1. **ABMCU** - Business Unit (Unidade de negócios)
1. **ABDC** - Document Code (Código do documento)
1. **ABSIC** - Standard Industrial Code (Código industrial padrão)
1. **ABLNGP** - Language Preference (Preferência de idioma)
1. **ABAT1-ABAT5** - Address Lines (Linhas de endereço)
1. **ABCM** - Credit Message (Mensagem de crédito)
1. **ABTAXC** - Tax Rate/Area (Área de taxa)
1. **ABURCD** - User Reserved Code (Código reservado do usuário)
1. **ABUSER** - User ID (ID do usuário)
1. **ABPID** - Program ID (ID do programa)
1. **ABUPMJ** - Date - Updated (Julian) (Data de atualização)
1. **ABJOBN** - Work Station ID (ID da estação de trabalho)
1. **ABUPMT** - Time - Last Updated (Hora da última atualização)

DE-PARA para Camada Silver (SL\_F0101)

|Prefixo|Alias (Campo)|Descrição Técnica|Descrição "Normalizada" (Português)|
| :- | :- | :- | :- |
|AB|AN8|Address Number|Número de Endereço: O identificador único para cada entidade (cliente, fornecedor, etc.). É a chave primária da tabela.|
|AB|ALPH|Name - Alpha|Nome: O nome completo da pessoa ou a razão social da empresa.|
|AB|TAX|Tax ID|ID Fiscal: O número de identificação fiscal (CNPJ, CPF, etc.).|
|AB|AT1|Search Type|Tipo de Pesquisa: Um código que classifica a entidade (ex: 'C' para Cliente, 'F' para Fornecedor).|
|AB|MCU|Business Unit|Unidade de Negócio: A unidade de negócio padrão associada à entidade.|
|AB|LNGP|Language Preference|Preferência de Idioma: O idioma de preferência para comunicação.|
|AB|CM|Credit Message|Mensagem de Crédito: Um código que indica a situação de crédito da entidade.|
|AB|TAXC|Person/Corporation Code|Código Pessoa/Empresa: Indica se o registro é de uma pessoa física ou jurídica.|
|AB|ATE|Address Type - Employee|Tipo de Endereço - Funcionário: Um indicador que sinaliza se a entidade é um funcionário.|
|AB|ATP|Address Type - Payables|Tipo de Endereço - Contas a Pagar: Sinaliza que a entidade é um fornecedor.|
|AB|ATR|Address Type - Receivables|Tipo de Endereço - Contas a Receber: Sinaliza que a entidade é um cliente.|
|AB|AC01 a AC30|Category Code - Address Book 01 a 30|Códigos de Categoria 01 a 30: Campos customizáveis para categorizar e agrupar as entidades de acordo com as necessidades do negócio (ex: região, setor, porte).|
|AB|USER|User ID|ID do Usuário: O usuário que criou ou modificou o registro por último.|
|AB|PID|Program ID|ID do Programa: O programa do JDE que foi utilizado para a última alteração.|
|AB|UPMJ|DATA\_ATULIZACAO|Data da Atualização: A data em que o registro foi modificado pela última vez.|
|AB|JOBN|Work Station ID|ID da Estação de Trabalho: A estação de trabalho que originou a última alteração.|
|AB|UPMT|Time of Day|Hora da Atualização: A hora da última modificação do registro.|




|**Campo Original**|**Campo Silver (Inglês)**|**Campo Silver (Português)**|**Tipo de Dado**|**Descrição**|
| :- | :- | :- | :- | :- |
|ABAN8|address\_number|numero\_endereco|Integer|Número do endereço (chave primária)|
|ABALKY|alternate\_key|chave\_alternativa|String|Chave alternativa|
|ABTAX|tax\_id|cnpj\_cpf|String|CNPJ/CPF|
|ABALPH|name|nome\_razao\_social|String|Nome/Razão Social|
|ABDC|document\_code|codigo\_documento|String|Código do documento|
|ABMCU|business\_unit|unidade\_negocio|String|Unidade de negócios|
|ABSIC|industry\_code|codigo\_industria|String|Código industrial|
|ABLNGP|language\_preference|preferencia\_idioma|String|Preferência de idioma|
|ABAT1|address\_line1|endereco\_linha1|String|Linha 1 do endereço|
|ABCM|credit\_message|mensagem\_credito|String|Mensagem de crédito|
|ABTAXC|tax\_area|area\_tributaria|String|Área tributária|
|ABAT2|address\_line2|endereco\_linha2|String|Linha 2 do endereço|
|ABAT3|address\_line3|endereco\_linha3|String|Linha 3 do endereço|
|ABAT4|city|cidade|String|Cidade|
|ABAT5|state|estado|String|Estado|
|ABATP|zip\_code|cep|String|CEP|
|ABATR|country|pais|String|País|
|ABATPR|province|provincia|String|Província|
|ABAB3|county|municipio|String|Município|
|ABATE|email|email|String|E-mail|
|ABSBLI|subledger\_inactive|subledger\_inativo|String|Indicador de subledger inativo|
|ABEFTB|effective\_tax\_bureau|orgao\_tributario\_efetivo|String|Órgão tributário efetivo|
|ABAN81-ABAN86|related\_address\_numbers|numeros\_endereco\_relacionados|Integer|Números de endereço relacionados|
|ABAC01-ABAC30|user\_reserved\_codes|codigos\_reservados\_usuario|String|Códigos reservados do usuário (01-30)|
|ABGLBA|global\_location|localizacao\_global|String|Localização global|
|ABPTI|payment\_terms\_id|id\_condicoes\_pagamento|String|ID condições de pagamento|
|ABPDI|pricing\_discount\_id|id\_desconto\_preco|String|ID desconto de preço|
|ABMSGA|message\_audit|auditoria\_mensagem|String|Auditoria de mensagem|
|ABRMK|remarks|observacoes|String|Observações|
|ABTXCT|tax\_county|municipio\_tributario|String|Município tributário|
|ABTX2|tax\_id2|inscricao\_estadual|String|Inscrição estadual|
|ABALP1|search\_name|nome\_busca|String|Nome para busca|
|ABURCD|user\_reserved\_code|codigo\_reservado\_usuario|String|Código reservado do usuário|
|ABURDT|user\_reserved\_date|data\_reservada\_usuario|Integer|Data reservada do usuário (Juliano)|
|ABURAT|user\_reserved\_amount|valor\_reservado\_usuario|Decimal|Valor reservado do usuário|
|ABURAB|user\_reserved\_address|endereco\_reservado\_usuario|String|Endereço reservado do usuário|
|ABURRF|user\_reserved\_reference|referencia\_reservada\_usuario|String|Referência reservada do usuário|
|ABUSER|user\_id|id\_usuario|String|ID do usuário|
|ABPID|program\_id|id\_programa|String|ID do programa|
|ABUPMJ|last\_update\_date\_julian|data\_ultima\_atualizacao\_juliana|Integer|Data última atualização (Juliano)|
|ABJOBN|workstation\_id|id\_estacao\_trabalho|String|ID da estação de trabalho|
|ABUPMT|last\_update\_time|hora\_ultima\_atualizacao|Time|Hora última atualização|
|ABPRGF|program\_function|funcao\_programa|String|Função do programa|
|ABSCCLTP|supplier\_classification\_type|tipo\_classificacao\_fornecedor|String|Tipo classificação fornecedor|
|ABTICKER|ticker\_symbol|simbolo\_bolsa|String|Símbolo na bolsa|
|ABEXCHG|stock\_exchange|bolsa\_valores|String|Bolsa de valores|
|ABDUNS|duns\_number|numero\_duns|String|Número DUNS|
|ABCLASS01-ABCLASS05|classification\_codes|codigos\_classificacao|String|Códigos de classificação (01-05)|
|ABNOE|number\_of\_employees|numero\_funcionarios|Integer|Número de funcionários|
|ABGROWTHR|growth\_rate|taxa\_crescimento|Decimal|Taxa de crescimento|
|ABYEARSTAR|year\_started|ano\_inicio|Integer|Ano de início|
|ABAEMPGP|employee\_group|grupo\_funcionarios|String|Grupo de funcionários|
|ABACTIN|activity\_indicator|indicador\_atividade|String|Indicador de atividade|
|ABREVRNG|revenue\_range|faixa\_receita|String|Faixa de receita|
|ABSYNCS|sync\_status|status\_sincronizacao|String|Status de sincronização|
|ABPERRS|person\_type|tipo\_pessoa|String|Tipo de pessoa (F/J)|
|ABCAAD|caad\_indicator|indicador\_caad|String|Indicador CAAD|



SQL para Criação da Tabela Silver

~~~sql

CREATE OR REPLACE TABLE SL_F0101 AS
SELECT 
    ABAN8 AS numero_endereco,
    ABALKY AS chave_alternativa,
    ABTAX AS cnpj_cpf,
    ABALPH AS nome_razao_social,
    ABDC AS codigo_documento,
    ABMCU AS unidade_negocio,
    ABSIC AS codigo_industria,
    ABLNGP AS preferencia_idioma,
    ABAT1 AS endereco_linha1,
    ABCM AS mensagem_credito,
    ABTAXC AS area_tributaria,
    ABAT2 AS endereco_linha2,
    ABAT3 AS endereco_linha3,
    ABAT4 AS cidade,
    ABAT5 AS estado,
    ABATP AS cep,
    ABATR AS pais,
    ABATPR AS provincia,
    ABAB3 AS municipio,
    ABATE AS email,
    ABSBLI AS subledger_inativo,
    ABEFTB AS orgao_tributario_efetivo,
    ABAN81 AS numero_endereco_relacionado1,
    ABAN82 AS numero_endereco_relacionado2,
    ABAN83 AS numero_endereco_relacionado3,
    ABAN84 AS numero_endereco_relacionado4,
    ABAN85 AS numero_endereco_relacionado5,
    ABAN86 AS numero_endereco_relacionado6,
    ABAC01 AS codigo_reservado_usuario01,
    -- ... (repetir para ABAC02 até ABAC30)
    ABGLBA AS localizacao_global,
    ABPTI AS id_condicoes_pagamento,
    ABPDI AS id_desconto_preco,
    ABMSGA AS auditoria_mensagem,
    ABRMK AS observacoes,
    ABTXCT AS municipio_tributario,
    ABTX2 AS inscricao_estadual,
    ABALP1 AS nome_busca,
    ABURCD AS codigo_reservado_usuario,
    ABURDT AS data_reservada_usuario,
    ABURAT AS valor_reservado_usuario,
    ABURAB AS endereco_reservado_usuario,
    ABURRF AS referencia_reservada_usuario,
    ABUSER AS id_usuario,
    ABPID AS id_programa,
    ABUPMJ AS data_ultima_atualizacao_juliana,
    ABJOBN AS id_estacao_trabalho,
    ABUPMT AS hora_ultima_atualizacao,
    ABPRGF AS funcao_programa,
    ABSCCLTP AS tipo_classificacao_fornecedor,
    ABTICKER AS simbolo_bolsa,
    ABEXCHG AS bolsa_valores,
    ABDUNS AS numero_duns,
    ABCLASS01 AS codigo_classificacao01,
    ABCLASS02 AS codigo_classificacao02,
    ABCLASS03 AS codigo_classificacao03,
    ABCLASS04 AS codigo_classificacao04,
    ABCLASS05 AS codigo_classificacao05,
    ABNOE AS numero_funcionarios,
    ABGROWTHR AS taxa_crescimento,
    ABYEARSTAR AS ano_inicio,
    ABAEMPGP AS grupo_funcionarios,
    ABACTIN AS indicador_atividade,
    ABREVRNG AS faixa_receita,
    ABSYNCS AS status_sincronizacao,
    ABPERRS AS tipo_pessoa,
    ABCAAD AS indicador_caad
FROM BR_F0101;
~~~~

Recomendações para a Camada Silver:

1. **Tratamento de PII**: Campos como CPF/CNPJ devem ser mascarados ou criptografados
1. **Conversão de datas**: Adicionar campos com datas convertidas do formato Julian
1. **Segmentação**: Considerar dividir esta tabela em múltiplas tabelas relacionadas devido ao seu tamanho
1. **Histórico**: Implementar mecanismo de histórico para capturar mudanças nos dados
1. **Validações**: Aplicar validações em campos como e-mail, CEP, CNPJ
1. **Campos de endereço**: Considerar normalizar o endereço em uma estrutura separada

Possíveis Junções (Joins) com Outras Tabelas

A verdadeira força da F0101 se manifesta quando a conectamos com outras tabelas do JDE para obter uma visão completa das operações. A junção (join) é quase sempre feita utilizando o campo AN8 (Address Number).

Abaixo estão algumas das junções mais comuns e importantes:

1\. Informações de Contato e Endereços Adicionais:

F0111 (Whos Who): Armazena informações de contatos específicos dentro de uma empresa.

Junção: F0101.AN8 = F0111.WWAN8

Utilidade: Obter a lista de pessoas de contato (nome, cargo, etc.) de um determinado cliente ou fornecedor.

F0115 (Phone Numbers): Contém os números de telefone associados a um registro da F0101.

Junção: F0101.AN8 = F0115.PNAN8

Utilidade: Listar todos os telefones de um cliente.

F0116 (Address by Date): Armazena os endereços postais (rua, cidade, estado, CEP). Um único AN8 pode ter múltiplos endereços (ex: entrega, cobrança).

Junção: F0101.AN8 = F0116.ADAN8

Utilidade: Recuperar o endereço de entrega ou de cobrança de um parceiro de negócio.

2\. Informações Financeiras:

F0301 (Customer Master): Contém informações específicas de clientes, como termos de pagamento e limite de crédito.

Junção: F0101.AN8 = F0301.CMAN8

Utilidade: Analisar dados de crédito e faturamento de clientes.

F0401 (Supplier Master): Armazena informações específicas de fornecedores.

Junção: F0101.AN8 = F0401.APAN8

Utilidade: Obter detalhes bancários e condições de pagamento de fornecedores.

F03B11 (Accounts Receivable Ledger): Tabela de partidas em aberto no contas a receber.

Junção: F0101.AN8 = F03B11.RPAN8

Utilidade: Relacionar faturas em aberto com os respectivos nomes dos clientes.

F0411 (Accounts Payable Ledger): Tabela de partidas em aberto no contas a pagar.

Junção: F0101.AN8 = F0411.RPAN8

Utilidade: Vincular faturas a pagar com os dados cadastrais dos fornecedores.

3\. Informações de Vendas e Compras:

F4211 (Sales Order Detail File): Contém os detalhes dos pedidos de venda.

Junção: F0101.AN8 = F4211.SHAN8 (Cliente de Venda) ou F0101.AN8 = F4211.SDAN8 (Cliente de Entrega).

Utilidade: Criar relatórios de vendas que mostrem o nome do cliente em vez de apenas o seu código.

F4311 (Purchase Order Detail File): Armazena os detalhes dos pedidos de compra.

Junção: F0101.AN8 = F4311.PHAN8

Utilidade: Elaborar relatórios de compras que incluam a razão social do fornecedor.

