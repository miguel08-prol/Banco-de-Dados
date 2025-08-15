create database reserva_equipamento;

use reserva_equipamento;

create table cliente (
nome_cliente varchar(100),
id_cliente int not null,
CPF varchar(14),
data_nascimento datetime
);

create table equipamento (
code_equipamento int not null,
tipo_equipamento varchar(255),
qtde int,
valor decimal
);

create table reserva (
code_reserva int not null,
nome_cliente varchar(100),
endereco varchar(150),
equipamento_reserva varchar(200),
data_reserva datetime
);

create table logica (
code_logica int primary key auto_increment not null,
code_reserva int not null,
code_equipamento int not null,
id_cliente int not null,
foreign key (code_reserva) references reserva (code_reserva),
foreign key (code_equipamento) references equipamento (code_equipamento),
foreign key (id_cliente) references cliente (id_cliente)
);
