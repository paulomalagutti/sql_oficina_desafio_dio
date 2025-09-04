USE oficina;

-- =================================================================
-- 1. Recuperações simples com SELECT Statement
-- Pergunta: Quais são todos os mecânicos e suas especialidades?
-- =================================================================
SELECT FullName, Specialty FROM mechanics;

-- =================================================================
-- 2. Filtros com WHERE Statement
-- Pergunta: Quais veículos foram fabricados após 2020?
-- =================================================================
SELECT Model, VehicleYear, LicensePlate
FROM vehicles
WHERE VehicleYear > 2020;

-- =================================================================
-- 3. Expressões para gerar atributos derivados
-- Pergunta: Qual é o custo total de peças para cada ordem de serviço que as utilizou?
-- =================================================================
SELECT
    sop.idServiceOrder AS 'Ordem de Serviço',
    SUM(p.Price * sop.Quantity) AS Custo_Total_Peças
FROM service_order_parts AS sop
JOIN parts AS p ON sop.idPart = p.idPart
GROUP BY sop.idServiceOrder;

-- =================================================================
-- 4. Ordenações dos dados com ORDER BY
-- Pergunta: Liste todos os clientes em ordem alfabética.
-- =================================================================
SELECT FullName, CPF, Contact
FROM clients
ORDER BY FullName ASC;

-- =================================================================
-- 5. Condições de filtros aos grupos – HAVING Statement
-- Pergunta: Quais mecânicos foram designados para mais de uma ordem de serviço?
-- =================================================================
SELECT
    m.FullName,
    COUNT(som.idServiceOrder) AS 'Nº de Ordens'
FROM mechanics AS m
JOIN service_order_mechanics AS som ON m.idMechanic = som.idMechanic
GROUP BY m.idMechanic
HAVING COUNT(som.idServiceOrder) > 1;

-- =================================================================
-- 6. Junções entre tabelas para uma perspectiva mais complexa
-- Pergunta: Qual é o relatório completo de cada ordem de serviço, mostrando o cliente, o veículo, o status e o mecânico responsável?
-- =================================================================
SELECT
    os.idServiceOrder AS 'OS',
    c.FullName AS Cliente,
    v.Model AS Veiculo,
    v.LicensePlate AS Placa,
    os.Status,
    m.FullName AS 'Mecânico Responsável'
FROM service_orders AS os
JOIN vehicles AS v ON os.idVehicle = v.idVehicle
JOIN clients AS c ON v.idClient = c.idClient
JOIN service_order_mechanics AS som ON os.idServiceOrder = som.idServiceOrder
JOIN mechanics AS m ON som.idMechanic = m.idMechanic
ORDER BY os.idServiceOrder;
