using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web.UI;

namespace WebApplicationFailDataDemo
{
    public partial class WebForm9 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string name = txtName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string subject = txtSubject.Text.Trim();
                string message = txtMessage.Text.Trim();

                // Validate fields
                if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) ||
                    string.IsNullOrEmpty(subject) || string.IsNullOrEmpty(message))
                {
                    lblStatus.Text = "⚠ Please fill in all fields.";
                    lblStatus.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // 1️⃣ Save to database
                string connectionString = ConfigurationManager.ConnectionStrings["ConnDB"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"INSERT INTO ContactMessages (Name, Email, Subject, Message, DateSent)
                                     VALUES (@Name, @Email, @Subject, @Message, GETDATE())";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Subject", subject);
                        cmd.Parameters.AddWithValue("@Message", message);
                        cmd.ExecuteNonQuery();
                    }
                }

                // 2️⃣ Send Email
                MailMessage mail = new MailMessage();
                mail.To.Add("ayudhtrivedi@gmail.com");  // Receiver email
                mail.From = new MailAddress(email);
                mail.Subject = subject;
                mail.Body = $"Name: {name}\nEmail: {email}\n\nMessage:\n{message}";

                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                smtp.Credentials = new System.Net.NetworkCredential(
                    "ayudhtrivedi@gmail.com",
                    "e g b h g l g h i g n y y d m c"
                );
                smtp.EnableSsl = true;
                smtp.Send(mail);

                lblStatus.Text = "✅ Thank you, " + name + "! Your message has been sent and stored successfully.";
                lblStatus.ForeColor = System.Drawing.Color.Green;

                // Clear input fields
                txtName.Text = "";
                txtEmail.Text = "";
                txtSubject.Text = "";
                txtMessage.Text = "";
            }
            catch (Exception ex)
            {
                lblStatus.Text = "❌ Error: " + ex.Message;
                lblStatus.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}
