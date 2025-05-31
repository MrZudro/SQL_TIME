USE hotel_reservations;
DROP FUNCTION IF EXISTS CalcularCostoReserva;
DROP PROCEDURE IF EXISTS CrearReserva;
DROP PROCEDURE IF EXISTS CancelarReserva;
DROP PROCEDURE IF EXISTS ObtenerDisponibilidadHabitacion;
DROP PROCEDURE IF EXISTS ObtenerHabitacionesDisponiblesPorAcomodacion;
DROP TRIGGER IF EXISTS trg_BeforeUpdateReserva;
DROP TRIGGER IF EXISTS trg_UpdateDisponibilidadOnReservaCancel;

-- ******************************************************
-- *          1. Función: CalcularCostoReserva          *
-- ******************************************************
# Calcula el costo total de una reserva, aplicando un descuento del 10% si se reserva con 15 días de anticipación.
DELIMITER //
CREATE FUNCTION CalcularCostoReserva(
    p_idHabitacion INT,
    p_fechaEntrada DATE,
    p_fechaSalida DATE,
    p_fechaReserva DATETIME
) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE v_precioPorNoche DECIMAL(10, 2);
    DECLARE v_diasReserva INT;
    DECLARE v_costoBase DECIMAL(10, 2);
    DECLARE v_descuento DECIMAL(10, 2) DEFAULT 0.00;
    DECLARE v_costoFinal DECIMAL(10, 2);

    -- Obtener el precio por noche de la habitación
    SELECT precioPorNoche INTO v_precioPorNoche
    FROM Habitacion
    WHERE idHabitacion = p_idHabitacion;

    -- Calcular el número de noches
    SET v_diasReserva = DATEDIFF(p_fechaSalida, p_fechaEntrada);

    -- Calcular el costo base
    SET v_costoBase = v_precioPorNoche * v_diasReserva;

    -- Verificar el descuento por reserva anticipada (15 días de antelación)
    IF DATEDIFF(p_fechaEntrada, p_fechaReserva) >= 15 THEN
        SET v_descuento = v_costoBase * 0.10; -- 10% de descuento
    END IF;

    SET v_costoFinal = v_costoBase - v_descuento;

    RETURN v_costoFinal;
END //
DELIMITER ;
-- ------------------------------------------------------
-- -- --2. Procedimiento Almacenado: CrearReserva-- -- --
-- ------------------------------------------------------
# Crea una nueva reserva, verifica la disponibilidad de la habitación y calcula el costo.
DELIMITER //
CREATE PROCEDURE CrearReserva(
    IN p_idCliente INT,
    IN p_idHabitacion INT,
    IN p_fechaEntrada DATE,
    IN p_fechaSalida DATE
)
BEGIN
    DECLARE v_fechasDisponibles BOOLEAN DEFAULT TRUE;
    DECLARE v_currentDate DATE;
    DECLARE v_costoCalculado DECIMAL(10, 2);

    -- Verificar la disponibilidad de la habitación para todo el período de reserva
    SET v_currentDate = p_fechaEntrada;
    bucle_fechas: WHILE v_currentDate < p_fechaSalida DO
        SELECT disponible INTO v_fechasDisponibles
        FROM DisponibilidadHabitacion
        WHERE idHabitacion = p_idHabitacion AND fecha = v_currentDate;

        IF NOT v_fechasDisponibles OR v_fechasDisponibles IS NULL THEN
            SET v_fechasDisponibles = FALSE;
			LEAVE bucle_fechas;         /*Salir del bucle si alguna fecha no está disponible*/
        END IF;

        SET v_currentDate = DATE_ADD(v_currentDate, INTERVAL 1 DAY);
    END WHILE;

    IF v_fechasDisponibles THEN
        -- Calcular el costo de la reserva
        SET v_costoCalculado = CalcularCostoReserva(p_idHabitacion, p_fechaEntrada, p_fechaSalida, NOW());

        -- Insertar la reserva
        INSERT INTO Reserva (idCliente, idHabitacion, fechaEntrada, fechaSalida, costoTotal)
        VALUES (p_idCliente, p_idHabitacion, p_fechaEntrada, p_fechaSalida, v_costoCalculado);

        -- Actualizar la disponibilidad de la habitación a FALSE para las fechas reservadas
        SET v_currentDate = p_fechaEntrada;
        WHILE v_currentDate < p_fechaSalida DO
            UPDATE DisponibilidadHabitacion
            SET disponible = FALSE
            WHERE idHabitacion = p_idHabitacion AND fecha = v_currentDate;

            -- Si la fecha no existe en DisponibilidadHabitacion, insertarla como no disponible
            IF ROW_COUNT() = 0 THEN
                INSERT INTO DisponibilidadHabitacion (idHabitacion, fecha, disponible)
                VALUES (p_idHabitacion, v_currentDate, FALSE);
            END IF;

            SET v_currentDate = DATE_ADD(v_currentDate, INTERVAL 1 DAY);
        END WHILE;

        SELECT 'Reserva creada exitosamente.' AS Mensaje, LAST_INSERT_ID() AS idReserva;
    ELSE
        SELECT 'Lo sentimos, la habitación no está disponible para las fechas seleccionadas.' AS Mensaje;
    END IF;

END //
DELIMITER ;

-- 3. Procedimiento Almacenado: CancelarReserva
-- Cancela una reserva y actualiza la disponibilidad de la habitación.
DELIMITER //
CREATE PROCEDURE CancelarReserva(
    IN p_idReserva INT
)
BEGIN
    DECLARE v_idHabitacion INT;
    DECLARE v_fechaEntrada DATE;
    DECLARE v_fechaSalida DATE;
    DECLARE v_estadoActual ENUM('Pendiente', 'Confirmada', 'Cancelada', 'Finalizada');
    DECLARE v_currentDate DATE;
    DECLARE v_reservaExistente INT; -- ¡Esta es la variable que faltaba!

    -- Verificar si la reserva existe y obtener sus detalles
    SELECT idHabitacion, fechaEntrada, fechaSalida, estadoReserva
    INTO v_idHabitacion, v_fechaEntrada, v_fechaSalida, v_estadoActual
    FROM Reserva
    WHERE idReserva = p_idReserva;

    -- Usamos FOUND_ROWS() o un COUNT para verificar si se encontró la reserva
    -- o simplemente podemos chequear si v_idHabitacion es NULL, que es lo que ocurrirá
    -- si la SELECT no encontró ninguna fila para p_idReserva.
    IF v_idHabitacion IS NULL THEN -- Si no se encontró la reserva
        SELECT 'Reserva no encontrada.' AS Mensaje;
    ELSEIF v_estadoActual = 'Cancelada' OR v_estadoActual = 'Finalizada' THEN
        SELECT 'La reserva ya ha sido cancelada o finalizada.' AS Mensaje;
    ELSE
        -- Actualizar el estado de la reserva a 'Cancelada'
        UPDATE Reserva
        SET estadoReserva = 'Cancelada'
        WHERE idReserva = p_idReserva;

        -- Actualizar la disponibilidad de la habitación a TRUE para las fechas canceladas (solo para fechas futuras)
        SET v_currentDate = v_fechaEntrada;
        WHILE v_currentDate < v_fechaSalida DO
            IF v_currentDate >= CURDATE() THEN -- Solo actualizar fechas futuras
                UPDATE DisponibilidadHabitacion
                SET disponible = TRUE
                WHERE idHabitacion = v_idHabitacion AND fecha = v_currentDate;
            END IF;
            SET v_currentDate = DATE_ADD(v_currentDate, INTERVAL 1 DAY);
        END WHILE;

        SELECT 'Reserva cancelada exitosamente.' AS Mensaje;
    END IF;
END //
DELIMITER ;

-- 4. Procedimiento Almacenado: ObtenerDisponibilidadHabitacion
-- Recupera la disponibilidad de una habitación específica para un rango de fechas dado.
DELIMITER //
CREATE PROCEDURE ObtenerDisponibilidadHabitacion(
    IN p_idHabitacion INT,
    IN p_fechaInicio DATE,
    IN p_fechaFin DATE
)
BEGIN
    SELECT
        dh.fecha,
        dh.disponible
    FROM
        DisponibilidadHabitacion dh
    WHERE
        dh.idHabitacion = p_idHabitacion AND dh.fecha BETWEEN p_fechaInicio AND p_fechaFin
    ORDER BY
        dh.fecha;
END //
DELIMITER ;

-- 5. Procedimiento Almacenado: ObtenerHabitacionesDisponiblesPorAcomodacion
-- Recupera habitaciones disponibles para un tipo de acomodación y rango de fechas específico.
DELIMITER //
CREATE PROCEDURE ObtenerHabitacionesDisponiblesPorAcomodacion(
    IN p_idAcomodacion INT,
    IN p_fechaEntrada DATE,
    IN p_fechaSalida DATE
)
BEGIN
    SELECT
        h.idHabitacion,
        h.numeroHabitacion,
        h.precioPorNoche,
        a.tipoAcomodacion,
        a.capacidad
    FROM
        Habitacion h
    JOIN
        Acomodacion a ON h.idAcomodacion = a.idAcomodacion
    WHERE
        h.idAcomodacion = p_idAcomodacion
        AND NOT EXISTS (
            SELECT 1
            FROM Reserva r
            WHERE
                r.idHabitacion = h.idHabitacion
                AND r.estadoReserva IN ('Pendiente', 'Confirmada')
                AND (
                    (r.fechaEntrada < p_fechaSalida AND r.fechaSalida > p_fechaEntrada) -- Reservas superpuestas
                )
        );
END //
DELIMITER ;

-- 6. Trigger: trg_BeforeUpdateReserva
-- Recalcula el costo si las fechas de reserva o la habitación cambian.
DELIMITER //
CREATE TRIGGER trg_BeforeUpdateReserva
BEFORE UPDATE ON Reserva
FOR EACH ROW
BEGIN
    -- Recalcular el costo si los campos relevantes cambian
    IF NEW.idHabitacion <> OLD.idHabitacion OR NEW.fechaEntrada <> OLD.fechaEntrada OR NEW.fechaSalida <> OLD.fechaSalida THEN
        SET NEW.costoTotal = CalcularCostoReserva(NEW.idHabitacion, NEW.fechaEntrada, NEW.fechaSalida, NEW.fechaReserva);
    END IF;
END //
DELIMITER ;

-- 7. Trigger: trg_UpdateDisponibilidadOnReservaCancel
-- Este trigger marca las habitaciones como disponibles cuando se cancela una reserva.
DELIMITER //
CREATE TRIGGER trg_UpdateDisponibilidadOnReservaCancel
AFTER UPDATE ON Reserva
FOR EACH ROW
BEGIN
    DECLARE v_currentDate DATE;

    IF OLD.estadoReserva IN ('Pendiente', 'Confirmada') AND NEW.estadoReserva = 'Cancelada' THEN
        SET v_currentDate = OLD.fechaEntrada;
        WHILE v_currentDate < OLD.fechaSalida DO
            -- Solo actualizar fechas futuras a partir de hoy
            IF v_currentDate >= CURDATE() THEN
                UPDATE DisponibilidadHabitacion
                SET disponible = TRUE
                WHERE idHabitacion = OLD.idHabitacion AND fecha = v_currentDate;
            END IF;
            SET v_currentDate = DATE_ADD(v_currentDate, INTERVAL 1 DAY);
        END WHILE;
    END IF;
END //
DELIMITER ;