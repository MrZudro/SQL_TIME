DROP DATABASE IF EXISTS terminal_transporte;
CREATE DATABASE terminal_transporte;
USE terminal_transporte;

CREATE TABLE Tiquetes(
    idTiquete INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    precio DECIMAL(10,2) NOT NULL,
    horaVenta TIMESTAMP NOT NULL, 
    idPuntoDeVenta INT NOT NULL,
    empresa BIGINT NOT NULL,
    documento_pasajero BIGINT(11) NOT NULL,
    tipo_doc_pasajero INT NOT NULL,
    estado INT NOT NULL
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
    numeroDePuestos INT NOT NULL,
    empresa BIGINT NOT NULL, 
    rutaAsignada INT NOT NULL
);

CREATE TABLE Buses_Rutas(
	infoRuta INT NOT NULL,
    infoBus VARCHAR(6) NOT NULL,
    
    PRIMARY KEY (infoRuta, infoBus)
);

CREATE TABLE Rutas(
	idRuta INT PRIMARY KEY AUTO_INCREMENT,
    ORIGEN VARCHAR(20) NOT NULL, 
    DESTINO VARCHAR(20) NOT NULL
);

CREATE TABLE Pasajeros(
	numeroDeDocumento BIGINT(11) NOT NULL,
	tipoDocumento INT NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    apellidoPaterno VARCHAR(25) NOT NULL,
    apellidoMaterno VARCHAR(25) NOT NULL,
    telefono BIGINT(10) NOT NULL,
    correo VARCHAR(120) NULL,
    
	PRIMARY KEY (numeroDeDocumento, tipoDocumento)
);

CREATE TABLE Conductores(
	numeroDeDocumento BIGINT(11) NOT NULL,
	tipoDocumento INT NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    apellidoPaterno VARCHAR(25) NOT NULL,
    apellidoMaterno VARCHAR(25) NOT NULL,
    telfono BIGINT(10) NOT NULL,
    correo VARCHAR(120) NOT NULL,
    
	PRIMARY KEY (numeroDeDocumento, tipoDocumento)
);

CREATE TABLE Administradores(
	numeroDeDocumento BIGINT(11) NOT NULL,
    tipoDocumento INT NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    apellidoPaterno VARCHAR(25) NOT NULL,
    apellidoMaterno VARCHAR(25) NOT NULL,
    telefono BIGINT(10) NOT NULL,
    correo VARCHAR(120) NOT NULL,
    
    PRIMARY KEY (numeroDeDocumento, tipoDocumento)
);

CREATE TABLE Reportes(
	empresa BIGINT NOT NULL,
	documento_administrador BIGINT(11) NOT NULL,
    tipo_doc_administrador INT NOT NULL,
	idReporte INT PRIMARY KEY AUTO_INCREMENT,
    fechaInicio DATE NOT NULL, 
    fechaTerminacion DATE NOT NULL,
    numeroTotalVentas DECIMAL(10,2) NOT NULL, 
    fechaDeGeneracion DATE NOT NULL
);

CREATE TABLE TiposDocumentos(
	idTipoDoc INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL, 
    descripcion VARCHAR(100) NOT NULL
);

-- tabla de auditoria que recibira al Trigger

CREATE TABLE AuditLogs (
    log_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nombre_tabla VARCHAR(50) NOT NULL,
    record_id INT NULL, -- ID del registro afectado en la tabla auditada (puede ser NULL si no aplica)
    action_type VARCHAR(50) NOT NULL, -- Tipo de acción (e.g., 'INSERT', 'UPDATE', 'DELETE', 'CANCELLATION')
    descripcion TEXT NULL, -- Descripción detallada del evento
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Marca de tiempo del registro
);

ALTER TABLE Buses_Rutas
ADD CONSTRAINT FK_BusesRutasInfoRuta
FOREIGN KEY (infoRuta) REFERENCES Rutas(idRuta);

ALTER TABLE Buses_Rutas
ADD CONSTRAINT FK_BusesRutasInfoBuses
FOREIGN KEY (infoBus) REFERENCES Buses(placa);

ALTER TABLE Tiquetes
ADD CONSTRAINT Fk_PuntoDeVenta
FOREIGN KEY (idPuntoDeVenta) REFERENCES PuntosDeVenta(idPuntoDeVenta);

ALTER TABLE Tiquetes
ADD CONSTRAINT Fk_InfoEmpresa_Tiquetes
FOREIGN KEY (empresa) REFERENCES Empresas(nit);

ALTER TABLE Tiquetes
ADD CONSTRAINT Fk_infoPasajero
FOREIGN KEY (documento_pasajero, tipo_doc_pasajero) REFERENCES Pasajeros(numeroDeDocumento, tipoDocumento);

ALTER TABLE Tiquetes
ADD CONSTRAINT FK_StatusDelTiquete
FOREIGN KEY (estado) REFERENCES EstadosTiquetes(idEstadoTiquete);

ALTER TABLE Buses
ADD CONSTRAINT FK_InfoEmpresa_Buses
FOREIGN KEY (empresa) REFERENCES Empresas(nit);

ALTER TABLE Buses
ADD CONSTRAINT FK_InfoRutas
FOREIGN KEY (rutaAsignada) REFERENCES Rutas(idRuta);

ALTER TABLE Pasajeros
ADD CONSTRAINT FK_InfoTipoDocumento_Pasajeros
FOREIGN KEY (tipoDocumento) REFERENCES TiposDocumentos(idTipoDoc);

ALTER TABLE Conductores
ADD CONSTRAINT FK_InfoTipoDocumento_Conductores
FOREIGN KEY (tipoDocumento) REFERENCES TiposDocumentos(idTipoDoc);

ALTER TABLE Administradores
ADD CONSTRAINT FK_InfoTipoDocumento_Administradores
FOREIGN KEY (tipoDocumento) REFERENCES TiposDocumentos(idTipoDoc);

ALTER TABLE Reportes
ADD CONSTRAINT FK_InfoEmpresa_Reportes
FOREIGN KEY (empresa) REFERENCES Empresas(nit);

ALTER TABLE Reportes 
ADD CONSTRAINT Fk_InfoAdministrador
FOREIGN KEY (documento_administrador, tipo_doc_administrador) REFERENCES Administradores(numeroDeDocumento, tipoDocumento);

-- Añado nuevas columnas a la tabla conductores
ALTER TABLE Conductores ADD estado BOOL;
ALTER TABLE Conductores ADD fechaIngreso DATE;

-- Cambio el nombre de una columna
ALTER TABLE Conductores CHANGE COLUMN telfono telefono BIGINT(10) ;

-- Cambio el nombre de la tabla de Conductores a Empleados
RENAME TABLE Conductores TO Empleados;

-- Cambio el tipo de dato de una columna 