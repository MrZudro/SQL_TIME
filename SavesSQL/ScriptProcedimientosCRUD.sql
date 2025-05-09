-- CREAMOS EL PROCEDIMIENTO DE INSERCION DE PASAJEROS
DELIMITER $$
CREATE PROCEDURE insertar_usuario(
	IN p_idUsuario BIGINT,
    IN p_tipoIdentificacion INT (11),
    IN p_nombre VARCHAR(25),
    IN p_apellidoDos VARCHAR(25),
    IN p_apellidoUno VARCHAR(25),
    IN p_phone BIGINT(10),
    IN p_email VARCHAR(120)
)
BEGIN
	INSERT INTO pasajeros(numeroDeDocumento, tipoDocumento, nombre, apellidoPaterno, apellidoMaterno, telefono, correo)
    VALUES (p_idUsuario, p_tipoIdentificacion, p_nombre, p_apellidoUno, p_apellidoDos, p_phone, p_email);
END$$
DELIMITER ;

/*
ESTO DE AQUI ES COMO LLAMAR UNA FUNCION, EN OTRAS PALABRAS UN
PROCEDIMIENTO PARA AHORRAR TIEMPO Y HACER EL CODIGO MUCHO MAS REUTILIZABLE 
 */
 
CALL insertar_usuario(4056038766, 1, "Arley", "Hernandez", "Dominguez", 3213259087, "ahernandez@yahoo.com");

-- CREACION DEL PROCEDIMIENTO DE ELIMINACION DE PASAJEROS
DELIMITER $$
CREATE PROCEDURE eliminar_pasajero(
		IN p_idUsuario BIGINT
)
BEGIN
	DELETE FROM pasajeros WHERE numeroDeDocumento = p_idUsuario;
END$$
DELIMITER ;

CALL eliminar_pasajero(4056038766);
/*
	CREACION DE PROCEDIMIENTO DE ACTUALIZACION
    TENGA EN CUENTA EL ORDEN DE LOS PARAMETROS, DONDE, EL PRIMER PARAMETRO ES EL DOCUMENTO DEL PASAJERO, 
    EL SEGUNDO EL NOMBRE DE CAMBIO QUE SE HA DE REALIZAR, LOS CAMBIOS DISPONIBLES SE ENCUENTRA EN LA 
    SIGUIENTE LISTA:
    
    Use tipodoc para cambiar el tipo de documento
    Use nombre para cambiar el nombre
    Use apellidop para cambiear el apellido paterno
    Use apellidom para cambiar el apellido materno
	Use telefono para cambiar el numero de telefono
    Use correo para cambiar el correo asociado al pasajero
    
    PARA EL ULIMO PARAMETRO SERA EL VALOR QUE SERVIRA DE REMPLAZO, RECUERDE HACER UNA CONSULTA DEL PASAJERO 
    ANTES DE REALIZAR CUALQUIER CAMBIO
*/

DELIMITER $$
CREATE PROCEDURE actualizar_pasajero(
    IN p_idUsuario BIGINT,
    IN p_tipo_cambio VARCHAR(20), 
    IN p_cambio VARCHAR(255)
)
BEGIN
    IF p_tipo_cambio = "tipodoc" THEN
        UPDATE pasajeros
        SET tipoDocumento = p_cambio 
        WHERE numeroDeDocumento = p_idUsuario;
		SELECT * FROM pasajeros WHERE numeroDeDocumento = p_idUsuario;
    ELSEIF p_tipo_cambio = "nombre" THEN
        UPDATE pasajeros
        SET nombre = p_cambio
        WHERE numeroDeDocumento = p_idUsuario;
		SELECT * FROM pasajeros WHERE numeroDeDocumento = p_idUsuario;
    ELSEIF p_tipo_cambio = "apellidop" THEN
        UPDATE pasajeros
        SET apellidoPaterno = p_cambio
        WHERE numeroDeDocumento = p_idUsuario;
		SELECT * FROM pasajeros WHERE numeroDeDocumento = p_idUsuario;
    ELSEIF p_tipo_cambio = "apellidom" THEN
        UPDATE pasajeros
        SET apellidoMaterno = p_cambio
        WHERE numeroDeDocumento = p_idUsuario;
		SELECT * FROM pasajeros WHERE numeroDeDocumento = p_idUsuario;
    ELSEIF p_tipo_cambio = "telefono" THEN
        UPDATE pasajeros
        SET telefono = p_cambio 
        WHERE numeroDeDocumento = p_idUsuario;
		SELECT * FROM pasajeros WHERE numeroDeDocumento = p_idUsuario;
    ELSEIF p_tipo_cambio = "correo" THEN
        UPDATE pasajeros
        SET correo = p_cambio
        WHERE numeroDeDocumento = p_idUsuario;
        SELECT * FROM pasajeros WHERE numeroDeDocumento = p_idUsuario;
    ELSE
        SELECT "ERROR DE INGRESO, EL VALOR DE p_tipo_cambio DEBE SER LOS DATOS QUE SE ENCUENTRAN EN LAS INSTRUCCIONES. REINTENTE." AS mensaje;
    END IF;
END$$
DELIMITER ;


CALL insertar_usuario(4056038766, 1, "Arley", "Hernandez", "Dominguez", 3213259087, "ahernandez@yahoo.com"); -- Creamos un nuevo usuario de prueba
CALL actualizar_pasajero(4056038766,"apellidop","Quiazua");	-- Actualizamos al susodicho
SELECT * FROM pasajeros WHERE numeroDeDocumento = 4056038766; -- consultamos para validar la actualizacion
CALL actualizar_pasajero(4056038766,"apellidoSSS","Quiazua"); -- INGRESO ERRONEO DE DATOS PARA PROBAR EL MENSAJE DE ERROR

-- CREACION DEL PROCEDIMIENTO LEER PASAJEROS

DELIMITER $$
CREATE PROCEDURE leer_pasajero(
	IN p_idUsuario BIGINT
)
BEGIN 
	SELECT numeroDeDocumento, CONCAT(nombre, " ", apellidoPaterno, " ", apellidoMaterno) AS Nombre_Completo, telefono, correo FROM pasajeros WHERE numeroDeDocumento = p_idUsuario;
END$$
DELIMITER ;

CALL leer_pasajero(4056038766);
