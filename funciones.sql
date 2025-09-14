-- Funciones de Texto
SELECT CONCAT(nombre," " ,edad) AS username FROM usuarios; -- CONCAT pega texto. JOIN pega tablas
SELECT CONCAT(nombre,edad) AS username FROM usuarios;
SELECT LENGTH(nombre) AS tamanio, nombre FROM usuarios; -- cuenta los espacios en blanco
SELECT UPPER(nombre) as NOMBRE FROM usuarios; -- lower funciona igual

-- Funciones numéricas
SELECT * FROM pedidos;
SELECT SUM(total) FROM pedidos;
SELECT AVG(envio) FROM pedidos;
SELECT id, ROUND(total) FROM pedidos;
SELECT ROUND(AVG(envio)) FROM pedidos;
SELECT MAX(total) FROM pedidos;
SELECT MIN(total) FROM pedidos;

-- Funciones de Fechas
SELECT NOW(); --  Fecha y hora ->INSERT UPDATE
SELECT CURDATE(); -- CURRENT DATE fecha actual
SELECT DATE_FORMAT(created_at, "%a %D, %c %y"), created_at FROM pedidos; -- cambio el formato de la fecha
-- agregacion: contar registros de una columna
SELECT COUNT(*) FROM pedidos;
SELECT COUNT(*) FROM usuarios;
SELECT COUNT(*) FROM hobbies;

-- Agrupaciones
SELECT * FROM pedidos ORDER BY usuario_id; -- el promedio de cuanto ha gastado cada usuario
SELECT AVG(total), usuario_id 
FROM pedidos
GROUP BY usuario_id;

SELECT COUNT(*), usuario_id -- cuenta los pedidos que hizo cada usuario
FROM pedidos
GROUP BY usuario_id;

SELECT usuario_id, COUNT(*) as cantidad_pedidos, AVG(total), SUM(total) -- cantidad de pedidos, promedio y total de pedidos de cada usuario
FROM pedidos
GROUP BY usuario_id;

SELECT usuario_id, COUNT(*) as cantidad_pedidos, AVG(total), SUM(total) -- los usuarios que tengan mas de un pedido, organizados igual que el ejemplo anterior
FROM pedidos
GROUP BY usuario_id
HAVING cantidad_pedidos > 1;

-- SELECT columna1, columna2, columna3, * FROM <tabla>
-- JOINS
-- WHERE <condicional> AND OR <condicional>
-- GROUP BY
-- HAVING
-- ORDER BY columna1 ASC/DESC
-- LIMIT inicio, cantidad