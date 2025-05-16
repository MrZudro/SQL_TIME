DROP DATABASE IF EXISTS database_fabricas;
CREATE DATABASE database_fabricas;
USE database_fabricas;

-- DDL

-- CREACION DE TABLAS BAJO MODELO ENTREGADO
CREATE TABLE fabricante(
	codigo INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto(
	codigo INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    precio DOUBLE NOT NULL,
    codigo_fabricante INT(10)
);

-- AÑADIMOS LA FOREIGN KEY
ALTER TABLE producto
ADD CONSTRAINT fk_producto_fabricante
FOREIGN KEY(codigo_fabricante) REFERENCES fabricante(codigo)