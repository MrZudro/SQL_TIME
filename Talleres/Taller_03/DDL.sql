DROP DATABASE IF EXISTS tiendaonline;
CREATE DATABASE tiendaonline;
USE tiendaonline;

CREATE TABLE productos(
	id_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL, 
    precio DECIMAL(10,2) NOT NULL, 
    stock FLOAT NOT NULL,
    id_categoria INT NOT NULL
);

CREATE TABLE pedidos(
	id_pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_pedido TIMESTAMP NOT NULL,
    total DECIMAL(10,2) NOT NULL
); 

CREATE TABLE detalles_pedido(
	id_detalle INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad FLOAT NOT NULL, 
    precio_unitario DECIMAL (10,2) NOT NULL
);

CREATE TABLE clientes(
	id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL, 
    apellido VARCHAR(100) NOT NULL, 
    email VARCHAR(100),
    fecha_registro TIMESTAMP NOT NULL
);

CREATE TABLE categorias(
	id_categoria INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE auditoria_productos (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_producto_afectado INT,
    nombre_anterior VARCHAR(50),
    precio_anterior DECIMAL(10,2),
    stock_anterior FLOAT,
    nombre_nuevo VARCHAR(50),
    precio_nuevo DECIMAL(10,2),
    stock_nuevo FLOAT,
    accion VARCHAR(10), -- INSERT, UPDATE, DELETE
    usuario_db VARCHAR(100),
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE auditoria_cambios_precio (
    id_cambio INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    precio_anterior DECIMAL(10,2),
    precio_nuevo DECIMAL(10,2),
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE auditoria_cambios_precio
ADD CONSTRAINT FK_audCambios_precio
FOREIGN KEY (id_producto) REFERENCES productos(id_producto);

ALTER TABLE productos
ADD CONSTRAINT FK_categoria_productos
FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria);

ALTER TABLE pedidos
ADD CONSTRAINT FK_pedidos_clientes
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente);

ALTER TABLE detalles_pedido
ADD CONSTRAINT FK_detalles_con_pedidos
FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido);

ALTER TABLE detalles_pedido
ADD CONSTRAINT FK_detalles_con_producto
FOREIGN KEY (id_producto) REFERENCES productos(id_producto);