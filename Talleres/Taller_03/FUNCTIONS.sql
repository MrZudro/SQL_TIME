-- FUNCIONES PERSONALIZADAS, CINCO EJEMPLOS
-- USESE: SELECT precioIva(productos.precio) AS PrecioFinal FROM productos WHERE id_producto = 1;

DELIMITER //
CREATE FUNCTION precioIva(precio DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE variable DECIMAL(10,2);
	SET variable = precio * 0.19;
	RETURN precio + variable;
END //
DELIMITER ;

-- FUNCION PARA OBTENER NOMBRE DEL CLIENTE
-- USESE: SELECT obtenerNombreCompleto(1) AS Cliente
DELIMITER //
CREATE FUNCTION obtenerNombreCompleto(
idCliente INT
)
RETURNS VARCHAR(201)
READS SQL DATA -- Esto le permitirá leer datos de las tablas previamente creadas
BEGIN
	DECLARE nombreCompleto VARCHAR(201);
    SELECT CONCAT(nombre, ' ', apellido) INTO nombreCompleto
    FROM clientes
    WHERE id_cliente = idCliente;
    RETURN nombreCompleto;
END //
DELIMITER ;

-- FUNCION PARA VERIFICAR SI UN CLIENTE SE REGISTRO EN LOS ULTIMOS 30 DIAS
-- USESE: SELECT esClienteTreintaDias(1) AS reciente;

DELIMITER //
CREATE FUNCTION esClienteTreintaDias(
id_cliente INT
)
RETURNS BOOLEAN
READS SQL DATA
BEGIN
	DECLARE fechaRegistro DATE;
    SELECT fecha_registro INTO fechaRegistro FROM clientes WHERE id_cliente = idCliente;
    RETURN fechaRegistro >= (CURDATE() - INTERVAL 30 DAY); -- INTERVAL SE USA UNICAMENTE PARA SUMAR Y RESTAR FECHAS
END //
DELIMITER ;

-- FUNCION DE FORMATEO NOMBRE-PRECIO DE LOS PRODUCTOS
-- USESE: SELECT formatoProductos(1) AS Descripcion

DELIMITER //
CREATE FUNCTION formatoProductos(
	idProducto INT
)
RETURNS VARCHAR(100)
READS SQL DATA 
BEGIN
	DECLARE descripcion VARCHAR(100);
    SELECT CONCAT(nombre, ' - $', FORMAT(precio, 2)) INTO descripcion
    FROM productos
    WHERE id_producto = idProducto;
    RETURN descripcion;
END//
DELIMITER ;

-- FUNCION PARA CALCULAR SUBTOTAL DE UN ITEM EN PEDIDO
-- USESE: SELECT totalItem(1,10) producto 1, 10 productos 
DELIMITER //
CREATE FUNCTION totalItem(
	IdProducto INT,
    CantidadItem FLOAT
)
RETURNS DECIMAL(10,2)
READS SQL DATA 
BEGIN 
	DECLARE precioProducto DECIMAL(10,2);
    SELECT precio INTO precioProducto FROM productos WHERE id_productos=idProducto;
    RETURN precioProducto * cantidadItem;
END//
DELIMITER ;

