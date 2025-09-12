-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE Clientes (
id_cliente int not null PRIMARY KEY,
Nome_cliente varchar(100)
)

CREATE TABLE Produtos (
Nome_Produto varchar(200) not null,
id_produto int not null PRIMARY KEY
)

CREATE TABLE Comprar (
id_compra int AUTO_INCREMENT PRIMARY KEY not null,
id_cliente int ,
id_produto int,
FOREIGN KEY(id_Produto) REFERENCES Produtos (id_produto)
FOREIGN KEY(id_cliente) REFERENCES Clientes (id_cliente)
)

