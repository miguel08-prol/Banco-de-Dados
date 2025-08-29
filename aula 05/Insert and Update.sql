create database Remoterc;

use Remoterc;

create table Produto(
Cprod int,
Descricao varchar(255),
Peso char(2),
ValorUnit decimal 
);
 
insert into Produto (Cprod,Descricao,Peso,ValorUnit) values(1,'Teclado','kg',35.00);
insert into Produto values(2,'Mouse','kg',25.00);
insert into Produto values(3,'HD','kg',350.00);

create table Vendedor(
Cvend int primary key,
Nome varchar(100),
Salario decimal(7.2),
Fsalario int
);

insert into Vendedor values(1,'Ronaldo',3512.00,1);
insert into Vendedor values(2,'Robertso',3225.00,2);
insert into Vendedor values(3,'Clodoaldo',4350.00,3);

create table Cliente(
Ccli int primary key,
Nome varchar(100) not null,
Endereco varchar(100),
Cidade varchar(150),
UF char(4)
);
 
insert into Cliente values(11,'Bruno','Rua1456' ,'Rio Claro','SP');
insert into Cliente values(12,'Cláudio','Rua Quadrada 234','Campinas','SP');
insert into Cliente values(13,'Cremilda','Rua das Flores 666','São Paulo','SP');

SELECT * FROM remoterc.cliente;

set Sql_Safe_Updates = 0;
Update Vendedor set Salario = 3150.00 where Fsalario = 1;
Update Vendedor set Salario = Salario * 1.10 where Fsalario = 2;
Update Vendedor set Salario = 3150.00 where Fsalario = 3;
