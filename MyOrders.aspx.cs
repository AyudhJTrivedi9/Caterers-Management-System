using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplicationFailDataDemo
{
    public partial class MyOrders : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserId"]);
                    LoadUserOrders(userId);
                }
                else
                {
                    Response.Redirect("LoginPage.aspx");
                }
            }
        }

        private void LoadUserOrders(int userId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["connDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT 
                        o.Id AS OrderId,
                        m.Title,
                        m.ImagePath,
                        m.Price,
                        o.Quantity,
                        (m.Price * o.Quantity) AS TotalPrice,
                        o.OrderDate
                    FROM Orders o
                    INNER JOIN AddMenu m ON o.ItemId = m.Id
                    WHERE o.UserId = @UserId
                    ORDER BY o.OrderDate DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", userId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    GridViewOrders.DataSource = dt;
                    GridViewOrders.DataBind();

                    lblTotalOrders.Text = dt.Rows.Count.ToString();
                    decimal totalAmount = 0;
                    foreach (DataRow row in dt.Rows)
                        totalAmount += Convert.ToDecimal(row["TotalPrice"]);

                    lblTotalAmount.Text = totalAmount.ToString("0.00");
                    lblMessage.Visible = false;
                }
                else
                {
                    GridViewOrders.Visible = false;
                    lblMessage.Visible = true;
                    lblMessage.Text = "You haven't placed any orders yet.";
                }
            }
        }

        // ✅ Handle Delete button click
        protected void GridViewOrders_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteOrder")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int orderId = Convert.ToInt32(GridViewOrders.DataKeys[index].Value);

                DeleteOrder(orderId);

                // Reload orders after deletion
                int userId = Convert.ToInt32(Session["UserId"]);
                LoadUserOrders(userId);
            }
        }

        private void DeleteOrder(int orderId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["connDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "DELETE FROM Orders WHERE Id=@OrderId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@OrderId", orderId);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
    }
}
