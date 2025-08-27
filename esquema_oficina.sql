-- CRIAÇÃO DO BANCO DE DADOS PARA O CENÁRIO DE OFICINA
CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;

-- Tabela Cliente
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF CHAR(11) NOT NULL,
    Endereco VARCHAR(255),
    Contato VARCHAR(45),
    CONSTRAINT unique_cpf_cliente UNIQUE (CPF)
);

-- Tabela Veículo
CREATE TABLE Veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    Placa CHAR(7) NOT NULL,
    Modelo VARCHAR(50),
    Marca VARCHAR(50),
    Ano INT,
    CONSTRAINT unique_placa_veiculo UNIQUE (Placa),
    CONSTRAINT fk_veiculo_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Equipe de Mecânicos
CREATE TABLE Equipe (
    idEquipe INT AUTO_INCREMENT PRIMARY KEY,
    CodigoIdentificacao VARCHAR(45) NOT NULL,
    Especialidade VARCHAR(100),
    CONSTRAINT unique_codigo_equipe UNIQUE (CodigoIdentificacao)
);

-- Tabela Ordem de Serviço
CREATE TABLE OrdemServico (
    idOrdemServico INT AUTO_INCREMENT PRIMARY KEY,
    idVeiculo INT,
    idEquipe INT,
    DataEmissao DATE NOT NULL,
    DataConclusao DATE,
    ValorTotal DECIMAL(10, 2),
    StatusOS ENUM('Aguardando Aprovação', 'Aprovada', 'Em Execução', 'Concluída', 'Cancelada') NOT NULL DEFAULT 'Aguardando Aprovação',
    Autorizado BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_os_veiculo FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),
    CONSTRAINT fk_os_equipe FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)
);

-- Tabela de Peças (Tabela de Referência)
CREATE TABLE Peca (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL,
    ValorUnitario DECIMAL(10, 2) NOT NULL
);

-- Tabela de Serviços (Tabela de Referência de Mão-de-Obra)
CREATE TABLE Servico (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL,
    ValorMaoDeObra DECIMAL(10, 2) NOT NULL
);

-- Tabela de Ligação: Peças usadas na OS (Relação N:M)
CREATE TABLE Peca_OS (
    idOrdemServico INT,
    idPeca INT,
    Quantidade INT NOT NULL DEFAULT 1,
    PRIMARY KEY (idOrdemServico, idPeca),
    CONSTRAINT fk_peca_os_os FOREIGN KEY (idOrdemServico) REFERENCES OrdemServico(idOrdemServico),
    CONSTRAINT fk_peca_os_peca FOREIGN KEY (idPeca) REFERENCES Peca(idPeca)
);

-- Tabela de Ligação: Serviços executados na OS (Relação N:M)
CREATE TABLE Servico_OS (
    idOrdemServico INT,
    idServico INT,
    PRIMARY KEY (idOrdemServico, idServico),
    CONSTRAINT fk_servico_os_os FOREIGN KEY (idOrdemServico) REFERENCES OrdemServico(idOrdemServico),
    CONSTRAINT fk_servico_os_servico FOREIGN KEY (idServico) REFERENCES Servico(idServico)
);