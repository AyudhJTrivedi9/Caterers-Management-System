using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationFailDataDemo
{
	public partial class WebForm8 : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int rating = GetSelectedRating(); // Determine which star is checked
            string feedback = txtFeedback.Text.Trim();

            if (rating == 0)
            {
                lblMessage.Text = "Please select a rating.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["conndb"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "INSERT INTO Ratings (RatingValue, Feedback) VALUES (@RatingValue, @Feedback)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@RatingValue", rating);
                cmd.Parameters.AddWithValue("@Feedback", string.IsNullOrEmpty(feedback) ? (object)DBNull.Value : feedback);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            lblMessage.Text = "Thank you for your feedback!";
            lblMessage.ForeColor = System.Drawing.Color.Green;

            // Optional: Clear inputs
            txtFeedback.Text = "";
            ClearStars();
        }

        private int GetSelectedRating()
        {
            if (star5.Checked) return 5;
            if (star4.Checked) return 4;
            if (star3.Checked) return 3;
            if (star2.Checked) return 2;
            if (star1.Checked) return 1;
            return 0;
        }

        private void ClearStars()
        {
            star1.Checked = false;
            star2.Checked = false;
            star3.Checked = false;
            star4.Checked = false;
            star5.Checked = false;
        }
    }
}