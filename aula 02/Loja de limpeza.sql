create database Loja_limpeza

use Loja_limpeza;

create table  funcionario (
CPF varchar(14),
cargo varchar(150),
Salario decimal,
RG varchar(15),
id_funcionario int primary key,
Nome_funcionario varchar(100),
data_nascimento date
);

create table  Serviços (
code_servico int primary key,
valor_servico decimal,
observacao varchar(255),
agendamento datetime,
tipos_servico varchar(100)
);

create table  Cliente (
RG varchar(15),
Nome_cliente varchar(100),
CPF varchar(14),
data_nascimento date,
preferencia varchar(30),
id_cliente int primary key
);

create table  Produtos (
code_produto int primary key,
valor_produto decimal,
fornecedor_produto varchar(255),
tipos_produto varchar(100),
imagem blob
);

create table  manuteção (
id_manutecao int primary key,
data_manutecao datetime,
observacao varchar(255),
dados_cliente varchar(255),
endereco varchar(200),
tipo_manutecao varchar(100)
);



