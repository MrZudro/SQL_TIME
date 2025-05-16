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
SELECT * FROM fabricante;

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
	#### CONSULTAS MULTITABLA (COMPOSICION INTERNA) <<JOIN OR INNER JOIN>> ####
*/

-- 1. LISTA CON NOMBRE Y PRECIO DE PRODUCTO Y NOMBRE DE FABRICANTE
SELECT producto.nombre AS nombre_producto, fabricante.nombre AS nombre_fabricante, precio FROM producto JOIN fabricante ON producto.codigo = fabricante.codigo;

-- 2. LISTA CON NOMBRE Y PRECIO Y NOMBRE DE FABRICANTE ORGANIZADOS POR ORDEN ALFABETICO
SELECT producto.nombre AS nombre_producto, fabricante.nombre AS nombre_fabricante, precio FROM producto JOIN fabricante ON producto.codigo = fabricante.codigo ORDER BY nombre_fabricante ASC;

-- 3. LISTA CON ID Y NOMBRE DE PRODUCTO ADEMAS DE ID FABRICANTE Y NOMBRE FABRICANTE
SELECT producto.codigo AS idProducto, producto.nombre AS NombreDelProducto, fabricante.codigo AS idFabricante, fabricante.nombre AS NombreDelFabricante FROM producto JOIN fabricante ON producto.codigo = fabricante.codigo;

-- 4. DEVUELVE NOMBRE Y PRECIO DEL PRODUCTO ORDENANDO POR EL MAS BARATO
SELECT producto.nombre AS NombreDelProducto, precio, fabricante.nombre AS Fabricante FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo ORDER BY precio ASC LIMIT 1;

-- 5. DEVUELVE EL NOMBRE Y PRECIO DEL PRODUCTO ORDENANDO POR EL MAS CARO
SELECT producto.nombre AS NombreDelProducto, precio, fabricante.nombre AS Fabricante FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo ORDER BY precio DESC LIMIT 1;

-- 6. LISTA CON TODOS LOS PRODUCTOS DE LENOVO
SELECT fabricante.nombre AS NombreDeFabricante, producto.nombre AS NombreDelProducto, precio FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE "lenovo";

-- 7. LISTA CON LOS PRODCUTOS DE CRUCIAL CUYO PRECIO SEA MAYOR A 200
SELECT fabricante.nombre AS NombreDeFabricante, producto.nombre AS NombreDelProducto, precio FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE "crucial" AND precio > 200;

-- 8. LISTA DE LOS PRODUCTOS DE ASUS, HEWLETT PACKARD Y SEAGATE SIN IN  
SELECT fabricante.nombre AS Nombre_de_fabricante, producto.nombre AS Nombre_de_producto, precio FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE "Asus" OR fabricante.nombre LIKE "Hewlett-Packard" OR fabricante.nombre LIKE "SEAGATE";

-- 9. LISTA DE LOS PRODUCTOS DE ASUS, HEWLETT PACKARD Y SEAGATE USANDO IN 
SELECT fabricante.nombre AS Nombre_de_fabricante, producto.nombre AS Nombre_de_producto, precio FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre IN("Asus","Hewlett-Packard","Seagate");

-- 10. LISTA CON EL NOMBRE Y PRECIO DE TODOS LOS PRODUCTOS TERMINADOS EN E 
SELECT fabricante.nombre AS NombreDelFabricante, producto.nombre AS NombreDelProducto, precio FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE "%e";

-- 11. LISTA CON EL NOMBRE Y PRECIO DE TODOS LOS PRODUCTOS QUE CONTENGAN W
SELECT fabricante.nombre AS NombreDelFabricante, producto.nombre AS NombreDelProducto, precio FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE "%w%";

-- 12. LISTADO CON NOMBRE Y PRECIO, NOMBRE DE FABRICANTE, ORDENADOS SEGUN CORRESPONDA
SELECT producto.nombre AS NombreDelProducto, precio, fabricante.nombre AS NombreDeFabricante FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo WHERE precio >= 180 ORDER BY precio DESC, producto.nombre ASC;

-- 13. LISTADO DE ID Y NOMBRE DE FABRICANTE UNICAMENTE AQUELLOS QUE TIENEN PRODUCTO ALGUNO
SELECT fabricante.codigo AS IdFabricante, fabricante.nombre FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo GROUP BY idFabricante;

/*
	CONSULTAS MULTITABLA (Composicion externa) LEFT JOIN & RIGHT JOIN
*/

-- 1. TODOS LOS FABRICANTES Y SUS PRODUCTOS
SELECT fabricante.codigo AS idFabricante, fabricante.nombre AS NombreDelFabricante, producto.nombre, producto.precio FROM fabricante LEFT JOIN producto ON codigo_fabricante = fabricante.codigo; 

-- 2. TODOS LOS FABRICANTES QUE NO TENGAN NINGUN PRODUCTO ASOCIADO
SELECT fabricante.codigo AS idFabricante, fabricante.nombre AS NombreDelFabricante, producto.nombre, producto.precio FROM fabricante LEFT JOIN producto ON codigo_fabricante = fabricante.codigo WHERE producto.precio IS NULL; 

-- 3. PUEDEN EXISTIR PRODUCTOS QUE NO ESTEN RELACIONADOS CON UN FABRICANTE
-- SI, YA QUE DESDE EL PRINCIPIO SE PERMITIO QUE LA COLUMNA codigo_fabricante FUESE NULLABLE, ES DECIR QUE PERMITIESE ALBERGAR VALORES DE TIPO NULL

/*
	CONSULTAS RESUMEN
*/

-- 1. NUMERO TOTAL DE PRODUCTOS QUE HAY EN PRODUCTO
SELECT COUNT(*) FROM producto;

-- 2. NUMERO TOTAL DE FABRICANTES QUE HAY EN FABRICANTE
SELECT COUNT(*) FROM fabricante;

-- 3. CUANTAS VECES APARECE CADA UNO DE LOS FABRICANTES EN PRODUCTOS
SELECT codigo_fabricante, COUNT(codigo_fabricante) AS conteo FROM producto GROUP BY codigo_fabricante;

-- 4. MEDIA DE TODOS LOS PRECIOS DE LOS PRODUCTOS 
SELECT AVG(precio) AS MediaDePrecio FROM producto;

-- 5. PRECIO MAS BARATO DE TODOS LOS PRODUCTOS
SELECT MIN(precio) AS Producto_Mas_Barato FROM producto;

-- 6. PRECIO MAS CARO DE TODOS LOS PRODUCTOS
SELECT MAX(precio) AS Producto_Mas_cariñoso FROM producto;

-- 7. PRECIO Y NOMBRE DEL PRODCUTO MAS BARATO
SELECT nombre, MIN(precio) AS Producto_Mas_Barato FROM producto;

-- 8. PRECIO Y NOMBRE DEL PRODUCTO MAS CARO
SELECT nombre, MAX(precio) AS Producto_Mas_Caro FROM producto;

-- 9. SUMA DEL PRECIO DE TODOS LOS PRODUCTOS
SELECT SUM(precio) AS Suma_de_precio FROM producto;

-- 10. NUMERO DE PRODUCTOS QUE TIENE ASUS
SELECT COUNT(codigo_fabricante) FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE "Asus";

-- 11. MEDIA DE PRECIOS DE ASUS 
SELECT AVG(precio) AS PromedioDePrecios FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE "Asus";

-- 12. PRECIO MAS BARATO ENTRE LOS PRODCUTOS DE ASUS
SELECT MIN(precio) AS PrecioMasBarato FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE "Asus";

-- 13. PRECIO MAS CARO ENTRE LOS PRODUCTOS DE ASUS
SELECT MAX(precio) AS PrecioMasCaro FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE "Asus";

-- 14. SUMA DE LAS PRODUCTOS DE ASUS
SELECT SUM(precio) AS SumaDePrecios FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE "Asus";

-- 15. PRECIO MAX, MIN, AVG Y SUM DE PRODCUTOS DE CRUCIAL
SELECT MAX(precio) AS PrecioMasCaro, MIN(precio) AS PrecioMasBarato, AVG(precio) AS PrecioPromedio, SUM(precio) AS SumatoriaDePrecios FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE "crucial";

-- 16. NUMERO DE PRODUCTOS DE CADA FABRICANTE ORDENADO DE MAYOR A MENOR
SELECT fabricante.nombre AS NombreDelFabricante, COUNT(producto.codigo) AS NumeroDeProductos FROM fabricante LEFT JOIN producto ON codigo_fabricante = fabricante.codigo GROUP BY fabricante.codigo, fabricante.nombre ORDER BY NumeroDeProductos DESC;  

-- 17. PRECIO MAX, MIN, AVG DE LOS PRODUCTOS DE CADA FABRICANTE
SELECT fabricante.nombre AS NombreDelFabricante, MAX(producto.precio) AS PrecioMasAlto, MIN(producto.precio) AS PrecioMasBajo, AVG(producto.precio) AS PromedioDePrecios FROM fabricante LEFT JOIN producto ON codigo_fabricante = fabricante.codigo GROUP BY fabricante.codigo, fabricante.nombre;

-- 18. PRECIO MAX, MIN, AVG, Y EL NUMERO TOTAL DE PRODUCTOS DE TODOS LOS FABRICANTES QCUYO PRECIO SEA > 200
SELECT fabricante.codigo, MAX(producto.precio) AS PrecioMasAlto, MIN(producto.precio) AS PrecioMasBajo, AVG(producto.precio) AS PromedioDePrecios, COUNT(producto.codigo) AS TotalDeProductos FROM fabricante LEFT JOIN producto ON codigo_fabricante = fabricante.codigo WHERE precio > 200 GROUP BY fabricante.codigo, fabricante.nombre;

-- 19. NOMBRE Y PRECIO MAX, MIN, AVG, Y TOTAL DE PRODUCTOS DE FABRICANTES CUYO PRECIO SEA > 200 
SELECT fabricante.codigo AS idFabricante, fabricante.nombre AS NombreDeFabricante, MAX(producto.precio) AS PrecioMasAlto, MIN(producto.precio) AS PrecioMasBajo, AVG(producto.precio) AS PromedioDePrecios, COUNT(producto.codigo) AS TotalDeProductos FROM fabricante LEFT JOIN producto ON codigo_fabricante = fabricante.codigo WHERE precio > 200 GROUP BY fabricante.codigo, fabricante.nombre;

-- 20 NUMERO DE PRODUCTOS CON PRECIO >= 180
SELECT COUNT(precio) AS Conteo FROM producto WHERE precio >= 180;

-- 21. NUMERO DE PRODUCTOS DE CADA FABRICANTE CON UN PRECIO QUE SEA >= 180
SELECT fabricante.nombre, COUNT(producto.codigo) AS ConteoDeProductos FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo WHERE precio >= 180 GROUP BY fabricante.nombre;

-- 22. PROMEDIO DE PRECIO DE CADA UNO DE LOS FABRICANTES MOSTRANDO EL PROMEDIO Y EL ID UNICAMENTE
SELECT fabricante.codigo, AVG(precio) AS PromedioPrecios FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo GROUP BY fabricante.codigo;
SELECT fabricante.codigo, AVG(precio) AS PromedioPrecios FROM fabricante LEFT JOIN producto ON codigo_fabricante = fabricante.codigo GROUP BY fabricante.codigo;

-- 23. PROMEDIO DE PRECIO DE CADA UNO DE LOS FABRICANTES MOSTRANDO EL PROMEDIO Y EL NOMBRE
SELECT fabricante.nombre, AVG(precio) AS PromedioPrecios FROM fabricante LEFT JOIN producto ON codigo_fabricante = fabricante.codigo GROUP BY fabricante.codigo;

-- 24. NOMBRES DE FABRICANTES CON PRODUCTOS MAYORES O IGUALES A 150
SELECT fabricante.nombre, AVG(precio) AS PrecioMedio FROM fabricante LEFT JOIN producto ON codigo_fabricante = fabricante.codigo GROUP BY fabricante.nombre HAVING AVG(precio) >= 150;

-- 25. NOMBRES DE FABRICANTE QUE TIENEN DOS O MAS PRODUCTOS
SELECT fabricante.nombre FROM fabricante LEFT JOIN producto ON codigo_fabricante = fabricante.codigo GROUP BY fabricante.nombre HAVING COUNT(producto.codigo_fabricante) >= 2;

-- 26. NOMBRES DE FABRICANTES Y NUMERO DE PRODUCTOS CON PRECIOS SUPERIORES A 220
SELECT fabricante.nombre, COUNT(producto.codigo_fabricante) AS Conteo FROM fabricante LEFT JOIN producto ON codigo_fabricante = fabricante.codigo WHERE precio >= 220 GROUP BY fabricante.nombre ORDER BY Conteo DESC; 
-- 27. NOMBRES DE FABRICANTES, NUMERO DE PRODUCTOS CON UN PRECIO TAL QUE >= 200
SELECT fabricante.nombre, COUNT(producto.codigo_fabricante) AS total FROM fabricante LEFT JOIN producto ON codigo_fabricante = fabricante.codigo AND precio >= 220 GROUP BY fabricante.nombre ORDER BY total DESC, fabricante.nombre DESC; 

-- 28. LISTA CON NOMBRE DE FABRICANTES CUYOS PRODUCTOS SUMADOS SON > 1000
SELECT fabricante.nombre FROM fabricante JOIN producto ON codigo_fabricante = fabricante.codigo GROUP BY fabricante.nombre, fabricante.codigo HAVING SUM(producto.precio) > 1000;

-- 29. LISTA CON EL PRODUCTO MAS CARO DE CADA FABRICANTE
SELECT producto.nombre AS NombreDeProducto, precio AS PrecioDelProducto, fabricante.nombre AS NombreDelFabricante FROM producto JOIN fabricante ON codigo_fabricante = fabricante.codigo GROUP BY fabricante.nombre ASC HAVING MAX(precio);


-- subconsultas

-- 1. PRODUCTOS DEL FABRICANTE LENOVO 
SELECT nombre, codigo_fabricante FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');

-- 2. 
SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "Lenovo"));

-- 3. 
SELECT nombre FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre LIKE "crucial"));

-- 4.
SELECT nombre FROM producto WHERE precio = (SELECT MIN(precio) FROM producto WHERE codigo_fabricante =(SELECT codigo FROM fabricante WHERE nombre LIKE "hewlett-packard"));

-- 5.
SELECT * FROM producto WHERE precio >= (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre LIKE "lenovo"));

-- 6. 
SELECT * FROM producto WHERE precio > (SELECT AVG(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre LIKE "asus"));

-- SUBCONSULTAS CON ALL Y ANY

-- 7. 
SELECT * FROM producto WHERE precio >= ALL(SELECT precio FROM producto);

-- 8. 
SELECT * FROM producto WHERE precio <= ALL(SELECT precio FROM producto);

-- 9. 
SELECT nombre FROM fabricante WHERE codigo = ANY(SELECT codigo_fabricante FROM producto);

-- 10. 
SELECT nombre FROM fabricante WHERE NOT codigo = ANY(SELECT codigo_fabricante FROM producto);

-- SUBCONSULTAS IN Y NOT IN 

-- 11. 
SELECT nombre FROM fabricante WHERE codigo IN(SELECT DISTINCT codigo_fabricante FROM producto);

-- 12. 
SELECT nombre FROM fabricante WHERE codigo NOT IN(SELECT DISTINCT codigo_fabricante FROM producto);

-- SUBCONSULTAS CON EXISTS Y NOT EXISTS
-- 13.
SELECT nombre FROM fabricante tablaf WHERE EXISTS(SELECT 1 FROM producto tablap WHERE tablap.codigo_fabricante = tablaf.codigo);

-- 14.
 SELECT nombre FROM fabricante tablaf WHERE NOT EXISTS(SELECT 1 FROM producto tablap WHERE tablap.codigo_fabricante = tablaf.codigo);

-- SUBCONSULTA CORRELACIONADAS

-- 15. 
SELECT fabricante.nombre FROM fabricante WHERE precio >= (SELECT precio FROM producto WHERE codigo_fabricante = fabricante.codigo);

