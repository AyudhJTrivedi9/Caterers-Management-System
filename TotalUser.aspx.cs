using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebApplicationFailDataDemo
{
    public partial class WebFormTotalUsers : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ConnDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadUsers();
        }

        private void LoadUsers()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT Id, F_Name, L_Name, E_id, Mobile_No, Gender, City, Roll FROM CustomerLogin";
                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text = "❌ Error: " + ex.Message;
                lblStatus.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "DELETE FROM CustomerLogin WHERE Id = @Id";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Id", userId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblStatus.Text = "✅ User deleted successfully.";
                lblStatus.ForeColor = System.Drawing.Color.Green;
                LoadUsers();
            }
            catch (Exception ex)
            {
                lblStatus.Text = "❌ Error deleting user: " + ex.Message;
                lblStatus.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int userId = Convert.ToInt32(gvUsers.DataKeys[e.NewEditIndex].Value);
            Response.Redirect("EditUser.aspx?Id=" + userId);
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("Registration.aspx");
        }
    }
}
