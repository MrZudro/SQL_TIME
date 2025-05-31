-- DDL Script para el Sistema de Reservas del Hotel

-- Crear la base de datos
DROP DATABASE IF EXISTS hotel_reservations ;
CREATE DATABASE IF NOT EXISTS hotel_reservations;
USE hotel_reservations;

-- Tabla para Acomodaciones de Habitación
CREATE TABLE IF NOT EXISTS Acomodacion (
    idAcomodacion INT PRIMARY KEY AUTO_INCREMENT,
    tipoAcomodacion VARCHAR(50) NOT NULL UNIQUE, -- Ej., '1 persona', '2 personas', 'Familiar (3 personas)', 'Familiar (4 personas)'
    capacidad INT NOT NULL CHECK (capacidad IN (1, 2, 3, 4))
);

-- Tabla para Habitaciones
CREATE TABLE IF NOT EXISTS Habitacion (
    idHabitacion INT PRIMARY KEY AUTO_INCREMENT,
    numeroHabitacion VARCHAR(10) NOT NULL UNIQUE,
    idAcomodacion INT NOT NULL,
    precioPorNoche DECIMAL(10, 2) NOT NULL
);

-- Tabla para Clientes
CREATE TABLE IF NOT EXISTS Cliente (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20)
);

-- Tabla para Reservas
CREATE TABLE IF NOT EXISTS Reserva (
    idReserva INT PRIMARY KEY AUTO_INCREMENT,
    idCliente INT NOT NULL,
    idHabitacion INT NOT NULL,
    fechaEntrada DATE NOT NULL,
    fechaSalida DATE NOT NULL,
    fechaReserva DATETIME DEFAULT CURRENT_TIMESTAMP,
    costoTotal DECIMAL(10, 2),
    estadoReserva ENUM('Pendiente', 'Confirmada', 'Cancelada', 'Finalizada') DEFAULT 'Pendiente',
    CHECK (fechaSalida > fechaEntrada)
);

-- Tabla para Disponibilidad de Habitación (para controlar el estado de las habitaciones)
CREATE TABLE IF NOT EXISTS DisponibilidadHabitacion (
    idDisponibilidad INT PRIMARY KEY AUTO_INCREMENT,
    idHabitacion INT NOT NULL,
    fecha DATE NOT NULL,
    disponible BOOLEAN DEFAULT TRUE,
    UNIQUE(idHabitacion, fecha)
);

ALTER TABLE Habitacion
ADD CONSTRAINT FK_habitacion_acomodacion
FOREIGN KEY (idAcomodacion) REFERENCES Acomodacion(idAcomodacion);

ALTER TABLE Reserva
ADD CONSTRAINT FK_reserva_cliente
FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente);

ALTER TABLE Reserva
ADD CONSTRAINT FK_reserva_habitacion
FOREIGN KEY (idHabitacion) REFERENCES Habitacion(idHabitacion);

ALTER TABLE DisponibilidadHabitacion
ADD CONSTRAINT FK_DisponibilidadHabitacion
FOREIGN KEY (idHabitacion) REFERENCES Habitacion(idHabitacion)