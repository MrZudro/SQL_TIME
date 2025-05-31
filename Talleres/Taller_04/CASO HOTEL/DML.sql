-- DML Script para el Sistema de Reservas del Hotel

USE hotel_reservations;

-- Insertar datos en Acomodacion
INSERT INTO Acomodacion (tipoAcomodacion, capacidad) VALUES
('Individual', 1),
('Doble', 2),
('Triple', 3),
('Cuádruple', 4);

-- Insertar datos en Habitacion
INSERT INTO Habitacion (numeroHabitacion, idAcomodacion, precioPorNoche) VALUES
('101', (SELECT idAcomodacion FROM Acomodacion WHERE tipoAcomodacion = 'Individual'), 80000.00),
('102', (SELECT idAcomodacion FROM Acomodacion WHERE tipoAcomodacion = 'Doble'), 120000.00),
('103', (SELECT idAcomodacion FROM Acomodacion WHERE tipoAcomodacion = 'Doble'), 120000.00),
('201', (SELECT idAcomodacion FROM Acomodacion WHERE tipoAcomodacion = 'Triple'), 150000.00),
('202', (SELECT idAcomodacion FROM Acomodacion WHERE tipoAcomodacion = 'Cuádruple'), 180000.00);

-- Insertar datos en Cliente
INSERT INTO Cliente (nombre, apellido, email, telefono) VALUES
('Juan', 'Perez', 'juan.perez@example.com', '555-1234'),
('Maria', 'Gomez', 'maria.gomez@example.com', '555-5678'),
('Carlos', 'Ruiz', 'carlos.ruiz@example.com', '555-9012');

-- Nota: Las Reservas y la DisponibilidadHabitacion se poblarán mediante procedimientos/triggers.