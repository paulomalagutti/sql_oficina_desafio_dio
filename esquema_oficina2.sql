-- Apaga o banco de dados se ele já existir, para um começo limpo.
DROP DATABASE IF EXISTS oficina;

-- Cria o banco de dados.
CREATE DATABASE oficina;

-- Seleciona o banco de dados para os comandos seguintes.
USE oficina;

-- Tabela de Clientes
CREATE TABLE clients (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    Address VARCHAR(255),
    Contact CHAR(11) NOT NULL
);

-- Tabela de Veículos
CREATE TABLE vehicles (
    idVehicle INT AUTO_INCREMENT PRIMARY KEY,
    idClient INT,
    Model VARCHAR(50) NOT NULL,
    VehicleYear INT NOT NULL,
    LicensePlate CHAR(7) NOT NULL UNIQUE,
    CONSTRAINT fk_vehicle_client FOREIGN KEY (idClient) REFERENCES clients(idClient)
);

-- Tabela de Mecânicos
CREATE TABLE mechanics (
    idMechanic INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Specialty VARCHAR(50)
);

-- Tabela de Peças
CREATE TABLE parts (
    idPart INT AUTO_INCREMENT PRIMARY KEY,
    PartName VARCHAR(100) NOT NULL,
    Price FLOAT NOT NULL
);

-- Tabela de Serviços
CREATE TABLE services (
    idService INT AUTO_INCREMENT PRIMARY KEY,
    ServiceName VARCHAR(100) NOT NULL,
    Price FLOAT NOT NULL
);

-- Tabela de Ordens de Serviço (Tabela Central)
CREATE TABLE service_orders (
    idServiceOrder INT AUTO_INCREMENT PRIMARY KEY,
    idVehicle INT,
    EntryDate DATE NOT NULL,
    IssueDescription VARCHAR(255) NOT NULL,
    Status ENUM('Aguardando Análise', 'Em Execução', 'Concluído', 'Entregue') DEFAULT 'Aguardando Análise',
    CONSTRAINT fk_so_vehicle FOREIGN KEY (idVehicle) REFERENCES vehicles(idVehicle)
);

-- Tabela associativa: Peças utilizadas em uma Ordem de Serviço (N:M)
CREATE TABLE service_order_parts (
    idServiceOrder INT,
    idPart INT,
    Quantity INT NOT NULL,
    PRIMARY KEY (idServiceOrder, idPart),
    CONSTRAINT fk_sop_order FOREIGN KEY (idServiceOrder) REFERENCES service_orders(idServiceOrder),
    CONSTRAINT fk_sop_part FOREIGN KEY (idPart) REFERENCES parts(idPart)
);

-- Tabela associativa: Serviços realizados em uma Ordem de Serviço (N:M)
CREATE TABLE service_order_services (
    idServiceOrder INT,
    idService INT,
    PRIMARY KEY (idServiceOrder, idService),
    CONSTRAINT fk_sos_order FOREIGN KEY (idServiceOrder) REFERENCES service_orders(idServiceOrder),
    CONSTRAINT fk_sos_service FOREIGN KEY (idService) REFERENCES services(idService)
);

-- Tabela associativa: Mecânicos responsáveis por uma Ordem de Serviço (N:M)
CREATE TABLE service_order_mechanics (
    idServiceOrder INT,
    idMechanic INT,
    PRIMARY KEY (idServiceOrder, idMechanic),
    CONSTRAINT fk_som_order FOREIGN KEY (idServiceOrder) REFERENCES service_orders(idServiceOrder),
    CONSTRAINT fk_som_mechanic FOREIGN KEY (idMechanic) REFERENCES mechanics(idMechanic)
);
