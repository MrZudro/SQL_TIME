-- DML

-- INSERSION DE DATOS PARA LOS FABRICANTES
CALL insertarFabricante("Asus"); 				-- 1 
CALL insertarFabricante("Lenovo");				-- 2
CALL insertarFabricante("Hewlett-Packard");		-- 3
CALL insertarFabricante("Samsung");				-- 4
CALL insertarFabricante("Seagate");				-- 5
CALL insertarFabricante("Crucial");				-- 6
CALL insertarFabricante("Gigabyte");			-- 7
CALL insertarFabricante("Huawei");				-- 8
CALL insertarFabricante("Xiaomi");				-- 9

-- INSERSION DE DATOS PARA LOS PRODUCTOS
CALL insertarProducto("Disco duro SATA3 1TB", 89.99, 5);
CALL insertarProducto("Memoria RAM DDR4 8GB", 120, 6);
CALL insertarProducto("Disco SSD 1 TB", 150.99, 4);
CALL insertarProducto("GeForce GTX 1050Ti", 185, 7);
CALL insertarProducto("GeForce GTX 1080 Xtreme", 755, 6);
CALL insertarProducto("Monitor 24 LED Full HD", 202, 1);
CALL insertarProducto("Monitor 27 LED Full HD", 245.99, 1);
CALL insertarProducto("Portátil Yoga 520", 559, 2);
CALL insertarProducto("Portátil Ideapd 320", 444, 2);
CALL insertarProducto("Impresora HP Deskjet 3720", 59.99, 3);
CALL insertarProducto("Impresora HP LaserJet Pro M26nw", 180, 3);

/*
	#### CONSULTAS SOBRE UNA TABLA ####
*/
-- 1. LISTE EL NOMBRE DE TODOS LOS PRODUCTOS QUE HAY
SELECT nombre FROM producto;

-- 2. LISTAR NOMBRES Y PRECIOS DE PRODUCTOS
SELECT nombre, precio FROM producto;

-- 3. LISTAR TODAS LAS TABLAS DE PRODUCTOS
SELECT * FROM producto;

-- 4. NOMBRE DE PRODUCTOS EN EUROS Y EN DOLARES (EURO HOY 0.89DLL)
SELECT nombre,(precio * 0.89) as precio_euros, precio as precio_dolares FROM producto;

-- 5. NOMBRE Y PRECIOS EN DOLARES Y EUROS CON USO DE ALIAS ESPECIFICOS
SELECT nombre as nombre_de_producto,(precio * 0.89) as euros, precio as dólares FROM producto;

-- 6. NOMBRE Y PRECIOS DE PRODUCTOS, PERO NOMBRE EN MAYUSCULA
SELECT UPPER(nombre), precio FROM producto;

-- 7. NOMBRE Y PRECIO DE PRODUCTOS, PERO NOMBRE EN MINUSCULA
SELECT LOWER(nombre), precio FROM producto;

-- 8. NOMBRE DE FABRICANTES Y FABRICANTES CON CIERTOS CARACTERES EN MAYUSCULA
SELECT nombre, CONCAT(UPPER(SUBSTRING(nombre,1, 2)), SUBSTRING(nombre, 3)) AS nombre_filtrado FROM fabricante;

-- 9. NOMBRE Y PRECIO DE PRODUCCTOS CON PRECIO REDONDEADO
SELECT nombre, ROUND(precio) FROM producto;

-- 10.  NOMBRE Y PRECIO DE PRODUCTOS PERO PRECIO TRUNCADO A 0.
SELECT nombre, TRUNCATE(precio, 0) AS precio_truncau FROM producto;

-- 11. LISTAR ID DE FABRICANTE, PERO SOLO AQUELLOS QUE TIENEN PRODUCTOS
SELECT codigo_fabricante FROM producto;

-- 12. LISTAR ID DE FABRICANTE, PERO SOLO AQUELLOS QUE TIENEN PRODUCTOS SIN COINCIDENCIAS
SELECT codigo_fabricante FROM producto GROUP BY codigo_fabricante;

-- 13. LISTAR NOMBRES DE LOS FABRICANTES DE MANERA ASCENDENTE
SELECT nombre FROM fabricante ORDER BY nombre ASC;

-- 14. LISTAR NOMBRES DE LOS FABRICANTES DE MANERA DESCENDENTE
SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- 15.  LISTAR NOMBRES Y PRECIOS DE MANERA DISTINTA
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

-- 16. DEVOLVER 5 FILAS DE LA TABLA FABRICANTE
SELECT * FROM fabricante LIMIT 5;

-- 17. DEVOLVER 2 FILAS A PARTIR DE LA 4TA
SELECT * FROM fabricante LIMIT 3, 3;

-- 18. NOMBRE Y PRECIO DEL PRODUCTO MAS BARATO, ONLY ORDER BY Y LIMIT
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

-- 19.  NOMBRE Y PRECIO DEL PRODUCTO MAS CARO, ONLY ORDER BY Y LIMIT
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- 20. PRODCUTOS CUYO FABRICANTE ES 2
SELECT nombre FROM producto WHERE codigo_fabricante = 2;

-- 21. PRODCUTOS CUYO PRECIO ES MENOR O IGUAL A 120$
SELECT nombre FROM producto WHERE precio <= 120;

-- 22. PRODUCTOS CUYO PRECIO ES MAYOR O IGUAL A 400
SELECT nombre FROM producto WHERE precio >= 400;

-- 23. PRODUCTOS QUE NO TIENEN UN PRECIO MAYOR O IGUAL A 400$
SELECT nombre FROM producto WHERE NOT precio >= 400;

-- 24. PRODUCTOS CON PRECIO ENTRE 80 Y 300 SIN USAR BETWEEN
SELECT nombre, precio FROM producto WHERE precio >= 80 AND precio <= 300;

-- 25. PRODUCTOS CON PRECIO ENTRE 60$ Y 200$ USANDO BETWWEEN
SELECT nombre, precio FROM producto WHERE precio BETWEEN 60 AND 200;

-- 26. PRECIO DE PRODCUTO QUE SEA MAYOR A 200 Y CUYO ID SEA 6
SELECT nombre, precio, codigo_fabricante FROM producto WHERE precio > 200 AND  codigo_fabricante = 6; 

-- 27. PRODUCTOS DONDE ID SEA 1,3,5 SIN USAR IN 
SELECT nombre FROM producto WHERE codigo_fabricante = 1 OR codigo_fabricante = 3 OR codigo_fabricante = 5;

-- 28. PRODUCTOS DONDE ID SEA 1,3,5 USANDO IN 
SELECT nombre, codigo_fabricante FROM producto WHERE codigo_fabricante IN (1,3,5);

-- 29. PRODUCTOS CON NOMBRE PERO CON PRECIO EN CENTIMOS Y UN ALIAS 
SELECT nombre, (precio*100) AS céntimos FROM producto;

-- 30. NOMBRE DE FABRICANTES QUE EMPIEZAN POR S 
SELECT nombre FROM fabricante WHERE nombre LIKE "s%";

-- 31. NOMBRE DE FABRICANTES QUE TERMINAN EN E  
SELECT nombre FROM fabricante WHERE nombre LIKE "%e";

-- 32. NOMBRE DE FABRICANTES QUE CONTENGAN LA LETRA W 
SELECT nombre FROM fabricante WHERE nombre LIKE "%w%";

-- 33. NOMBRE DE FABRICANTES QUE SU LONGITUD SEA DE 4 CARACTERES
SELECT nombre FROM fabricante WHERE CHAR_LENGTH(nombre) = 4;

-- 34. LISTA QUE CONTENGA LOS PRODUCTOS QUE TENGAN PORTATIL EN EL NOMBRE
SELECT nombre FROM producto WHERE nombre LIKE "%Portátil%";

-- 35. LISTA QUE CONTENGA MONITOR Y UN PRECIO INFERIOR 215$
SELECT nombre, precio FROM producto WHERE nombre LIKE "%Monitor%" AND precio < 215;

-- 36. LISTA DE NOMBRE Y PRECIO, CUYO PRECIO ES MAYOR O IGUAL A 180 Y OREDENARLO
SELECT nombre, precio FROM producto WHERE precio >= 180 ORDER BY precio DESC, nombre ASC;

/*
	#### CONSULTAS MULTITABLA (COMPOSICION INTERNA) ####
*/

-- 1. LISTA CON NOMBRE Y PRECIO DE PRODUCTO Y NOMBRE DE FABRICANTE
SELECT producto.nombre AS nombre_producto, fabricante.nombre AS nombre_fabricante, precio FROM producto JOIN fabricante ON producto.codigo = fabricante.codigo;

-- 2. LISTA CON NOMBRE Y PRECIO Y NOMBRE DE FABRICANTE ORGANIZADOS POR ORDEN ALFABETICO
SELECT producto.nombre AS nombre_producto, fabricante.nombre AS nombre_fabricante, precio FROM producto JOIN fabricante ON producto.codigo = fabricante.codigo ORDER BY nombre_fabricante ASC;

-- 3. LISTA CON ID Y NOMBRE DE PRODUCTO ADEMAS DE ID FABRICANTE Y NOMBRE FABRICANTE
SELECT producto.codigo AS idProducto, producto.nombre AS NombreDelProducto, fabricante.codigo AS idFabricante, fabricante.nombre AS NombreDelFabricante FROM producto JOIN fabricante ON producto.codigo = fabricante.codigo;

-- 4. DEVUELVE NOMBRE Y PRECIO DEL PRODUCTO 