-- VISTAS

-- ####################### 1 #######################
-- 			VISTA DE CLIENTES REGISTRADOS EN EL ULTIMO MES
CREATE VIEW VistaClientesRecientes AS
SELECT id_cliente, nombre, apellido, email, fecha_registro
FROM clientes
WHERE fecha_registro >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- Uso: SELECT * FROM VistaClientesRecientes;

-- ####################### 2 #######################
-- 			VISTA DE VENTAS TOTALES EPOR PRODUCTO
CREATE VIEW VistaVentasPorProducto AS
SELECT
    p.id_producto,
    p.nombre AS nombre_producto,
    SUM(dp.cantidad) AS cantidad_total_vendida,
    SUM(dp.cantidad * dp.precio_unitario) AS ingreso_total
FROM productos p
JOIN detalles_pedido dp ON p.id_producto = dp.id_producto
GROUP BY p.id_producto, p.nombre;

-- Uso: SELECT * FROM VistaVentasPorProducto ORDER BY ingreso_total DESC;

-- ####################### 3 #######################
-- 	VISTA DE PEDIDOS CON INFORMACION DEL CLIENTE Y NOMBRE DE PRODUCTOS
CREATE VIEW VistaPedidosDetallados AS
SELECT
    pe.id_pedido,
    pe.fecha_pedido,
    pe.total AS total_pedido,
    cl.id_cliente,
    cl.nombre AS nombre_cliente,
    cl.apellido AS apellido_cliente,
    pr.nombre AS nombre_producto,
    dp.cantidad,
    dp.precio_unitario
FROM pedidos pe
JOIN clientes cl ON pe.id_cliente = cl.id_cliente
JOIN detalles_pedido dp ON pe.id_pedido = dp.id_pedido
JOIN productos pr ON dp.id_producto = pr.id_producto;

-- Uso: SELECT * FROM VistaPedidosDetallados WHERE id_pedido = 1;

-- ####################### 4 #######################
-- VISTA DE PRODUCTOS CON BAJO STOCK (MENOS DE 5 UNIDADES)
CREATE VIEW VistaProductosBajoStock AS
SELECT id_producto, nombre, stock, precio, id_categoria
FROM productos
WHERE stock < 5;

-- Uso: SELECT * FROM VistaProductosBajoStock;

-- ####################### 4 #######################
-- VISTA DE PEDIDOS DE LOS ULTIMOS 7 DIAS CON NOMBRE DEL CLIENTE
CREATE VIEW VistaPedidosUltimaSemana AS
SELECT
    p.id_pedido,
    p.fecha_pedido,
    CONCAT(c.nombre, ' ', c.apellido) AS nombre_cliente,
    c.email AS email_cliente,
    p.total
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
WHERE p.fecha_pedido >= DATE_SUB(CURDATE(), INTERVAL 7 DAY);

-- Uso: SELECT * FROM VistaPedidosUltimaSemana ORDER BY fecha_pedido DESC;vistaclientesrecientes


