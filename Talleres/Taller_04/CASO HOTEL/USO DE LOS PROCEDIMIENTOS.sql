USE hotel_reservations;

-- Ejemplo 1: Creando una reserva (habitación 102, para María Gómez, del 2025-06-10 al 2025-06-12)
-- Asumiendo que el idCliente para María Gómez es 2 y el idHabitacion para la 102 es 2 (verifica tus inserts DML si son diferentes)
CALL CrearReserva(2, 2, '2025-06-10', '2025-06-12');

-- Ejemplo 2: Creando una reserva con descuento de 15 días (Juan Pérez, habitación 101, del 2025-07-15 al 2025-07-17)
-- Asumiendo que el idCliente para Juan Pérez es 1 y el idHabitacion para la 101 es 1
CALL CrearReserva(1, 1, '2025-07-15', '2025-07-17'); -- Esta reserva se realiza con más de 15 días de antelación (hoy es 30 de mayo de 2025)

-- Ejemplo 3: Intentando crear una reserva para una habitación/fechas ya ocupadas
-- Esto debería fallar si la habitación 102 ya está reservada para el 2025-06-10
CALL CrearReserva(3, 2, '2025-06-10', '2025-06-11');

-- Ejemplo 4: Visualizando las reservas
SELECT * FROM Reserva;

-- Ejemplo 5: Visualizando la disponibilidad de una habitación (para la habitación 102 en junio de 2025)
CALL ObtenerDisponibilidadHabitacion(2, '2025-06-01', '2025-06-30');

-- Ejemplo 6: Cancelando una reserva (reemplaza X con un idReserva real de tu tabla Reserva)
-- Asumiendo que el idReserva de la primera reserva (Juan Pérez) es 1.
CALL CancelarReserva(1);

-- Ejemplo 7: Visualizando la disponibilidad de la habitación después de la cancelación
CALL ObtenerDisponibilidadHabitacion(2, '2025-06-01', '2025-06-30');

-- Ejemplo 8: Encontrar habitaciones dobles disponibles para un período específico
-- Asumiendo que el idAcomodacion para 'Doble' es 2
CALL ObtenerHabitacionesDisponiblesPorAcomodacion(2, '2025-08-01', '2025-08-05');