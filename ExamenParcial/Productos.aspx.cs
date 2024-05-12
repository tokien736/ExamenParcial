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
    public partial class Productos : System.Web.UI.Page
    {
        private static string cadena = ConfigurationManager.ConnectionStrings["Cadena"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProductos();
            }
        }

        private void CargarProductos()
        {
            try
            {
                using (SqlConnection conexion = new SqlConnection(cadena))
                {
                    string consulta = "EXEC spListarProductos";
                    SqlDataAdapter adapter = new SqlDataAdapter(consulta, conexion);
                    DataTable dtProductos = new DataTable();
                    adapter.Fill(dtProductos);

                    GridViewProductos.DataSource = dtProductos;
                    GridViewProductos.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error al cargar los productos: " + ex.Message);
            }
        }

        protected void EliminarProducto(int idProducto)
        {
            try
            {
                using (SqlConnection conexion = new SqlConnection(cadena))
                {
                    conexion.Open();

                    SqlCommand comando = new SqlCommand("spEliminarProductoPorID", conexion);
                    comando.CommandType = CommandType.StoredProcedure;
                    comando.Parameters.AddWithValue("@IDProducto", idProducto);
                    comando.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error al eliminar el producto: " + ex.Message);
            }
        }

        protected void btnAgregarProducto_Click(object sender, EventArgs e)
        {
            try
            {
                string tipo = txtTipo.Text;
                decimal precio = Convert.ToDecimal(txtPrecio.Text);
                string descripcion = txtDescripcion.Text;
                int cantidadDisponible = Convert.ToInt32(txtCantidadDisponible.Text);

                using (SqlConnection conexion = new SqlConnection(cadena))
                {
                    conexion.Open();

                    SqlCommand comando = new SqlCommand("spCrearProducto", conexion);
                    comando.CommandType = CommandType.StoredProcedure;
                    comando.Parameters.AddWithValue("@Tipo", tipo);
                    comando.Parameters.AddWithValue("@Precio", precio);
                    comando.Parameters.AddWithValue("@Descripcion", descripcion);
                    comando.Parameters.AddWithValue("@CantidadDisponible", cantidadDisponible);
                    comando.ExecuteNonQuery();

                    CargarProductos();
                    LimpiarCamposProducto();
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error al agregar el producto: " + ex.Message);
            }
        }

        protected void ActualizarProducto(int idProducto, string tipo, decimal precio, string descripcion, int cantidadDisponible)
        {
            try
            {
                using (SqlConnection conexion = new SqlConnection(cadena))
                {
                    conexion.Open();

                    SqlCommand comando = new SqlCommand("spActualizarProducto", conexion);
                    comando.CommandType = CommandType.StoredProcedure;
                    comando.Parameters.AddWithValue("@IDProducto", idProducto);
                    comando.Parameters.AddWithValue("@Tipo", tipo);
                    comando.Parameters.AddWithValue("@Precio", precio);
                    comando.Parameters.AddWithValue("@Descripcion", descripcion);
                    comando.Parameters.AddWithValue("@CantidadDisponible", cantidadDisponible);
                    comando.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error al actualizar el producto: " + ex.Message);
            }
        }

        protected void GridViewProductos_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewProductos.EditIndex = e.NewEditIndex;
            CargarProductos();
        }

        protected void GridViewProductos_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int idProducto = Convert.ToInt32(GridViewProductos.Rows[e.RowIndex].Cells[0].Text);
                EliminarProducto(idProducto);
                CargarProductos();
            }
            catch (Exception ex)
            {
                Response.Write("Error al eliminar el producto: " + ex.Message);
            }
        }

        protected void GridViewProductos_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridViewProductos.Rows[e.RowIndex];
                if (row != null)
                {
                    TextBox txtTipo = row.FindControl("txtTipo") as TextBox;
                    TextBox txtPrecio = row.FindControl("txtPrecio") as TextBox;
                    TextBox txtDescripcion = row.FindControl("txtDescripcion") as TextBox;
                    TextBox txtCantidadDisponible = row.FindControl("txtCantidadDisponible") as TextBox;

                    if (txtTipo != null && txtPrecio != null && txtDescripcion != null && txtCantidadDisponible != null)
                    {
                        string idProductoString = GridViewProductos.DataKeys[e.RowIndex].Values["IDProducto"].ToString();
                        int idProducto;
                        if (int.TryParse(idProductoString, out idProducto))
                        {
                            string tipo = txtTipo.Text;
                            decimal precio = Convert.ToDecimal(txtPrecio.Text);
                            string descripcion = txtDescripcion.Text;
                            int cantidadDisponible = Convert.ToInt32(txtCantidadDisponible.Text);

                            ActualizarProducto(idProducto, tipo, precio, descripcion, cantidadDisponible);
                            GridViewProductos.EditIndex = -1;
                            CargarProductos();
                        }
                        else
                        {
                            Response.Write("El ID del producto no es un número válido.");
                        }
                    }
                    else
                    {
                        Response.Write("Los controles TextBox no se encontraron correctamente.");
                    }
                }
                else
                {
                    Response.Write("La fila no se encontró correctamente.");
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error al actualizar el producto: " + ex.Message);
            }
        }

        protected void LimpiarCamposProducto()
        {
            txtTipo.Text = "";
            txtPrecio.Text = "";
            txtDescripcion.Text = "";
            txtCantidadDisponible.Text = "";
        }

    }
}