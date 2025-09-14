-- Restaurante indeciso…. 
-- El dueño quiere una base para manejar toda la información del restaurante.
CREATE DATABASE restaurante;
USE restaurante;

-- El chef llega emocionado contigo porque vas a comenzar con su base de datos, y te dice: “Necesitamos guardar nuestros platos: id, nombre y precio.”

CREATE TABLE platos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(6,2) NOT NULL
);

-- Después de un rato, el gerente dice: “Ups… cada plato debe pertenecer a una categoría (entrada, plato fuerte, postre).”
ALTER TABLE platos
ADD COLUMN categoria VARCHAR(10) AFTER nombre;

-- El chef interrumpe otra vez: “Me olvidé: también quiero saber si un plato es vegetariano.”
ALTER TABLE platos
ADD COLUMN VEGETARIANO BOOL AFTER nombre;

-- El gerente te pide: “Agreguemos una tabla de clientes, para guardar nombre y teléfono.”
CREATE TABLE clientes (
	nombre VARCHAR (50) NOT NULL,
    teléfono VARCHAR (15) NOT NULL
);
-- Al gerente luego se le ocurre: “Importante: ¡ningún precio negativo!”
ALTER TABLE platos
ADD CONSTRAINT precio_valido CHECK (precio >= 0);

-- El gerente recuerda que también debe tener la dirección del cliente
ALTER TABLE clientes
ADD COLUMN dirección VARCHAR (100) AFTER nombre;

-- Todos se enojan y piden eliminar toda la información
DROP TABLE clientes;
DROP TABLE platos;

