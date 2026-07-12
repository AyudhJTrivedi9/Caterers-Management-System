<%@ Page Title="Edit User" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" 
    CodeBehind="EditUser.aspx.cs" Inherits="WebApplicationFailDataDemo.EditUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background: linear-gradient(135deg, #f8d7da, #fff3cd);
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            background-color: #ffffff;
            width: 70%;
            margin: 50px auto;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        h2 {
            text-align: center;
            color: #333;
            font-weight: bold;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
            color: #444;
        }

        input, select, textarea {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-top: 5px;
            margin-bottom: 15px;
            font-size: 15px;
            transition: all 0.2s;
        }

        input:focus, textarea:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0,123,255,0.5);
            outline: none;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 6px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            margin: 5px;
        }

        .btn-search {
            background-color: #007bff;
        }

        .btn-update {
            background-color: #28a745;
        }

        .btn-reset {
            background-color: #dc3545;
        }

        .btn:hover {
            opacity: 0.85;
        }

        .message {
            text-align: center;
            font-weight: bold;
            font-size: 16px;
            margin-top: 15px;
        }

        .success {
            color: #28a745;
        }

        .error {
            color: #dc3545;
        }

    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>📝 Edit Customer Profile</h2>

        <label>Email ID (Search):</label>
        <asp:TextBox ID="txtSearchEmail" runat="server" Placeholder="Enter your registered email"></asp:TextBox>
        <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-search" Text="Search" OnClick="btnSearch_Click" />

        <hr />

        <asp:Panel ID="pnlEdit" runat="server" Visible="false">
            <label>First Name:</label>
            <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>

            <label>Last Name:</label>
            <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>

            <label>Date of Birth:</label>
            <asp:TextBox ID="txtDOB" TextMode="Date" runat="server"></asp:TextBox>

            <label>Mobile Number:</label>
            <asp:TextBox ID="txtMobile" runat="server"></asp:TextBox>

            <label>Gender:</label>
            <asp:RadioButtonList ID="rblGender" RepeatDirection="Horizontal" runat="server">
                <asp:ListItem Text="Male" Value="Male" />
                <asp:ListItem Text="Female" Value="Female" />
                <asp:ListItem Text="Other" Value="Other" />
            </asp:RadioButtonList>

            <label>City:</label>
            <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>

            <label>Address:</label>
            <asp:TextBox ID="txtAddress" TextMode="MultiLine" Rows="3" runat="server"></asp:TextBox>

            <label>Role:</label>
            <asp:TextBox ID="txtRole" runat="server" ReadOnly="true" />

            <br />
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-update" OnClick="btnUpdate_Click" />
            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-reset" OnClientClick="document.forms[0].reset(); return false;" />

        </asp:Panel>

        <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
    </div>
</asp:Content>