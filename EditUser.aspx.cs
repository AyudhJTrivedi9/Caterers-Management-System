using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebApplicationFailDataDemo
{
    public partial class EditUser : System.Web.UI.Page
    {
        string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string email = txtSearchEmail.Text.Trim();

            if (string.IsNullOrEmpty(email))
            {
                lblMessage.Text = "⚠️ Please enter an email to search.";
                lblMessage.CssClass = "message error";
                pnlEdit.Visible = false;
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM CustomerLogin WHERE E_id = @E_id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@E_id", email);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtFirstName.Text = reader["F_Name"].ToString();
                    txtLastName.Text = reader["L_Name"].ToString();
                    txtDOB.Text = Convert.ToDateTime(reader["DOB"]).ToString("yyyy-MM-dd");
                    txtMobile.Text = reader["Mobile_No"].ToString();
                    rblGender.SelectedValue = reader["Gender"].ToString();
                    txtCity.Text = reader["City"].ToString();
                    txtAddress.Text = reader["Address"].ToString();
                    txtRole.Text = reader["Roll"].ToString();

                    pnlEdit.Visible = true;
                    lblMessage.Text = "✅ Record found. You can edit details below.";
                    lblMessage.CssClass = "message success";
                }
                else
                {
                    lblMessage.Text = "❌ No record found for the entered email.";
                    lblMessage.CssClass = "message error";
                    pnlEdit.Visible = false;
                }

                reader.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string email = txtSearchEmail.Text.Trim();
            string fname = txtFirstName.Text.Trim();
            string lname = txtLastName.Text.Trim();
            string dob = txtDOB.Text;
            string mobile = txtMobile.Text.Trim();
            string gender = rblGender.SelectedValue;
            string city = txtCity.Text.Trim();
            string address = txtAddress.Text.Trim();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"UPDATE CustomerLogin 
                                 SET F_Name=@FName, L_Name=@LName, DOB=@DOB, Mobile_No=@Mobile, Gender=@Gender, 
                                     City=@City, Address=@Address 
                                 WHERE E_id=@E_id";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FName", fname);
                cmd.Parameters.AddWithValue("@LName", lname);
                cmd.Parameters.AddWithValue("@DOB", dob);
                cmd.Parameters.AddWithValue("@Mobile", mobile);
                cmd.Parameters.AddWithValue("@Gender", gender);
                cmd.Parameters.AddWithValue("@City", city);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@E_id", email);

                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                if (rows > 0)
                {
                    lblMessage.Text = "✅ Profile updated successfully!";
                    lblMessage.CssClass = "message success";
                }
                else
                {
                    lblMessage.Text = "❌ Update failed. Please try again.";
                    lblMessage.CssClass = "message error";
                }
            }
        }
    }
}
