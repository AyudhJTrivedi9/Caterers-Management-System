using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplicationFailDataDemo
{
    public partial class AddToCart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadImages();
        }

        private void LoadImages()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Id, Title, Description, Price, ImagePath FROM AddMenu ORDER BY Id DESC";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Fix image paths if using "~" in ImagePath (like ~/Images/item1.jpg)
                foreach (DataRow row in dt.Rows)
                {
                    if (row["ImagePath"] != DBNull.Value)
                    {
                        string rawPath = row["ImagePath"].ToString();
                        if (rawPath.StartsWith("~"))
                            row["ImagePath"] = ResolveUrl(rawPath);
                    }
                }

                Repeater1.DataSource = dt;
                Repeater1.DataBind();
            }
        }
    }
}
