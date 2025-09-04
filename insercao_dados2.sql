USE oficina;

-- Inserção de Clientes
INSERT INTO clients (FullName, CPF, Address, Contact) VALUES
('Carlos Pereira', '11122233344', 'Rua Alfa, 10', '11987654321'),
('Ana Lima', '55566677788', 'Rua Beta, 20', '11912345678'),
('Ricardo Souza', '99988877766', 'Rua Gama, 30', '11955554444');

-- Inserção de Veículos
INSERT INTO vehicles (idClient, Model, VehicleYear, LicensePlate) VALUES
(1, 'Toyota Corolla', 2020, 'ABC1234'),
(2, 'Honda Civic', 2021, 'DEF5678'),
(3, 'Ford Ka', 2019, 'GHI9012'),
(1, 'Fiat Strada', 2022, 'JKL3456');

-- Inserção de Mecânicos
INSERT INTO mechanics (FullName, Specialty) VALUES
('João da Silva', 'Motor'),
('Pedro Martins', 'Elétrica'),
('Marcos Andrade', 'Suspensão');

-- Inserção de Peças
INSERT INTO parts (PartName, Price) VALUES
('Filtro de Óleo', 50.00),
('Vela de Ignição', 25.00),
('Pastilha de Freio', 120.00),
('Amortecedor Dianteiro', 350.00);

-- Inserção de Serviços
INSERT INTO services (ServiceName, Price) VALUES
('Troca de Óleo e Filtro', 150.00),
('Revisão do Sistema de Freios', 200.00),
('Alinhamento e Balanceamento', 100.00),
('Troca de Suspensão', 400.00);

-- Inserção de Ordens de Serviço
INSERT INTO service_orders (idVehicle, EntryDate, IssueDescription, Status) VALUES
(1, '2024-05-10', 'Barulho estranho no motor ao ligar.', 'Concluído'),
(2, '2024-05-12', 'Freios fazendo barulho ao frear.', 'Em Execução'),
(3, '2024-05-15', 'Carro puxando para a direita.', 'Entregue'),
(1, '2024-05-18', 'Revisão completa da suspensão.', 'Aguardando Análise');

-- Atribuição de Serviços às Ordens de Serviço
INSERT INTO service_order_services (idServiceOrder, idService) VALUES
(1, 1), -- OS 1: Troca de Óleo
(2, 2), -- OS 2: Revisão de Freios
(3, 3), -- OS 3: Alinhamento
(4, 4); -- OS 4: Troca de Suspensão

-- Atribuição de Peças às Ordens de Serviço
INSERT INTO service_order_parts (idServiceOrder, idPart, Quantity) VALUES
(1, 1, 1),  -- OS 1: 1 Filtro de Óleo
(1, 2, 4),  -- OS 1: 4 Velas
(2, 3, 2),  -- OS 2: 2 Pastilhas de Freio
(4, 4, 2);  -- OS 4: 2 Amortecedores

-- Atribuição de Mecânicos às Ordens de Serviço
INSERT INTO service_order_mechanics (idServiceOrder, idMechanic) VALUES
(1, 1), -- OS 1: João (Motor)
(2, 2), -- OS 2: Pedro (Elétrica)
(2, 3), -- OS 2: Marcos (Suspensão) - 2 mecânicos na mesma OS
(3, 3), -- OS 3: Marcos (Suspensão)
(4, 3); -- OS 4: Marcos (Suspensão)
