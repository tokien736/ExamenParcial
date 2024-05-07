<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pedidos2.aspx.cs" Inherits="ExamenParcial.Pedidos2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <!--tablas de estudiante-->
        <div>
            <p>Mantenimineto de la tabla Pedidos</p>
            <p>IDPedido: <asp:TextBox runat="server" ID="txtIDPedido"></asp:TextBox></p>
            <p>IDUsuario: <asp:TextBox runat="server" ID="txtIDUsuario"></asp:TextBox></p>
            <p>FechaPedido: <asp:TextBox runat="server" ID="txtFechaPedido"></asp:TextBox></p>
            <p>Estado: <asp:TextBox runat="server" ID="txtEstado"></asp:TextBox></p>
            <p>TotalPedido: <asp:TextBox runat="server" ID="txtTotalPedido"></asp:TextBox></p>

            <p>
                <asp:Button runat="server" ID="btnAgregar4" Text="Agregar" OnClick="btnAgregar_Click"/>
                <asp:Button runat="server" ID="btnEliminar4" Text="Eliminar" OnClick="btnEliminar_Click"/>
                <asp:Button runat="server" ID="btnActualizar4" Text="Actualizar" OnClick="btnActualizar_Click"/>
            </p>
            <p>
                <asp:TextBox runat="server" ID="txtBuscar"></asp:TextBox>
                <asp:Button runat="server" ID="btnBuscar" Text="Buscar" OnClick="btnBuscar_Click" />
            </p>
            <p>
                <asp:GridView runat="server" id="gvPedidos" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="5" ForeColor="Black" GridLines="Horizontal" OnSelectedIndexChanged="Unnamed1_SelectedIndexChanged" Width="264px">
                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                    <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                    <SortedDescendingHeaderStyle BackColor="#242121" />
                </asp:GridView>
            </p>
        </div>
    </form>
    <p>
        &nbsp;</p>
</body>
</html>
