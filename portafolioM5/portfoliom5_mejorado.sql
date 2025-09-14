-- CREACION DE TABLAS
CREATE TABLE persona (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    edad INT DEFAULT NULL
);
CREATE TABLE actividades (
    id_actividad INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    tipo ENUM('fija', 'esporadica') NOT NULL,
    descripcion TEXT
);
CREATE TABLE asignaciones (
    id_asignacion INT PRIMARY KEY AUTO_INCREMENT,
    id_actividad INT NOT NULL,
    id_persona INT NOT NULL,
    FOREIGN KEY (id_actividad) REFERENCES actividades(id_actividad),
    FOREIGN KEY (id_persona) REFERENCES persona(id)
);

CREATE TABLE calendario (
    id_evento INT PRIMARY KEY AUTO_INCREMENT,
    id_actividad INT NOT NULL,
    fecha_inicio DATETIME NOT NULL,
    fecha_fin DATETIME NOT NULL,
    repeticion ENUM('única', 'diaria', 'semanal', 'mensual') DEFAULT 'única',
    observaciones TEXT,
    FOREIGN KEY (id_actividad) REFERENCES actividades(id_actividad)
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
INSERT INTO actividades (nombre, tipo, descripcion) VALUES
('Clase de ballet', 'fija', 'Clase de ballet para Amy de lunes a viernes'), -- actividad 1
('Clase de pilates', 'fija', 'Pilates para Amy los martes y jueves'), -- actividad 2
('Clase de fútbol', 'fija', 'Futbol para David los martes'), -- actividad 3
('Clase de ajedrez', 'fija', 'Ajedrez para David los jueves'), -- actividad 4
('Clase de inglés', 'fija', 'Ingles para Amy los sabados'), -- -- actividad 5
('Clase de música', 'fija', 'Musica para David los sabados'), -- -- actividad 6
('Bootcamp', 'fija', 'Ejercicio para Mama de lunes a viernes'), -- -- actividad 7
('Ejercicio personal', 'fija', 'Rutina de Mama lunes, miercoles y viernes'), -- -- actividad 8
('Traslado de Amy al ballet', 'fija', 'Mama lleva a Amy al ballet todos los días'), -- -- actividad 9
('Traslado de David a actividades', 'fija', 'Papa lleva a David a futbol, ajedrez y musica'), -- -- actividad 10
('Cita odontólogo familiar', 'esporadica', 'Control dental semestral para Amy, David, Mamá y Papá en enero y diciembre'), -- actividad 11
('Cita pediatra anual', 'esporadica', 'Chequeo médico anual para Amy y David en julio'), -- actividad 12
('Llevar auto al taller', 'esporadica', 'Papá lleva el auto al taller cuando se requiere'),-- -- actividad 13
('Cumpleaños de Emma', 'esporadica', 'Celebración familiar el 7 de julio'); -- actividad 14

SELECT * FROM actividades; -- select para ver como quedaron los datos en la tabla

-- inserto los datos de la tabla  asignaciones de las actividades fijas
INSERT INTO asignaciones (id_persona, id_actividad) VALUES
(1, 1), (1, 2), (1, 5), -- Amy
(2, 3), (2, 4), (2, 6), -- David
(3, 10), -- Papa
(4, 7), (4, 8), (4, 9);-- Mama

-- ahora inserto actividades esporadicas en la tabla de asignaciones

INSERT INTO asignaciones (id_persona, id_actividad) VALUES
(1, 11), (2, 11), (3, 11), (4, 11), -- Cita odontólogo familiar (id_actividad = 11)
(1, 12), (2, 12), -- Cita pediatra anual (id_actividad = 12)
(3, 13),-- Llevar auto al taller (id_actividad = 13)
(1, 14), (2, 14), (3, 14), (4, 14); -- Cumpleaños de Emma (id_actividad = 14)

SELECT * FROM asignaciones; -- select para ver los datos en la tabla

-- insertando datos en la tabla calendario, a las actividades fijas le coloco fecha de septiembre y a las esporadicas la que corresponde
INSERT INTO calendario (id_actividad, fecha_inicio, fecha_fin, repeticion, observaciones) VALUES
(1, '2025-09-15 16:00:00', '2025-09-15 17:00:00', 'semanal', 'Clase de ballet - lunes'),
(1, '2025-09-16 16:00:00', '2025-09-16 17:00:00', 'semanal', 'Clase de ballet - martes'),
(1, '2025-09-17 16:00:00', '2025-09-17 17:00:00', 'semanal', 'Clase de ballet - miércoles'),
(1, '2025-09-18 16:00:00', '2025-09-18 17:00:00', 'semanal', 'Clase de ballet - jueves'),
(1, '2025-09-19 16:00:00', '2025-09-19 17:00:00', 'semanal', 'Clase de ballet - viernes'), -- Ballet lunes a viernes
(2, '2025-09-16 16:00:00', '2025-09-16 17:00:00', 'semanal', 'Pilates - martes'),
(2, '2025-09-18 16:00:00', '2025-09-18 17:00:00', 'semanal', 'Pilates - jueves'), -- Pilates martes y jueves
(3, '2025-09-16 19:00:00', '2025-09-16 20:00:00', 'semanal', 'Fútbol - martes'), -- Fútbol martes
(4, '2025-09-18 19:30:00', '2025-09-18 20:30:00', 'semanal', 'Ajedrez - jueves'), -- Ajedrez jueves
(5, '2025-09-20 14:00:00', '2025-09-20 15:00:00', 'semanal', 'Inglés - sábado'), -- Inglés sábado
(6, '2025-09-20 11:00:00', '2025-09-20 12:00:00', 'semanal', 'Música - sábado'), -- Música sábado
(7, '2025-09-15 18:00:00', '2025-09-15 19:00:00', 'semanal', 'Bootcamp - lunes'),
(7, '2025-09-16 18:00:00', '2025-09-16 19:00:00', 'semanal', 'Bootcamp - martes'),
(7, '2025-09-17 18:00:00', '2025-09-17 19:00:00', 'semanal', 'Bootcamp - miércoles'),
(7, '2025-09-18 18:00:00', '2025-09-18 19:00:00', 'semanal', 'Bootcamp - jueves'),
(7, '2025-09-19 18:00:00', '2025-09-19 19:00:00', 'semanal', 'Bootcamp - viernes'),-- Bootcamp lunes a viernes
(8, '2025-09-15 09:30:00', '2025-09-15 10:30:00', 'semanal', 'Ejercicio - lunes'),
(8, '2025-09-17 09:30:00', '2025-09-17 10:30:00', 'semanal', 'Ejercicio - miércoles'),
(8, '2025-09-19 09:30:00', '2025-09-19 10:30:00', 'semanal', 'Ejercicio - viernes'), -- Ejercicio personal lunes, miércoles, viernes
(9, '2025-09-15 15:30:00', '2025-09-15 16:00:00', 'semanal', 'Traslado ballet - lunes'),
(9, '2025-09-16 15:30:00', '2025-09-16 16:00:00', 'semanal', 'Traslado ballet - martes'),
(9, '2025-09-17 15:30:00', '2025-09-17 16:00:00', 'semanal', 'Traslado ballet - miércoles'),
(9, '2025-09-18 15:30:00', '2025-09-18 16:00:00', 'semanal', 'Traslado ballet - jueves'),
(9, '2025-09-19 15:30:00', '2025-09-19 16:00:00', 'semanal', 'Traslado ballet - viernes'), -- Traslados de Amy
(10, '2025-09-16 18:30:00', '2025-09-16 19:00:00', 'semanal', 'Traslado fútbol - martes'),
(10, '2025-09-18 19:00:00', '2025-09-18 19:30:00', 'semanal', 'Traslado ajedrez - jueves'),
(10, '2025-09-20 10:30:00', '2025-09-20 11:00:00', 'semanal', 'Traslado música - sábado'), -- Traslados de David
(11, '2025-01-15 10:00:00', '2025-01-15 11:30:00', 'única', 'Cita odontológica semestral - enero'),-- odontologo semestral para todos
(11, '2025-12-15 10:00:00', '2025-12-15 11:30:00', 'única', 'Cita odontológica semestral - diciembre'),-- odontologo semestral para todos
(12, '2025-07-10 09:00:00', '2025-07-10 10:00:00', 'única', 'Chequeo pediátrico anual para Amy y David'), -- Chequeo pediatrico anual
(13, '2025-09-18 08:30:00', '2025-09-18 10:00:00', 'única', 'Papá lleva el auto al taller para revisión técnica'),-- llevar auto al taller
(14, '2025-07-07 17:00:00', '2025-07-07 20:00:00', 'única', 'Fiesta de cumpleaños de Emma en Mc Donalds');-- cumpleaños de emma
SELECT * FROM calendario; -- select para ver los datos en la tabla

-- Implementar consultas de inserción (INSERT), actualización (UPDATE) y eliminación (DELETE) para modificar los datos dentro de las tablas.
-- Insertar una nueva actividad, reunion de apoderados
INSERT INTO actividades (nombre, tipo, descripcion)
VALUES ('Reunión de apoderados Colegio Amy', 'esporadica', 'Reunion para presentar actividades del ultimo trimestre');-- actividad 15
-- le asigno la actividad al papa que es quien ira a la reunion
INSERT INTO asignaciones (id_persona, id_actividad)
VALUES (3, 15); 
-- agrego la reunión de apoderados al calendario
INSERT INTO calendario (id_actividad, fecha_inicio, fecha_fin, repeticion, observaciones)
VALUES (15, '2025-09-25 18:00:00', '2025-09-25 19:30:00', 'única', 'Reunión en el colegio de Amy');

-- actualizar la fecha de una actividad; cita con el pediatra de Amy y David
UPDATE calendario
SET fecha_inicio = '2025-07-15 09:00:00', fecha_fin = '2025-07-24 10:00:00'
WHERE id_actividad = 12 AND repeticion = 'única';
-- actualizar la descripción de la actividad Clase de ballet
SET SQL_SAFE_UPDATES = 0; -- tengo el sql en modo seguro y no me reconocia el codigo

UPDATE actividades
SET descripcion = 'Clase de ballet para Amy todos los días hábiles'
WHERE nombre = 'Clase de ballet';

-- Deletes
-- Papa no va a asisitr al cumpleaños de Emma
DELETE FROM asignaciones
WHERE id_persona = 3 AND id_actividad = 14;
-- Eliminar la cita odontologica de enero del calendario
DELETE FROM calendario
WHERE id_actividad = 11 AND fecha_inicio = '2025-01-15 10:00:00';

-- Desarrollar consultas SQL para obtener información específica de las tablas, utilizando cláusulas como SELECT, WHERE, JOIN, GROUP BY, entre otras.
-- Ver todas las actividades asignadas a cada persona
SELECT persona.nombre AS persona,
       actividades.nombre AS actividad, actividades.tipo, actividades.descripcion
FROM asignaciones
JOIN persona ON asignaciones.id_persona = persona.id
JOIN actividades ON asignaciones.id_actividad = actividades.id_actividad
ORDER BY persona.nombre;

-- ver actividades que ocurren el dia martes
SELECT actividades.nombre,
       calendario.fecha_inicio,
       persona.nombre AS persona
FROM calendario
JOIN actividades ON calendario.id_actividad = actividades.id_actividad
JOIN asignaciones ON actividades.id_actividad = asignaciones.id_actividad
JOIN persona ON asignaciones.id_persona = persona.id
WHERE DAYNAME(calendario.fecha_inicio) = 'Tuesday';

-- ver cuantas actividades tiene cada persona
SELECT persona.nombre,
       COUNT(*) AS total_actividades
FROM asignaciones
JOIN persona ON asignaciones.id_persona = persona.id
GROUP BY persona.nombre;

-- ver actividades esporadicas del mes de julio
SELECT actividades.nombre,
       calendario.fecha_inicio,
       calendario.observaciones
FROM calendario
JOIN actividades ON calendario.id_actividad = actividades.id_actividad AND MONTH(calendario.fecha_inicio) = 7;

-- Utilizar el lenguaje DDL para crear, modificar y eliminar tablas, índices y otros objetos dentro de una base de datos.
-- Cambiar tipo de dato de la edad de integer a smallint
ALTER TABLE persona
MODIFY COLUMN edad SMALLINT;
-- cambiar el nombre de la columna "descripcion" a "detalle"
ALTER TABLE actividades
CHANGE COLUMN descripcion detalle TEXT;
-- crear columna e mail en la tabla personas
ALTER TABLE persona
ADD COLUMN email VARCHAR(100);
-- eliminar de la tabla personas la columna de e-mail
ALTER TABLE persona
DROP COLUMN email;
-- eliminar tabla asignaciones
DROP TABLE asignaciones; -- NO EJECUTADO


SET SQL_SAFE_UPDATES = 1; -- Vuelvo a activar el modo seguro
