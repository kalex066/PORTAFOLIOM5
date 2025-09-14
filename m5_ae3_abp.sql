-- Creando tabla clientes
CREATE TABLE clientes (
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    direccion TEXT,
    telefono TEXT
);
-- creando tabla pedidos
CREATE TABLE pedidos (
    id INTEGER PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    fecha DATE,
    total INTEGER,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- 1. Inserta al menos cinco nuevos clientes en la tabla "clientes".
INSERT INTO clientes (id, nombre, direccion, telefono) VALUES
(1, 'David Suarez', 'Av. Ejercito Libertador 1484, Puente Alto', '987320581'),
(2, 'Amy Herrera', 'Bombero Nuñez 127, Recoleta', '978192090'),
(3, 'Beatriz Sepulveda', 'Los Alerces 3258, Ñuñoa', '942516744'),
(4, 'Eduardo Yedro', 'Vikuña Mackenna 325, La Florida', '978456589'),
(5, 'Pamela Figueroa', 'Coquimbo 1285, Puente Alto', '967654445');

-- 2. Inserta al menos diez nuevos pedidos en la tabla "pedidos". Asegúrate de asignar correctamente el cliente correspondiente a cada pedido utilizando la columna "cliente_id".
INSERT INTO pedidos (id, cliente_id, fecha, total) VALUES
(1, 1, '2025-08-15', 25000),
(2, 2, '2025-08-16', 15000),
(3, 3, '2025-08-16', 35000),
(4, 4, '2025-08-17', 15000),
(5, 5, '2025-08-18', 25000),
(6, 5, '2025-08-19', 25000),
(7, 2, '2025-08-19', 15000),
(8, 3, '2025-08-20', 25000),
(9, 1, '2025-08-20', 30000),
(10, 1, '2025-08-20', 15000);

-- 3. Proyecta todos los clientes de la tabla "clientes" y sus respectivos pedidos.
SELECT clientes.id, clientes.nombre, pedidos.id AS pedido_id, pedidos.fecha, pedidos.total
FROM clientes
LEFT JOIN pedidos ON clientes.id = pedidos.cliente_id;

-- 4. Proyecta todos los pedidos realizados por un cliente específico, utilizando su ID.
SELECT 
    pedidos.id AS pedido_id,
    pedidos.fecha,
    pedidos.total,
    clientes.id AS cliente_id,
    clientes.nombre AS nombre_cliente
FROM pedidos
JOIN clientes ON pedidos.cliente_id = clientes.id
WHERE clientes.id = 3;

-- 5. Calcula el total de todos los pedidos para cada cliente.
SELECT clientes.id, clientes.nombre, SUM(pedidos.total) AS total_pedidos
FROM clientes
JOIN pedidos ON clientes.id = pedidos.cliente_id
GROUP BY clientes.id, clientes.nombre;

-- 6. Actualiza la dirección de un cliente dado su "id".
UPDATE clientes
SET direccion = 'Manquehue 325, Las Condes'
WHERE id = 2;
-- consultando para ver si realizo la modificacion
SELECT clientes.id, clientes.nombre, clientes.direccion 
FROM clientes
WHERE id = 2;

-- 7. Elimina un cliente específico de la tabla "clientes" y todos sus pedidos asociados de la tabla "pedidos".
DELETE FROM pedidos
WHERE cliente_id = 3;

DELETE FROM clientes
WHERE id = 3;
-- consultando para ver la modificacion
SELECT * FROM clientes;

-- 8. Proyecta los tres clientes que han realizado más pedidos, ordenados de forma descendente por el número de pedidos.
SELECT clientes.id, clientes.nombre, COUNT(pedidos.id) AS cantidad_pedidos
FROM clientes
JOIN pedidos ON clientes.id = pedidos.cliente_id
GROUP BY clientes.id, clientes.nombre
ORDER BY cantidad_pedidos DESC
LIMIT 3;



