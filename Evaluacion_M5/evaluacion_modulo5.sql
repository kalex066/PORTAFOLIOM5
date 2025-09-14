
CREATE TABLE Proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    cantidad_inventario INT NOT NULL CHECK (cantidad_inventario >= 0)
);

CREATE TABLE Transacciones (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('compra', 'venta') NOT NULL,
    fecha DATE NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    id_producto INT NOT NULL,
    id_proveedor INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor)
);

-- DML
-- insertar datos en tabla de productos
INSERT INTO productos (nombre, descripcion, precio, cantidad_inventario) VALUES
('Laptop', 'lenovo 11 va generacion', 1200000, 15),
('Mouse', 'Mouse inalámbrico verde hp', 15000, 50),
('Teclado', 'Teclado rooo', 45000, 30),
('Monitor 24"', 'Monitor LED Full HD', 95000, 20),
('Impresora laser', 'Impresora hp a color', 85000, 10),
('Router WiFi', 'Router de doble banda', 60000, 25),
('Disco SSD 1TB', 'Almacenamiento rápido', 110000, 40),
('Memoria RAM 16GB', 'DDR4 para PC', 75000, 35),
('Cámara Web HD', 'lenovo full resolucion', 30000, 18),
('Auriculares Bluetooth', 'diseño stich', 55000, 22);

-- insertar datos tabla proveedores 
INSERT INTO proveedores (nombre, direccion, telefono, email) VALUES
('Wei Chile', 'Pedro Lautaro Ferrer 2031', '987654321', 'ventas@wei.cl'),
('Compuproveedor', 'Calle Norte 456', '912345678', 'contacto@compuexpress.cl'),
('CompuSoluciones', 'Apoquindo 5950', '956789012', 'ventas@compusoluciones.cl'),
('DigitalStore', 'Mall Plaza Vespucio Local 45', '934567890', 'info@digitalstore.cl'),
('Gtek', 'Mall Plaza Nuñoa 127', '923456789', 'ventas@gtek.cl'),
('Onei', 'La Capitania 80', '945678901', 'ventas@onei.cl'),
('PcFactory', 'Paseo Estado 235', '967890123', 'info@pcfactory.cl'),
('SPDigital', 'Padre MAriano 356', '978901234', 'ventas@spd.cl'),
('PC Express', 'San Carlos 857', '989012345', 'ventas@pcexpress.cl'),
('Tecno Systems', 'Providencia 8888', '990123456', 'comercial@technosystems.cl');

-- insertar datos tabla de transacciones
INSERT INTO transacciones (tipo, fecha, cantidad, id_producto, id_proveedor) VALUES
('compra', '2025-08-01', 10, 1, 1),
('venta', '2025-08-02', 2, 1, 1),
('compra', '2025-08-03', 20, 2, 2),
('venta', '2025-08-04', 5, 2, 2),
('compra', '2025-08-05', 15, 3, 3),
('venta', '2025-08-06', 3, 3, 3),
('compra', '2025-08-07', 10, 4, 4),
('venta', '2025-08-08', 4, 4, 4),
('compra', '2025-08-09', 5, 5, 5),
('venta', '2025-08-10', 2, 5, 5);

-- Actualiza la cantidad de inventario de un producto después de una venta o compra.
-- despues de la venta de dos unidades de producto, id_producto 1
UPDATE productos
SET cantidad_inventario = cantidad_inventario - 2
WHERE id_producto = 1;


-- despues de la compra de 3 productos, id producto 2
UPDATE productos
SET cantidad_inventario = cantidad_inventario + 3
WHERE id_producto = 2;

-- Elimina un producto de la base de datos si ya no está disponible.
DELETE FROM productos
WHERE id_producto = 5 AND cantidad_inventario = 0;

-- CONSULTAS BASICAS
-- Recupera todos los productos disponibles en el inventario.
SELECT * FROM Productos WHERE cantidad_inventario > 0;

-- Recupera todos los proveedores que suministran productos específicos.
SELECT nombre, telefono, email FROM proveedores
JOIN transacciones ON proveedores.id_proveedor = transacciones.id_proveedor
WHERE transacciones.tipo = 'compra'
GROUP BY nombre, telefono, email;

-- Consulta las transacciones realizadas en una fecha específica.
SELECT * FROM Transacciones WHERE fecha = '2025-08-01';

-- Realiza consultas de selección con funciones de agrupación, como COUNT() y SUM(), para calcular el número total de productos vendidos o el valor total de las compras.
-- numero total de productos vendidos
SELECT SUM(cantidad) AS total_vendido
FROM Transacciones
WHERE tipo = 'venta';

-- Valor total de compras
SELECT SUM(cantidad * precio) AS total_compras
FROM Transacciones
JOIN Productos ON Transacciones.id_producto = Productos.id_producto
WHERE tipo = 'compra';

-- Transacciones SQL
-- Realiza una transacción para registrar una compra de productos. Utiliza el comando BEGIN TRANSACTION, COMMIT y ROLLBACK para asegurar que los cambios se apliquen correctamente.
-- comprar 8 unidades del producto id_producto 2 al proveedor con id_proveedor 6
START TRANSACTION;
-- compra
INSERT INTO transacciones (tipo, fecha, cantidad, id_producto, id_proveedor)
VALUES ('compra', '2025-08-31', 8, 2, 6);
-- Actualizar el inventario del producto
UPDATE productos
SET cantidad_inventario = cantidad_inventario + 8
WHERE id_producto = 2;
-- Confirmar si todo salió bien
COMMIT;
-- si algo sale mal
ROLLBACK;

-- CONSULTAS COMPLEJAS
-- Realiza una consulta que recupere el total de ventas de un producto durante el mes anterior.
SELECT SUM(transacciones.cantidad) AS total_vendido
FROM transacciones WHERE tipo = 'venta'   AND id_producto = 3   AND MONTH(fecha) = 7   AND YEAR(fecha) = 2025;

-- Utiliza JOINs (INNER, LEFT) para obtener información relacionada entre las tablas productos, proveedores y transacciones.
-- consulta de ventas por producto y proveedor
SELECT transacciones.fecha,
       transacciones.tipo,
       transacciones.cantidad,
       productos.nombre AS nombre_producto,
       proveedores.nombre AS nombre_proveedor
FROM transacciones
INNER JOIN productos ON transacciones.id_producto = productos.id_producto
INNER JOIN proveedores ON transacciones.id_proveedor = proveedores.id_proveedor
WHERE transacciones.tipo = 'venta';

-- consulta para ver productos sin movimientos
SELECT productos.nombre,
       transacciones.tipo,
       transacciones.fecha,
       transacciones.cantidad
FROM productos
LEFT JOIN transacciones ON productos.id_producto = transacciones.id_producto;

-- Implementa una consulta con subconsultas (subqueries) para obtener productos que no se han vendido durante un período determinado.
-- productos que no se han vendido en julio
SELECT nombre
FROM productos
WHERE id_producto NOT IN (
    SELECT id_producto
    FROM transacciones
    WHERE tipo = 'venta'
      AND MONTH(fecha) = 7
      AND YEAR(fecha) = 2025
);
