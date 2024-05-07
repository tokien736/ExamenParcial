use master
go
create database examenfinal
go

use examenfinal
go
CREATE TABLE Usuarios (
    IDUsuario INT PRIMARY KEY,
    DNI VARCHAR(20) UNIQUE,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    Direccion VARCHAR(200)
)

CREATE TABLE Productos (
    IDProducto INT PRIMARY KEY,
    Tipo VARCHAR(50),
    Precio DECIMAL(10, 2),
    Descripcion TEXT,
    CantidadDisponible INT
)
go

CREATE TABLE Ventas (
    IDVenta INT PRIMARY KEY,
    IDUsuario INT,
    IDProducto INT,
    Cantidad INT,
    Total DECIMAL(10, 2),
    FechaVenta DATETIME,
    FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario),
    FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto)
)
go 
CREATE TABLE Pedidos (
    IDPedido INT PRIMARY KEY,
    IDUsuario INT,
    FechaPedido DATETIME,
    Estado VARCHAR(50),
    TotalPedido DECIMAL(10, 2),
    FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario)
)
go 