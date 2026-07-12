using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationFailDataDemo
{
    public partial class WebForm15 : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ConnDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMessages();
            }
        }

        private void LoadMessages()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM ContactMessages ORDER BY DateSent DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvMessages.DataSource = dt;
                gvMessages.DataBind();
            }
        }

        protected void gvMessages_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int messageId = Convert.ToInt32(gvMessages.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string deleteQuery = "DELETE FROM ContactMessages WHERE Id=@Id";
                SqlCommand cmd = new SqlCommand(deleteQuery, conn);
                cmd.Parameters.AddWithValue("@Id", messageId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            lblStatus.ForeColor = System.Drawing.Color.Green;
            lblStatus.Text = "Message deleted successfully.";

            LoadMessages(); // Refresh grid
        }
    }
}