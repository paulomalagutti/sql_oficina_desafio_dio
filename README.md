# sql_oficina_desafio_dio
Desafio de Projeto: Modelagem de Banco de Dados para Oficina Mecânica
# Desafio de Projeto: Modelagem de Banco de Dados para Oficina Mecânica

Este repositório contém a solução para o Desafio de Projeto da Digital Innovation One (DIO), focado na criação de um esquema conceitual de banco de dados para gerenciar Ordens de Serviço em uma oficina mecânica.

---

## 📝 Narrativa e Levantamento de Requisitos

O projeto foi desenvolvido a partir da seguinte narrativa:

* **Sistema:** Controle e gerenciamento de execução de ordens de serviço (OS).
* **Fluxo Principal:** Clientes levam veículos para consertos ou revisões periódicas.
* **Atribuição:** Cada veículo é designado a uma equipe de mecânicos que identifica os serviços e preenche a OS.
* **Composição da OS:** A OS é composta por serviços (mão-de-obra) e peças, cujos valores são consultados em tabelas de referência.
* **Autorização:** O cliente precisa autorizar a execução dos serviços para que a OS prossiga.
* **Atributos da OS:** Cada OS possui um número, data de emissão, status, valor total e data de conclusão.

---

## 🔗 Esquema e Relacionamentos

Com base na narrativa, o banco de dados foi modelado com as seguintes entidades e relacionamentos para garantir a integridade e a organização das informações:

-   **Entidades Principais:** `Cliente`, `Veiculo`, `Equipe`, `OrdemServico`, `Peca`, `Servico`.
-   **Relacionamentos Chave:**
    -   Um `Cliente` pode ter vários `Veiculos`.
    -   Uma `Equipe` é responsável por várias `Ordens de Serviço`.
    -   Uma `OrdemServico` está associada a um único `Veiculo` e uma única `Equipe`.
    -   Para permitir que uma OS tenha múltiplos serviços e peças, foram criadas as tabelas de junção `Servico_OS` e `Peca_OS` (relacionamento N-para-M).

---

##  DIAGRAMA EER (Modelo Entidade-Relacionamento)

A estrutura visual do banco de dados, mostrando todas as tabelas, colunas e como elas se conectam.

## 🛠️ Como Utilizar

Para recriar este banco de dados, execute o script SQL contido no arquivo `esquema_oficina.sql` em uma instância MySQL.
