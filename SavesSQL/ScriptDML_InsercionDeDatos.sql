-- DML, instrucciones para realizar consultas a la base de datos.
INSERT INTO TiposDocumentos 
VALUES
(NULL, "Cedula de Ciudadania", "CEDULA QUE IDENTIFICA AL COLOMBIANO PAPÁ"),
(NULL, "Tarjeta de Identidad", "EL DOCUMENTO DE LOS NIÑOS"),
(NULL, "Cedula de Extranjeria", "EL DOCUMENTO DE LOS CHAMOZUELOS"),
(NULL, "Pasaporte", "DOCUMENTOS DE LOS DE GRINGOLANDIA");

INSERT INTO PuntosDeVenta (idPuntoDeVenta, nombre, descripcion) VALUES
(NULL, 'Taquilla Principal Salitre', 'Ventanilla A1 en el Terminal Salitre'),
(NULL, 'Taquilla Norte', 'Ventanilla B2 en el Terminal del Norte'),
(NULL, 'Venta Online Web', 'Ventas realizadas a través del portal web'),
(NULL, 'App Móvil', 'Ventas realizadas a través de la aplicación móvil');

INSERT INTO EstadosTiquetes
VALUES
(NULL, 'Vendido'),
(NULL, 'Cancelado'),
(NULL, 'Utilizado'),
(NULL, 'Abordado');

INSERT INTO Rutas
VALUES
(NULL, "Bogotá", "Chiquinquirá"),
(NULL, "Chiquinquirá", "Bogotá"),
(NULL, "Bogotá", "Chía"),
(NULL, "Chía", "Bogotá"), 
(NULL, "Bogotá", "Fosca"),
(NULL, "Fosca", "Bogotá");

INSERT INTO Empresas
VALUES
(8907001896, "velotax"),
(8600051081, "Bolivariana"),
(8001234567, 'Transportes Rápidos S.A.S.'),
(8007654321, 'Flota La Veloz Ltda.'),
(9001112223, 'Expreso Continental');

-- Insertando datos a tablas que no son fuertes, osea aquellas que tienen llaves foraneas
INSERT INTO Pasajeros 
VALUES
(1000065439, 1, "Alexander", "Prieto", "Hernandez", 3214567890, "alexander@gmail.com"),
(1000163439, 2, "Alexandra", "Jimenez", "Perez", 3224549990, "alexandra@gmail.com"),
(1011654392, 1, "Sergei", "Alexander", "Bobinsky", 3239875643, "Samuel@gmail.com"),
(1000271734, 4, "Sophia", "Salgado", "Hernandez", 3534065789, "sophiaExplodes@gmail.com"),
(1011654211, 1, "Dayanna", "Quiroga", "Quiroga", 3129878822, "Quirogas@yahoo.com"),
(1020304050, 1, 'Carlos', 'Sanchez', 'Perez', 3101234567, 'carlos.sanchez@email.com'),
(2030405060, 2, 'Ana', 'Gomez', 'Lopez', 3207654321, 'ana.gomez@email.com'),
(3040506070, 1, 'Luis', 'Martinez', 'Rodriguez', 3001122334, 'luis.martinez@email.com'),
(4050607080, 3, 'Sophia', 'Williams', 'Brown', 3159988776, 'sophia.williams@email.com'),
(5060708090, 1, 'Maria', 'Garcia', 'Velez', 3123456789, 'maria.g@email.com'),
(6070809000, 4, 'Juan', 'Diaz', 'Rojas', 3187654321, 'juan.d@email.com'),
(7080900010, 1, 'Pedro', 'Ramirez', 'Luna', 3175554433, 'pedro.r@email.com'),
(8090001020, 2, 'Laura', 'Torres', 'Campos', 3161212121, 'laura.t@email.com');

INSERT INTO Empleados
VALUES
(1000271345, 1, "Ernesto", "Perez", "De Sumapaz", 3216643551, "ErnestoPerez@soyfrailejon.com", 1, "2001-08-12" ),
(1221345777, 1, "Bob", "Andres", "Patiño", 3108406534, "BobPatiño@KillBart.com",1,"2010-12-15"),
(51743294, 1, "Tony", "Felipe", "Stark", 3208401634, "Ironman@starkIndustries.com", 0, "1990-03-24"),
(52876344, 1, "Barry", "Antonio", "Allen", 3114502776, "Flash@wellIndustries.com", 1, "2024-05-04");

INSERT INTO Administradores
VALUES
(22334501, 4, "Donald", "E.", "Trump", 3215577902, "MrPresident@solopelucas.com"),
(54321098, 1, 'Jefe', 'Operaciones', 'Continental', 3198765432, 'jefe.op@expcontinental.com'),
(79123456, 1, 'Admin', 'Principal', 'Sistemas', 3015556677, 'admin.sistemas@transrapidos.com'),
(65432109, 1, 'Gerente', 'Comercial', 'Ventas', 3118889900, 'gerente.ventas@flotaveloz.com');

INSERT INTO Buses
VALUES
("FFF-354", 40, 8907001896, 1),
("FEO-666", 25, 8907001896, 2),
("FAT-999", 30, 8600051081, 3),
("BTA-543", 30, 8600051081, 4);

-- primeras incersiones de datos para tiquetes
INSERT INTO Tiquetes (precio, horaVenta, idPuntoDeVenta, empresa, documento_pasajero, tipo_doc_pasajero, estado)
VALUES
(75000.00, '2025-05-01 00:00:00', 1, 8001234567, 1020304050, 1, 1),
(85000.00, '2025-05-02 00:00:00', 3, 8007654321, 2030405060, 2, 1),
(60000.00, '2025-05-02 00:00:00', 1, 8001234567, 3040506070, 1, 3),
(95000.00, '2025-05-03 00:00:00', 2, 9001112223, 4050607080, 3, 1),
(75000.00, '2025-05-04 00:00:00', 3, 8001234567, 1020304050, 1, 4),
(85000.00, '2025-05-05 00:00:00', 4, 8007654321, 2030405060, 2, 2);

-- Incersiones de datos mensuales para generar reportes posteriormente 
-- Tiquetes Enero 2025
INSERT INTO Tiquetes (precio, horaVenta, idPuntoDeVenta, empresa, documento_pasajero, tipo_doc_pasajero, estado) VALUES
(78000.00, '2025-01-05 10:30:00', 1, 8001234567, 1020304050, 1, 1), -- Transportes Rápidos
(88000.00, '2025-01-06 14:15:00', 3, 8007654321, 2030405060, 2, 1), -- Flota La Veloz
(70000.00, '2025-01-10 08:00:00', 2, 9001112223, 4050607080, 3, 3), -- Expreso Continental
(78000.00, '2025-01-15 16:45:00', 4, 8001234567, 3040506070, 1, 1), -- Transportes Rápidos
(90000.00, '2025-01-20 11:00:00', 1, 8007654321, 5060708090, 1, 4); -- Flota La Veloz

-- Tiquetes Febrero 2025
INSERT INTO Tiquetes (precio, horaVenta, idPuntoDeVenta, empresa, documento_pasajero, tipo_doc_pasajero, estado) VALUES
(80000.00, '2025-02-03 09:20:00', 3, 8001234567, 6070809000, 4, 1), -- Transportes Rápidos
(86000.00, '2025-02-05 13:00:00', 1, 8007654321, 1020304050, 1, 1), -- Flota La Veloz
(72000.00, '2025-02-12 17:30:00', 3, 9001112223, 2030405060, 2, 1), -- Expreso Continental
(79000.00, '2025-02-18 07:45:00', 2, 8001234567, 7080900010, 1, 3), -- Transportes Rápidos
(89000.00, '2025-02-25 19:00:00', 4, 8007654321, 8090001020, 2, 1); -- Flota La Veloz

-- Tiquetes Marzo 2025
INSERT INTO Tiquetes (precio, horaVenta, idPuntoDeVenta, empresa, documento_pasajero, tipo_doc_pasajero, estado) VALUES
(77000.00, '2025-03-01 11:10:00', 1, 8001234567, 3040506070, 1, 1), -- Transportes Rápidos
(91000.00, '2025-03-05 15:00:00', 3, 8007654321, 4050607080, 3, 4), -- Flota La Veloz
(69000.00, '2025-03-10 09:45:00', 1, 9001112223, 5060708090, 1, 1), -- Expreso Continental
(81000.00, '2025-03-17 12:30:00', 4, 8001234567, 1020304050, 1, 2), -- Transportes Rápidos (Cancelado)
(87000.00, '2025-03-22 18:15:00', 2, 8007654321, 6070809000, 4, 3); -- Flota La Veloz

-- Tiquetes Abril 2025
INSERT INTO Tiquetes (precio, horaVenta, idPuntoDeVenta, empresa, documento_pasajero, tipo_doc_pasajero, estado) VALUES
(76000.00, '2025-04-02 08:50:00', 3, 8001234567, 7080900010, 1, 1), -- Transportes Rápidos
(93000.00, '2025-04-07 16:20:00', 1, 8007654321, 8090001020, 2, 1), -- Flota La Veloz
(71000.00, '2025-04-11 10:00:00', 4, 9001112223, 1020304050, 1, 1), -- Expreso Continental
(79500.00, '2025-04-19 14:30:00', 2, 8001234567, 2030405060, 2, 4), -- Transportes Rápidos
(88500.00, '2025-04-26 20:00:00', 3, 8007654321, 3040506070, 1, 1); -- Flota La Veloz

-- Tiquetes Mayo 2025 
INSERT INTO Tiquetes (precio, horaVenta, idPuntoDeVenta, empresa, documento_pasajero, tipo_doc_pasajero, estado) VALUES
(75000.00, '2025-05-01 10:00:00', 1, 8001234567, 4050607080, 3, 1),
(85000.00, '2025-05-02 11:30:00', 3, 8007654321, 5060708090, 1, 1),
(60000.00, '2025-05-03 09:15:00', 1, 9001112223, 6070809000, 4, 3),
(95000.00, '2025-05-04 17:00:00', 2, 8001234567, 7080900010, 1, 1),
(75000.00, '2025-05-05 14:45:00', 3, 8007654321, 8090001020, 2, 4);

-- Reportes para Transportes Rápidos S.A.S. (NIT: 8001234567)
INSERT INTO Reportes (empresa, documento_administrador, tipo_doc_administrador, fechaInicio, fechaTerminacion, numeroTotalVentas, fechaDeGeneracion) VALUES
(8001234567, 79123456, 1, '2025-01-01', '2025-01-31', 156000.00, '2025-02-01'), -- Estimado para Enero (78000+78000)
(8001234567, 79123456, 1, '2025-02-01', '2025-02-28', 159000.00, '2025-03-01'), -- Estimado para Febrero (80000+79000)
(8001234567, 79123456, 1, '2025-03-01', '2025-03-31', 77000.00, '2025-04-01'),  -- Estimado para Marzo (77000, el otro cancelado)
(8001234567, 79123456, 1, '2025-04-01', '2025-04-30', 155500.00, '2025-05-01'); -- Estimado para Abril (76000+79500)

-- Reportes para Flota La Veloz Ltda. (NIT: 8007654321)
INSERT INTO Reportes (empresa, documento_administrador, tipo_doc_administrador, fechaInicio, fechaTerminacion, numeroTotalVentas, fechaDeGeneracion) VALUES
(8007654321, 65432109, 1, '2025-01-01', '2025-01-31', 178000.00, '2025-02-02'), -- Estimado para Enero (88000+90000)
(8007654321, 65432109, 1, '2025-02-01', '2025-02-28', 175000.00, '2025-03-02'), -- Estimado para Febrero (86000+89000)
(8007654321, 65432109, 1, '2025-03-01', '2025-03-31', 178000.00, '2025-04-02'), -- Estimado para Marzo (91000+87000)
(8007654321, 65432109, 1, '2025-04-01', '2025-04-30', 181500.00, '2025-05-02'); -- Estimado para Abril (93000+88500)

-- Reportes para Expreso Continental (NIT: 9001112223)
INSERT INTO Reportes (empresa, documento_administrador, tipo_doc_administrador, fechaInicio, fechaTerminacion, numeroTotalVentas, fechaDeGeneracion) VALUES
(9001112223, 54321098, 1, '2025-01-01', '2025-03-31', 211000.00, '2025-04-05'), -- Estimado Q1 (70000+72000+69000)
(9001112223, 54321098, 1, '2025-04-01', '2025-04-30', 71000.00, '2025-05-05');  -- Estimado Abril (71000)

INSERT INTO Reportes (empresa, documento_administrador, tipo_doc_administrador, fechaInicio, fechaTerminacion, numeroTotalVentas, fechaDeGeneracion) VALUES
(8001234567, 79123456, 1, '2025-05-01', '2025-05-05', 170000.00, '2025-05-06');

