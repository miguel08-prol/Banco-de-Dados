create database Empresa_Solar;

use Empresa_Solar;

CREATE TABLE Clientes (
id_cliente int not null PRIMARY KEY,
Nome_cliente varchar(100)
);

CREATE TABLE Produtos (
Nome_Produto varchar(200) not null,
id_produto int not null PRIMARY KEY
);

CREATE TABLE Comprar (
id_compra int AUTO_INCREMENT PRIMARY KEY not null,
id_cliente int ,
id_produto int,
FOREIGN KEY(id_produto) REFERENCES Produtos (id_produto),
FOREIGN KEY(id_cliente) REFERENCES Clientes (id_cliente)
);

create table Vendedor(
id_vendedor int auto_increment primary key,
nome_vendedor varchar(100),
salario decimal(7,2),
fsalarial char(2)
);

drop table Vendedor;


insert into Clientes (Nome_Cliente) values ('Miguel');
insert into Produtos values (2,'Teclado');
insert into Vendedor (nome_vendedor,salario,fsalarial) values ('Miguel',5.000,1);
insert into Vendedor (nome_vendedor,salario,fsalarial) values ('Miguel',500.9,2);
insert into Vendedor (nome_vendedor,salario,fsalarial) values ('Miguel',50000.9,2);
insert into Vendedor (nome_vendedor,salario,fsalarial) values ('Miguel',5000.9,2);

update Produtos set Nome_Produto = 'Monitor' where id_produto = 1;
update Vendedor set salario = 3000 where fsalarial = 2;
update Vendedor set salario = salario * 0.1 where fsalarial = 1;

select * from Produtos;
select * from Vendedor;





