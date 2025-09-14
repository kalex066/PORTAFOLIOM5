-- Query = Consulta (Instrucción que se manda al servidor para hacer algo en específico: Seleccionar, Guardar, Actualizar, Borrar)
-- CRUD: Create, Read, Update, Delete: Crear, Leer, Actualizar, Borrar
-- SELECT: Seleccionar información de una tabla -> READ

-- SELECT * FROM <tabla>; -> Seleccionando todas las columnas de una tabla específica
SELECT * FROM usuarios;

-- SELECT columna1, columna2, columna3 FROM <tabla>; Mostrando columnas específicas
SELECT nombre, edad FROM usuarios;

-- SELECT columna1, columna2, columna3 FROM <tabla> WHERE <condicional>; "Filtrando" los registros que quiero mostrar
SELECT nombre, edad FROM usuarios WHERE id = 2; 

-- Select con una condicional
SELECT * FROM usuarios WHERE edad > 20;

-- select en base al nombre, es indistinto si uso mayusculas y minusculas
SELECT * FROM usuarios WHERE nombre LIKE "aureliano";

-- select con simbolo de porcentaje para hacer una comparacion parcial, un comodin % comodin. Puede tener cualquier caracter sirve para numemros si estan declarados como char
SELECT nombre FROM usuarios WHERE nombre LIKE "Al%";
-- select a todos los registros que terminen con o
SELECT nombre FROM usuarios WHERE nombre LIKE "%o";
-- select a todos los registros que en cualquier posición tenga una letra e
SELECT nombre FROM usuarios WHERE nombre LIKE "%e%";

-- AND: Ambas condicionales se cumplan, pueden ser las condicionales que quiera
SELECT * FROM usuarios WHERE nombre LIKE "%o" AND edad > 23;

-- OR: Una u otra condicional se cumpla, pueden ser varias condicionales
SELECT * FROM usuarios WHERE nombre LIKE "%o" OR edad > 23;

-- ordenar descendiente o ascendente, por defecto si no lo indico lo hace de manera ascendente (menor a mayor ó a-z)
SELECT * FROM usuarios WHERE edad > 25 ORDER BY nombre ASC;
SELECT * FROM usuarios WHERE edad > 25 ORDER BY nombre DESC;

SELECT * FROM usuarios WHERE edad > 25 ORDER BY edad DESC;

-- puedo poner límites de la cantidad de registros que quiero que se muestren; indicando el inicio (donde quiero que empiece y la cantidad de registros)
SELECT * FROM usuarios;
SELECT * FROM usuarios LIMIT 0, 3;-- EMPIEZA EN EL REGISTRO CERO
SELECT * FROM usuarios LIMIT 3, 3;-- EMPIEZAE EN EL REGISTRO CUATRO

-- RESUMEN Y ORDEN EN QUE SE EMPLEAN LOS COMANDOS PARA EL SELECT
-- SELECT columna1, columna2, columna3, * FROM <tabla>
-- WHERE <condicional> AND OR <condicional>
-- ORDER BY columna1 ASC/DESC
-- LIMIT inicio, cantidad

