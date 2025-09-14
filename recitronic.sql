-- 1. Crear database y tablas
CREATE DATABASE recitronic;
USE recitronic;

CREATE TABLE clientes (
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(75) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    telefono VARCHAR(15) NOT NULL
    );
   
CREATE TABLE articulos (
	id_articulo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo_articulo VARCHAR (50) NOT NULL,
    estado VARCHAR (15) NOT NULL DEFAULT 'pendiente',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE
      );
           
CREATE TABLE citas (
	id_cita INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha_hora DATETIME NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE
    );
    
CREATE TABLE pagos (
	id_pago INT AUTO_INCREMENT PRIMARY KEY,
	id_cliente INT,
    monto DECIMAL (8,2) NOT NULL,
	fecha_pago DATETIME NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE
    );
    
-- 2.1 Insertar datos a las tablas creadas
-- Insertar clientes
INSERT INTO clientes (nombre, direccion, telefono) VALUES 
('Pedro Perez', 'Adriana Cousiño 130', '987654321'),
('Maria Lopez', 'Av San Carlos 123', '963258741'),
('Juana Rodriguez', 'Independencia 345', '911223344'),
('Alberto Plaza', 'Pedro de Valdivia 987', '955667788'),
('Carmen Sifuentes', 'Los leones 125', '999887744');

-- Insertar artículo
INSERT INTO articulos (id_cliente, tipo_articulo, estado) VALUES 
(1, 'Televisor', 'pendiente'),
(3, 'Camara xd5', 'retirado'),
(5, 'telefono 123', 'retirado'),
(2, 'telefono 456', 'pendiente'),
(2, 'impresora xse', 'pendiente'),
(4, 'notebook 589', 'pendiente'),
(1, 'desktop 56', 'retirado'),
(3, 'monitor 12´´', 'retirado'),
(5, 'Televisor 451', 'retirado');

-- Insertar cita
INSERT INTO citas (id_cliente, fecha_hora) VALUES 
(1, '2025-08-30 11:30:00'),
(2, '2025-08-28 8:00:00'),
(4, '2025-08-30 11:00:00'),
(1, '2025-08-29 9:00:00');

-- Insertar pago
INSERT INTO Pagos (id_cliente, monto, fecha_pago) VALUES
(1, 10000.00, '2025-08-02 14:00:00'),
(2, 5000.00, '2025-08-04 15:00:00'),
(3, 3000.00, '2025-08-20 11:00:00'),
(4, 1500.00, '2025-08-24 11:00:00'),
(5, 21000.00, '2025-08-22 10:00:00'),
(1, 8000.00, '2025-08-20 10:00:00'),
(1, 9000.00, '2025-08-24 10:00:00'),
(4, 7000.00, '2025-08-22 8:00:00');

-- 2.2 Actualizar información sobre las citas y el estado de los artículos reciclados.
-- Cambiar fecha de cita
UPDATE citas
SET fecha_hora = '2025-08-30 18:00:00'
WHERE id_cita = 2;
-- select para ver los cambios
SELECT * FROM Citas WHERE id_cita = 2;

-- Cambiar estado del artículo
UPDATE articulos
SET estado = 'reciclado'
WHERE id_articulo = 4;
-- select para ver los cambios
SELECT * FROM Articulos WHERE id_articulo = 4;


-- 2.3 Eliminar registros de artículos y citas cuando sea necesario.
-- Eliminar artículo por error
-- Verificar que el artículo existe antes de eliminar
SELECT * FROM articulos WHERE id_articulo = 3;
-- Eliminar el artículo
DELETE FROM articulos WHERE id_articulo = 3;
-- Confirmar que fue eliminado
SELECT * FROM articulos WHERE id_articulo = 3;

-- Eliminar cita 
-- Verificar que la cita existe antes de eliminar
SELECT * FROM Citas WHERE id_cita = 1;
-- Eliminar la cita
DELETE FROM Citas WHERE id_cita = 1;
-- Confirmar que fue eliminada
SELECT * FROM Citas WHERE id_cita = 1;

-- 3. Demostrar el Uso de Transacciones
-- Crear una transacción que incluya insertar datos, actualizar registros y eliminar registros. Asegurarse de que las operaciones sean atómicas
START TRANSACTION;
-- 1️⃣ INSERTAR: Nuevo cliente
INSERT INTO clientes (nombre, direccion, telefono)
VALUES ('Marcela Soto', 'Independencia 147', '978451296');

-- 2️⃣ ACTUALIZAR estado de un artículo existente
UPDATE Articulos
SET estado = 'reciclado'
WHERE id_articulo = 2;
-- 3️⃣ ELIMINAR una cita cancelada
DELETE FROM Citas
WHERE id_cita = 4;
-- Confirmar los cambios
COMMIT;
-- visualizando cambios de la transaccion
-- Ver nuevo cliente
SELECT * FROM clientes;
-- Ver estado actualizado del artículo
SELECT * FROM Articulos WHERE id_articulo = 2;
-- Verificar que la cita fue eliminada
SELECT * FROM Citas WHERE id_cita = 4;

START TRANSACTION;

INSERT INTO clientes (nombre, direccion, telefono)
VALUES ('Carlos Ruiz', 'Jorge Ross 874', '936251445');

-- Error: id_cliente 25 no existe
INSERT INTO citas (id_cliente, fecha_hora)
VALUES (25, '2025-09-02 15:00:00');

ROLLBACK;
