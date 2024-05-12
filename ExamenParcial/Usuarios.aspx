<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="ExamenParcial.Usuarios" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Usuarios</title>
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

        /* Estilos para el formulario de agregar usuario */
        h3 {
            color: #333;
        }

        /* Estilos para los TextBox */
        input[type="text"],
        input[type="email"],
        input[type="tel"] {
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
            <h2>Usuarios</h2>
            <!-- GridView para mostrar los usuarios -->
            <asp:GridView ID="GridViewUsuarios" runat="server"  DataKeyNames="IDUsuario" AutoGenerateColumns="False" OnRowEditing="GridViewUsuarios_RowEditing" OnRowDeleting="GridViewUsuarios_RowDeleting" OnRowUpdating="GridViewUsuarios_RowUpdating">
                <Columns>
                    <asp:BoundField DataField="IDUsuario" HeaderText="ID" />
                    <asp:BoundField DataField="DNI" HeaderText="DNI" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                    <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Direccion" HeaderText="Dirección" />
                    <asp:TemplateField HeaderText="Acciones" ShowHeader="False">
                        <ItemTemplate>
                            <!-- Botones para editar y eliminar usuarios -->
                            <asp:Button ID="btnEditar" runat="server" Text="Editar" CommandName="Edit" CommandArgument='<%# Container.DataItemIndex %>' />
                            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CommandName="Delete" CommandArgument='<%# Container.DataItemIndex %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <!-- Controles TextBox para editar -->
                            <asp:TextBox ID="txtDNI" runat="server" Text='<%# Eval("DNI") %>' />
                            <asp:TextBox ID="txtNombre" runat="server" Text='<%# Eval("Nombre") %>' />
                            <asp:TextBox ID="txtApellido" runat="server" Text='<%# Eval("Apellido") %>' />
                            <asp:TextBox ID="txtTelefono" runat="server" Text='<%# Eval("Telefono") %>' />
                            <asp:TextBox ID="txtEmail" runat="server" Text='<%# Eval("Email") %>' />
                            <asp:TextBox ID="txtDireccion" runat="server" Text='<%# Eval("Direccion") %>' />
                            <!-- Botón para guardar cambios -->

                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CommandName="Update" CommandArgument='<%# Container.DataItemIndex %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>


            <br />
            <!-- Formulario para agregar un nuevo usuario -->
            <h3>Agregar Usuario</h3>
            <asp:TextBox ID="txtDNI" runat="server" placeholder="DNI"  />
            <asp:TextBox ID="txtNombre" runat="server" placeholder="Nombre"  />
            <asp:TextBox ID="txtApellido" runat="server" placeholder="Apellido"  />
            <asp:TextBox ID="txtTelefono" runat="server" placeholder="Teléfono" />
            <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" type="email"  />
            <asp:TextBox ID="txtDireccion" runat="server" placeholder="Dirección" />
            <asp:Button ID="btnAgregar" runat="server" Text="Agregar" OnClick="btnAgregar_Click" />
            <div class="footer">
                <p>© 2024 Todos los derechos reservados.</p>
            </div>
        </div>
    </form>
</body>
</html>