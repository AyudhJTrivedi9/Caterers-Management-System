using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationFailDataDemo
{
    public partial class ViewCart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadCart();
        }

        private void LoadCart()
        {
            DataTable cart = Session["Cart"] as DataTable;

            if (cart != null && cart.Rows.Count > 0)
            {
                GridViewCart.DataSource = cart;
                GridViewCart.DataBind();

                decimal total = 0;
                foreach (DataRow row in cart.Rows)
                {
                    total += Convert.ToDecimal(row["Total"]);
                }

                lblTotal.Text = "Total: ₹" + total.ToString("0.00");
            }
            else
            {
                lblMessage.Text = "🛒 Your cart is empty.";
                GridViewCart.Visible = false;
                lblTotal.Visible = false;
                btnCheckout.Visible = false;
            }
        }

        protected void GridViewCart_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            DataTable cart = Session["Cart"] as DataTable;
            if (cart != null)
            {
                cart.Rows.RemoveAt(e.RowIndex);
                Session["Cart"] = cart;
            }
            LoadCart();
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Session["CartTotal"] = lblTotal.Text.Replace("Total: ₹", "").Trim();
            Response.Redirect("Payment.aspx");
        }
    }
}
