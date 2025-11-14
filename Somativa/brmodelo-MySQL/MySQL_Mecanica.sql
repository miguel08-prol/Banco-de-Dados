CREATE DATABASE Mecanica;
USE Mecanica;

CREATE TABLE Cliente (
    id_cliente INT NOT NULL PRIMARY KEY,
    nome_cliente VARCHAR(150) NOT NULL,
    veiculo VARCHAR(100) NOT NULL,
    telefone VARCHAR(16) NOT NULL,
    CPF VARCHAR(14) NOT NULL,
    cod_cadastro INT NOT NULL
);

CREATE TABLE Fornecedor (
    id_fornecedor INT NOT NULL PRIMARY KEY,
    nome_fornecedor VARCHAR(100) NOT NULL,
    instituicao VARCHAR(150) NOT NULL,
    telefone VARCHAR(16) NOT NULL,
    email VARCHAR(150),
    CEP VARCHAR(14) NOT NULL
);

CREATE TABLE estoque (
    cod_produto INT NOT NULL,
    nome_produto VARCHAR(150),
    id_fornecedor INT NOT NULL,
    qtde_produto INT NOT NULL,
    id_estoque INT NOT NULL PRIMARY KEY
);

CREATE TABLE Servicos (
    cod_servico INT NOT NULL PRIMARY KEY,
    tipo_servico VARCHAR(90) NOT NULL,
    duracao VARCHAR(12) NOT NULL,
    descricao VARCHAR(100),
    preco DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Funcionario_Cadastrar (
    funcao VARCHAR(50) NOT NULL,
    id_funcionario INT NOT NULL,
    nome_funcionario VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) NOT NULL,
    telefone VARCHAR(16) NOT NULL,
    CEP VARCHAR(12),
    id_cliente INT NOT NULL, 
    cod_produto INT NOT NULL,
    cod_servico INT NOT NULL,
    marca_veiculo VARCHAR(100) NOT NULL,
    Observacao VARCHAR(200),
    cod_cadastro INT NOT NULL,
    placa_veiculo CHAR(7) NOT NULL,
    nome_cliente VARCHAR(100),
    nome_produto VARCHAR(100),
    servico VARCHAR(76),
    PRIMARY KEY(id_funcionario, cod_cadastro)
);

CREATE TABLE Produto (
    nome_produto VARCHAR(100) NOT NULL,
    descricao VARCHAR(200),
    preco DECIMAL(10, 2) NOT NULL,
    cod_produto INT NOT NULL PRIMARY KEY,
    id_fornecedor INT NOT NULL, 
    peso_produto VARCHAR(50) NOT NULL,
    id_estoque INT NOT NULL,
    FOREIGN KEY(id_estoque) REFERENCES estoque (id_estoque)
);

CREATE TABLE solicitado (
    cod_cadastro INT NOT NULL,
    cod_produto INT NOT NULL,
    id_funcionario INT NOT NULL,
    FOREIGN KEY(id_funcionario, cod_cadastro) REFERENCES Funcionario_Cadastrar (id_funcionario, cod_cadastro),
    FOREIGN KEY(cod_produto) REFERENCES Produto (cod_produto)
);

CREATE TABLE compra (
    cod_produto INT NOT NULL,
    id_cliente INT NOT NULL,
    FOREIGN KEY(cod_produto) REFERENCES Produto (cod_produto),
    FOREIGN KEY(id_cliente) REFERENCES Cliente (id_cliente)
);

CREATE TABLE realiza (
    cod_servico INT NOT NULL,
    id_funcionario INT NOT NULL,
    cod_cadastro INT NOT NULL,
    FOREIGN KEY(cod_servico) REFERENCES Servicos (cod_servico),
    FOREIGN KEY(id_funcionario, cod_cadastro) REFERENCES Funcionario_Cadastrar (id_funcionario, cod_cadastro)
);

CREATE TABLE fornece (
    id_fornecedor INT NOT NULL,
    cod_produto INT NOT NULL,
    FOREIGN KEY(id_fornecedor) REFERENCES Fornecedor (id_fornecedor),
    FOREIGN KEY(cod_produto) REFERENCES Produto (cod_produto)
);

CREATE TABLE depende (
    cod_servico INT NOT NULL,
    id_funcionario INT NOT NULL,
    cod_cadastro INT NOT NULL,
    FOREIGN KEY(cod_servico) REFERENCES Servicos (cod_servico),
    FOREIGN KEY(id_funcionario, cod_cadastro) REFERENCES Funcionario_Cadastrar (id_funcionario, cod_cadastro)
);


ALTER TABLE Cliente 
ADD FOREIGN KEY (cod_cadastro) REFERENCES Funcionario_Cadastrar (cod_cadastro);

ALTER TABLE Funcionario_Cadastrar 
ADD FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente);

ALTER TABLE Funcionario_Cadastrar 
ADD FOREIGN KEY (cod_produto) REFERENCES Produto (cod_produto);

ALTER TABLE Funcionario_Cadastrar 
ADD FOREIGN KEY (cod_servico) REFERENCES Servicos (cod_servico);

ALTER TABLE estoque 
ADD FOREIGN KEY (cod_produto) REFERENCES Produto (cod_produto);

ALTER TABLE estoque 
ADD FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor (id_fornecedor);

ALTER TABLE Produto 
ADD FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor (id_fornecedor);

INSERT INTO Servicos (cod_servico, tipo_servico, duracao, descricao, preco) VALUES
(101, 'Troca de Óleo e Filtro', '30 min', 'Óleo sintético 5W-30 e filtro de óleo padrão.', 180.00),
(102, 'Revisão Básica (21 itens)', '1h 30m', 'Verificação de fluidos, pneus, bateria e suspensão.', 280.00),
(103, 'Alinhamento e Balanceamento', '1h 15m', 'Ajuste da geometria da suspensão e balanceamento das rodas.', 150.00),
(104, 'Troca de Pastilhas de Freio', '1h 0m', 'Substituição das pastilhas dianteiras ou traseiras.', 120.00),
(105, 'Troca de Discos de Freio', '2h 0m', 'Substituição dos discos e limpeza do sistema.', 250.00),
(106, 'Revisão de Freios Completa', '3h 0m', 'Discos, pastilhas, fluido e limpeza.', 450.00),
(107, 'Troca de Embreagem', '6h 0m', 'Substituição completa do kit de embreagem.', 850.00),
(108, 'Diagnóstico Eletrônico', '45 min', 'Uso de scanner para identificar falhas no motor e câmbio.', 90.00),
(109, 'Limpeza de Bicos Injetores', '2h 30m', 'Limpeza e teste de estanqueidade dos bicos.', 160.00),
(110, 'Troca de Velas e Cabos', '1h 0m', 'Substituição do conjunto de velas e cabos de ignição.', 140.00),
(111, 'Substituição de Bateria', '15 min', 'Instalação de bateria nova e teste do alternador.', 50.00),
(112, 'Reparo de Pneus (Furo)', '30 min', 'Reparo simples em pneu furado.', 40.00),
(113, 'Troca de Correia Dentada', '4h 0m', 'Substituição da correia e tensor.', 600.00),
(114, 'Troca de Amortecedores', '3h 30m', 'Substituição dos 4 amortecedores e coxins.', 550.00),
(115, 'Revisão para Viagem', '2h 0m', 'Verificação completa de segurança e fluidos.', 320.00),
(116, 'Higienização de Ar Condicionado', '1h 0m', 'Limpeza do sistema e troca de filtro de cabine.', 110.00),
(117, 'Funilaria e Pintura (Pequeno Reparo)', '12h 0m', 'Avaliação e reparo de pequenos arranhões ou amassados.', 750.00),
(118, 'Instalação de Acessórios', '1h 0m', 'Instalação de rádio, sensor de ré ou câmera.', 100.00),
(119, 'Troca de Fluido de Freio', '45 min', 'Substituição completa do fluido.', 80.00),
(120, 'Lavagem Completa', '1h 30m', 'Lavagem detalhada da carroceria e interior.', 95.00);

INSERT INTO Fornecedor (id_fornecedor, nome_fornecedor, instituicao, telefone, email, CEP) VALUES
(100, 'Distribuidora Auto-Pecas', 'DAP Ltda', '(11) 9876-5432', 'contato@dap.com', '01000-000'),
(200, 'Ignicao Solutions', 'IS Autopeças', '(21) 1234-5678', 'vendas@is.com', '20000-000'),
(300, 'Pneus e Cia', 'P&C Matriz', '(31) 5555-4444', 'admin@pec.com', '30000-000');

INSERT INTO Produto (cod_produto, nome_produto, descricao, preco, id_fornecedor, peso_produto, id_estoque) VALUES
(1, 'Óleo 5W-30 Sintético', 'Balde de 1L, uso universal.', 35.00, 100, '1.0 kg', 1),
(2, 'Filtro de Óleo Universal', 'Compatível com 80% dos carros nacionais.', 15.00, 100, '0.3 kg', 2),
(3, 'Jogo de Velas Iridium', '4 unidades, alta performance.', 85.00, 200, '0.2 kg', 3),
(4, 'Jogo de Pastilhas Dianteiras', 'Cerâmica, baixo ruído.', 120.00, 100, '1.5 kg', 4),
(5, 'Disco de Freio Ventilado', 'Unidade, para rodas aro 15/16.', 95.00, 100, '5.0 kg', 5),
(6, 'Fluido de Freio DOT 4', 'Frasco de 500ml, alta temperatura.', 30.00, 100, '0.5 kg', 6),
(7, 'Pneu Aro 15 (185/65 R15)', 'Pneu de uso misto, 82T.', 350.00, 300, '7.5 kg', 7),
(8, 'Correia Dentada', 'Borracha reforçada, 107 dentes.', 55.00, 200, '0.15 kg', 8),
(9, 'Kit Amortecedor Dianteiro', 'Par de amortecedores a gás.', 280.00, 100, '10.0 kg', 9),
(10, 'Bateria 60 Amperes', 'Livre de manutenção, 12V.', 320.00, 200, '15.0 kg', 10),
(11, 'Aditivo para Radiador', 'Concentrado, base orgânica.', 45.00, 100, '1.0 kg', 11),
(12, 'Lâmpada Farol H4', 'Unidade, 60/55W padrão.', 18.00, 200, '0.05 kg', 12),
(13, 'Filtro de Ar do Motor', 'Elemento filtrante de papel.', 25.00, 100, '0.1 kg', 13),
(14, 'Filtro de Cabine (Ar Cond.)', 'Filtro anti-pólen.', 35.00, 100, '0.15 kg', 14),
(15, 'Cabo de Vela', 'Jogo completo de 4 cabos.', 65.00, 200, '0.4 kg', 15),
(16, 'Cera Automotiva', 'Cera líquida de carnaúba, 500ml.', 50.00, 300, '0.6 kg', 16),
(17, 'Palheta Limpador Pára-brisa', 'Par de palhetas 22 polegadas.', 40.00, 300, '0.3 kg', 17),
(18, 'Fusível Kit Sortido', 'Caixa com 50 fusíveis de 5A a 30A.', 22.00, 200, '0.1 kg', 18),
(19, 'Saca Filtro de Óleo', 'Ferramenta de metal.', 45.00, 300, '0.5 kg', 19),
(20, 'Kit de Reparo de Pneu', 'Selante e reparador rápido.', 70.00, 300, '0.8 kg', 20);


INSERT INTO estoque (id_estoque, cod_produto, nome_produto, id_fornecedor, qtde_produto) VALUES
(1, 1, 'Óleo 5W-30 Sintético', 100, 250),
(2, 2, 'Filtro de Óleo Universal', 100, 300),
(3, 3, 'Jogo de Velas Iridium', 200, 80),
(4, 4, 'Jogo de Pastilhas Dianteiras', 100, 150),
(5, 5, 'Disco de Freio Ventilado', 100, 90),
(6, 6, 'Fluido de Freio DOT 4', 100, 180),
(7, 7, 'Pneu Aro 15 (185/65 R15)', 300, 45),
(8, 8, 'Correia Dentada', 200, 70),
(9, 9, 'Kit Amortecedor Dianteiro', 100, 35),
(10, 10, 'Bateria 60 Amperes', 200, 50),
(11, 11, 'Aditivo para Radiador', 100, 210),
(12, 12, 'Lâmpada Farol H4', 200, 400),
(13, 13, 'Filtro de Ar do Motor', 100, 190),
(14, 14, 'Filtro de Cabine (Ar Cond.)', 100, 160),
(15, 15, 'Cabo de Vela', 200, 75),
(16, 16, 'Cera Automotiva', 300, 120),
(17, 17, 'Palheta Limpador Pára-brisa', 300, 100),
(18, 18, 'Fusível Kit Sortido', 200, 60),
(19, 19, 'Saca Filtro de Óleo', 300, 25),
(20, 20, 'Kit de Reparo de Pneu', 300, 85);