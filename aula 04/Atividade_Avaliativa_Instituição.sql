create database Instituição;

use Instituição;

create table Fornecedor (
    Fcodigo int primary key not null,
    Fname varchar(100) not null,
    FStatus varchar(35) default 'Ativo',
    Cidade varchar(50) not null
);

create table Peça (
    Pcodigo int primary key not null,
    Pname varchar(200) not null,
    Cor varchar(20) not null,
    Peso varchar(50) not null,
    Cidade varchar(100) not null
);

create table Fornecimento (
    Fcod int not null,
    Pcod int not null,
    PRcod int not null,
    Quantidade int,
    PRIMARY KEY (Fcod, Pcod, PRcod)
);

create table instituição2 (
    Icodigo int primary key not null,
    Iname varchar(200) not null
);

create table Projeto (
    PRnome varchar(100) not null,
    PRcod int primary key not null,
    cod int
);

drop table instituição2;

CREATE TABLE Cidade (
    Ccod INT PRIMARY KEY,
    Cnome VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL
);

alter table Fornecedor
    change Cidade Fone VARCHAR(20);

alter table Fornecedor
    add Ccod INT;

alter table Peça
    change Cidade Ccod INT NOT NULL;

alter table Projeto
    drop Cidade;

ALTER TABLE Fornecedor ADD FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);
ALTER TABLE Peça ADD FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);
ALTER TABLE Projeto ADD FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);

ALTER TABLE Fornecimento create database Instituição;

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

CREATE INDEX idx_fornecedor_ccod ON Fornecedor(Ccod);
CREATE INDEX idx_peca_ccod ON Peca(Ccod);
CREATE INDEX idx_projeto_ccod ON Projeto(Ccod);

ALTER TABLE Fornecedor ADD FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);
ALTER TABLE Peça ADD FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);
ALTER TABLE Projeto ADD FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);

ALTER TABLE Fornecimento ADD FOREIGN KEY (Fcod) REFERENCES Fornecedor(Fcodigo);
ALTER TABLE Fornecimento ADD FOREIGN KEY (Pcod) REFERENCES Peça(Pcodigo);
ALTER TABLE Fornecimento ADD FOREIGN KEY (PRcod) REFERENCES Projeto(PRcod);
ADD FOREIGN KEY (Fcod) REFERENCES Fornecedor(Fcodigo);
ALTER TABLE Fornecimento ADD FOREIGN KEY (Pcod) REFERENCES Peça(Pcodigo);
ALTER TABLE Fornecimento ADD FOREIGN KEY (PRcod) REFERENCES Projeto(PRcod);

CREATE INDEX idx_fornecedor_ccod ON Fornecedor(Ccod);
CREATE INDEX idx_peca_ccod ON Peça(Ccod);
CREATE INDEX idx_projeto_ccod ON Projeto(Ccod);


