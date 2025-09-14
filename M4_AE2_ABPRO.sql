-- Consulta 1: Mostrar el nombre, telefono y email de todos los clientes que tienen un alquiler activo (es decir, cuya fecha actual esté dentro del rango entre fecha_inicio y fecha_fin).
SELECT nombre as Cliente, telefono, email FROM clientes
JOIN alquileres ON clientes.id_cliente = alquileres.id_cliente
WHERE fecha_inicio < CURDATE() AND CURDATE() < fecha_fin;
-- Consulta 2: Mostrar los vehículos que se alquilaron en el mes de marzo de 2025. Debe mostrar el modelo, marca, y precio_dia de esos vehículos.
SELECT marca, modelo, precio_dia FROM vehiculos
JOIN alquileres ON alquileres.id_vehiculo = vehiculos.id_vehiculo
WHERE MONTH(alquileres.fecha_inicio) = 03;
-- Consulta 3: Calcular el precio total del alquiler para cada cliente, considerando el número de días que alquiló el vehículo (el precio por día de cada vehículo multiplicado por la cantidad de días de alquiler).
select c.id_cliente, c.nombre, sum(v.precio_dia *(a.fecha_fin - a.fecha_inicio)) as precio_total
from clientes c
inner join alquileres a on c.id_cliente = a.id_cliente
inner join vehiculos v on a.id_vehiculo = v.id_vehiculo
group by c.id_cliente, c.nombre
order by precio_total desc;
-- Consulta 4: Encontrar los clientes que no han realizado ningún pago (no tienen registros en la tabla Pagos). Muestra su nombre y email.
select c.nombre, c.email
from clientes c
left join alquileres a on c.id_cliente = a.id_cliente
left join pagos p on a.id_alquiler = p.id_alquiler
where p.id_pago is null;
-- Consulta 5: Calcular el promedio de los pagos realizados por cada cliente. Muestra el nombre del cliente y el promedio de pago.
SELECT clientes.nombre, AVG(pagos.monto) AS promedio_pago
FROM pagos
JOIN alquileres ON pagos.id_alquiler = alquileres.id_alquiler
JOIN clientes ON alquileres.id_cliente = clientes.id_cliente
GROUP BY clientes.id_cliente, clientes.nombre;
-- Consulta 6: Mostrar los vehículos que están disponibles para alquilar en una fecha específica (por ejemplo, 2025-03-18). Debe mostrar el modelo, marca y precio_dia. Si el vehículo está ocupado, no se debe incluir.
SELECT vehiculos.modelo, vehiculos.marca, vehiculos.precio_dia
FROM vehiculos
WHERE vehiculos.id_vehiculo NOT IN (
    SELECT alquileres.id_vehiculo
    FROM alquileres
    WHERE '2025-03-18' BETWEEN alquileres.fecha_inicio AND alquileres.fecha_fin
);
-- Consulta 7: Encontrar la marca y el modelo de los vehículos que se alquilaron más de una vez en el mes de marzo de 2025.
SELECT v.marca, v.modelo, COUNT(a.id_alquiler) AS total_alquileres
FROM alquileres a
JOIN vehiculos v ON a.id_vehiculo = v.id_vehiculo
WHERE a.fecha_inicio BETWEEN '2025-03-01' AND '2025-03-31'
GROUP BY v.id_vehiculo, v.marca, v.modelo
HAVING COUNT(a.id_alquiler) > 1;
-- Consulta 8: Mostrar el total de monto pagado por cada cliente. Debe mostrar el nombre del cliente y la cantidad total de pagos realizados (suma del monto de los pagos).
SELECT c.nombre, SUM(p.monto) AS total_pagado
FROM pagos p
JOIN alquileres a ON p.id_alquiler = a.id_alquiler
JOIN clientes c ON a.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre
ORDER BY c.nombre;
-- Consulta 9: Mostrar los clientes que alquilaron el vehículo Ford Focus (con id_vehiculo = 3). Debe mostrar el nombre del cliente y la fecha del alquiler.
SELECT clientes.nombre, alquileres.fecha_inicio, alquileres.fecha_fin
FROM alquileres
JOIN clientes ON alquileres.id_cliente = clientes.id_cliente
WHERE alquileres.id_vehiculo = 3;
-- Consulta 10: Realizar una consulta que muestre el nombre del cliente y el total de días alquilados de cada cliente, ordenado de mayor a menor total de días. El total de días es calculado como la diferencia entre fecha_inicio y fecha_fin.
SELECT clientes.nombre, SUM(alquileres.fecha_fin - alquileres.fecha_inicio) AS total_dias
FROM alquileres
JOIN clientes ON alquileres.id_cliente = clientes.id_cliente
GROUP BY clientes.nombre
ORDER BY total_dias DESC;


