use examenfinal
go
-- CRUD para la tabla Usuarios
-- Crear un nuevo usuario
IF OBJECT_ID('spCrearUsuario') IS NOT NULL
    DROP PROCEDURE spCrearUsuario
GO
CREATE PROCEDURE spCrearUsuario
    @DNI VARCHAR(8),
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Telefono VARCHAR(20),
    @Email VARCHAR(100),
    @Direccion VARCHAR(200)
AS
BEGIN
    INSERT INTO Usuarios (DNI, Nombre, Apellido, Telefono, Email, Direccion)
    VALUES (@DNI, @Nombre, @Apellido, @Telefono, @Email, @Direccion)
END
GO

-- Leer todos los usuarios
IF OBJECT_ID('spListarUsuarios') IS NOT NULL
    DROP PROCEDURE spListarUsuarios
GO
CREATE PROCEDURE spListarUsuarios
AS
BEGIN
    SELECT * FROM Usuarios
END
GO

-- Leer un usuario por su ID
IF OBJECT_ID('spBuscarUsuarioPorID') IS NOT NULL
    DROP PROCEDURE spBuscarUsuarioPorID
GO
CREATE PROCEDURE spBuscarUsuarioPorID
    @IDUsuario INT
AS
BEGIN
    SELECT * FROM Usuarios WHERE IDUsuario = @IDUsuario
END
GO

-- Actualizar información de un usuario
IF OBJECT_ID('spActualizarUsuario') IS NOT NULL
    DROP PROCEDURE spActualizarUsuario
GO
CREATE PROCEDURE spActualizarUsuario
    @IDUsuario INT,
    @DNI VARCHAR(20),
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Telefono VARCHAR(20),
    @Email VARCHAR(100),
    @Direccion VARCHAR(200)
AS
BEGIN
    UPDATE Usuarios
    SET DNI = @DNI,
        Nombre = @Nombre,
        Apellido = @Apellido,
        Telefono = @Telefono,
        Email = @Email,
        Direccion = @Direccion
    WHERE IDUsuario = @IDUsuario
END
GO

-- Eliminar un usuario por su ID
IF OBJECT_ID('spEliminarUsuarioPorID') IS NOT NULL
    DROP PROCEDURE spEliminarUsuarioPorID
GO
CREATE PROCEDURE spEliminarUsuarioPorID
    @IDUsuario INT
AS
BEGIN
    DELETE FROM Usuarios WHERE IDUsuario = @IDUsuario
END
GO


-- CRUD para la tabla Productos
-- Crear un nuevo producto
IF OBJECT_ID('spCrearProducto') IS NOT NULL
    DROP PROCEDURE spCrearProducto
GO
CREATE PROCEDURE spCrearProducto
    @Tipo VARCHAR(50),
    @Precio DECIMAL(10, 2),
    @Descripcion TEXT,
    @CantidadDisponible INT
AS
BEGIN
    INSERT INTO Productos (Tipo, Precio, Descripcion, CantidadDisponible)
    VALUES (@Tipo, @Precio, @Descripcion, @CantidadDisponible)
END
GO

-- Leer todos los productos
IF OBJECT_ID('spListarProductos') IS NOT NULL
    DROP PROCEDURE spListarProductos
GO
CREATE PROCEDURE spListarProductos
AS
BEGIN
    SELECT * FROM Productos
END
GO

-- Leer un producto por su ID
IF OBJECT_ID('spBuscarProductoPorID') IS NOT NULL
    DROP PROCEDURE spBuscarProductoPorID
GO
CREATE PROCEDURE spBuscarProductoPorID
    @IDProducto INT
AS
BEGIN
    SELECT * FROM Productos WHERE IDProducto = @IDProducto
END
GO

-- Actualizar información de un producto
IF OBJECT_ID('spActualizarProducto') IS NOT NULL
    DROP PROCEDURE spActualizarProducto
GO
CREATE PROCEDURE spActualizarProducto
    @IDProducto INT,
    @Tipo VARCHAR(50),
    @Precio DECIMAL(10, 2),
    @Descripcion TEXT,
    @CantidadDisponible INT
AS
BEGIN
    UPDATE Productos
    SET Tipo = @Tipo,
        Precio = @Precio,
        Descripcion = @Descripcion,
        CantidadDisponible = @CantidadDisponible
    WHERE IDProducto = @IDProducto
END
GO

-- Eliminar un producto por su ID
IF OBJECT_ID('spEliminarProductoPorID') IS NOT NULL
    DROP PROCEDURE spEliminarProductoPorID
GO
CREATE PROCEDURE spEliminarProductoPorID
    @IDProducto INT
AS
BEGIN
    DELETE FROM Productos WHERE IDProducto = @IDProducto
END
GO


-- CRUD para la tabla Ventas
-- Crear una nueva venta
IF OBJECT_ID('spRegistrarVenta') IS NOT NULL
    DROP PROCEDURE spRegistrarVenta
GO
CREATE PROCEDURE spRegistrarVenta
    @IDUsuario INT,
    @IDProducto INT,
    @Cantidad INT,
    @Total DECIMAL(10, 2),
    @FechaVenta DATETIME
AS
BEGIN
    INSERT INTO Ventas (IDUsuario, IDProducto, Cantidad, Total, FechaVenta)
    VALUES (@IDUsuario, @IDProducto, @Cantidad, @Total, @FechaVenta)
END
GO

-- Leer todas las ventas
IF OBJECT_ID('spListarVentas') IS NOT NULL
    DROP PROCEDURE spListarVentas
GO
CREATE PROCEDURE spListarVentas
AS
BEGIN
    SELECT * FROM Ventas
END
GO

-- Leer una venta por su ID
IF OBJECT_ID('spBuscarVentaPorID') IS NOT NULL
    DROP PROCEDURE spBuscarVentaPorID
GO
CREATE PROCEDURE spBuscarVentaPorID
    @IDVenta INT
AS
BEGIN
    SELECT * FROM Ventas WHERE IDVenta = @IDVenta
END
GO


-- CRUD para la tabla Pedidos
-- Crear un nuevo pedido
IF OBJECT_ID('spCrearPedido') IS NOT NULL
    DROP PROCEDURE spCrearPedido
GO
CREATE PROCEDURE spCrearPedido
    @IDUsuario INT,
    @FechaPedido DATETIME,
    @Estado VARCHAR(50),
    @TotalPedido DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Pedidos (IDUsuario, FechaPedido, Estado, TotalPedido)
    VALUES (@IDUsuario, @FechaPedido, @Estado, @TotalPedido)
END
GO

-- Leer todos los pedidos
IF OBJECT_ID('spListarPedidos') IS NOT NULL
    DROP PROCEDURE spListarPedidos
GO
CREATE PROCEDURE spListarPedidos
AS
BEGIN
    SELECT * FROM Pedidos
END
GO

-- Leer un pedido por su ID
IF OBJECT_ID('spBuscarPedidoPorID') IS NOT NULL
    DROP PROCEDURE spBuscarPedidoPorID
GO
CREATE PROCEDURE spBuscarPedidoPorID
    @IDPedido INT
AS
BEGIN
    SELECT * FROM Pedidos WHERE IDPedido = @IDPedido
END
GO

-- Ejemplo de inserción de datos
EXEC spCrearUsuario '58984564', 'Jose Enrique', 'Flores', '123456789', 'email@mail.com', 'Calle cusco 123';
EXEC spCrearProducto 'Electrónico', 999.99, 'Descripción del producto electrónico', 10;
EXEC spRegistrarVenta 1, 1, 2, 1999.98, '2024-05-07 10:00:00';
EXEC spCrearPedido 1, '2024-05-07 10:00:00', 'Pendiente', 1999.98;


-- Ejemplo de visualización de datos
EXEC spListarUsuarios;
EXEC spListarProductos;
EXEC spListarVentas;
EXEC spListarPedidos;




