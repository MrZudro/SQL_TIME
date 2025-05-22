-- PROCEDIMIENTOS

-- AGREGAR A UN NUEVO CLIENTE
DELIMITER //
CREATE PROCEDURE SP_AgregarNuevoCliente (
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_email VARCHAR(100)
)
BEGIN
    INSERT INTO clientes (nombre, apellido, email, fecha_registro)
    VALUES (p_nombre, p_apellido, p_email, CURRENT_TIMESTAMP);
END //
DELIMITER ;

-- Uso: CALL SP_AgregarNuevoCliente('Carlos', 'Santana', 'carlos.s@example.com');

-- ACTUALIZAR PRECIO DE UN PRODUCTO Y REGISTRAR AUDITORIA
DELIMITER //
CREATE PROCEDURE SP_ActualizarPrecioProducto (
    IN p_id_producto INT,
    IN p_nuevo_precio DECIMAL(10,2)
)
BEGIN
    DECLARE v_precio_anterior DECIMAL(10,2);

    SELECT precio INTO v_precio_anterior FROM productos WHERE id_producto = p_id_producto;

    IF v_precio_anterior IS NOT NULL THEN
        UPDATE productos
        SET precio = p_nuevo_precio
        WHERE id_producto = p_id_producto;

        INSERT INTO auditoria_cambios_precio (id_producto, precio_anterior, precio_nuevo)
        VALUES (p_id_producto, v_precio_anterior, p_nuevo_precio);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto no encontrado.';
    END IF;
END //
DELIMITER ;

-- Uso: CALL SP_ActualizarPrecioProducto(1, 29.99);

-- PROCESO PARA OBTENER DETALLES DE UN PEDIDO
DELIMITER //
CREATE PROCEDURE SP_ObtenerDetallesDeUnPedido (
    IN p_id_pedido INT
)
BEGIN
    SELECT
        dp.id_detalle,
        pr.nombre AS nombre_producto,
        dp.cantidad,
        dp.precio_unitario,
        (dp.cantidad * dp.precio_unitario) AS subtotal_item
    FROM detalles_pedido dp
    JOIN productos pr ON dp.id_producto = pr.id_producto
    WHERE dp.id_pedido = p_id_pedido;
END //
DELIMITER ;

-- Uso: CALL SP_ObtenerDetallesDeUnPedido(1);

-- PROCESO PARA ELIMINAR UN CLIENTE SI NO TIENE PEDIDOS ASOCIADOS
DELIMITER //
CREATE PROCEDURE SP_EliminarClienteSinPedidos (
    IN p_id_cliente INT
)
BEGIN
    DECLARE conteo_pedidos INT;

    SELECT COUNT(*) INTO conteo_pedidos
    FROM pedidos
    WHERE id_cliente = p_id_cliente;

    IF conteo_pedidos = 0 THEN
        DELETE FROM clientes WHERE id_cliente = p_id_cliente;
        SELECT 'Cliente eliminado exitosamente.' AS mensaje;
    ELSE
        SELECT 'No se puede eliminar el cliente, tiene pedidos asociados.' AS mensaje;
    END IF;
END //
DELIMITER ;

-- Uso: CALL SP_EliminarClienteSinPedidos(3);

-- PROCESO PARA GENERAR INFORME DE VENTAS EN RANGO DE FECHAS
DELIMITER //
CREATE PROCEDURE SP_InformeDeVentasPorProducto (
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT
        pr.nombre AS nombre_producto,
        SUM(dp.cantidad) AS total_unidades_vendidas,
        SUM(dp.cantidad * dp.precio_unitario) AS total_ingresos_generados
    FROM detalles_pedido dp
    JOIN productos pr ON dp.id_producto = pr.id_producto
    JOIN pedidos pe ON dp.id_pedido = pe.id_pedido
    WHERE DATE(pe.fecha_pedido) BETWEEN p_fecha_inicio AND p_fecha_fin
    GROUP BY pr.id_producto, pr.nombre
    ORDER BY total_ingresos_generados DESC;
END //
DELIMITER ;

-- Uso: CALL SP_InformeDeVentasPorProducto('2024-01-01', '2024-12-31');