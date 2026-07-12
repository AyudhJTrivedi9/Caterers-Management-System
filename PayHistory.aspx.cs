using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace WebApplicationFailDataDemo
{
    public partial class PayHistory : System.Web.UI.Page
    {
        /*protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("WebForm2.aspx"); // back to login if not logged in
                    return;
                }
                LoadPayments();
            }
        }

        private void LoadPayments()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT PaymentId, FullName, Email, PaymentMethod, CardOrUpi, Amount, PaymentDate FROM Payments WHERE UserId = @UserId ORDER BY PaymentDate DESC", conn);
                da.SelectCommand.Parameters.AddWithValue("@UserId", userId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    gvHistory.DataSource = dt;
                    gvHistory.DataBind();

                    decimal totalAmount = 0;
                    foreach (DataRow row in dt.Rows)
                        totalAmount += Convert.ToDecimal(row["Amount"]);

                    lblTotalAmount.Text = "💰 Total Spent: ₹" + totalAmount.ToString("N2");
                    lblNoRecords.Text = "";
                }
                else
                {
                    gvHistory.DataSource = null;
                    gvHistory.DataBind();
                    lblTotalAmount.Text = "";
                    lblNoRecords.Text = "No payments found for your account.";
                }
            }
        }

        protected void gvHistory_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "GeneratePDF")
            {
                int paymentId = Convert.ToInt32(e.CommandArgument);
                GeneratePDF(paymentId);
            }
        }

        private void GeneratePDF(int paymentId)
        {
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnDB"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Payments WHERE PaymentId = @PaymentId", conn);
                da.SelectCommand.Parameters.AddWithValue("@PaymentId", paymentId);
                da.Fill(dt);
            }

            if (dt.Rows.Count == 0)
                return;

            DataRow row = dt.Rows[0];

            Document pdfDoc = new Document(PageSize.A4, 40, 40, 40, 40);
            MemoryStream ms = new MemoryStream();
            PdfWriter.GetInstance(pdfDoc, ms);
            pdfDoc.Open();

            var titleFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.BLUE);
            var bodyFont = FontFactory.GetFont(FontFactory.HELVETICA, 12, BaseColor.BLACK);

            pdfDoc.Add(new Paragraph("Payment Receipt", titleFont));
            pdfDoc.Add(new Paragraph("\n----------------------------------------\n", bodyFont));
            pdfDoc.Add(new Paragraph($"Full Name: {row["FullName"]}", bodyFont));
            pdfDoc.Add(new Paragraph($"Email: {row["Email"]}", bodyFont));
            pdfDoc.Add(new Paragraph($"Payment Method: {row["PaymentMethod"]}", bodyFont));
            pdfDoc.Add(new Paragraph($"Card/UPI: {row["CardOrUpi"]}", bodyFont));
            pdfDoc.Add(new Paragraph($"Amount Paid: ₹{row["Amount"]}", bodyFont));
            pdfDoc.Add(new Paragraph($"Date: {Convert.ToDateTime(row["PaymentDate"]).ToString("dd-MM-yyyy HH:mm")}", bodyFont));
            pdfDoc.Add(new Paragraph("\n----------------------------------------\n", bodyFont));
            pdfDoc.Add(new Paragraph("Thank you for your payment!", bodyFont));

            pdfDoc.Close();

            byte[] bytes = ms.ToArray();
            ms.Close();

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", $"attachment;filename=PaymentReceipt_{paymentId}.pdf");
            Response.BinaryWrite(bytes);
            Response.End();
        }
        */
    }
}
