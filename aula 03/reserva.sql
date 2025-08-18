create database reserva_equipamento;

use reserva_equipamento;


create table cliente (
    id_cliente INT PRIMARY KEY NOT NULL,
    nome_cliente VARCHAR(100),
    CPF VARCHAR(14),
    data_nascimento DATETIME
);


create table equipamento (
    code_equipamento INT PRIMARY KEY NOT NULL,
    tipo_equipamento VARCHAR(255),
    qtde INT,
    valor DECIMAL
);


create table reserva (
    code_reserva INT PRIMARY KEY NOT NULL,
    data_reserva DATETIME
);


create table logica (
    code_logica INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    code_reserva INT NOT NULL,
    code_equipamento INT NOT NULL,
    id_cliente INT NOT NULL,
    FOREIGN KEY (code_reserva) REFERENCES reserva (code_reserva),
    FOREIGN KEY (code_equipamento) REFERENCES equipamento (code_equipamento),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);

