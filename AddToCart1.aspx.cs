using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace WebApplicationFailDataDemo
{
    public partial class ViewItem : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["connDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["ItemId"] != null)
                {
                    int itemId;
                    if (int.TryParse(Request.QueryString["ItemId"], out itemId))
                    {
                        LoadItemDetails(itemId);
                    }
                }
            }
        }

        private void LoadItemDetails(int itemId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Id, Title, Description, Price, Quantity, ImagePath FROM AddMenu WHERE Id=@ItemId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ItemId", itemId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblTitle.Text = reader["Title"].ToString();
                    lblDescription.Text = reader["Description"].ToString();
                    lblPrice.Text = Convert.ToDecimal(reader["Price"]).ToString("0.00");
                    lblStock.Text = "Available: " + reader["Quantity"].ToString();
                    hfSelectedItemId.Value = reader["Id"].ToString();
                    imgItem.ImageUrl = reader["ImagePath"].ToString();

                    ViewState["AvailableQty"] = Convert.ToInt32(reader["Quantity"]);

                    // Set minimum quantity = 25 or max available
                    int minQty = 25;
                    int avail = Convert.ToInt32(reader["Quantity"]);
                    txtQuantity.Text = (avail >= minQty) ? minQty.ToString() : avail.ToString();
                }
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hfSelectedItemId.Value))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Item not found.');", true);
                return;
            }

            int userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 1;
            int itemId = Convert.ToInt32(hfSelectedItemId.Value);
            int quantity;
            if (!int.TryParse(txtQuantity.Text, out quantity))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Invalid quantity.');", true);
                return;
            }

            int availableQty = ViewState["AvailableQty"] != null ? Convert.ToInt32(ViewState["AvailableQty"]) : 0;
            if (quantity > availableQty)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Only {availableQty} items available.');", true);
                return;
            }

            // Insert into AddToCart table (IsApproved=0)
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = @"INSERT INTO AddToCart (ImageId, Quantity, DateAdded) 
                                 VALUES (@ItemId, @Qty, GETDATE())";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ItemId", itemId);
                cmd.Parameters.AddWithValue("@Qty", quantity);
                cmd.ExecuteNonQuery();
            }

            // Show remaining
            int remaining = availableQty - quantity;
            lblRemaining.Text = $"Remaining Dishes: {remaining}";
            lblRemaining.Visible = true;

            ScriptManager.RegisterStartupScript(this, GetType(), "added",
                "alert('Item added to cart successfully!'); window.location='ViewCart.aspx';", true);
        }
    }
}
