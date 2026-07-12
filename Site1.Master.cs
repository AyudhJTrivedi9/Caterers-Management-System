using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplicationFailDataDemo
{
    public partial class Site1 : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // ✅ Prevent duplicate updates on every postback
            {
                DisplayVisitorCount();

                // Increment total visitors only once per session
                if (Session["Visited"] == null)
                {
                    IncrementVisitorCount();
                    Session["Visited"] = true;
                }
            }
        }

        private void DisplayVisitorCount()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string selectQuery = "SELECT TotalCount FROM VisitorCounter WHERE Id = 1";
                SqlCommand cmd = new SqlCommand(selectQuery, conn);
                object result = cmd.ExecuteScalar();
                lblVisitorCount.Text = result != null ? result.ToString() : "0";
            }
        }

        private void IncrementVisitorCount()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string updateQuery = "UPDATE VisitorCounter SET TotalCount = TotalCount + 1 WHERE Id = 1";
                SqlCommand cmd = new SqlCommand(updateQuery, conn);
                cmd.ExecuteNonQuery();
            }
        }
    }
}
