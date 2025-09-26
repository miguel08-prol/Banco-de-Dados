-- Criar banco de dados

create database Loja_informatica;

-- Ativar BD
use Loja_informatica;

create table produto (
code_produto int,
Descricao varchar(255),
nome_produto varchar(100),
preco_produto decimal,
imagem blob
);

