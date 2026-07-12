using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationFailDataDemo
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                FetchUserLogs();
        }

        private void FetchUserLogs()
        {
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query;

                if (Session["UserRole"] != null && Session["UserRole"].ToString() == "Admin")
                {
                    query = "SELECT * FROM UserLogHistory ORDER BY LoginTime DESC";
                }
                else if (Session["UserId"] != null)
                {
                    query = "SELECT * FROM UserLogHistory WHERE UserId = @UserId ORDER BY LoginTime DESC";
                }
                else
                {
                    Response.Redirect("LoginPage.aspx");
                    return;
                }

                SqlCommand cmd = new SqlCommand(query, conn);

                if (query.Contains("@UserId"))
                    cmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["UserId"]));

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvUserLogs.DataSource = dt;
                gvUserLogs.DataBind();
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            FetchUserLogs();
        }
    }
}