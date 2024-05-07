USE master
GO

-- Crear la base de datos solo si no existe
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'examenfinal')
BEGIN
    CREATE DATABASE examenfinal
END
GO

USE examenfinal
GO

-- Crear la tabla Usuarios con restricciones de integridad
CREATE TABLE Usuarios (
    IDUsuario INT PRIMARY KEY IDENTITY,
    DNI VARCHAR(8) UNIQUE NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    Direccion VARCHAR(200),
    CONSTRAINT CK_Usuarios_Validacion_DNI CHECK (LEN(DNI) = 8),
    CONSTRAINT CK_Usuarios_Validacion_Telefono CHECK (LEN(Telefono) >= 7 AND LEN(Telefono) <= 20),
    CONSTRAINT CK_Usuarios_Validacion_Email CHECK (Email LIKE '%@%.%')
)

-- Crear la tabla Productos con restricciones de integridad
CREATE TABLE Productos (
    IDProducto INT PRIMARY KEY IDENTITY,
    Tipo VARCHAR(50) NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    Descripcion TEXT,
    CantidadDisponible INT NOT NULL CHECK (CantidadDisponible >= 0)
)

-- Crear la tabla Ventas con restricciones de integridad
CREATE TABLE Ventas (
    IDVenta INT PRIMARY KEY IDENTITY,
    IDUsuario INT NOT NULL,
    IDProducto INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    Total DECIMAL(10, 2) NOT NULL,
    FechaVenta DATETIME NOT NULL,
    FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario),
    FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto)
)

-- Crear la tabla Pedidos con restricciones de integridad
CREATE TABLE Pedidos (
    IDPedido INT PRIMARY KEY IDENTITY,
    IDUsuario INT NOT NULL,
    FechaPedido DATETIME NOT NULL,
    Estado VARCHAR(50) NOT NULL,
    TotalPedido DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario)
)

-- Insertar datos de ejemplo en la tabla Usuarios
INSERT INTO Usuarios (DNI, Nombre, Apellido, Telefono, Email, Direccion)
VALUES ('12345678', 'Juan', 'Perez', '123456789', 'juan@example.com', 'Calle 123'),
       ('87654321', 'María', 'López', '987654321', 'maria@example.com', 'Avenida 456');

-- Insertar datos de ejemplo en la tabla Productos
INSERT INTO Productos (Tipo, Precio, Descripcion, CantidadDisponible)
VALUES ('Electrónico', 999.99, 'Descripción del producto electrónico', 10),
       ('Ropa', 49.99, 'Descripción del producto de ropa', 20);

-- Insertar datos de ejemplo en la tabla Ventas
INSERT INTO Ventas (IDUsuario, IDProducto, Cantidad, Total, FechaVenta)
VALUES (1, 1, 2, 1999.98, '2024-05-07 10:00:00'),
       (2, 2, 1, 49.99, '2024-05-08 11:00:00');

-- Insertar datos de ejemplo en la tabla Pedidos
INSERT INTO Pedidos (IDUsuario, FechaPedido, Estado, TotalPedido)
VALUES (1, '2024-05-07 10:00:00', 'Pendiente', 1999.98),
       (2, '2024-05-08 11:00:00', 'En proceso', 49.99);
