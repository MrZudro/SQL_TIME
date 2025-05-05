DROP DATABASE terminal_transporte;
CREATE DATABASE terminal_transporte;
USE terminal_transporte;

CREATE TABLE Tiquetes(
    idTiquete INT PRIMARY KEY AUTO_INCREMENT,
    precio DECIMAL(10,2) NOT NULL,
    horaVenta DATE NOT NULL
);

CREATE TABLE EstadosTiquetes(
	idEstadoTiquete INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL
);

CREATE TABLE PuntosDeVenta(
	idPuntoDeVenta INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL, 
    descripcion VARCHAR(100)
);

CREATE TABLE Empresas(
	nit BIGINT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL 
);

CREATE TABLE Buses(
	placa VARCHAR (6) PRIMARY KEY,
    numeroDePuestos TINYINT NOT NULL
);

CREATE TABLE Rutas(
	idRuta INT PRIMARY KEY AUTO_INCREMENT,
    ORIGEN VARCHAR(20) NOT NULL, 
    DESTINO VARCHAR(20) NOT NULL
);

CREATE TABLE Pasajeros(
	numeroDeDocumento BIGINT(11) NOT NULL,
	tipoDocumento TINYINT NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    apellidoPaterno VARCHAR(25) NOT NULL,
    apellidoMaterno VARCHAR(25) NOT NULL,
    telefono BIGINT(10) NOT NULL,
    correo VARCHAR(120) NULL,
    
	PRIMARY KEY (numeroDeDocumento, tipoDocumento)
);

CREATE TABLE Conductores(
	numeroDeDocumento BIGINT(11) NOT NULL,
	tipoDocumento TINYINT NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    apellidoPaterno VARCHAR(25) NOT NULL,
    apellidoMaterno VARCHAR(25) NOT NULL,
    telefono BIGINT(10) NOT NULL,
    correo VARCHAR(120) NOT NULL,
    
	PRIMARY KEY (numeroDeDocumento, tipoDocumento)
);

CREATE TABLE Administradores(
	numeroDeDocumento BIGINT(11) NOT NULL,
    tipoDocumento TINYINT NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    apellidoPaterno VARCHAR(25) NOT NULL,
    apellidoMaterno VARCHAR(25) NOT NULL,
    telefono BIGINT(10) NOT NULL,
    correo VARCHAR(120) NOT NULL,
    
    PRIMARY KEY (numeroDeDocumento, tipoDocumento)
);

CREATE TABLE Reportes(
	idReporte INT PRIMARY KEY AUTO_INCREMENT,
    fechaInicio DATE NOT NULL, 
    fechaTerminacion DATE NOT NULL,
    numeroTotalVentas DECIMAL(10,2) NOT NULL, 
    fechaDeGeneracion DATE NOT NULL
);

ALTER TABLE Tiquetes
ADD CONSTRAINT Fk_PuntoDeVenta
FOREIGN KEY (idPuntoDeVenta) REFERENCES PuntosDeVenta(idPuntoDeVenta);

ALTER TABLE Tiquetes
ADD CONSTRAINT Fk_Empresa
FOREIGN KEY (nit) REFERENCES Empresas(nit)
	
