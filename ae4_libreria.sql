CREATE DATABASE libreria_db;
USE libreria_db;

-- Tabla Clientes
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(100) NOT NULL,
    correo_cliente VARCHAR(100) NOT NULL UNIQUE,
    telefono_cliente VARCHAR(15) NOT NULL,
    direccion_cliente VARCHAR(255) NOT NULL
);

-- Tabla Libros
CREATE TABLE Libros (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    titulo_libro VARCHAR(255) NOT NULL,
    autor_libro VARCHAR(100) NOT NULL,
    precio_libro DECIMAL(10,2) NOT NULL,
    cantidad_disponible INT NOT NULL CHECK (cantidad_disponible >= 0),
    categoria_libro VARCHAR(50) NOT NULL
);

-- Tabla Pedidos
CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    total_pedido DECIMAL(10,2) NOT NULL,
    estado_pedido VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Tabla Detalles_Pedido
CREATE TABLE Detalles_Pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_libro INT NOT NULL,
    cantidad_libro INT NOT NULL,
    precio_libro DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_libro) REFERENCES Libros(id_libro)
);

-- Tabla Pagos
CREATE TABLE Pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    fecha_pago DATE NOT NULL,
    monto_pago DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido)
);

-- Modificaciones a realizar en la base de datos
-- Cambiar el tipo de dato de telefono_cliente a VARCHAR(20) para permitir más flexibilidad en la entrada de números internacionales.
ALTER TABLE Clientes
MODIFY telefono_cliente VARCHAR(20);

-- Modificar el campo precio_libro en Libros para que acepte un valor con hasta 3 decimales (decimales(10,3)) en lugar de dos.
ALTER TABLE Libros
MODIFY precio_libro DECIMAL(10,3);

-- Actualizar la tabla Pagos para incluir un nuevo campo fecha_confirmacion que registre cuándo se confirma el pago.
ALTER TABLE Pagos
ADD fecha_confirmacion DATE;

-- Eliminar la tabla Detalles_Pedido y sus registros cuando se haya confirmado la entrega de todos los libros de un pedido.
DROP TABLE Detalles_Pedido;

-- Después de realizar los cambios en la estructura de la base de datos, eliminar la tabla Pagos.
DROP TABLE Pagos;

-- Truncar la tabla Pedidos para eliminar todos los registros de pedidos. Asegurarse de que esto no afecte la integridad referencial.
TRUNCATE TABLE Pedidos;
