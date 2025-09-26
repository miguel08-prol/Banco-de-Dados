create database Cursos_Online;

use Cursos_Online;

-- Parte 1->Modelagem Conceitual 
-- Parte 2->Criação das Tabelas
create table Aluno (
    id_aluno int not null primary key,
    nome_aluno varchar(100),
    data_nascimento datetime,
    email_aluno varchar(150) not null
);

create table Cursos (
    id_curso int not null primary key,
    titulo_curso varchar(50) not null,
    descricao_curso varchar(150),
    carga_horaria int,
    Status_curso varchar(7) default 'Ativo'
);

create table Inscricoes (
    id_inscr int not null primary key,
    data_inscricao datetime,

    id_aluno int not null,
    id_curso int not null,

    foreign key (id_aluno) references Aluno (id_aluno),
    foreign key (id_curso) references Cursos (id_curso)
);

create table Avaliacoes (
    id_avalia int not null primary key,
    nota_avalia decimal(3, 1),
    comentario varchar(150),

    id_inscr int not null,

   foreign key (id_inscr) references Inscricoes (id_inscr)
);

-- Parte 3->Inserção de Dados
insert into Aluno( id_aluno,nome_aluno,data_nascimento,email_aluno) values
(1,'Miguel Massane','2025-10-30','miguel@gmail.com'),
(2,"Danilo Silva",'2025-09-10',"danilo@gmail.com"),
(3,"Bruno Moraes",'2025-05-08',"bruno@gmail.com"),
(4,"Samuel Costa",'2025-06-12',"samuel@gmail.com"),
(5,"Felipe Oliveira",'2025-04-11',"felipe@gmail.com");

insert into Cursos (id_curso,titulo_curso,descricao_curso,carga_horaria,Status_curso) values
(1,"Desenvolvimento de Sistema","Criar Sistemas",40,'Ativo'),
(2,"ADM","Mexer no word",90,'Ativo'),
(3,"Eletrica","Fazer fiação",50,"Inativo"),
(4,"Mecanca","Mexer em maquinas",60,'Ativo'),
(5,"Robotica","Criar Robos",78,"Inativo");

insert into Inscricoes(id_inscr,data_inscricao,id_aluno,id_curso) values
(20,"2025-10-30",2,"1"),
(25,"2025-11-20",1,"4"),
(34,"2025-01-19",3,"3"),
(45,"2025-06-09",4,"2"),
(76,"2025-12-30",5,"5");

insert into Avaliacoes(id_avalia,nota_avalia,comentario,id_inscr) values
(1,6.5,"Prescisa Melhorar",20),
(2,8.9,"Exelente",34),
(3,0,"Vish Boy",76);

select * from Aluno;
select * from Cursos;
select * from Inscricoes;
select * from Avaliacoes;

-- Parte 4->Atualização de Dados
update Aluno set  email_aluno = "miguelmassane@gmail.com" where id_aluno = 1;
update Cursos set  carga_horaria = 87 where id_curso = 1;
update Aluno set  nome_aluno = "Samuel Costa Silva" where id_aluno = 4;
update Cursos set  Status_curso = "Ativo" where id_curso = 5;
update Avaliacoes set  nota_avalia = 5.5 where id_inscr = 20;

-- Parte 5->Exclusão de Dados
delete from Cursos where id_curso = 2;
delete from Inscricoes where id_aluno = 2;
delete from Avaliacoes where id_avalia = 3;
delete from Aluno where id_aluno = 5;
delete from Cursos where Status_curso = "Inativo";

-- Parte 6->Consultas
select * from Aluno;
select nome_aluno,email_aluno from Aluno;
select * from Cursos where carga_horaria >= 30;
select * from Cursos where carga_horaria >= 60;
select * from  Cursos where Status_curso = "Ativo";
select * from Aluno where year(data_nascimento) > '1995';
select * from Avaliacoes where nota_avalia >= 9.0;
select * from Avaliacoes where nota_avalia >= 8.0;
select Count(*) from Cursos;
select carga_horaria from Cursos order by carga_horaria desc limit 3;

-- Parte 7->Index
create index idx_email_email_aluno on Aluno(email_aluno);