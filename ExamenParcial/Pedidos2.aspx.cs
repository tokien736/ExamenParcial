using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace ExamenParcial
{
    public partial class Pedidos2 : System.Web.UI.Page
    {
        private static string cadena = ConfigurationManager.ConnectionStrings["cadena"].ConnectionString;
        /*cargar tabla Pedidos*/
        private void CargarDatos()
        {
            using (SqlConnection conexion = new SqlConnection(cadena))
            {
                string consulta = "select * from Pedidos";
                SqlDataAdapter adapter = new SqlDataAdapter(consulta, conexion);
                DataTable tabla = new DataTable();
                adapter.Fill(tabla);
                this.gvPedidos.DataSource = tabla;
                this.gvPedidos.DataBind();
            }

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                CargarDatos();
            }
        }

        protected void Unnamed1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        /*actualisa tabla Pedidos*/
        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            using (SqlConnection conexion = new SqlConnection(cadena))
            {
                try
                {
                    string IDPedido = txtIDPedido.Text.Trim();
                    string IDUsuario = txtIDUsuario.Text.Trim();
                    string FechaPedido = txtFechaPedido.Text.Trim();
                    string Estado = txtEstado.Text.Trim();
                    string TotalPedido = txtTotalPedido.Text.Trim();
                    string consulta = "UPDATE Pedidos SET IDUsuario = @IDUsuario, FechaPedido = @FechaPedido, Estado = @Estado, TotalPedido = @TotalPedido WHERE IDPedido = @IDPedido";

                    SqlCommand comando = new SqlCommand(consulta, conexion);
                    comando.Parameters.AddWithValue("@IDPedido", IDPedido);
                    comando.Parameters.AddWithValue("@IDUsuario", IDUsuario);
                    comando.Parameters.AddWithValue("@FechaPedido", FechaPedido);
                    comando.Parameters.AddWithValue("@Estado", Estado);
                    comando.Parameters.AddWithValue("@TotalPedido", TotalPedido);

                    conexion.Open();
                    int i = comando.ExecuteNonQuery();
                    conexion.Close();

                    if (i > 0)
                    {
                        CargarDatos();
                        Response.Write("<script>alert('Se actualizó correctamente');</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('No se encontró ningún estudiante con ese código');</script>");
                    }
                }
                catch (SqlException ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>");
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>");
                }
                finally
                {
                    conexion.Close();
                }
            }
        }
        /*agreda dato tabla Pedidos*/
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            using (SqlConnection conexion = new SqlConnection(cadena))
            {
                try
                {
                    string IDPedido = txtIDPedido.Text.Trim();
                    string IDUsuario = txtIDUsuario.Text.Trim();
                    string FechaPedido = txtFechaPedido.Text.Trim();
                    string Estado = txtEstado.Text.Trim();
                    string TotalPedido = txtTotalPedido.Text.Trim();
                    string consulta = "insert into Pedidos values(@IDPedido,@IDUsuario,@FechaPedido,@Estado,@TotalPedido)";

                    SqlCommand comando = new SqlCommand(consulta, conexion);

                    comando.Parameters.AddWithValue("@IDPedido", IDPedido);
                    comando.Parameters.AddWithValue("@IDUsuario", IDUsuario);
                    comando.Parameters.AddWithValue("@FechaPedido", FechaPedido);
                    comando.Parameters.AddWithValue("@Estado", Estado);
                    comando.Parameters.AddWithValue("@TotalPedido", TotalPedido);

                    conexion.Open();
                    int i = comando.ExecuteNonQuery();
                    conexion.Close();
                    if (i == 0)
                    {
                        CargarDatos();
                        Response.Write("<script>alert('Se agrego correctamente');</script>");

                    }
                    else Response.Write("<script>alert('Problema al agregar datos a la tabla');</script>");
                }
                catch (SqlException ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>"); conexion.Close();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>"); conexion.Close();
                }
                finally
                {
                    conexion.Close();
                }
            }
        }
        /*elimina datos de tabla Pedidos*/
        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            using (SqlConnection conexion = new SqlConnection(cadena))
            {
                try
                {
                    string IDPedido = txtIDPedido.Text.Trim();
                    string consulta = "DELETE FROM Pedidos WHERE IDPedido = @IDPedido";

                    SqlCommand comando = new SqlCommand(consulta, conexion);
                    comando.Parameters.AddWithValue("@txtIDPedido", txtIDPedido);

                    conexion.Open();
                    int i = comando.ExecuteNonQuery();
                    conexion.Close();

                    if (i > 0)
                    {
                        CargarDatos();
                        Response.Write("<script>alert('Se eliminó correctamente');</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('No se encontró ningún pedido con ese código');</script>");
                    }
                }
                catch (SqlException ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>");
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>");
                }
                finally
                {
                    conexion.Close();
                }
            }
        }
        /*buscar datos de tabla Pedidos*/
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            using (SqlConnection conexion = new SqlConnection(cadena))
            {
                try
                {
                    string consulta = "SELECT IDPedido, IDUsuario, FechaPedido, Estado, TotalPedido FROM Pedidos WHERE 1=1";
                    if (!string.IsNullOrEmpty(txtIDPedido.Text.Trim()))
                    {
                        consulta += " AND IDPedido = @IDPedido";
                    }
                    if (!string.IsNullOrEmpty(txtIDUsuario.Text.Trim()))
                    {
                        consulta += " AND IDUsuario LIKE '%' + @IDUsuario + '%'";
                    }
                    if (!string.IsNullOrEmpty(txtFechaPedido.Text.Trim()))
                    {
                        consulta += " AND FechaPedido LIKE '%' + @FechaPedido + '%'";
                    }
                    if (!string.IsNullOrEmpty(txtEstado.Text.Trim()))
                    {
                        consulta += " AND Estado LIKE '%' + @Estado + '%'";
                    }
                    if (!string.IsNullOrEmpty(txtTotalPedido.Text.Trim()))
                    {
                        consulta += " AND TotalPedido LIKE '%' + @TotalPedido + '%'";
                    }

                    SqlCommand comando = new SqlCommand(consulta, conexion);

                    if (!string.IsNullOrEmpty(txtIDPedido.Text.Trim()))
                    {
                        comando.Parameters.AddWithValue("@IDPedido", txtIDPedido.Text.Trim());
                    }
                    if (!string.IsNullOrEmpty(txtIDUsuario.Text.Trim()))
                    {
                        comando.Parameters.AddWithValue("@IDUsuario", txtIDUsuario.Text.Trim());
                    }
                    if (!string.IsNullOrEmpty(txtFechaPedido.Text.Trim()))
                    {
                        comando.Parameters.AddWithValue("@FechaPedido", txtFechaPedido.Text.Trim());
                    }
                    if (!string.IsNullOrEmpty(txtEstado.Text.Trim()))
                    {
                        comando.Parameters.AddWithValue("@Estado", txtEstado.Text.Trim());
                    }
                    if (!string.IsNullOrEmpty(txtTotalPedido.Text.Trim()))
                    {
                        comando.Parameters.AddWithValue("@TotalPedido", txtTotalPedido.Text.Trim());
                    }

                    conexion.Open();
                    SqlDataReader reader = comando.ExecuteReader();

                    if (reader.HasRows)
                    {
                        gvPedidos.DataSource = reader;
                        gvPedidos.DataBind();
                    }
                    else
                    {
                        Response.Write("<script>alert('No se encontraron pedidos con los criterios de búsqueda proporcionados');</script>");
                    }

                    reader.Close();
                }
                catch (SqlException ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>");
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>");
                }
                finally
                {
                    conexion.Close();
                }
            }
        }
    }
}