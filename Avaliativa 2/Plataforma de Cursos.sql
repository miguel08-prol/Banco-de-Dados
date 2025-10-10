CREATE DATABASE Cursos_Online;

USE Cursos_Online;

CREATE TABLE Aluno (
    id_aluno int not null primary key,
    nome_aluno varchar(100),
    data_nascimento datetime,
    email_aluno varchar(150) not null
);

CREATE TABLE Cursos (
    id_curso int not null primary key,
    titulo_curso varchar(50) not null,
    descricao_curso varchar(150),
    carga_horaria int,
    Status_curso varchar(7) default 'Ativo'
);

CREATE TABLE Inscricoes (
    id_inscr int not null primary key,
    data_inscricao datetime,

    id_aluno int not null,
    id_curso int not null,

    foreign key (id_aluno) references Aluno (id_aluno),
    foreign key (id_curso) references Cursos (id_curso)
);

CREATE TABLE Avaliacoes (
    id_avalia int not null primary key,
    nota_avalia decimal(3, 1),
    comentario varchar(150),

    id_inscr int not null,

   foreign key (id_inscr) references Inscricoes (id_inscr)
);

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
(3,0,"Vish Boy",5);


select * from Avaliacoes