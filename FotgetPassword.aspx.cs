using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web.UI;

namespace WebApplicationFailDataDemo
{
    public partial class WebForm14 : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ConnDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // ============================
        //   SEND OTP
        // ============================
        protected void btnSendOTP_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string mobile = txtMobile.Text.Trim();

            if (email == "" && mobile == "")
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Please enter Email or Mobile.";
                return;
            }

            // Generate OTP
            Random rnd = new Random();
            string generatedOTP = rnd.Next(100000, 999999).ToString();

            // Store OTP & User input in Session
            Session["OTP"] = generatedOTP;
            Session["Email"] = email;
            Session["Mobile"] = mobile;

            try
            {
                if (email != "")
                {
                    MailMessage mail = new MailMessage();
                    mail.To.Add(email);
                    mail.From = new MailAddress("ayudhtrivedi@gmail.com");
                    mail.Subject = "Your OTP for Password Reset";
                    mail.Body = "Your OTP is: " + generatedOTP;

                    SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                    smtp.Credentials = new System.Net.NetworkCredential("ayudhtrivedi@gmail.com", "ftrciulngekfrtxb");
                    smtp.EnableSsl = true;
                    smtp.Send(mail);

                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "OTP sent to your email.";
                }
                else
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "OTP: " + generatedOTP + " (Testing mode)";
                }
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error sending OTP: " + ex.Message;
            }
        }

        // ============================
        //   RESET PASSWORD
        // ============================
        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            string enteredOTP = txtOTP.Text.Trim();
            string savedOTP = Session["OTP"]?.ToString() ?? "";

            if (enteredOTP != savedOTP)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Invalid OTP.";
                return;
            }

            string newPass = txtNewPassword.Text.Trim();
            string confirmPass = txtConfirmPassword.Text.Trim();

            if (newPass == "" || confirmPass == "")
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Enter new password.";
                return;
            }

            if (newPass != confirmPass)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Passwords do not match!";
                return;
            }

            string email = Session["Email"]?.ToString();
            string mobile = Session["Mobile"]?.ToString();
            string role = rblRole.SelectedValue;

            // TABLE NAME
            string table = (role == "Customer") ? "CustomerLogin" : "AdminLogin";

            // SQL depends on Email or Mobile
            string query = "";

            if (!string.IsNullOrEmpty(email))
            {
                query = $"UPDATE {table} SET Passwd=@Password, Conf_Passwd=@Password WHERE E_id=@Email";
            }
            else
            {
                query = $"UPDATE {table} SET Passwd=@Password, Conf_Passwd=@Password WHERE Mobile_No=@Mobile";
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Password", newPass);

                if (!string.IsNullOrEmpty(email))
                    cmd.Parameters.AddWithValue("@Email", email);
                else
                    cmd.Parameters.AddWithValue("@Mobile", mobile);

                con.Open();
                int rows = cmd.ExecuteNonQuery();

                if (rows > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Password reset successfully!";
                    Session.Remove("OTP");
                }
                else
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "User not found.";
                }
            }
        }

    }
}
