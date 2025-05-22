-- TRIGGERS O DISPARADORES

-- AUDITORIA DE CAMBIOS EN UNA TABLA

DELIMITER //
CREATE TRIGGER TRG_AuditoriaProductos_AfterUpdate
AFTER UPDATE ON productos
FOR EACH ROW 
BEGIN
	INSERT INTO auditoria_productos(
		id_producto_afectado,
        nombre_anterior, precio_anterior, stock_anterior,
        nombre_nuevo, precio_nuevo, stock_nuevo,
        accion, usuario_db
    )
    VALUES(
		OLD.id_producto,
        OLD.nombre, OLD.precio, OLD.stock,
        NEW.nombre, NEW.precio, NEW.stock,
        'UPDATE', USER() -- La funcion user obtiene los datos del usuario que realiza la accion
    );
END //    
DELIMITER ;
DELIMITER //
CREATE TRIGGER TRG_AuditoriaProductos_AfterDelete
AFTER DELETE ON productos
FOR EACH ROW 
BEGIN 
	INSERT INTO auditoria_productos(
		id_producto_afectado,
        nombre_anterior, precio_anterior, stock_anterior, 
        accion, usuario_db
    )
    VALUES(
		OLD.id_producto, 
        OLD.nombre, OLD.precio, OLD.stock, 
        'DELETE', USER()
    );
END //
DELIMITER ;

-- ACTUALIZAR EL STOCK DE PRODUCTOS LUEGO DE INSERTAR O ELIMINAR EN DETALLES_PEDIDO

DELIMITER //
CREATE TRIGGER TRG_ActualizarStock_AfterInsertDetalle
AFTER INSERT ON detalles_pedido
FOR EACH ROW 
BEGIN
	UPDATE productos
    SET stock = stock - NEW.cantidad
    WHERE id_producto = NEW.id_producto
DELIMITER ;

DELIMITER //
CREATE TRIGGER TRG_ReponerStock_AfterDeleteDetalle
AFTER DELETE ON detalles_pedido
FOR EACH ROW
BEGIN
    UPDATE productos
    SET stock = stock + OLD.cantidad
    WHERE id_producto = OLD.id_producto;
END //
DELIMITER ;

-- PREVENIR ELIMINACION CUANDO EL ESTADO DEL PEDIDO SEA PENDIENTE
DELIMITER //
CREATE TRIGGER TRG_PrevenirEliminacionProductoConPedidos
BEFORE DELETE ON productos
FOR EACH ROW
BEGIN
    DECLARE conteo_pedidos INT;
    SELECT COUNT(*) INTO conteo_pedidos
    FROM detalles_pedido
    WHERE id_producto = OLD.id_producto;

    IF conteo_pedidos > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar el producto porque tiene pedidos asociados.';
    END IF;
END //
DELIMITER ;

-- ESTABLECER FECHAS AUTOMATICAMENTE
-- PARA TABLA PEDIDOS
DELIMITER //
CREATE TRIGGER TRG_EstablecerFechaPedido
BEFORE INSERT ON pedidos
FOR EACH ROW
BEGIN
    IF NEW.fecha_pedido IS NULL THEN
        SET NEW.fecha_pedido = CURRENT_TIMESTAMP;
    END IF;
END //
DELIMITER ;

-- PARA TABLA CLIENTES
DELIMITER //
CREATE TRIGGER TRG_EstablecerFechaRegistroCliente
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    IF NEW.fecha_registro IS NULL THEN
        SET NEW.fecha_registro = CURRENT_TIMESTAMP;
    END IF;
END //
DELIMITER ;
