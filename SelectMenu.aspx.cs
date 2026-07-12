using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebApplicationFailDataDemo
{
    public partial class SelectMenu : System.Web.UI.Page
    {
        string cs = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\DatabasePRJ.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadMenuItems();
        }

        private void LoadMenuItems()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM AddMenu", con);
                con.Open();
                //Repeater1.DataSource = cmd.ExecuteReader();
                //Repeater1.DataBind();
            }
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectDish")
            {
                string[] data = e.CommandArgument.ToString().Split('|');
                string itemId = data[0];
                decimal price = Convert.ToDecimal(data[1]);

                // Get last order discount
                int discount = 0;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("SELECT TOP 1 Discount, Id FROM OrderBook ORDER BY Id DESC", con);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        discount = Convert.ToInt32(dr["Discount"]);
                        // Pass OrderId to payment
                        string orderId = dr["Id"].ToString();
                        decimal finalAmount = price - (price * discount / 100);

                        Response.Redirect($"SelectMenuPayment.aspx?ItemId={itemId}&Price={price}&Discount={discount}&PayAmount={finalAmount}&OrderId={orderId}", true);
                    }
                }
            }
        }
    }
}
