using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationFailDataDemo
{
	public partial class WebForm6 : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            string description = txtDescription.Text.Trim();
            string priceText = txtPrice.Text.Trim();

            if (!decimal.TryParse(priceText, out decimal price))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Please enter a valid numeric price.";
                return;
            }

            if (!FileUpload1.HasFile)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Please select an image file.";
                return;
            }

            try
            {
                string fileName = Path.GetFileName(FileUpload1.FileName);
                string folderPath = Server.MapPath("~/Uploads/");

                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string filePath = Path.Combine(folderPath, fileName);
                FileUpload1.SaveAs(filePath);

                string relativePath = "~/Uploads/" + fileName;

                SaveToDatabase(title, description, price, relativePath);

                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Image uploaded successfully!";

                txtTitle.Text = "";
                txtDescription.Text = "";
                txtPrice.Text = "";
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error: " + ex.Message;
            }
        }

        private void SaveToDatabase(string title, string description, decimal price, string imagePath)
        {
            string connStr = ConfigurationManager.ConnectionStrings["connDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    INSERT INTO AddMenu (Title, Description, Price, ImagePath)
                    VALUES (@Title, @Description, @Price, @ImagePath)";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@Price", price);
                cmd.Parameters.AddWithValue("@ImagePath", imagePath);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}