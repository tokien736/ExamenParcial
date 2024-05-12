<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="ExamenParcial.Productos" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Productos</title>
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

        /* Estilos para los TextBox */
        input[type="text"],
        input[type="number"],
        textarea {
            width: 200px;
            padding: 5px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        /* Estilos para los botones */
        input[type="button"],
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="button"]:hover,
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
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
            <h2>Productos</h2>
            <!-- GridView para mostrar los productos -->
            <asp:GridView ID="GridViewProductos" runat="server" DataKeyNames="IDProducto" AutoGenerateColumns="False"
                OnRowEditing="GridViewProductos_RowEditing" OnRowDeleting="GridViewProductos_RowDeleting"
                OnRowUpdating="GridViewProductos_RowUpdating">
                <Columns>
                    <asp:BoundField DataField="IDProducto" HeaderText="ID" />
                    <asp:BoundField DataField="Tipo" HeaderText="Tipo" />
                    <asp:BoundField DataField="Precio" HeaderText="Precio" />
                    <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                    <asp:BoundField DataField="CantidadDisponible" HeaderText="Cantidad Disponible" />
                    <asp:TemplateField HeaderText="Acciones" ShowHeader="False">
                        <ItemTemplate>
                            <!-- Botones para editar y eliminar productos -->
                            <asp:Button ID="btnEditar" runat="server" Text="Editar" CommandName="Edit" CommandArgument='<%# Container.DataItemIndex %>' />
                            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CommandName="Delete" CommandArgument='<%# Container.DataItemIndex %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <!-- Controles TextBox para editar -->
                            <asp:TextBox ID="txtTipo" runat="server" Text='<%# Eval("Tipo") %>' />
                            <asp:TextBox ID="txtPrecio" runat="server" Text='<%# Eval("Precio") %>' />
                            <asp:TextBox ID="txtDescripcion" runat="server" Text='<%# Eval("Descripcion") %>' />
                            <asp:TextBox ID="txtCantidadDisponible" runat="server" Text='<%# Eval("CantidadDisponible") %>' />
                            <!-- Botón para guardar cambios -->
                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CommandName="Update" CommandArgument='<%# Container.DataItemIndex %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <!-- Formulario para agregar un nuevo producto -->
            <h3>Agregar Producto</h3>
            <asp:TextBox ID="txtTipo" runat="server" placeholder="Tipo" />
            <asp:TextBox ID="txtPrecio" runat="server" placeholder="Precio" type="number" />
            <asp:TextBox ID="txtDescripcion" runat="server" placeholder="Descripción" />
            <asp:TextBox ID="txtCantidadDisponible" runat="server" placeholder="Cantidad Disponible" type="number" />
            <asp:Button ID="btnAgregarProducto" runat="server" Text="Agregar" OnClick="btnAgregarProducto_Click" />
            <div class="footer">
                <p>© 2024 Todos los derechos reservados.</p>
            </div>
        </div>
    </form>
</body>
</html>
