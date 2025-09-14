-- Creando la tabla de dueños
CREATE TABLE duenos (
id INT PRIMARY KEY
AUTO_INCREMENT,
	nombre VARCHAR (100) NOT NULL,
    correo VARCHAR (30) UNIQUE,
    telefono VARCHAR (10),
    biografia TEXT
);
-- Creando la tabla de mascotas
CREATE TABLE mascotas (
id INT PRIMARY KEY
AUTO_INCREMENT,
	nombre VARCHAR (50) NOT NULL,
    especie VARCHAR (30),
    fecha_nacimiento DATE,
    peso DECIMAL (5,2) DEFAULT 1.00,
    dueno_id INT,
    FOREIGN KEY (dueno_id)
REFERENCES duenos(id)
);
-- Insertando los valores para la tabla de dueños
INSERT INTO duenos (nombre, correo, telefono, biografia) VALUES
('Juana de Arco', 'juana@skillnest.com', '3001234567', 'Amante de los perros, especialmente los de raza grande'),
('Pedro Paramo', 'pedro@skillnest.com', '3019786543', 'Le encantan los gatos y tiene experiencia cuidando gatos rescatados'),
('Pablo Picasso', 'pablo@skillnest.com', '3025543211', 'Fanatico de las aves exóticas, colecciona guacamayas y periquitos'),
('Elena de Troya', 'elena@skillnest.com', '3032223344', 'Creció rodeada de mascotas en la finca de su familia');
-- Para verificar si se guardo la información correctamente
SELECT * FROM duenos;

-- Insertando los valores para la tabla de mascotas 
INSERT INTO mascotas (nombre, especie, fecha_nacimiento, peso, dueno_id) VALUES
('Firulais', 'perro', '2020-05-10', 25.40, 1),
('Michi', 'gato', '2021-03-15', 4.20, 2),
('Rocky', 'perro', '2018-11-20', 28.70, 3),
('Luna', 'gato', '2022-01-05', 3.80, 4),
('Kiko', 'ave', '2022-07-12', 0.10, 3),
('Nube', 'Perro', '2019-09-30', 21.5, 1),
('Sol', 'gato', '2017-02-18', 6.40, 2),
('Toby', 'perro', '2020-12-25', 20.20, 3),
('Kiwi', 'ave', '2023-04-01', 0.08, 4),
('Coco', 'perro', '2021-08-19', 12.7, 1);
-- Para consultar registros de las mascotas
SELECT * FROM mascotas;
-- Guardando una consulta dando acceso solo a ciertas columnas. Suele utilizarse cuando sé que voy a estar repitiendo la misma consulta y la quiero tener lista
CREATE VIEW vista_mascotas AS
SELECT nombre, especie FROM mascotas;

SELECT * FROM vista_mascotas;
-- Procedimiento Almacenado: un bloque de instrucciones de SQL que me permite ejecutar cuando lo invoco/llamo. Podemos realizar múltiples acciones en un solo proceso
DELIMITER //
CREATE PROCEDURE actualizar_peso_mascota(
    IN mascotaId INT,
    IN nuevoPeso DECIMAL(5,2)
)
BEGIN
    -- Actualizamos el peso
    UPDATE mascotas
    SET peso = nuevoPeso
    WHERE id = mascotaId;

    -- Mostramos la información de la mascota actualizada
    SELECT id, nombre, especie, fecha_nacimiento, peso
    FROM mascotas
    WHERE id = mascotaId;
END //
DELIMITER ;
CALL actualizar_peso_mascota(5, 2);
SELECT FROM mascota WHERE id -- Creando la tabla de dueños
CREATE TABLE duenos (
id INT PRIMARY KEY
AUTO_INCREMENT,
	nombre VARCHAR (100) NOT NULL,
    correo VARCHAR (30) UNIQUE,
    telefono VARCHAR (10),
    biografia TEXT
);
-- Creando la tabla de mascotas
CREATE TABLE mascotas (
id INT PRIMARY KEY
AUTO_INCREMENT,
	nombre VARCHAR (50) NOT NULL,
    especie VARCHAR (30),
    fecha_nacimiento DATE,
    peso DECIMAL (5,2) DEFAULT 1.00,
    dueno_id INT,
    FOREIGN KEY (dueno_id)
REFERENCES duenos(id)
);
-- Insertando los valores para la tabla de dueños
INSERT INTO duenos (nombre, correo, telefono, biografia) VALUES
('Juana de Arco', 'juana@skillnest.com', '3001234567', 'Amante de los perros, especialmente los de raza grande'),
('Pedro Paramo', 'pedro@skillnest.com', '3019786543', 'Le encantan los gatos y tiene experiencia cuidando gatos rescatados'),
('Pablo Picasso', 'pablo@skillnest.com', '3025543211', 'Fanatico de las aves exóticas, colecciona guacamayas y periquitos'),
('Elena de Troya', 'elena@skillnest.com', '3032223344', 'Creció rodeada de mascotas en la finca de su familia');
-- Para verificar si se guardo la información correctamente
SELECT * FROM duenos;

-- Insertando los valores para la tabla de mascotas 
INSERT INTO mascotas (nombre, especie, fecha_nacimiento, peso, dueno_id) VALUES
('Firulais', 'perro', '2020-05-10', 25.40, 1),
('Michi', 'gato', '2021-03-15', 4.20, 2),
('Rocky', 'perro', '2018-11-20', 28.70, 3),
('Luna', 'gato', '2022-01-05', 3.80, 4),
('Kiko', 'ave', '2022-07-12', 0.10, 3),
('Nube', 'Perro', '2019-09-30', 21.5, 1),
('Sol', 'gato', '2017-02-18', 6.40, 2),
('Toby', 'perro', '2020-12-25', 20.20, 3),
('Kiwi', 'ave', '2023-04-01', 0.08, 4),
('Coco', 'perro', '2021-08-19', 12.7, 1);
-- Para consultar registros de las mascotas
SELECT * FROM mascotas;
-- Guardando una consulta dando acceso solo a ciertas columnas. Suele utilizarse cuando sé que voy a estar repitiendo la misma consulta y la quiero tener lista
CREATE VIEW vista_mascotas AS
SELECT nombre, especie FROM mascotas;

SELECT * FROM vista_mascotas;
-- Procedimiento Almacenado: un bloque de instrucciones de SQL que me permite ejecutar cuando lo invoco/llamo. Podemos realizar múltiples acciones en un solo proceso
DELIMITER //
CREATE PROCEDURE actualizar_peso_mascota(
    IN mascotaId INT,
    IN nuevoPeso DECIMAL(5,2)
)
BEGIN
    -- Actualizamos el peso
    UPDATE mascotas
    SET peso = nuevoPeso
    WHERE id = mascotaId;

    -- Mostramos la información de la mascota actualizada
    SELECT id, nombre, especie, fecha_nacimiento, peso
    FROM mascotas
    WHERE id = mascotaId;
END //
DELIMITER ;

CALL actualizar_peso_mascota(3, 20);

-- crear funcion
DELIMITER //
CREATE FUNCTION contar_mascotas() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM mascotas;
    RETURN total;
END //
DELIMITER ;
SELECT contar_mascotas();
DELIMITER //
-- crear una funcion
CREATE FUNCTION contar_mascotas() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM mascotas;
    RETURN total;
END //
DELIMITER ;
SELECT contar_mascotas();

SELECT * FROM mascotas WHERE nombre = "Michi";

CREATE INDEX idx_nombre_mascota ON mascotas(nombre);

