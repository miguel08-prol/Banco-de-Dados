CREATE DATABASE Livraria;

USE Livraria;

-- Tabela Cliente
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) NOT NULL UNIQUE,
    data_nascimento DATETIME,
    telefone VARCHAR(9),
    email VARCHAR(100)
);

-- Tabela Autores
CREATE TABLE Autores (
    cod_autor INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nome_autor VARCHAR(100) NOT NULL,
    data_nascimento DATETIME,
    nacio_autor VARCHAR(50) NOT NULL
);

-- Tabela Editores
CREATE TABLE Editores (
    id_editora INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nome_editora VARCHAR(100) NOT NULL,
    CNPJ VARCHAR(14) NOT NULL UNIQUE,
    endereco VARCHAR(200) NOT NULL,
    cidade VARCHAR(200) NOT NULL,
    telefone VARCHAR(9),
    contato VARCHAR(20) NOT NULL
);

-- Tabela Livros
CREATE TABLE Livros (
    cod_livro INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    titulo VARCHAR(70) NOT NULL,
    genero VARCHAR(100) NOT NULL,
    preco DECIMAL(7, 2) NOT NULL,
    qtd DECIMAL(10, 0) NOT NULL
);

-- Tabela Vendas
CREATE TABLE Vendas (
    cod_venda INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    data_venda DATETIME NOT NULL,
    nome_cliente VARCHAR(100) NOT NULL,
    titulo VARCHAR(100),
    qtd DECIMAL(6, 0) NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL
);

-- Tabelas de Relacionamento (Chaves Estrangeiras)
CREATE TABLE Comprar (
    cod_venda INT NOT NULL,
    id_cliente INT NOT NULL,
    PRIMARY KEY (cod_venda, id_cliente),
    CONSTRAINT fk_comprar_vendas FOREIGN KEY (cod_venda) REFERENCES Vendas (cod_venda),
    CONSTRAINT fk_comprar_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente)
);

CREATE TABLE direcionar (
    id_cliente INT NOT NULL,
    cod_livro INT NOT NULL,
    PRIMARY KEY (id_cliente, cod_livro),
    CONSTRAINT fk_direcionar_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente),
    CONSTRAINT fk_direcionar_livros FOREIGN KEY (cod_livro) REFERENCES Livros (cod_livro)
);

CREATE TABLE Publicar (
    id_editora INT NOT NULL,
    cod_livro INT NOT NULL,
    PRIMARY KEY (id_editora, cod_livro),
    CONSTRAINT fk_publicar_editores FOREIGN KEY (id_editora) REFERENCES Editores (id_editora),
    CONSTRAINT fk_publicar_livros FOREIGN KEY (cod_livro) REFERENCES Livros (cod_livro)
);

CREATE TABLE Escrever (
    cod_livro INT NOT NULL,
    cod_autor INT NOT NULL,
    PRIMARY KEY (cod_livro, cod_autor),
    CONSTRAINT fk_escrever_livros FOREIGN KEY (cod_livro) REFERENCES Livros (cod_livro),
    CONSTRAINT fk_escrever_autores FOREIGN KEY (cod_autor) REFERENCES Autores (cod_autor)
);


-- Inserindo dados nas tabelas principais
INSERT INTO Cliente (nome_cliente, CPF, data_nascimento, telefone, email) VALUES
('João Silva', '123.456.789-01', '1985-05-15', '987654321', 'joao.silva@email.com'),
('Maria Oliveira', '987.654.321-02', '1990-10-22', '912345678', 'maria.oliveira@email.com'),
('Pedro Souza', '456.789.012-03', '1978-02-10', '987651234', 'pedro.souza@email.com'),
('Ana Costa', '789.012.345-04', '1995-12-03', '912349876', 'ana.costa@email.com'),
('Carlos Pereira', '012.345.678-05', '1982-07-28', '998765432', 'carlos.pereira@email.com'),
('Juliana Santos', '345.678.901-06', '2001-04-19', '976543210', 'juliana.santos@email.com'),
('Felipe Lima', '678.901.234-07', '1975-09-08', '912987654', 'felipe.lima@email.com'),
('Bianca Gomes', '901.234.567-08', '1992-06-25', '987123456', 'bianca.gomes@email.com');

INSERT INTO Autores (nome_autor, data_nascimento, nacio_autor) VALUES
('Machado de Assis', '1839-06-21', 'Brasileiro'),
('Clarice Lispector', '1920-12-10', 'Brasileira'),
('J.R.R. Tolkien', '1892-01-03', 'Britânico'),
('J.K. Rowling', '1965-07-31', 'Britânica'),
('George Orwell', '1903-06-25', 'Britânico'),
('Stephen King', '1947-09-21', 'Americano'),
('Gabriel García Márquez', '1927-03-06', 'Colombiano'),
('Jane Austen', '1775-12-16', 'Britânica');

INSERT INTO Editores (nome_editora, CNPJ, endereco, cidade, telefone, contato) VALUES
('Companhia das Letras', '01234567890123', 'Rua São Paulo, 100', 'São Paulo', '987654321', 'Maria Clara'),
('Editora Record', '12345678901234', 'Avenida Rio Branco, 250', 'Rio de Janeiro', '912345678', 'Pedro Henrique'),
('Suma', '23456789012345', 'Rua das Flores, 50', 'Belo Horizonte', '987651234', 'Ana Luiza'),
('Editora Rocco', '34567890123456', 'Rua dos Pinheiros, 75', 'São Paulo', '912349876', 'João Carlos'),
('Intrínseca', '45678901234567', 'Rua da Consolação, 200', 'São Paulo', '998765432', 'Felipe Santos'),
('Editora Aleph', '56789012345678', 'Avenida Paulista, 1500', 'São Paulo', '976543210', 'Camila Martins'),
('Editora Arqueiro', '67890123456789', 'Rua Augusta, 120', 'São Paulo', '912987654', 'Lucas Ferreira'),
('Penguin Companhia', '78901234567890', 'Rua dos Mercadores, 30', 'Rio de Janeiro', '987123456', 'Laura Mendes');

INSERT INTO Livros (titulo, genero, preco, qtd) VALUES
('Dom Casmurro', 'Romance', 45.50, 50),
('A Hora da Estrela', 'Ficção', 35.00, 75),
('O Senhor dos Anéis', 'Fantasia', 89.90, 120),
('Harry Potter e a Pedra Filosofal', 'Fantasia', 55.75, 200),
('1984', 'Ficção Científica', 49.90, 90),
('O Iluminado', 'Terror', 65.00, 60),
('Cem Anos de Solidão', 'Realismo Mágico', 78.50, 45),
('Orgulho e Preconceito', 'Romance', 42.00, 85);

INSERT INTO Vendas (data_venda, nome_cliente, titulo, qtd, valor_total) VALUES
('2024-03-10', 'João Silva', 'Dom Casmurro', 1, 45.50),
('2024-03-11', 'Maria Oliveira', 'O Senhor dos Anéis', 1, 89.90),
('2024-03-12', 'Ana Costa', 'Harry Potter e a Pedra Filosofal', 2, 111.50),
('2024-03-12', 'Pedro Souza', '1984', 1, 49.90),
('2024-03-13', 'Carlos Pereira', 'A Hora da Estrela', 1, 35.00),
('2024-03-14', 'Juliana Santos', 'O Iluminado', 1, 65.00),
('2024-03-15', 'Felipe Lima', 'Cem Anos de Solidão', 1, 78.50),
('2024-03-16', 'Bianca Gomes', 'Orgulho e Preconceito', 1, 42.00);


-- Inserindo dados nas tabelas de relacionamento
INSERT INTO Comprar (cod_venda, id_cliente) VALUES
(1, 1), (2, 2), (3, 4), (4, 3), (5, 5), (6, 6), (7, 7), (8, 8);

INSERT INTO direcionar (id_cliente, cod_livro) VALUES
(1, 1), (2, 3), (3, 5), (4, 4), (5, 2), (6, 6), (7, 7), (8, 8);

INSERT INTO Publicar (id_editora, cod_livro) VALUES
(1, 1), (1, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8);

INSERT INTO Escrever (cod_livro, cod_autor) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8);

-- Consultas --
select * from Livros;

select titulo,preco from Livros;

-- Consultas por Titulo,preco > 20 --
select titulo, preco from Livros where preco < 20;

-- Consultas por titulo e preco em ordem decrecente 
select titulo,preco from Livros order by preco desc;

-- Limitar consultas por valor de quantidade
-- Apresentadas 
select titulo from Livros limit 5;

-- Renomear colunas com as 
select titulo as nome,preco as ano from Livros;

-- Consultas Agregadas 
select count(*) as total_livros from Livros;

-- Consultas com joins 
select Livros,titulo,Autores.nome from livros 
join Autores on Livros.id_autor =  Autores.id_Autor;

-- Consulta por agrupamento group by
select titulo, count(*) as qtd from Livros group by titulo;

