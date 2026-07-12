<%@ Page Title="Reset Password" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true" CodeBehind="FotgetPassword.aspx.cs" Inherits="WebApplicationFailDataDemo.WebForm14" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            font-family: 'Segoe UI', sans-serif;
        }

        .reset-card {
            max-width: 450px;
            margin: 60px auto;
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            text-align: center;
            transition: transform 0.3s ease;
        }

        .reset-card:hover {
            transform: translateY(-5px);
        }

        h2 {
            color: #007bff;
            margin-bottom: 25px;
            font-size: 28px;
        }

        label {
            font-weight: bold;
            display: block;
            text-align: left;
            margin-top: 15px;
            color: #333;
        }

        input[type="text"], input[type="password"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 8px;
            border: 1px solid #ccc;
            box-sizing: border-box;
            font-size: 16px;
        }

        .btn {
            margin-top: 20px;
            width: 100%;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: transform 0.2s, background 0.3s;
        }

        .btn-sendotp {
            background-color: #f5b301;
            color: #fff;
        }

        .btn-sendotp:hover {
            background-color: #e0a500;
            transform: scale(1.05);
        }

        .btn-reset {
            background-color: #007bff;
            color: #fff;
        }

        .btn-reset:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }

        .message {
            margin-top: 15px;
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="reset-card">
        <h2>Reset Password</h2>

        <asp:RadioButtonList ID="rblRole" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Value="Customer" Selected="True">Customer</asp:ListItem>
            <asp:ListItem Value="Admin">Admin</asp:ListItem>
        </asp:RadioButtonList>

        <label>Email (optional):</label>
        <asp:TextBox ID="txtEmail" runat="server" Placeholder="Enter your email"></asp:TextBox>

        <label>Mobile Number (optional):</label>
        <asp:TextBox ID="txtMobile" runat="server" Placeholder="Enter your mobile number"></asp:TextBox>

        <asp:Button ID="btnSendOTP" runat="server" CssClass="btn btn-sendotp" Text="Send OTP" OnClick="btnSendOTP_Click" />

        <label>Enter OTP:</label>
        <asp:TextBox ID="txtOTP" runat="server" Placeholder="Enter OTP" MaxLength="6"></asp:TextBox>

        <label>New Password:</label>
        <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" Placeholder="Enter new password"></asp:TextBox>

        <label>Confirm Password:</label>
        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" Placeholder="Confirm new password"></asp:TextBox>

        <asp:Button ID="btnResetPassword" runat="server" CssClass="btn btn-reset" Text="Reset Password" OnClick="btnResetPassword_Click" />

        <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
    </div>
</asp:Content>
