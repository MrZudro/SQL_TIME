DROP FUNCTION IF EXISTS rembolso;
DROP PROCEDURE IF EXISTS cancelar_and_rembolsar;
DROP TRIGGER IF EXISTS TR_tiquete_cancelado;

-- HOJA CON PROCEDIMIENTOS NUMERO UNO
# PROBLEMATICA: CANCELACIÓN AUTOMATIZADA DE TIQUETES Y EL CALCULO DEL REMBOLSO
# Se busca actualizar el estado de un tiquete cuando este sea cancelado, de manera que se calcule un rembolso.

-- *************** FUNCION DE CALCULO ***************** --

/*
	Esta funcion busca calcular el monto ddel rembolso, 
    aplicando ciertamente una penalizacion por cancelacion.
*/
DELIMITER $$
CREATE FUNCTION rembolso(
	p_precio_tiquete DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE v_monto_rem DECIMAL(10,2);
    SET v_monto_rem = p_precio_tiquete * 0.90; -- penalizacion del 10% por la cancelacion del servicio
    RETURN v_monto_rem;
END$$
DELIMITER ;

-- ****************** PROCEDIMIENTO ALMACENADO **************** -- 

/*
	Este procedimiento llamará la funcion para calcular el monto y
    dirigirá para actualizar el estado del tiquete, si el tiquete no
    existe arrojará un error
*/

DELIMITER $$
CREATE PROCEDURE cancelar_and_rembolsar(
	IN p_idTiquete INT, -- La 'p' indica parametro
    OUT p_mensaje VARCHAR(200), -- Un procedimiento puede tener salidas, pero hay que declararlas
    OUT p_monto_rem DECIMAL(10,2)
)
BEGIN
	DECLARE var_ori_precio DECIMAL(10,2); -- el prefijo 'var' indica variable.
    DECLARE var_id_estado_cancel INT;
   
	# Estas son consultas para identificar el tiquete cancelado y su precio original
    SELECT idEstadoTiquete INTO var_id_estado_cancel FROM estadostiquetes WHERE nombre = 'Cancelado';
    SELECT precio INTO var_ori_precio FROM tiquetes WHERE p_idTiquete = idTiquete;
    
	# Sí el precio no esta vacio, quiere decir que el tiquete existe
    IF var_ori_precio IS NOT NULL THEN
		SET p_monto_rem = rembolso(var_ori_precio);
	
    /* 
		Sentencia de actualizacion del precio nuevo para la empresa, se pone primero pues esta 
        activa el trigger pero no modifica nada
    */
		UPDATE Tiquetes
        SET precio = var_ori_precio - p_monto_rem
        WHERE idTiquete = p_idTiquete;
        
    # Sentencia de actualizacion del estado del tiquete.
        UPDATE Tiquetes
        SET estado = var_id_estado_cancel
        WHERE idTiquete = p_idTiquete;
        
	# Mensaje de Exito 
        SET p_mensaje = CONCAT('Tiquete numero:  ', p_idTiquete, ' HA SIDO CANCELADO EXITOSAMENTE. EL MONTO REMBOLSADO ES DE: ', p_monto_rem);
	ELSE 
		SET p_mensaje = 'ERROR 101: EL TIQUETE NO EXISTE.';
        SET p_monto_rem = NULL;
	END IF;
END$$
DELIMITER ;

-- ****************** DISPARADOR, TRIGGER **************** -- 

/*
	El disparador registrara automaticamente el cambio y lo pondra
    en una tabla de auditoria.
*/

DELIMITER $$
CREATE TRIGGER TR_tiquete_cancelado
AFTER UPDATE ON Tiquetes
FOR EACH ROW 
BEGIN 
	# Creo una variable para por medio de una consulta obtener el id del estado que vamos a modificar
	DECLARE var_id_estado_cancel INT;
    SELECT idEstadoTiquete INTO var_id_estado_cancel FROM EstadosTiquetes WHERE nombre = 'Cancelado';
    
    /*
		SI EL ESTADO ANTERIOR ES DIFERENTE DEL NUEVO ESTADO Y EL NUEVO ESTADO ES IGUAL AL ESTADO DEL TIQUETE
        CANCELADO ENTONCES INSERTE EN LA TABLA LOS VALORES ....
    */
    
    IF OLD.estado <> NEW.estado AND NEW.estado = var_id_estado_cancel THEN 
		INSERT INTO AuditLogs (nombre_tabla, record_id, action_type, descripcion, log_timestamp)
        VALUES('Tiquetes', NEW.idTiquete, 'CANCELACION', CONCAT('Tiquete cancelado. Precio original: ', OLD.precio, '. VALOR DE GANANCIA: ', NEW.precio, '. Nuevo estado: Cancelado.'), NOW());
	END IF;
END$$
DELIMITER ;

