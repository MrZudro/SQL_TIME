
/* 
	PROCEDIMIENTO POR EL CUAL ES POSIBLE RESUMIR LAS 
    SENTENCIAS DE INGRESO DE PRODUCTOS 
*/
DELIMITER $$
CREATE PROCEDURE insertarProducto(
	IN p_nombre VARCHAR(100),
    IN p_precio DOUBLE,
    IN p_codigo_fabricante INT(100)
)
BEGIN
	INSERT INTO producto(nombre, precio, codigo_fabricante)
    VALUES (p_nombre,p_precio, p_codigo_fabricante);
END$$

DELIMITER ;

/* 
	PROCEDIMIENTO POR EL CUAL ES POSIBLE RESUMIR LAS 
    SENTENCIAS DE INGRESO DE FABRICANTES
*/

DELIMITER $$
CREATE PROCEDURE insertarFabricante(
	IN p_nombre VARCHAR(100)
)
BEGIN
	INSERT INTO fabricante(codigo, nombre) 
    VALUES(NULL, p_nombre);
END$$
DELIMITER ;