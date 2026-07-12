using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationFailDataDemo
{
	public partial class WebForm13 : System.Web.UI.Page
	{
        string connStr = ConfigurationManager.ConnectionStrings["connDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMenuItems();
            }
        }

        private void LoadMenuItems()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Id, Title FROM AddMenu ORDER BY Title";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlMenu.DataSource = dt;
                ddlMenu.DataTextField = "Title";
                ddlMenu.DataValueField = "Id";
                ddlMenu.DataBind();

                ddlMenu.Items.Insert(0, new ListItem("--Select--", "0"));
            }
        }

        protected void ddlMenu_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlMenu.SelectedValue != "0")
            {
                int id = Convert.ToInt32(ddlMenu.SelectedValue);
                LoadMenuDetails(id);
            }
            else
            {
                txtTitle.Text = "";
                txtDescription.Text = "";
                txtPrice.Text = "";
            }
        }

        private void LoadMenuDetails(int id)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Title, Description, Price, ImagePath FROM AddMenu WHERE Id=@Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtTitle.Text = reader["Title"].ToString();
                    txtDescription.Text = reader["Description"].ToString();
                    txtPrice.Text = reader["Price"].ToString();
                }
                reader.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (ddlMenu.SelectedValue == "0")
            {
                lblMessage.Text = "Please select an item to update.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            int id = Convert.ToInt32(ddlMenu.SelectedValue);
            string title = txtTitle.Text.Trim();
            string description = txtDescription.Text.Trim();
            string priceText = txtPrice.Text.Trim();

            if (!decimal.TryParse(priceText, out decimal price))
            {
                lblMessage.Text = "Enter a valid price.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string imagePath = null;
            if (FileUpload1.HasFile)
            {
                string fileName = Path.GetFileName(FileUpload1.FileName);
                string folderPath = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string fullPath = Path.Combine(folderPath, fileName);
                FileUpload1.SaveAs(fullPath);
                imagePath = "~/Uploads/" + fileName;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE AddMenu SET Title=@Title, Description=@Description, Price=@Price"
                             + (imagePath != null ? ", ImagePath=@ImagePath" : "")
                             + " WHERE Id=@Id";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@Price", price);
                if (imagePath != null)
                    cmd.Parameters.AddWithValue("@ImagePath", imagePath);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessage.Text = "Item updated successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Green;

            LoadMenuItems(); // refresh dropdown
        }
    }
}