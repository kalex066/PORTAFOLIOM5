CREATE TABLE Cliente (
  id_cliente INT PRIMARY KEY,
  nombre VARCHAR(45) NOT NULL,
  direccion VARCHAR(150),
  telefono VARCHAR(12) UNIQUE,
  correo VARCHAR(40) UNIQUE CHECK (correo LIKE '%@%')
);
CREATE TABLE VehiculosDisponibles (
  id_vehiculosdisponibles INT PRIMARY KEY,
  patente VARCHAR(10) UNIQUE NOT NULL,
  tipo VARCHAR(45) NOT NULL,
  capacidad DECIMAL(5,2) CHECK (capacidad > 0),
  disponibilidad BOOL
);

CREATE TABLE SolicitudRetiro (
  id_solicitud INT PRIMARY KEY,
  fecha DATE NOT NULL,
  hora TIME NOT NULL,
  estado ENUM('pendiente', 'completado', 'cancelado'),
  id_cliente INT NOT NULL,
  id_vehiculosdisponibles INT NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
  FOREIGN KEY (id_vehiculosdisponibles) REFERENCES VehiculosDisponibles(id_vehiculosdisponibles)
);
CREATE TABLE Articulos (
  id_articulos INT PRIMARY KEY,
  nombre VARCHAR(45) NOT NULL,
  descripcion VARCHAR (255) NOT NULL,
  peso DECIMAL(6,2) CHECK (peso > 0),
  estado ENUM('bueno', 'dañado') NOT NULL,
  id_solicitud INT NOT NULL,
  FOREIGN KEY (id_solicitud) REFERENCES SolicitudRetiro(id_solicitud)
);
