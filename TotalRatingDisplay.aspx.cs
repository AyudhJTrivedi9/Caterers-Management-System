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
	public partial class WebForm12 : System.Web.UI.Page
	{
        string connStr = ConfigurationManager.ConnectionStrings["ConnDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindRatings();
            }
        }

        // Fetch and bind Ratings to GridView
        private void BindRatings()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT RatingID, RatingValue, Feedback, CreatedAt FROM Ratings ORDER BY CreatedAt DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvRatings.DataSource = dt;
                gvRatings.DataBind();
            }
        }

        // Delete selected rating
        protected void gvRatings_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int ratingId = Convert.ToInt32(gvRatings.DataKeys[e.RowIndex].Value);

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string deleteQuery = "DELETE FROM Ratings WHERE RatingID=@RatingID";
                    SqlCommand cmd = new SqlCommand(deleteQuery, conn);
                    cmd.Parameters.AddWithValue("@RatingID", ratingId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Refresh GridView
                BindRatings();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error deleting rating: " + ex.Message + "');</script>");
            }
        }
    }
}