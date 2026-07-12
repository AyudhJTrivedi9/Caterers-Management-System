using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationFailDataDemo
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        private const int TotalDishLimit = 200; // per dish target

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDishesWithStatus();
            }
        }

        private void LoadDishesWithStatus()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connDB"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT 
                        M.Id, M.Title, M.Description, M.Price, M.ImagePath,
                        ISNULL(SUM(C.Quantity), 0) AS AddedCount
                    FROM AddMenu M
                    LEFT JOIN AddToCart C ON M.Id = C.ImageId
                    GROUP BY M.Id, M.Title, M.Description, M.Price, M.ImagePath
                    ORDER BY M.Id DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.Fill(dt);
            }

            // Add calculated columns for remaining & total
            dt.Columns.Add("TotalDishLimit", typeof(int));
            dt.Columns.Add("Remaining", typeof(int));

            foreach (DataRow row in dt.Rows)
            {
                int added = Convert.ToInt32(row["AddedCount"]);
                row["TotalDishLimit"] = TotalDishLimit;
                row["Remaining"] = Math.Max(TotalDishLimit - added, 0);

                // Fix image path
                string rawPath = row["ImagePath"].ToString();
                if (rawPath.StartsWith("~"))
                    row["ImagePath"] = ResolveUrl(rawPath);
            }

            Repeater1.DataSource = dt;
            Repeater1.DataBind();
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;

            HiddenField hfImageId = (HiddenField)item.FindControl("hfImageId");
            TextBox txtQuantity = (TextBox)item.FindControl("txtQuantity");

            if (int.TryParse(hfImageId.Value, out int imageId) && int.TryParse(txtQuantity.Text, out int quantity))
            {
                string connStr = ConfigurationManager.ConnectionStrings["connDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string insertQuery = "INSERT INTO AddToCart (ImageId, Quantity) VALUES (@ImageId, @Quantity)";
                    SqlCommand cmd = new SqlCommand(insertQuery, conn);
                    cmd.Parameters.AddWithValue("@ImageId", imageId);
                    cmd.Parameters.AddWithValue("@Quantity", quantity);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Reload data to show updated remaining count
                LoadDishesWithStatus();

                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Dish added successfully!');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Invalid quantity.');", true);
            }
        }
    }
}
