<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ventas.aspx.cs" Inherits="ExamenParcial.Ventas" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ventas</title>
    <style>
        /* Estilos para el menú de navegación */
        .navbar {
            background-color: #333; /* Color de fondo del menú */
            overflow: hidden;
        }

        .navbar a {
            float: left; /* Alineación de los elementos del menú */
            display: block;
            color: white; /* Color del texto del menú */
            text-align: center;
            padding: 14px 20px; /* Espaciado interno de los enlaces */
            text-decoration: none; /* Quita el subrayado de los enlaces */
        }

        /* Cambia el color de fondo del enlace al pasar el ratón sobre él */
        .navbar a:hover {
            background-color: #ddd; /* Color de fondo al pasar el ratón */
            color: black; /* Color del texto al pasar el ratón */
        }

        /* Estilos para el cuerpo de la página */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        /* Estilos para el encabezado */
        h2 {
            color: #333;
        }

        /* Estilos para la tabla */
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        tr:hover {
            background-color: #f2f2f2;
        }

        /* Estilos para el footer */
        .footer {
            background-color: #333; /* Color de fondo del footer */
            color: #fff; /* Color del texto del footer */
            text-align: center; /* Alineación del texto */
            padding: 20px 0; /* Espaciado interno del footer */
            position: fixed; /* Fija el footer en la parte inferior */
            left: 0;
            bottom: 0;
            width: 100%; /* Ancho completo */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="navbar">
                <a href="Usuario.aspx">Usuario</a>
                <a href="Productos.aspx">Productos</a>
                <a href="Ventas.aspx">Ventas</a>
                <a href="Pedidos.aspx">Pedidos</a>
            </div>
            <h2>Ventas</h2>
            <!-- GridView para mostrar las ventas -->
            <asp:GridView ID="GridViewVentas" runat="server"  DataKeyNames="IDVenta" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="IDVenta" HeaderText="ID" />
                    <asp:BoundField DataField="IDUsuario" HeaderText="ID Usuario" />
                    <asp:BoundField DataField="IDProducto" HeaderText="ID Producto" />
                    <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                    <asp:BoundField DataField="Total" HeaderText="Total" />
                    <asp:BoundField DataField="FechaVenta" HeaderText="Fecha de Venta" />
                </Columns>
            </asp:GridView>

            <!-- Formulario para agregar una nueva venta -->
            <h3>Agregar Venta</h3>
            <asp:TextBox ID="txtIDUsuario" runat="server" placeholder="ID Usuario" />
            <asp:TextBox ID="txtIDProducto" runat="server" placeholder="ID Producto" />
            <asp:TextBox ID="txtCantidad" runat="server" placeholder="Cantidad" />
            <asp:TextBox ID="txtTotal" runat="server" placeholder="Total" />
            <asp:TextBox ID="txtFechaVenta" runat="server" placeholder="Fecha de Venta" type="date"  />
            <asp:Button ID="btnAgregarVenta" runat="server" Text="Agregar Venta" OnClick="btnAgregarVenta_Click" />
            <div class="footer">
                <p>© 2024 Todos los derechos reservados.</p>
            </div>
        </div>
    </form>
</body>
</html>
