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
    public partial class Usuarios : System.Web.UI.Page
    {
        private static string cadena = ConfigurationManager.ConnectionStrings["Cadena"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarUsuarios();
            }
        }

        // Método para cargar los usuarios desde la base de datos y mostrarlos en el GridView
        private void CargarUsuarios()
        {
            try
            {
                using (SqlConnection conexion = new SqlConnection(cadena))
                {
                    // Consulta SQL para obtener los usuarios
                    string consulta = "EXEC spListarUsuarios";
                    SqlDataAdapter adapter = new SqlDataAdapter(consulta, conexion);
                    DataTable dtUsuarios = new DataTable();
                    adapter.Fill(dtUsuarios);

                    // Asignamos los datos al control GridView
                    GridViewUsuarios.DataSource = dtUsuarios;
                    GridViewUsuarios.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Si hay algún error, lo mostramos en la página
                Response.Write("Error al cargar los usuarios: " + ex.Message);
            }
        }

        // Método para eliminar un usuario
        protected void EliminarUsuario(int idUsuario)
        {
            try
            {
                using (SqlConnection conexion = new SqlConnection(cadena))
                {
                    // Abrir conexión
                    conexion.Open();

                    // Crear y configurar el comando para llamar al procedimiento almacenado
                    SqlCommand comando = new SqlCommand("spEliminarUsuarioPorID", conexion);
                    comando.CommandType = CommandType.StoredProcedure;

                    // Asignar parámetros
                    comando.Parameters.AddWithValue("@IDUsuario", idUsuario);

                    // Ejecutar el comando
                    comando.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                // Si hay algún error, lo mostramos en la página
                Response.Write("Error al eliminar el usuario: " + ex.Message);
            }
        }

        // Evento para el botón de editar en el GridView
        protected void GridViewUsuarios_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewUsuarios.EditIndex = e.NewEditIndex;
            CargarUsuarios();
        }

        // Evento para el botón de eliminar en el GridView
        protected void GridViewUsuarios_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                // Obtener el ID del usuario desde la primera columna
                int idUsuario = Convert.ToInt32(GridViewUsuarios.Rows[e.RowIndex].Cells[0].Text);
                // Eliminar el usuario utilizando el ID obtenido
                EliminarUsuario(idUsuario);
                // Recargar los usuarios en el GridView
                CargarUsuarios();
            }
            catch (Exception ex)
            {
                // Manejar la excepción aquí
                Response.Write("Error al eliminar el usuario: " + ex.Message);
            }
        }

        // Método para limpiar los campos del formulario después de realizar una operación
        protected void LimpiarCampos()
        {
            txtDNI.Text = "";
            txtNombre.Text = "";
            txtApellido.Text = "";
            txtTelefono.Text = "";
            txtEmail.Text = "";
            txtDireccion.Text = "";
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                // Recuperar los valores ingresados en los campos de texto
                string dni = txtDNI.Text;
                string nombre = txtNombre.Text;
                string apellido = txtApellido.Text;
                string telefono = txtTelefono.Text;
                string email = txtEmail.Text;
                string direccion = txtDireccion.Text;

                // Llamar al procedimiento almacenado para agregar un nuevo usuario
                using (SqlConnection conexion = new SqlConnection(cadena))
                {
                    // Abrir conexión
                    conexion.Open();

                    // Crear y configurar el comando para llamar al procedimiento almacenado
                    SqlCommand comando = new SqlCommand("spCrearUsuario", conexion);
                    comando.CommandType = CommandType.StoredProcedure;

                    // Asignar parámetros
                    comando.Parameters.AddWithValue("@DNI", dni);
                    comando.Parameters.AddWithValue("@Nombre", nombre);
                    comando.Parameters.AddWithValue("@Apellido", apellido);
                    comando.Parameters.AddWithValue("@Telefono", telefono);
                    comando.Parameters.AddWithValue("@Email", email);
                    comando.Parameters.AddWithValue("@Direccion", direccion);

                    // Ejecutar el comando
                    comando.ExecuteNonQuery();

                    // Recargar los usuarios en el GridView
                    CargarUsuarios();

                    // Limpiar los campos del formulario después de agregar un usuario
                    LimpiarCampos();
                }
            }
            catch (Exception ex)
            {
                // Si hay algún error, mostrar el mensaje de error en la página
                Response.Write("Error al agregar el usuario: " + ex.Message);
            }
        }

        // Método para actualizar un usuario
        protected void ActualizarUsuario(int idUsuario, string dni, string nombre, string apellido, string telefono, string email, string direccion)
        {
            try
            {
                using (SqlConnection conexion = new SqlConnection(cadena))
                {
                    // Abrir conexión
                    conexion.Open();

                    // Crear y configurar el comando para llamar al procedimiento almacenado
                    SqlCommand comando = new SqlCommand("spActualizarUsuario", conexion);
                    comando.CommandType = CommandType.StoredProcedure;

                    // Asignar parámetros
                    comando.Parameters.AddWithValue("@IDUsuario", idUsuario);
                    comando.Parameters.AddWithValue("@DNI", dni);
                    comando.Parameters.AddWithValue("@Nombre", nombre);
                    comando.Parameters.AddWithValue("@Apellido", apellido);
                    comando.Parameters.AddWithValue("@Telefono", telefono);
                    comando.Parameters.AddWithValue("@Email", email);
                    comando.Parameters.AddWithValue("@Direccion", direccion);

                    // Ejecutar el comando
                    comando.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                // Si hay algún error, lo mostramos en la página
                Response.Write("Error al actualizar el usuario: " + ex.Message);
            }
        }

        // Evento para el botón de actualizar en el GridView
        protected void GridViewUsuarios_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridViewUsuarios.Rows[e.RowIndex];

                // Verificar si la fila y los controles TextBox existen
                if (row != null)
                {
                    TextBox txtDNI = row.FindControl("txtDNI") as TextBox;
                    TextBox txtNombre = row.FindControl("txtNombre") as TextBox;
                    TextBox txtApellido = row.FindControl("txtApellido") as TextBox;
                    TextBox txtTelefono = row.FindControl("txtTelefono") as TextBox;
                    TextBox txtEmail = row.FindControl("txtEmail") as TextBox;
                    TextBox txtDireccion = row.FindControl("txtDireccion") as TextBox;

                    // Verificar si los TextBox se encontraron correctamente
                    if (txtDNI != null && txtNombre != null && txtApellido != null && txtTelefono != null && txtEmail != null && txtDireccion != null)
                    {
                        string idUsuarioString = GridViewUsuarios.DataKeys[e.RowIndex].Values["IDUsuario"].ToString();

                        int idUsuario;
                        if (int.TryParse(idUsuarioString, out idUsuario))
                        {
                            string dni = txtDNI.Text;
                            string nombre = txtNombre.Text;
                            string apellido = txtApellido.Text;
                            string telefono = txtTelefono.Text;
                            string email = txtEmail.Text;
                            string direccion = txtDireccion.Text;

                            ActualizarUsuario(idUsuario, dni, nombre, apellido, telefono, email, direccion);
                            GridViewUsuarios.EditIndex = -1; // Salir del modo de edición
                            CargarUsuarios();
                        }
                        else
                        {
                            Response.Write("El ID del usuario no es un número válido.");
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
                Response.Write("Error al actualizar el usuario: " + ex.Message);
            }
        }

    }
}