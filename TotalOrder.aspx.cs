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
    public partial class WebForm7 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllOrders();
            }
        }

        private void LoadAllOrders()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT 
                        c.Id AS OrderId,
                        m.Title,
                        m.ImagePath,
                        m.Price,
                        c.Quantity,
                        (m.Price * c.Quantity) AS TotalPrice,
                        c.DateAdded AS OrderDate
                    FROM AddToCart c
                    INNER JOIN AddMenu m ON c.ImageId = m.Id
                    ORDER BY c.DateAdded DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridViewOrders.DataSource = dt;
                GridViewOrders.DataBind();
            }
        }

        protected void GridViewOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteOrder")
            {
                int orderId = Convert.ToInt32(e.CommandArgument);

                string connStr = ConfigurationManager.ConnectionStrings["connDB"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string deleteQuery = "DELETE FROM AddToCart WHERE Id = @OrderId";
                    SqlCommand cmd = new SqlCommand(deleteQuery, conn);
                    cmd.Parameters.AddWithValue("@OrderId", orderId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }

                // Refresh GridView
                LoadAllOrders();
            }
        }
    }
}