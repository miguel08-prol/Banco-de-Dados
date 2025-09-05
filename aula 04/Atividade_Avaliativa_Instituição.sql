create database Instituição;

use Instituição;
select database();


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

show tables;
drop table instituição2;

CREATE TABLE Cidade (
    Ccod INT PRIMARY KEY,
    Cnome VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL
);

alter table Fornecedor 
change Cidade Fone VARCHAR(20);
ADD Ccod INT;

alter table Peça
change Cidade Ccod INT NOT NULL;

alter table Projeto
drop Cidade;

CREATE INDEX idx_fornecedor_ccod ON Fornecedor(Ccod);
CREATE INDEX idx_peca_ccod ON Peça(Ccod);
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

-- Verificar ultimo valor inserido de ID(quado tiver auto imcremento)
select last_insert_id();


-- Tabela Cidade
Insert into Cidade
values(11,'Limeira','SP');

insert into Cidade
values(14,'Rio Claro','Sp');

Insert into Cidade
values(12,'Santa Barbara','SP');

Insert into Cidade
values(13,'Piracicaba','SP');

insert into Fornecedor
values(11,'José Silva','Ativo','Limeira');

insert into Fornecedor
values(13,'Silvana Cardoso','Desativado','Piracicaba');

Insert into Peça
values(9876543,'Escapamento','Cinza','20kg','Ubatuba');

Insert into Peça
values(36278977,'Motor','Rosa','15kg','Ubatuba')