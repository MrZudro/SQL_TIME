CALL gen_reporte_ventas(8001234567, 79123456, 1, '2025-05-01', '2025-05-05', @idReporte, @mensaje);
SELECT @idReporte AS Id_del_reporte, @mensaje AS reporte;