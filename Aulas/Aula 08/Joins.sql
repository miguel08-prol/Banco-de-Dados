CREATE DATABASE IF NOT EXISTS joins;
USE joins;

-- TABLES
CREATE TABLE Cliente(
CodCli CHAR(3) NOT NULL PRIMARY KEY,
    Nome VARCHAR(40) NOT NULL,
    Endereco VARCHAR(50) NOT NULL,
    Cidade VARCHAR(20) NOT NULL,
    Estado CHAR(2) NOT NULL,
    CEP CHAR(9) NOT NULL
);

CREATE TABLE Venda(
Duplic CHAR(6) NOT NULL PRIMARY KEY,
    Valor DECIMAL(10,2) NOT NULL,
    Vencto DATE NOT NULL,
    CodCli CHAR(3) NOT NULL,
    FOREIGN KEY(CodCli) REFERENCES Cliente(CodCli)
);

-- INSERT Cliente
INSERT INTO Cliente VALUES(
'250',
    'BANCO BARCA S/A',
    'R. VITO, 34',
    'SAO SEBASTIAO',
    'CE',
    '62380-000'
);

INSERT INTO Cliente VALUES(
'820',
    'MECANICA SAO PAULO',
    'R. DO MACUCO, 99',
    'SANTO ANTONIO',
    'ES',
    '29810-020'
);

INSERT INTO Cliente VALUES(
'170',
    'POSTO BRASIL LTDA.',
    'AV. IMPERIO, 85',
    'GUAGIRUS',
    'BA',
    '42837-000'
);

-- INSERT Venda
INSERT INTO Venda VALUES(
'230001',
    1300.00,
    '2001-06-10',
    '250'
);

INSERT INTO Venda VALUES(
'230099',
    1000.00,
    '2002-10-02',
    '820'
);

INSERT INTO Venda VALUES(
'997818',
    3000.00,
    '2001-11-11',
    '170'
);

-- Consultas
-- Nome Cliente e Duplic

select Cliente.nome,Cliente.Cidade,Venda.duplic
from Cliente,Venda
where Cliente.codcli = Venda.codcli;

-- Consulta com Inner Join
select Venda.duplic,Cliente.nome,Cliente.Cidade
from Cliente inner join venda
on Cliente.codcli = venda.codcli;

select Cliente.nome, count(*) as qtde 
from Cliente inner join Venda
on Cliente.codcli = Venda.codcli
group by Cliente.nome;

select Cliente.nome, SUM(Venda.Valor) AS Total
from Cliente inner join Venda
on Cliente.Codcli = Venda.codcli
group by Cliente.nome;

select Cliente.nome, MIN(Venda.Valor) AS Menor_venda 
from Cliente INNER JOIN Venda 
on Cliente.Codcli = Venda.Codcli
group by Cliente.nome;

select Cliente.nome, MAX(Venda.Valor) AS Maior_venda 
from Cliente INNER JOIN Venda
on Cliente.Codcli = Venda.Codcli
group by Cliente.nome;

-- Tabela nova para uso de inner join
create table ex (
nome varchar(100)
);

create table fx (
nome varchar(100)
);

-- Tabela ex
INSERT INTO ex VALUES("Bruno");
INSERT INTO ex VALUES("Fernando");
INSERT INTO ex VALUES("Bianca");
INSERT INTO ex VALUES("Ana");
INSERT INTO ex VALUES("Carlos");

-- Tabela fx
INSERT INTO fx VALUES("Bruno");
INSERT INTO fx VALUES("Fernando");
INSERT INTO fx VALUES("Bianca");
INSERT INTO fx VALUES("Ana");
INSERT INTO fx VALUES("Carlos");

select ex.nome,fx.nome
from fx inner join ex
on ex.nome = fx.nome;

select ex.nome,fx.nome
from ex as ex
left join fx as fx
on ex.nome = fx.nome
union
select ex.nome,fx.nome
from ex as ex
right join fx as fx
on ex.nome = fx.nome;

select Cliente.Nome,Venda.Vencto 
from Cliente inner join Venda
on Cliente.CodCli = Venda.CodCli
where year(Venda.Vencto ) = 2001 and month(Venda.Vencto ) = 11
order by Venda.Vencto;

select Cliente.nome,Venda.duplic,Venda.valor
from Cliente inner join Venda
on Cliente.codcli = Venda.codcli
where Cliente.nome like "%PCTEC%"

