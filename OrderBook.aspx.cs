using System;

namespace WebApplicationFailDataDemo
{
    public partial class OrderBook : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Only Date & Time auto-set
                txtDate.Text = DateTime.Now.ToString("dd-MM-yyyy");
                txtTime.Text = DateTime.Now.ToString("hh:mm tt");

                // User must manually enter Username & Email
                txtUserName.Text = "";
                txtEmail.Text = "";
            }
        }

        protected void txtQty_TextChanged(object sender, EventArgs e)
        {
            lblMsg.Text = "";

            if (string.IsNullOrWhiteSpace(txtQty.Text))
            {
                lblMsg.Text = "Please enter quantity.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                txtDiscount.Text = "";
                return;
            }

            if (!int.TryParse(txtQty.Text.Trim(), out int qty) || qty <= 0)
            {
                lblMsg.Text = "Enter a valid positive number!";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                txtDiscount.Text = "";
                return;
            }

            int discount =
                  qty >= 400 ? 50
                : qty >= 300 ? 40
                : qty >= 200 ? 30
                : qty >= 100 ? 20
                : 0;

            txtDiscount.Text = discount.ToString();
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            // Validation
            if (string.IsNullOrWhiteSpace(txtUserName.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text) ||
                string.IsNullOrWhiteSpace(txtQty.Text))
            {
                lblMsg.Text = "Please fill all fields before proceeding.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Save values
            Session["OrderQty"] = txtQty.Text;
            Session["OrderDiscount"] = txtDiscount.Text;
            Session["OrderDate"] = txtDate.Text;
            Session["OrderTime"] = txtTime.Text;
            Session["OrderUser"] = txtUserName.Text;
            Session["OrderEmail"] = txtEmail.Text;

            Response.Redirect("Add.aspx");
        }
    }
}
