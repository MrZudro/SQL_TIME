-- Declarar variables para capturar los valores de salida del procedimiento
SET @mensaje_salida = '';
SET @monto_reembolso_salida = 0.00;

-- Llamar al procedimiento almacenado para cancelar el tiquete con ID 1
CALL cancelar_and_rembolsar(
    2,                       -- Aquí pasamos el ID del tiquete
    @mensaje_salida,
    @monto_reembolso_salida
);


-- Mostrar los resultados del procedimiento
SELECT
    @mensaje_salida AS MensajeDelProcedimiento,
    @monto_reembolso_salida AS MontoReembolsado;


-- Verificar el estado actualizado del tiquete
SELECT
    T.idTiquete,
    T.precio,
    ET.nombre AS EstadoActual,
    T.horaVenta
FROM
    Tiquetes T
JOIN
    EstadosTiquetes ET ON T.estado = ET.idEstadoTiquete
WHERE
    T.idTiquete = 2;


-- Mostrar el registro en la tabla AuditLogs para verificar la acción
SELECT *
FROM AuditLogs
WHERE nombre_tabla = 'Tiquetes'
ORDER BY log_timestamp DESC;