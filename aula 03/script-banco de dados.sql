create database solar;

use solar;

create table if not exists fornecedor (
id_fornecedor int not null primary key,
nome_fornecedor varchar(100),
CNPJ varchar(18) not null,
endereco varchar(100) not null,
celular varchar(19) not null,
estado char(2) default 'SP' not null
);

create table venda (
code_venda int primary key auto_increment not null,
code_produto int not null,
id_fornecedor int not null,
foreign key (code_produto) references produto (code_produto),
foreign key (id_fornecedor) references fornecedor (id_fornecedor)
);

create table if not exists produto (
code_produto int not null primary key,
nome_produto varchar(100),
qtde decimal,
descricao varchar(100),
valor decimal);

create table if not exists cliente (
code_cliente int not null primary key,
nome_clente varchar(100),
CPF varchar(14) not null,
endereco varchar(100) not null,
celular varchar(19)not null);

create table compra (
code_compra int primary key auto_increment not null,
code_produto int not null,
code_cliente int not null,
foreign key (code_produto) references produto (code_produto),
foreign key (code_cliente) references cliente (code_cliente)
);

create table funcionario (
code_funcionario int primary key not null,
nome_funcionario varchar(100) not null,
code_cliente int not null,
CPF varchar(14)
);

create table departamento(
id_departamento int primary key not null,
nome_departamento varchar(100),
funcao varchar(25),
responsavel varchar(50)
);

create table funcao (
code_funcao int primary key auto_increment not null,
code_funcionario int not null,
id_departamento int not null,
foreign key (code_funcionario) references funcionario (code_funcionario),
foreign key (id_departamento) references departamento (id_departamento) 
);

-- Consultar tabela Funionarios
select * from empregado;

-- Alterações em tabelas
alter table empregado 
add data_nascimento datetime,
add setor varchar(45),
add estado char(2) default 'SP' not null ;

-- Apagar coluna
alter table funcionario
drop column sexo;

-- Renomear a tabela
alter table funcionario
rename to empregado;

alter table empregado
change CPF CIC_funcionario varchar(18);

alter table empregado 
modify column estado char(2) default 'MG';

alter table empregado 
modify column nome_funcionario varchar(200);

alter table empregado 
add primary key (CIC_funcionario);