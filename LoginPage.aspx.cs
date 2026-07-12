using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplicationFailDataDemo
{
    public partial class WebForm2 : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Session.Clear();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string role = rbAdmin.Checked ? "Admin" : "User";

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "<span style='color:red;'>Please enter username and password.</span>";
                return;
            }

            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = (role == "Admin")
                    ? "SELECT * FROM AdminLogin WHERE F_Name=@Username AND Passwd=@Password"
                    : "SELECT * FROM CustomerLogin WHERE F_Name=@Username AND Passwd=@Password";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    int userId = Convert.ToInt32(reader["Id"]);
                    string userName = reader["F_Name"].ToString();
                    string userEmail = reader["E_id"].ToString();  // Email required to check approval

                    reader.Close();

                    // 🔍 Approval check only for USER login
                    if (role == "User")
                    {
                        string approvalSql = "SELECT Status FROM UserApproval WHERE Email=@Email";

                        SqlCommand cmd2 = new SqlCommand(approvalSql, conn);
                        cmd2.Parameters.AddWithValue("@Email", userEmail);

                        object statusObj = cmd2.ExecuteScalar();

                        if (statusObj == null || statusObj.ToString() != "Approved")
                        {
                            lblMessage.Text = "<span style='color:red;'>Your account is not approved yet!</span>";
                            return;
                        }
                    }

                    // 🟢 Approved → Store session
                    Session["UserId"] = userId;
                    Session["Username"] = userName;
                    Session["UserRole"] = role;

                    // 📝 Insert into Login History
                    string insertLog = @"INSERT INTO UserLogHistory (UserId, UserName, Role, LoginTime)
                                         VALUES (@UserId, @UserName, @Role, GETDATE());
                                         SELECT SCOPE_IDENTITY();";

                    SqlCommand logCmd = new SqlCommand(insertLog, conn);
                    logCmd.Parameters.AddWithValue("@UserId", userId);
                    logCmd.Parameters.AddWithValue("@UserName", userName);
                    logCmd.Parameters.AddWithValue("@Role", role);

                    object result = logCmd.ExecuteScalar();

                    if (result != null)
                    {
                        Session["LogId"] = Convert.ToInt32(result);
                    }

                    // REDIRECT
                    if (role == "User")
                        Response.Redirect("UserDeshboard.aspx", false);
                    else
                        Response.Redirect("AdminDeshboard.aspx", false);
                }
                else
                {
                    lblMessage.Text = "<span style='color:red;'>Invalid username or password.</span>";
                }
            }
        }
    }
}
