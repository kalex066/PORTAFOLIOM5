-- VEO LA INFORMACION DE LAS DOS TABLAS
SELECT * FROM usuarios;
SELECT * FROM direcciones;

-- UNION ENTRE USUARIOS Y DIRECCIONES. RELACIÓN (1:1)
-- JOIN igualo la llave primaria de la tabla2(direcciones) a la llave foranea de la tabla1(usuarios)
SELECT * FROM usuarios
JOIN direcciones ON direcciones.id = direccion_id; -- puedo intercambiar el orden de los identificadores siempre y cuando respete la realación
SELECT * FROM usuarios
JOIN direcciones ON direccion_id = direcciones.id;
-- aqui estoy eliminando que me muestre la columna de id de la tabla de direcciones, es decir que puedo nombrar solo las columnas que quiero ver
SELECT usuarios.*, calle, num, ciudad, cp FROM usuarios
JOIN direcciones ON direcciones.id = direccion_id;

-- UNION ENTRE PEDIDIOS Y USUARIOS RELACION UNO A MUCHOS (1:n), LA LLAVE FORANEA DEBE ESTAR EN LA TABLA DE MUCHOS, PORQUE UN PEDIDO PERTENECE SOLO A UN USUARIO
-- SELECT columnas FROM <tabla1> la tabla que un usuario puede tener n pedidos
-- JOIN <tabla2> ON <tabla1>.llave_foranea = <tabla2>.llave_primaria
SELECT * FROM pedidos
JOIN usuarios ON pedidos.usuario_id = usuarios.id;
-- si coloco la relación al reves, la única diferencia es que me muestra primero la tabal de usuarios
SELECT * FROM usuarios
JOIN pedidos ON pedidos.usuario_id = usuarios.id;
-- LAs dos consultas anteriores Muestran solamente usuarios que hicieron pedido

-- Mostrar TODOS usuarios sin importar si hicieron o no pedido
SELECT * FROM usuarios
LEFT JOIN pedidos ON pedidos.usuario_id = usuarios.id; -- muestra todos los usuarios tabla1 izquierta y tabla 2 derecho, selecciona todos los usuarios y une con los que hicieron pedidos

-- UNION ENTRE USUARIOS Y USUARIOS_HAS_HOBBIES + USUARIOS_HAS:HOBBIES Y HOBBIES, RELACION MUCHOS A MUCHOS (n:m). SE CREA UNA TABLA INTERMEDIA
-- SELECT columnas FROM <tabla1>
-- JOIN <tabla_intermediaria> ON <tabla1>.llave_primaria = <tabla_intermediaria>.llave_foranea
-- JOIN <tabla2> ON <tabla2>.llave_primaria = <tabla_intermediaria>.llave_foranea
SELECT * FROM usuarios
JOIN usuarios_has_hobbies ON usuarios.id = usuarios_has_hobbies.usuario_id
JOIN hobbies ON hobbies.id = usuarios_has_hobbies.hobbie_id;

-- Muestra de la tabla usuarios, el nombre y la actividad, donde la actividad empiece con C y los ordene de forma ascendente
SELECT usuarios.id, nombre, actividad FROM usuarios
JOIN usuarios_has_hobbies ON usuarios.id = usuarios_has_hobbies.usuario_id
JOIN hobbies ON hobbies.id = usuarios_has_hobbies.hobbie_id
WHERE actividad LIKE "C%"
ORDER by nombre ASC;

-- ORDEN DE LOS SELECTS INCLUYENDO JOINS
-- SELECT columna1, columna2, columna3, * FROM <tabla>
-- JOINS
-- WHERE <condicional> AND OR <condicional>
-- ORDER BY columna1 ASC/DESC
-- LIMIT inicio, cantidad