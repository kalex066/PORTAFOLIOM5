-- creacion de tablas
CREATE TABLE persona (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    edad INT DEFAULT NULL
);
CREATE TABLE actividad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    hora TIME NOT NULL,
    dia VARCHAR(15) NOT NULL
);
-- tabla intermedia, con relacion muchos a muchos (una persona puede realizar muchas actividades, y una actividad la pueden realizar varias personas)
CREATE TABLE persona_actividad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    persona_id INT NOT NULL,
    actividad_id INT NOT NULL,
    FOREIGN KEY (persona_id) REFERENCES persona(id),
    FOREIGN KEY (actividad_id) REFERENCES actividad(id)
);
-- Insertar registros para poblar las tablas y la database
-- insertando personas
INSERT INTO persona (nombre, edad) VALUES 
('Amy', 10),
('David', 6),
('Papá', 40),
('Mamá', 35);
SELECT * FROM persona; -- select para ver como quedo la tabla

-- insertando actividades
INSERT INTO actividad (nombre, hora, dia) VALUES
('Clase de ballet', '16:00:00', 'Lunes'),
('Clase de ballet', '16:00:00', 'Martes'),
('Clase de ballet', '16:00:00', 'Miercoles'),
('Clase de ballet', '16:00:00', 'Jueves'),
('Clase de ballet', '16:00:00', 'Viernes'),
('Clase de pilates', '16:00:00', 'Martes'),
('Clase de pilates', '16:00:00', 'Jueves'),
('Llevar a Amy al ballet', '15:30:00', 'Lunes'),
('Llevar a Amy al ballet', '15:30:00', 'Martes'),
('Llevar a Amy al ballet', '15:30:00', 'Miercoles'),
('Llevar a Amy al ballet', '15:30:00', 'Jueves'),
('Llevar a Amy al ballet', '15:30:00', 'Viernes'),
('Hacer ejercicio', '9:30:00', 'Lunes'),
('Hacer ejercicio', '9:30:00', 'Miercoles'),
('Hacer ejercicio', '9:30:00', 'Viernes'),
('Llevar a David al futbol', '18:30:00', 'Martes'),
('Clase de futbol', '19:00:00', 'Martes'),
('Llevar a David al ajedrez', '19:00:00', 'Jueves'),
('Clase de ajedrez', '19:30:00', 'Jueves'),
('Clase de ingles', '14:00:00', 'Sabado'),
('Llevar a David a clase de musica', '10:30:00', 'Sabado'),
('Clase de música', '11:00:00', 'Sabado'),
('Bootcamp', '18:00:00', 'Lunes'),
('Bootcamp', '18:00:00', 'Martes'),
('Bootcamp', '18:00:00', 'Miercoles'),
('Bootcamp', '18:00:00', 'Jueves'),
('Bootcamp', '18:00:00', 'Viernes');
SELECT * FROM actividad; -- select para validar como se registraron los datos en la tabla

-- insertando asociacion persona vs actividad
-- Amy
INSERT INTO persona_actividad (persona_id, actividad_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), -- Clase de ballet
(1, 6), (1, 7), -- Clase de Pilates
(1, 20); -- Clase de inglés

-- David
INSERT INTO persona_actividad (persona_id, actividad_id) VALUES
(2, 17), -- Clase de fútbol
(2, 19), -- Clase de ajedrez
(2, 21); -- Clase de música

-- Papa
INSERT INTO persona_actividad (persona_id, actividad_id) VALUES
(3, 16), (3, 18), (3, 22); -- Papá: llevar a David a sus actividades

-- Mamá
INSERT INTO persona_actividad (persona_id, actividad_id) VALUES
(4, 8), (4, 9),(4, 10),(4, 11),(4, 12), -- llevar a Amy
(4, 13), (4, 14), (4, 15), -- hacer ejercicios
(4, 23), (4, 24), (4, 25), (4, 26), (4, 27); -- bootcamp
SELECT * FROM persona_actividad; -- select para ver como quedaron los datos en la tabla

-- -- utilizando lenguaje de manipulacion de datos
-- insertar nueva actividad
INSERT INTO actividad (nombre, hora, dia) VALUES ('Cumpleaños de Miranda', '19:00:00', 'Sabado');
-- asociando la actividad a una persona (Amy tiene una invitacion el sabado para ir al cumpleaños de Miranda)
INSERT INTO persona_actividad (persona_id, actividad_id) VALUES (1, 28);

-- cambiar hora de una actividad, la clase de ingles la profe la pospuso para las 15
UPDATE actividad
SET hora = '15:00:00'
WHERE id = 20 AND dia = 'Sabado';
-- cambiar la asignacion de una actividad, me equivoque en la asignacion: la actividad Clase de musica esta asignada al papa y le corresponde a dAvid, y la actividad llevar a David a la clase se le asigno a David y es del papa
UPDATE persona_actividad
SET persona_id = 3 WHERE actividad_id = 21;

UPDATE persona_actividad
SET persona_id = 2 WHERE actividad_id = 22;

-- elimino la actividad 27 (bootcamp de los viernes) de la mama
DELETE FROM persona_actividad
WHERE persona_id = 4 AND actividad_id = 27;

-- ver todas las actividades por dia y hora que realiza Amy
SELECT persona.nombre AS nombre_persona,
       actividad.nombre AS nombre_actividad, actividad.hora, actividad.dia 
FROM persona
JOIN persona_actividad ON persona.id = persona_actividad.persona_id
JOIN actividad ON actividad.id = persona_actividad.actividad_id
WHERE persona.nombre = 'Amy'
ORDER BY actividad.dia, actividad.hora;

-- ver todas las actividades que ocurren el dia sabado
SELECT actividad.dia,
       actividad.nombre AS nombre_actividad,
       actividad.hora,
       persona.nombre AS nombre_persona
FROM actividad
JOIN persona_actividad ON actividad.id = persona_actividad.actividad_id
JOIN persona ON persona.id = persona_actividad.persona_id
WHERE actividad.dia = 'Sabado'
ORDER BY actividad.hora;

-- ver cuantas actividades realiza cada persona ordena de manera descendente
SELECT persona.nombre AS nombre_persona,
       COUNT(persona_actividad.id) AS cantidad_actividades
FROM persona
JOIN persona_actividad ON persona.id = persona_actividad.persona_id
GROUP BY persona.id
ORDER BY cantidad_actividades DESC;

-- ver un resumen de las actividades que realiza cada persona en la semana
SELECT persona.nombre AS nombre_persona,
       actividad.dia,
       actividad.hora,
       actividad.nombre AS nombre_actividad
FROM persona
JOIN persona_actividad ON persona.id = persona_actividad.persona_id
JOIN actividad ON actividad.id = persona_actividad.actividad_id
ORDER BY persona.nombre,
         FIELD(actividad.dia, 'Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo'),
         actividad.hora;

-- Utilizar el lenguaje DDL para crear, modificar y eliminar tablas, índices y otros objetos dentro de una base de datos.
-- crear indice para la busqueda por dia
CREATE INDEX idx_dia ON actividad(dia);

-- renombrar la tabla persona_actividad
RENAME TABLE persona_actividad TO actividad_por_persona;

-- eliminar el indice que cree dos pasos atras
DROP INDEX idx_dia ON actividad;

