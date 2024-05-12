using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ExamenParcial
{
    public partial class Pedidos : System.Web.UI.Page
    {
        private static string cadena = ConfigurationManager.ConnectionStrings["Cadena"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarPedidos();
            }
        }

        private void CargarPedidos()
        {
            try
            {
                using (SqlConnection conexion = new SqlConnection(cadena))
                {
                    SqlCommand comando = new SqlCommand("spListarPedidos", conexion);
                    comando.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter adapter = new SqlDataAdapter(comando);
                    DataTable dtPedidos = new DataTable();
                    adapter.Fill(dtPedidos);

                    GridViewPedidos.DataSource = dtPedidos;
                    GridViewPedidos.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error al cargar los pedidos: " + ex.Message);
            }
        }

        protected void btnAgregarPedido_Click(object sender, EventArgs e)
        {
            try
            {
                string idUsuario = txtIDUsuarioPedido.Text;
                string fechaPedido = txtFechaPedido.Text;
                string estado = txtEstadoPedido.Text;
                decimal totalPedido = Convert.ToDecimal(txtTotalPedido.Text);

                using (SqlConnection conexion = new SqlConnection(cadena))
                {
                    SqlCommand comando = new SqlCommand("spCrearPedido", conexion);
                    comando.CommandType = CommandType.StoredProcedure;
                    comando.Parameters.AddWithValue("@IDUsuario", idUsuario);
                    comando.Parameters.AddWithValue("@FechaPedido", fechaPedido);
                    comando.Parameters.AddWithValue("@Estado", estado);
                    comando.Parameters.AddWithValue("@TotalPedido", totalPedido);

                    conexion.Open();
                    comando.ExecuteNonQuery();
                }

                CargarPedidos();
                LimpiarCamposPedido();
            }
            catch (Exception ex)
            {
                Response.Write("Error al agregar el pedido: " + ex.Message);
            }
        }

        protected void LimpiarCamposPedido()
        {
            txtIDUsuarioPedido.Text = "";
            txtFechaPedido.Text = "";
            txtEstadoPedido.Text = "";
            txtTotalPedido.Text = "";
        }
    }
    }