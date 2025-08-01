create database Pizzaria;

use Pizzaria;

create table Cliente(
id_cliente int primary key
);

create table Funcionario(
id_Funcionario int primary key
);

create table Pizza(
Sabores int primary key
);

create table Ingredientes(
Tipo int primary key
);

create table Vendas(
Saldo int primary key
);

create table Entrega(
Endereço int primary key
);