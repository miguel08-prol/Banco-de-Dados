CREATE DATABASE OficinaMecanica;
USE OficinaMecanica;

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

select * from Veiculos where marca = "Ford";
select distinct c.id_cliente, c.nome,c.telefone from Clientes c inner join Veiculos v on c.id_cliente = v.id_cliente inner join Ordem_Servico os on v.id_veiculo = os.id_veiculo where os.data_abertura >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
select * from Mecanicos where especialidade = "Injeção Eletrônica";
select * from Ordem_Servico where status = "Aguardando Peça";
select * from Pecas where estoque < 30;
select v.id_veiculo,v.modelo,v.placa from Veiculos v where (select count(*) from Ordem_Servico os where os.id_veiculo) > 1;
select m.nome as nome_mecanico,os.id_os,os.data_abertura,os.status from Ordem_Servico os inner join OS_Mecanicos osm on os.id_os = osm.id_os inner join Mecanicos m on osm.id_mecanico = m.id_mecanico where m.id_mecanico = 3;
-- Desafio
select nome,preco_unitario from Pecas where preco_unitario > 200.00;

-- 2. UPDATE (Atualização de Dados)
update Pecas set preco_unitario = preco_unitario * 1.05 where nome = 'Bosch';
