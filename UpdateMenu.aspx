<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UpdateMenu.aspx.cs" Inherits="WebApplicationFailDataDemo.WebForm13" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #f5f6fa;
            font-family: 'Segoe UI', sans-serif;
        }

        .update-card {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            max-width: 600px;
            margin: 50px auto;
        }

        .update-card h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        label {
            font-weight: 600;
            margin-top: 10px;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 8px;
            margin-top: 4px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        input[type="file"] {
            margin-top: 8px;
        }

        .btn-update {
            margin-top: 15px;
            width: 100%;
            padding: 10px;
            background-color:  #007bff;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-update:hover {
            background-color: #218838;
        }

        .message {
            text-align: center;
            margin-top: 15px;
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="update-card">
        <h2>Update Menu Item</h2>

        <asp:Label ID="lblSelect" runat="server" Text="Select Item:" AssociatedControlID="ddlMenu"></asp:Label>
        <asp:DropDownList ID="ddlMenu" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlMenu_SelectedIndexChanged"></asp:DropDownList>
        <br /><br />

        <asp:Label ID="lblTitle" runat="server" Text="Item Name:" AssociatedControlID="txtTitle"></asp:Label>
        <asp:TextBox ID="txtTitle" runat="server"></asp:TextBox>
        <br /><br />

        <asp:Label ID="lblDesc" runat="server" Text="Description:" AssociatedControlID="txtDescription"></asp:Label>
        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
        <br /><br />

        <asp:Label ID="lblPrice" runat="server" Text="Price:" AssociatedControlID="txtPrice"></asp:Label>
        <asp:TextBox ID="txtPrice" runat="server"></asp:TextBox>
        <br /><br />

        <asp:Label ID="lblImage" runat="server" Text="Change Image:" AssociatedControlID="FileUpload1"></asp:Label>
        <asp:FileUpload ID="FileUpload1" runat="server" />
        <br /><br />

        <asp:Button ID="btnUpdate" runat="server" CssClass="btn-update" Text="Update Item" OnClick="btnUpdate_Click" />
        <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
    </div>
</asp:Content>

