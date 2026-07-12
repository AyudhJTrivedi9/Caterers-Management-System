using System;
using System.Configuration;
using System.Data.SqlClient;

namespace WebApplicationFailDataDemo
{
    public partial class Payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["CartTotal"] != null)
                    lblTotalAmount.Text = "Total Payable: ₹" + Session["CartTotal"].ToString();
                else
                    lblTotalAmount.Text = "Total Payable: ₹0.00";
            }
        }

        protected void rblPaymentMethod_SelectedIndexChanged(object sender, EventArgs e)
        {
            string method = rblPaymentMethod.SelectedValue;
            pnlCard.Visible = (method == "Credit Card" || method == "Debit Card");
            pnlUPI.Visible = (method == "UPI");
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtName.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text) ||
                string.IsNullOrWhiteSpace(txtAddress.Text) ||
                string.IsNullOrWhiteSpace(rblPaymentMethod.SelectedValue))
            {
                lblMessage.Text = "❌ Please fill all required details.";
                lblMessage.CssClass = "error";
                return;
            }

            string paymentMethod = rblPaymentMethod.SelectedValue;
            string cardOrUpi = paymentMethod == "UPI" ? txtUPI.Text.Trim() : txtCardNumber.Text.Trim();
            decimal amount = 0;
            decimal.TryParse(Session["CartTotal"]?.ToString(), out amount);

            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["connDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = @"INSERT INTO Payments 
                                    (FullName, Email, Address, PaymentMethod, CardOrUpi, Amount, PaymentDate) 
                                     VALUES (@FullName, @Email, @Address, @PaymentMethod, @CardOrUpi, @Amount, GETDATE())";
                    SqlCommand cmd = new SqlCommand(query, conn);

                    cmd.Parameters.AddWithValue("@FullName", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@PaymentMethod", paymentMethod);
                    cmd.Parameters.AddWithValue("@CardOrUpi", cardOrUpi);
                    cmd.Parameters.AddWithValue("@Amount", amount);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMessage.Text = "✅ Payment successful via " + paymentMethod + "!";
                lblMessage.CssClass = "success";

                // Clear session
                Session["Cart"] = null;
                Session["CartTotal"] = null;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Error: " + ex.Message;
                lblMessage.CssClass = "error";
            }
        }
    }
}
