using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebApplicationFailDataDemo
{
    public partial class Approval : System.Web.UI.Page
    {
        private readonly string connStr = ConfigurationManager.ConnectionStrings["ConnDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadPendingUsers();
        }

        private void LoadPendingUsers()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT Email, RequestDate FROM UserApproval WHERE Status='Pending'";

                using (SqlDataAdapter da = new SqlDataAdapter(sql, conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
            }
        }

        protected void gvUsers_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            string email = e.CommandArgument.ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                if (e.CommandName == "Approve")
                {
                    string sql = "UPDATE UserApproval SET Status='Approved' WHERE Email=@Email";
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.ExecuteNonQuery();
                    }

                    lblMsg.Text = email + " approved successfully!";
                }
                else if (e.CommandName == "Reject")
                {
                    string sql = "UPDATE UserApproval SET Status='Rejected' WHERE Email=@Email";
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.ExecuteNonQuery();
                    }

                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    lblMsg.Text = email + " rejected.";
                }
            }

            LoadPendingUsers();
        }
    }
}
