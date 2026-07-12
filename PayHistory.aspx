<%@ Page Title="Payment History" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="PayHistory.aspx.cs" Inherits="WebApplicationFailDataDemo.PayHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .history-container {
            width: 80%;
            margin: 40px auto;
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .btn:hover { background-color: #0056b3; }
        h2 { text-align: center; }
        .total {
            text-align: right;
            font-weight: bold;
            margin-top: 15px;
            font-size: 18px;
        }
        .no-records {
            text-align: center;
            color: red;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="history-container">
        <h2>📜 My Payment History</h2>
        <asp:GridView ID="gvHistory" runat="server" AutoGenerateColumns="False" CssClass="table"
            OnRowCommand="gvHistory_RowCommand">
            <Columns>
                <asp:BoundField DataField="PaymentId" HeaderText="Order ID" />
                <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="PaymentMethod" HeaderText="Payment Method" />
                <asp:BoundField DataField="CardOrUpi" HeaderText="Card/UPI" />
                <asp:BoundField DataField="Amount" HeaderText="Amount (₹)" DataFormatString="{0:N2}" />
                <asp:BoundField DataField="PaymentDate" HeaderText="Date" DataFormatString="{0:dd-MM-yyyy}" />
                <asp:TemplateField HeaderText="PDF">
                    <ItemTemplate>
                        <asp:Button ID="btnPDF" runat="server" Text="Download PDF" CssClass="btn"
                            CommandName="GeneratePDF" CommandArgument='<%# Eval("PaymentId") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:Label ID="lblTotalAmount" runat="server" CssClass="total"></asp:Label>
        <asp:Label ID="lblNoRecords" runat="server" CssClass="no-records"></asp:Label>
    </div>
</asp:Content>
