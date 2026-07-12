using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

namespace WebApplicationFailDataDemo
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        private readonly string connStr = ConfigurationManager.ConnectionStrings["DBConn"].ConnectionString;

        // MAIN ADMIN PASS KEY
        private const string ADMIN_MASTER_KEY = "MAINADMIN2025";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // 🔐 MD5 HASH FUNCTION — FIXED & CORRECT
        private string GetMD5Hash(string input)
        {
            using (MD5 md5 = MD5.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(input);
                byte[] hash = md5.ComputeHash(bytes);

                StringBuilder sb = new StringBuilder();
                foreach (byte b in hash)
                    sb.Append(b.ToString("X2"));

                return sb.ToString();
            }
        }

        // ✔ Strong Password Validation
        private bool IsStrongPassword(string password)
        {
            string pattern =
                @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";

            return Regex.IsMatch(password, pattern);
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            lblMsg.Text = "";
            lblMsg.ForeColor = System.Drawing.Color.Red;

            string fname = txtFName.Text.Trim();
            string lname = txtLName.Text.Trim();
            string dobText = txtDOB.Text.Trim();
            string mobile = txtMobile.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();
            string gender = ddlGender.SelectedValue;
            string city = txtCity.Text.Trim();
            string address = txtAddress.Text.Trim();
            string role = ddlRole.SelectedValue;
            string adminKey = txtAdminKey.Text.Trim();

            // REQUIRED FIELDS
            if (fname == "" || email == "" || password == "" || confirmPassword == "")
            {
                lblMsg.Text = "Please fill all required fields.";
                return;
            }

            // ADMIN KEY VALIDATION
            if (role == "Admin" && adminKey != ADMIN_MASTER_KEY)
            {
                lblMsg.Text = "Invalid Admin Pass Key!";
                return;
            }

            // PASSWORD MATCH
            if (password != confirmPassword)
            {
                lblMsg.Text = "Passwords do not match.";
                return;
            }

            // STRONG PASSWORD CHECK
            if (!IsStrongPassword(password))
            {
                lblMsg.Text = "Password must contain UPPERCASE, lowercase, digit, special char & be at least 8 characters.";
                return;
            }

            // MOBILE VALIDATION
            if (mobile != "" && !Regex.IsMatch(mobile, @"^\d{10}$"))
            {
                lblMsg.Text = "Mobile must be exactly 10 digits.";
                return;
            }

            // EMAIL VALIDATION
            if (!Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                lblMsg.Text = "Invalid email format.";
                return;
            }

            // DATE VALIDATION
            DateTime? dob = null;
            if (dobText != "")
            {
                if (!DateTime.TryParse(dobText, out DateTime parsedDOB))
                {
                    lblMsg.Text = "Invalid date format.";
                    return;
                }

                dob = parsedDOB;
            }

            // 🔐 HASH ONLY PASSWORD (Correct)
            string md5Password = GetMD5Hash(password);

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // CHECK DUPLICATES
                    if (IsEmailOrMobileExists(conn, email, mobile))
                    {
                        lblMsg.Text = "Email or Mobile number already exists.";
                        return;
                    }

                    string table = (role == "Customer") ? "CustomerLogin" : "AdminLogin";

                    // INSERT QUERY - FIXED
                    string sql = $@"
                    INSERT INTO {table}
                    (F_Name, L_Name, DOB, Mobile_No, E_id, Passwd, Gender, City, Address, Roll)
                    VALUES
                    (@FName, @LName, @DOB, @Mobile_No, @E_id, @Passwd, @Gender, @City, @Address, @Roll)";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@FName", fname);
                        cmd.Parameters.AddWithValue("@LName", (object)lname ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@DOB", (object)dob ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@Mobile_No", (mobile == "" ? (object)DBNull.Value : mobile));
                        cmd.Parameters.AddWithValue("@E_id", email);
                        cmd.Parameters.AddWithValue("@Passwd", md5Password);   // MD5 HASH SAVED
                        cmd.Parameters.AddWithValue("@Gender", gender ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@City", city ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@Address", address ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@Roll", role);

                        cmd.ExecuteNonQuery();
                    }

                    // If customer → add to approval table
                    if (role == "Customer")
                    {
                        string sql2 = @"INSERT INTO UserApproval (Email, Status, RequestDate) 
                                        VALUES (@Email, 'Pending', GETDATE())";

                        using (SqlCommand cmd2 = new SqlCommand(sql2, conn))
                        {
                            cmd2.Parameters.AddWithValue("@Email", email);
                            cmd2.ExecuteNonQuery();
                        }

                        lblMsg.ForeColor = System.Drawing.Color.Green;
                        lblMsg.Text = "Registered successfully. Approval pending.";
                    }
                    else
                    {
                        lblMsg.ForeColor = System.Drawing.Color.Green;
                        lblMsg.Text = "Admin created successfully.";
                    }

                    ClearForm();
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
            }
        }

        // CHECK IF EMAIL OR MOBILE EXISTS
        private bool IsEmailOrMobileExists(SqlConnection conn, string email, string mobile)
        {
            string sql = @"
                SELECT COUNT(*) FROM (
                    SELECT E_id AS Value FROM CustomerLogin
                    UNION ALL SELECT E_id FROM AdminLogin
                ) t WHERE Value = @Email";

            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                if (Convert.ToInt32(cmd.ExecuteScalar()) > 0)
                    return true;
            }

            if (mobile != "")
            {
                string sql2 = @"
                    SELECT COUNT(*) FROM (
                        SELECT Mobile_No FROM CustomerLogin
                        UNION ALL SELECT Mobile_No FROM AdminLogin
                    ) t WHERE Mobile_No = @Mobile";

                using (SqlCommand cmd2 = new SqlCommand(sql2, conn))
                {
                    cmd2.Parameters.AddWithValue("@Mobile", mobile);
                    if (Convert.ToInt32(cmd2.ExecuteScalar()) > 0)
                        return true;
                }
            }

            return false;
        }

        private void ClearForm()
        {
            txtFName.Text = "";
            txtLName.Text = "";
            txtDOB.Text = "";
            txtMobile.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
            ddlGender.SelectedIndex = 0;
            txtCity.Text = "";
            txtAddress.Text = "";
            ddlRole.SelectedIndex = 0;
            txtAdminKey.Text = "";
        }
    }
}
