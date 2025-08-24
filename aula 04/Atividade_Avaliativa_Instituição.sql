create database Instituição;

use Instituição;

create table Fornecedor (
Fcodigo int primary key not null,
Fname varchar(100) not null,
FStatus varchar(35) default"Ativo",
Cidade varchar(50) not null
);

create table Peça (
Pcodigo int primary key not null,
Fname varchar(200) not null,
Cor varchar(20) not null,
Peso varchar(50) not null,
Cidade varchar(100) not null
);

create table Fornecimento (
Fcod int primary key not null,
Pcod int null,
PRcod int not null,
Quantidade int 
);

create table instituição2 (
Icodigo int primary key not null,
Iname varchar(200) not null
);

create table Projeto (
PRnome varchar(100) not null,
PRcod int not null,
cod int primary key
);

drop table instituição2

CREATE TABLE Cidade (
    Ccod INT PRIMARY KEY,
    Cnome VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL
);

alter table Fornecedor 
change Cidade Fone VARCHAR(20);
add Ccod INT;

alter table Peça
change Cidade Ccod INT NOT NULL;

alter table Projeto
drop Cidade;



