CREATE DATABASE Livraria;

USE Livraria;

CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) NOT NULL UNIQUE,
    data_nascimento DATETIME,
    telefone VARCHAR(9),
    email VARCHAR(100)
);

CREATE TABLE Autores (
    cod_autor INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nome_autor VARCHAR(100) NOT NULL,
    data_nascimento DATETIME,
    nacio_autor VARCHAR(50) NOT NULL
);

CREATE TABLE Editores (
    id_editora INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nome_editora VARCHAR(100) NOT NULL,
    CNPJ VARCHAR(14) NOT NULL UNIQUE,
    endereco VARCHAR(200) NOT NULL,
    cidade VARCHAR(200) NOT NULL,
    telefone VARCHAR(9),
    contato VARCHAR(20) NOT NULL
);

CREATE TABLE Livros (
    cod_livro INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    titulo VARCHAR(70) NOT NULL,
    genero VARCHAR(100) NOT NULL,
    preco DECIMAL(7, 2) NOT NULL,
    qtd DECIMAL(10, 0) NOT NULL
);

CREATE TABLE Vendas (
    cod_venda INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    data_venda DATETIME NOT NULL,
    nome_cliente VARCHAR(100) NOT NULL,
    titulo VARCHAR(100),
    qtd DECIMAL(6, 0) NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL
);

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