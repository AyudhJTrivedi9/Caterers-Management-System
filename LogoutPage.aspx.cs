using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplicationFailDataDemo
{
    public partial class LogoutPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // ✅ Check if LogId exists in session
            if (Session["LogId"] != null)
            {
                int logId = Convert.ToInt32(Session["LogId"]);
                string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnDB"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string updateLog = "UPDATE UserLogHistory SET LogoutTime = GETDATE() WHERE Id = @LogId";
                    SqlCommand cmd = new SqlCommand(updateLog, conn);
                    cmd.Parameters.AddWithValue("@LogId", logId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }

            // ✅ Clear session and redirect to login page
            Session.Clear();
            Response.Redirect("LoginPage.aspx", false);
        }
    }
}
