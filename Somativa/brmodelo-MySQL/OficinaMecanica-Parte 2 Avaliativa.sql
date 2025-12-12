CREATE DATABASE OficinaMecanica;

USE OficinaMecanica;

-- Tabelas
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    endereco VARCHAR(150)
);

CREATE TABLE Mecanicos (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(50),
    data_contratacao DATE
);

CREATE TABLE Veiculos (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    placa VARCHAR(10) UNIQUE,
    ano INT,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Pecas (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL
);

CREATE TABLE Servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    valor_mao_obra DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Ordem_Servico (
    id_os INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    data_abertura DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_conclusao DATETIME,
    status VARCHAR(20) DEFAULT 'Aberta',
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculos(id_veiculo)
);

CREATE TABLE OS_Servicos (
    id_os INT NOT NULL,
    id_servico INT NOT NULL,
    obs VARCHAR(100),
    PRIMARY KEY (id_os, id_servico),
    FOREIGN KEY (id_os) REFERENCES Ordem_Servico(id_os),
    FOREIGN KEY (id_servico) REFERENCES Servicos(id_servico)
);

CREATE TABLE OS_Pecas (
    id_os INT NOT NULL,
    id_peca INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    PRIMARY KEY (id_os, id_peca),
    FOREIGN KEY (id_os) REFERENCES Ordem_Servico(id_os),
    FOREIGN KEY (id_peca) REFERENCES Pecas(id_peca)
);

CREATE TABLE OS_Mecanicos (
    id_os INT NOT NULL,
    id_mecanico INT NOT NULL,
    PRIMARY KEY (id_os, id_mecanico),
    FOREIGN KEY (id_os) REFERENCES Ordem_Servico(id_os),
    FOREIGN KEY (id_mecanico) REFERENCES Mecanicos(id_mecanico)
);

-- Inserção de Dados (DML)
INSERT INTO Clientes (nome, cpf, telefone, endereco) VALUES
('Roberto Silva', '111.222.333-01', '(11) 99999-0001', 'Rua A, 10'),
('Ana Souza', '222.333.444-02', '(11) 99999-0002', 'Av B, 200'),
('Carlos Pereira', '333.444.555-03', '(21) 98888-0003', 'Rua C, 30'),
('Julia Lima', '444.555.666-04', '(31) 97777-0004', 'Av D, 400'),
('Marcos Rocha', '555.666.777-05', '(41) 96666-0005', 'Rua E, 50'),
('Fernanda Alves', '666.777.888-06', '(51) 95555-0006', 'Av F, 600'),
('Paulo Dias', '777.888.999-07', '(61) 94444-0007', 'Rua G, 70'),
('Beatriz Martins', '888.999.000-08', '(71) 93333-0008', 'Av H, 800'),
('Lucas Ferreira', '999.000.111-09', '(81) 92222-0009', 'Rua I, 90'),
('Mariana Costa', '000.111.222-10', '(91) 91111-0010', 'Av J, 1000');

INSERT INTO Mecanicos (nome, especialidade, data_contratacao) VALUES
('João da Silva', 'Motor', '2020-01-15'),
('Pedro Santos', 'Suspensão', '2021-03-10'),
('Tiago Oliveira', 'Elétrica', '2019-05-20'),
('André Costa', 'Freios', '2022-07-01'),
('Rafael Souza', 'Geral', '2018-11-11'),
('Bruno Lima', 'Injeção Eletrônica', '2023-01-05'),
('Gabriel Rocha', 'Ar Condicionado', '2021-06-15'),
('Felipe Mendes', 'Motor', '2020-09-20'),
('Gustavo Nunes', 'Suspensão', '2019-02-28'),
('Leonardo Dias', 'Elétrica', '2022-12-01');

INSERT INTO Veiculos (id_cliente, marca, modelo, placa, ano) VALUES
(1, 'Ford', 'Ka', 'ABC-1234', 2018),
(2, 'Fiat', 'Uno', 'DEF-5678', 2015),
(3, 'Chevrolet', 'Onix', 'GHI-9012', 2020),
(4, 'Hyundai', 'HB20', 'JKL-3456', 2019),
(5, 'Toyota', 'Corolla', 'MNO-7890', 2017),
(6, 'Honda', 'Civic', 'PQR-1234', 2021),
(7, 'Volkswagen', 'Gol', 'STU-5678', 2010),
(8, 'Renault', 'Kwid', 'VWX-9012', 2022),
(9, 'Jeep', 'Renegade', 'YZA-3456', 2020),
(10, 'Nissan', 'Kicks', 'BCD-7890', 2018);

INSERT INTO Pecas (nome, preco_unitario, estoque) VALUES
('Óleo 5w30', 45.00, 100),
('Filtro de Óleo', 25.00, 50),
('Pastilha de Freio', 120.00, 30),
('Amortecedor Dianteiro', 350.00, 20),
('Vela de Ignição', 15.00, 200),
('Correia Dentada', 90.00, 40),
('Bateria 60Ah', 450.00, 15),
('Disco de Freio', 180.00, 25),
('Filtro de Ar', 30.00, 60),
('Lâmpada H4', 20.00, 100);

INSERT INTO Servicos (descricao, valor_mao_obra) VALUES
('Troca de Óleo', 50.00),
('Alinhamento e Balanceamento', 100.00),
('Troca de Pastilhas', 80.00),
('Revisão Completa', 300.00),
('Troca de Amortecedores', 200.00),
('Limpeza de Bicos', 150.00),
('Troca de Correia', 250.00),
('Carga de Gás Ar Condicionado', 180.00),
('Troca de Bateria', 30.00),
('Diagnóstico Elétrico', 120.00);

INSERT INTO Ordem_Servico (id_veiculo, data_abertura, data_conclusao, status, valor_total) VALUES
(1, '2023-10-01 08:00:00', '2023-10-01 17:00:00', 'Concluída', 200.00),
(2, '2023-10-02 09:00:00', '2023-10-02 12:00:00', 'Concluída', 150.00),
(3, '2023-10-03 08:30:00', NULL, 'Em Andamento', NULL),
(4, '2023-10-04 10:00:00', '2023-10-05 15:00:00', 'Concluída', 500.00),
(5, '2023-10-05 14:00:00', NULL, 'Aguardando Peça', NULL),
(6, '2023-10-06 08:00:00', '2023-10-06 18:00:00', 'Concluída', 800.00),
(7, '2023-10-07 11:00:00', NULL, 'Aberta', NULL),
(8, '2023-10-08 09:30:00', '2023-10-08 11:30:00', 'Concluída', 100.00),
(9, '2023-10-09 13:00:00', NULL, 'Em Andamento', NULL),
(10, '2023-10-10 15:00:00', NULL, 'Aberta', NULL);

INSERT INTO OS_Servicos (id_os, id_servico, obs) VALUES
(1, 1, 'Óleo sintético'),
(1, 2, NULL),
(2, 3, 'Dianteiras'),
(3, 4, '10 mil km'),
(4, 5, NULL),
(5, 7, 'Urgente'),
(6, 4, '50 mil km'),
(6, 8, NULL),
(7, 10, 'Falha painel'),
(8, 1, 'Mineral'),
(9, 6, NULL),
(10, 9, 'Bateria arriada');

INSERT INTO OS_Pecas (id_os, id_peca, quantidade) VALUES
(1, 1, 4),
(1, 2, 1),
(2, 3, 1),
(4, 4, 2),
(5, 6, 1),
(6, 1, 4),
(6, 2, 1),
(6, 9, 1),
(8, 1, 3),
(10, 7, 1);

INSERT INTO OS_Mecanicos (id_os, id_mecanico) VALUES
(1, 1),
(2, 4),
(3, 1),
(4, 2),
(4, 9),
(5, 1),
(6, 5),
(7, 3),
(8, 8),
(9, 6);


-- 1. SELECT (Consultas Básicas)

SELECT * FROM Veiculos WHERE marca = 'Ford';
SELECT DISTINCT c.nome, c.telefone FROM Clientes c JOIN Veiculos v ON c.id_cliente = v.id_cliente JOIN Ordem_Servico os ON v.id_veiculo = os.id_veiculo WHERE os.data_abertura >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
SELECT * FROM Mecanicos WHERE especialidade = 'Injeção Eletrônica';
SELECT * FROM Ordem_Servico WHERE status = 'Aguardando Peça';
SELECT * FROM Pecas WHERE estoque < 30;
SELECT v.id_veiculo, v.modelo, v.placa FROM Veiculos v WHERE (SELECT COUNT(*) FROM Ordem_Servico os WHERE os.id_veiculo = v.id_veiculo) > 1;
SELECT os.id_os, os.data_abertura, os.status, m.nome AS nome_mecanico FROM Ordem_Servico os JOIN OS_Mecanicos osm ON os.id_os = osm.id_os JOIN Mecanicos m ON osm.id_mecanico = m.id_mecanico WHERE m.id_mecanico = 3;

-- Desafio 
SELECT nome, preco_unitario FROM Pecas WHERE preco_unitario > 200.00;

-- 2. UPDATE (Atualização de Dados)

UPDATE Pecas SET preco_unitario = preco_unitario * 1.05 WHERE id_peca = 2;
UPDATE Ordem_Servico SET status = 'Concluída', data_conclusao = NOW() WHERE id_os = 3;
UPDATE Ordem_Servico SET data_conclusao = CURDATE() WHERE status = 'Em Andamento' AND data_abertura < DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- Desafio
UPDATE Pecas SET estoque = estoque * 2 WHERE id_peca = 9;

-- 3. ALTER TABLE (Modificação da Estrutura)

ALTER TABLE Clientes ADD COLUMN email VARCHAR(100);
ALTER TABLE Mecanicos MODIFY COLUMN especialidade VARCHAR(150);
ALTER TABLE Ordem_Servico DROP COLUMN status;
ALTER TABLE Ordem_Servico ADD COLUMN teste_apagar VARCHAR(10);
ALTER TABLE Ordem_Servico DROP COLUMN teste_apagar;

-- Desafio 
ALTER TABLE Pecas ADD CONSTRAINT chk_preco_venda CHECK (preco_unitario >= 0);

-- 4. JOIN (Consultas com Múltiplas Tabelas)

SELECT os.id_os, c.nome AS Nome_Cliente, v.placa, os.data_aberturaFROM Ordem_Servico os JOIN Veiculos v ON os.id_veiculo = v.id_veiculo JOIN Clientes c ON v.id_cliente = c.id_cliente;

SELECT p.nome AS Nome_Peca, osp.quantidade
FROM OS_Pecas osp
JOIN Pecas p ON osp.id_peca = p.id_peca
WHERE osp.id_os = 5;
SELECT m.nome AS Nome_Mecanico
FROM OS_Mecanicos osm
JOIN Mecanicos m ON osm.id_mecanico = m.id_mecanico
WHERE osm.id_os = 6;

-- Desafio
SELECT v.placa, v.modelo, c.nome AS Proprietario
FROM Veiculos v
JOIN Clientes c ON v.id_cliente = c.id_cliente;

-- 5. INNER JOIN (Apenas Interseções)

SELECT v.placa, v.modelo
FROM Veiculos v
INNER JOIN Ordem_Servico os ON v.id_veiculo = os.id_veiculo
WHERE os.status = 'Em Andamento';

SELECT DISTINCT c.nome AS Nome_Cliente
FROM Clientes c
INNER JOIN Veiculos v ON c.id_cliente = v.id_cliente
WHERE v.marca = 'Ford';

SELECT DISTINCT m.nome AS Nome_Mecanico
FROM Mecanicos m
INNER JOIN OS_Mecanicos osm ON m.id_mecanico = osm.id_mecanico;

-- Desafio
SELECT DISTINCT s.descricao AS Nome_Servico
FROM Servicos s
INNER JOIN OS_Servicos oss ON s.id_servico = oss.id_servico;

-- 6. LEFT JOIN (Priorizando a Esquerda)


SELECT c.nome AS Nome_Cliente, os.id_os
FROM Clientes c
LEFT JOIN Veiculos v ON c.id_cliente = v.id_cliente
LEFT JOIN Ordem_Servico os ON v.id_veiculo = os.id_veiculo
ORDER BY c.nome;

SELECT m.nome AS Nome_Mecanico, COUNT(osm.id_os) AS Qtd_OS
FROM Mecanicos m
LEFT JOIN OS_Mecanicos osm ON m.id_mecanico = osm.id_mecanico
GROUP BY m.nome
ORDER BY Qtd_OS DESC;

SELECT p.nome AS Nome_Peca, SUM(osp.quantidade) AS Total_Vendido
FROM Pecas p
LEFT JOIN OS_Pecas osp ON p.id_peca = osp.id_peca
GROUP BY p.nome
ORDER BY Total_Vendido DESC,NULLS,LAST;

-- Desafio
SELECT v.placa, v.modelo, MAX(os.data_abertura) AS Ultima_OS
FROM Veiculos v
LEFT JOIN Ordem_Servico os ON v.id_veiculo = os.id_veiculo
GROUP BY v.id_veiculo, v.placa, v.modelo
ORDER BY Ultima_OS DESC,NULLS ,LAST;

-- 7. RIGHT JOIN (Priorizando a Direita)


SELECT os.id_os, c.nome AS Nome_Cliente
FROM Veiculos v
JOIN Clientes c ON v.id_cliente = c.id_cliente
RIGHT JOIN Ordem_Servico os ON v.id_veiculo = os.id_veiculo;

SELECT s.descricao AS Nome_Servico, oss.id_os
FROM OS_Servicos oss
RIGHT JOIN Servicos s ON oss.id_servico = s.id_servico
ORDER BY s.descricao;

SELECT osm.id_os, m.nome AS Nome_Mecanico
FROM OS_Mecanicos osm
INNER JOIN Mecanicos m ON osm.id_mecanico = m.id_mecanico;

-- Desafio
SELECT v.placa, v.modelo, os.id_os
FROM Ordem_Servico os
RIGHT JOIN Veiculos v ON os.id_veiculo = v.id_veiculo;

-- 8. Subconsultas (Subqueries)


SELECT nome
FROM Clientes
WHERE id_cliente IN (
SELECT v.id_cliente
FROM Veiculos v
JOIN Ordem_Servico os ON v.id_veiculo = os.id_veiculo
GROUP BY v.id_cliente
HAVING COUNT(os.id_os) > 1
);

SELECT nome
FROM Pecas
WHERE id_peca IN (
SELECT id_peca
FROM OS_Pecas
WHERE id_os IN (
SELECT id_os
FROM OS_Mecanicos
WHERE id_mecanico = 4
)
);
SELECT placa, modelo
FROM Veiculos
WHERE id_veiculo NOT IN (
SELECT DISTINCT id_veiculo
FROM Ordem_Servico
);

-- Desafio
SELECT descricao, valor_mao_obra
FROM Servicos
WHERE valor_mao_obra > (
SELECT AVG(valor_mao_obra)
FROM Servicos
);

-- 9. Agregação (SUM, COUNT, AVG, GROUP BY)

-- 9.1 Agregações Simples
SELECT COUNT(*) AS Total_Veiculos FROM Veiculos;
SELECT SUM(estoque * preco_unitario) AS Valor_Total_Estoque FROM Pecas;
SELECT AVG(valor_mao_obra) AS Preco_Medio_Mao_Obra FROM Servicos;
SELECT 
    (SELECT COALESCE(SUM(s.valor_mao_obra), 0) 
     FROM OS_Servicos oss 
     JOIN Servicos s ON oss.id_servico = s.id_servico 
     WHERE oss.id_os = 1) 
    +
    (SELECT COALESCE(SUM(p.preco_unitario * osp.quantidade), 0) 
     FROM OS_Pecas osp 
     JOIN Pecas p ON osp.id_peca = p.id_peca 
     WHERE osp.id_os = 1) 
    AS Faturamento_Total_OS_1;

-- 9.2 Agregações com Agrupamento (GROUP BY)
SELECT marca, COUNT(*) AS Quantidade FROM Veiculos GROUP BY marca ORDER BY Quantidade DESC;
SELECT YEAR(data_abertura) AS Ano, MONTH(data_abertura) AS Mes, COUNT(id_os) AS Total_OS 
FROM Ordem_Servico GROUP BY Ano, Mes ORDER BY Ano, Mes;
SELECT status, COUNT(id_os) AS Total_Por_Status FROM Ordem_Servico GROUP BY status;
SELECT AVG(DATEDIFF(data_conclusao, data_abertura)) AS Media_Dias_Abertos
FROM Ordem_Servico
WHERE data_conclusao IS NOT NULL;

-- 9.3 Agregações com Filtros (WHERE)
SELECT COUNT(id_os) AS Total_OS_Concluidas FROM Ordem_Servico WHERE status = 'Concluída';
SELECT SUM(os.valor_total) AS Faturamento_Ford 
FROM Ordem_Servico os JOIN Veiculos v ON os.id_veiculo = v.id_veiculo 
WHERE v.marca = 'Ford' AND os.valor_total IS NOT NULL;
SELECT AVG(valor_mao_obra) AS Media_Servicos_Oleos FROM Servicos WHERE descricao LIKE '%Óleo%';


-- 9.4 Agregações com Condições Complexas (HAVING)
SELECT c.nome, SUM(os.valor_total) AS Total_Gasto 
FROM Ordem_Servico os JOIN Veiculos v ON os.id_veiculo = v.id_veiculo JOIN Clientes c ON v.id_cliente = c.id_cliente 
GROUP BY c.nome 
HAVING SUM(os.valor_total) > 500.00 
ORDER BY Total_Gasto DESC;

SELECT p.nome, SUM(osp.quantidade) AS Total_Vendido 
FROM OS_Pecas osp JOIN Pecas p ON osp.id_peca = p.id_peca 
GROUP BY p.nome 
HAVING SUM(osp.quantidade) > 3 
ORDER BY Total_Vendido DESC;

SELECT m.especialidade, COUNT(osm.id_os) AS Total_OS 
FROM Mecanicos m JOIN OS_Mecanicos osm ON m.id_mecanico = osm.id_mecanico 
GROUP BY m.especialidade 
HAVING COUNT(osm.id_os) > 1 
ORDER BY Total_OS DESC;

-- Desafio
SELECT m.nome, COUNT(osm.id_os) AS Total_OS 
FROM Mecanicos m JOIN OS_Mecanicos osm ON m.id_mecanico = osm.id_mecanico 
GROUP BY m.nome 
ORDER BY Total_OS,DESC 
LIMIT 1;

-- 10. Indexação

CREATE UNIQUE INDEX idx_veiculos_placa ON Veiculos (placa);
CREATE INDEX idx_os_id_veiculo ON Ordem_Servico (id_veiculo);

-- Resposta 1: O JOIN é rápido porque o banco de dados não precisa ler a tabela inteirapara achar os veículos correspondentes a uma OS. Ele vai direto ao endereço de memória apontado pelo índice.

-- Desafio: O que é um índice composto e por que ele é eficiente para (id_os, id_peca)?
-- Resposta: Um índice composto é um índice criado sobre duas ou mais colunas juntas. Na tabela OS_Pecas, a chave primária é composta (id_os, id_peca). Ele é eficiente porque o banco organiza os dados primeiro pelo id_os e, dentro dele, pelo id_peca. Isso permite encontrar instantaneamente uma peça específica dentro de uma OS específica, sem precisar cruzar dados duas vezes.
