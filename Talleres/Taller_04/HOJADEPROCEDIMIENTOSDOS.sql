DROP FUNCTION IF EXISTS calcular_ventas;
DROP PROCEDURE IF EXISTS gen_reporte_ventas;
DROP TRIGGER IF EXISTS TR_reporte;

-- HOJA DE PROCESIMIENTOS NUMERO DOS
-- *********** -- GENERECION AUTOMATICA DE REPORTES -- ************ --
/*
	ESTE PROCESO BUSCA FACILITAR LA GENERACION DE INFORMES DE VENTAS AL 
    AGREGAR DATOS
*/

-- ======================== FUNCTION =========================== --
DELIMITER $$
CREATE FUNCTION calcular_ventas(
	p_empresa_nit BIGINT,
    p_fecha_inicio DATE,
    P_fecha_fin DATE
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE var_totalventas DECIMAL(10,2);
    SELECT SUM(precio) into var_totalventas FROM Tiquetes WHERE empresa = p_empresa_nit
    AND horaVenta BETWEEN p_fecha_inicio AND p_fecha_fin  AND estado = (SELECT idEstadoTiquete FROM EstadosTiquetes WHERE nombre = 'Vendido');
    
    RETURN IFNULL(var_totalventas, 0);
END$$
DELIMITER ;

-- ======================= PROCEDURE ========================== --
DELIMITER $$
CREATE PROCEDURE gen_reporte_ventas(
	IN p_empresa_nit BIGINT,
    IN p_doc_admin BIGINT,
    IN p_tipo_doc_admin INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_terminacion DATE,
    OUT p_idReporte INT,
    OUT p_mensaje VARCHAR(255)
)
BEGIN 
	DECLARE var_totalventas DECIMAL(10,2);
    SET var_totalventas = calcular_ventas(p_empresa_nit, p_fecha_inicio, p_fecha_terminacion);
    
    INSERT INTO Reportes(empresa, documento_administrador, tipo_doc_administrador, fechaInicio, fechaTerminacion, numeroTotalVentas, fechaDeGeneracion)
    VALUES (p_empresa_nit, p_doc_admin, p_tipo_doc_admin, p_fecha_inicio, p_fecha_terminacion, var_totalventas, CURDATE());
    
    SET p_idReporte = LAST_INSERT_ID();
    SET p_mensaje = CONCAT('Reporte de veNtas para la empresa ', p_empresa_nit, ' generado exitosamente (ID: ' , p_idReporte, '). Total de ventas: ', var_totalventas);
END$$
DELIMITER ;

-- ====================== TRIGGER ======================= --
DELIMITER $$
CREATE TRIGGER TR_reporte
AFTER INSERT ON Reportes
FOR EACH ROW
BEGIN
	INSERT INTO AuditLogs (nombre_tabla, record_id, action_type, descripcion, log_timestamp)
    VALUES('Reportes', NEW.idReporte, 'INSERTADO', CONCAT('Nuevo reporte genreado para empresa ', NEW.empresa, ' del ', NEW.fechaInicio, ' al ', NEW.fechaterminacion, '.'), NOW());
END$$
DELIMITER ;