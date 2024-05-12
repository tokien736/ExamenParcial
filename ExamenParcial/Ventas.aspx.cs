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
    public partial class Ventas : System.Web.UI.Page
    {
        private static string cadena = ConfigurationManager.ConnectionStrings["Cadena"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarVentas();
            }
        }

        // Método para cargar las ventas desde la base de datos y mostrarlas en el GridView
        private void CargarVentas()
        {
            try
            {
                using (SqlConnection conexion = new SqlConnection(cadena))
                {
                    // Consulta SQL para obtener las ventas
                    string consulta = "EXEC spListarVentas";
                    SqlDataAdapter adapter = new SqlDataAdapter(consulta, conexion);
                    DataTable dtVentas = new DataTable();
                    adapter.Fill(dtVentas);

                    // Asignamos los datos al control GridView
                    GridViewVentas.DataSource = dtVentas;
                    GridViewVentas.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Si hay algún error, lo mostramos en la página
                MostrarMensajeError("Error al cargar las ventas: " + ex.Message);
            }
        }

        // Método para eliminar una venta
        private void EliminarVenta(int idVenta)
        {
            try
            {
                using (SqlConnection conexion = new SqlConnection(cadena))
                using (SqlCommand comando = new SqlCommand("spEliminarVentaPorID", conexion))
                {
                    comando.CommandType = CommandType.StoredProcedure;
                    comando.Parameters.AddWithValue("@IDVenta", idVenta);

                    conexion.Open();
                    comando.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                // Si hay algún error, lo mostramos en la página
                MostrarMensajeError("Error al eliminar la venta: " + ex.Message);
            }
        }

        // Evento para el botón de eliminar en el GridView
        protected void GridViewVentas_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                // Obtener el ID de la venta desde la primera columna
                int idVenta = Convert.ToInt32(GridViewVentas.Rows[e.RowIndex].Cells[0].Text);
                // Eliminar la venta utilizando el ID obtenido
                EliminarVenta(idVenta);
                // Recargar las ventas en el GridView
                CargarVentas();
            }
            catch (Exception ex)
            {
                // Manejar la excepción aquí
                MostrarMensajeError("Error al eliminar la venta: " + ex.Message);
            }
        }

        // Método para mostrar un mensaje de error en la página
        private void MostrarMensajeError(string mensaje)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", $"alert('{mensaje}');", true);
        }

        // Método para limpiar los campos del formulario después de realizar una operación
        private void LimpiarCampos()
        {
            txtIDUsuario.Text = "";
            txtIDProducto.Text = "";
            txtCantidad.Text = "";
            txtTotal.Text = "";
            txtFechaVenta.Text = "";
        }

        protected void btnAgregarVenta_Click(object sender, EventArgs e)
        {
            try
            {
                // Recuperar los valores ingresados en los campos de texto
                int idUsuario = Convert.ToInt32(txtIDUsuario.Text);
                int idProducto = Convert.ToInt32(txtIDProducto.Text);
                int cantidad = Convert.ToInt32(txtCantidad.Text);
                decimal total = Convert.ToDecimal(txtTotal.Text);
                DateTime fechaVenta = Convert.ToDateTime(txtFechaVenta.Text);

                // Llamar al procedimiento almacenado para agregar una nueva venta
                using (SqlConnection conexion = new SqlConnection(cadena))
                using (SqlCommand comando = new SqlCommand("spRegistrarVenta", conexion))
                {
                    comando.CommandType = CommandType.StoredProcedure;
                    comando.Parameters.AddWithValue("@IDUsuario", idUsuario);
                    comando.Parameters.AddWithValue("@IDProducto", idProducto);
                    comando.Parameters.AddWithValue("@Cantidad", cantidad);
                    comando.Parameters.AddWithValue("@Total", total);
                    comando.Parameters.AddWithValue("@FechaVenta", fechaVenta);

                    conexion.Open();
                    comando.ExecuteNonQuery();
                }

                // Recargar las ventas en el GridView
                CargarVentas();

                // Limpiar los campos del formulario después de agregar una venta
                LimpiarCampos();
            }
            catch (Exception ex)
            {
                // Si hay algún error, mostrar el mensaje de error en la página
                MostrarMensajeError("Error al agregar la venta: " + ex.Message);
            }
        }
    }
}