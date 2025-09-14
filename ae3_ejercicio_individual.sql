-- 1.Crear el siguiente modelo ERD para una base de datos de clientes y pedidos.
CREATE TABLE clientes (
	id_clientes INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR (50) NOT NULL,
    direccion VARCHAR (200) NOT NULL,
    telefono VARCHAR (15) NOT NULL
    );
CREATE TABLE pedidos (
	id_pedidos INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    fecha DATETIME NOT NULL,
    total DECIMAL (5,2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id_clientes) ON DELETE CASCADE
    );

-- 2. Inserta al menos cinco nuevos clientes en la tabla "clientes".
INSERT INTO clientes (nombre, direccion, telefono) VALUES 
("David Suarez", "Ejercito Libertador 1484", "987320581"), 
("Amy Herrera", "Bombero Nuñez 127", "978192090"), 
("Beatriz Sepulveda", "Fresia 258", "967654445"), 
("Carlos Cardenas", "Vikuña Mackenna 9874", "912547896"), 
("Francisca Riquelme", "Coquimbo 988", "92257864");

-- 3. Inserta al menos diez nuevos pedidos en la tabla "pedidos". Asegúrate de asignar correctamente el cliente correspondiente a cada pedido utilizando la columna "cliente_id".
INSERT INTO pedidos (cliente_id, fecha, total) VALUES 
(1, '2025-08-09', 100.00),
(2, '2025-08-08', 500.00),
(2, '2025-08-02', 150.00),
(2, '2025-08-12', 200.00),
(3, '2025-08-16', 120.00),
(4, '2025-08-06', 700.00),
(3, '2025-08-03', 500.00),
(5, '2025-08-18', 500.00),
(4, '2025-08-14', 100.00),
(5, '2025-08-06', 150.00);

-- 4. Proyecta todos los clientes de la tabla "clientes" y sus respectivos pedidos.
SELECT * FROM clientes
JOIN pedidos ON clientes.id_clientes = pedidos.cliente_id;

-- 5. Proyecta todos los pedidos realizados por un cliente específico, utilizando su ID.
SELECT * FROM pedidos 
WHERE cliente_id = 3;

-- 6. Calcula el total de todos los pedidos para cada cliente.
SELECT SUM(total), id_clientes, nombre
FROM clientes
LEFT JOIN pedidos ON clientes.id_clientes = pedidos.cliente_id
GROUP BY id_clientes;

-- 7. Actualiza la dirección de un cliente dado su "id".
UPDATE clientes SET direccion = "Nueva Providencia 1547" WHERE clientes.id_clientes = 2;

-- 8. Elimina un cliente específico de la tabla "clientes" y todos sus pedidos asociados de la tabla "pedidos".
DELETE FROM pedidos WHERE cliente_id = 5;
DELETE FROM clientes WHERE id = 5;

-- 9. Proyecta los tres clientes que han realizado más pedidos, ordenados de forma descendente por el número de pedidos.
SELECT nombre, COUNT(*) AS cantidad_pedidos
FROM clientes
JOIN pedidos ON clientes.id_clientes = pedidos.cliente_id
GROUP BY clientes.id_clientes
ORDER BY cantidad_pedidos DESC
LIMIT 3;