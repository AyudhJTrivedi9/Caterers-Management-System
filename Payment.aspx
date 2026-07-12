<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="Payment.aspx.cs" Inherits="WebApplicationFailDataDemo.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .payment-container {
            width: 60%;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.15);
            font-family: Arial;
        }
        h2 { text-align: center; color: #333; }
        label { font-weight: bold; display: block; margin-top: 10px; }
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            margin-bottom: 10px;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }
        .btn:hover { background-color: #0056b3; }
        .total-amount {
            text-align: right;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .success, .error {
            text-align: center;
            margin-top: 15px;
            font-size: 16px;
            font-weight: bold;
        }
        .success { color: green; }
        .error { color: red; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="payment-container">
        <h2>💳 Complete Your Payment</h2>

        <asp:Label ID="lblTotalAmount" runat="server" CssClass="total-amount"></asp:Label>
        <hr />

        <!-- Removed ValidationSummary -->

        <label>Full Name</label>
        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter your name"></asp:TextBox>

        <label>Email</label>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="example@email.com"></asp:TextBox>

        <label>Address</label>
        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Your address"></asp:TextBox>

        <label>Select Payment Method</label>
        <asp:RadioButtonList ID="rblPaymentMethod" runat="server" RepeatDirection="Horizontal"
            AutoPostBack="true" OnSelectedIndexChanged="rblPaymentMethod_SelectedIndexChanged">
            <asp:ListItem Text="Credit Card" Value="Credit Card"></asp:ListItem>
            <asp:ListItem Text="Debit Card" Value="Debit Card"></asp:ListItem>
            <asp:ListItem Text="UPI" Value="UPI"></asp:ListItem>
        </asp:RadioButtonList>

        <!-- Card Details -->
        <asp:Panel ID="pnlCard" runat="server" Visible="false">
            <label>Card Number</label>
            <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control" placeholder="XXXX-XXXX-XXXX-XXXX"></asp:TextBox>

            <label>Expiry Date (MM/YY)</label>
            <asp:TextBox ID="txtExpiry" runat="server" CssClass="form-control"></asp:TextBox>

            <label>CVV</label>
            <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
        </asp:Panel>

        <!-- UPI Details -->
        <asp:Panel ID="pnlUPI" runat="server" Visible="false">
            <label>UPI ID</label>
            <asp:TextBox ID="txtUPI" runat="server" CssClass="form-control" placeholder="example@upi"></asp:TextBox>
        </asp:Panel>

        <asp:Button ID="btnPay" runat="server" Text="Pay Now" CssClass="btn" OnClick="btnPay_Click" />
        <asp:Label ID="lblMessage" runat="server" CssClass="success"></asp:Label>

        <br />
        <asp:HyperLink ID="hlHistory" runat="server" NavigateUrl="~/PayHistory.aspx" CssClass="btn" 
            Text="View Payment History" />
    </div>
</asp:Content>
