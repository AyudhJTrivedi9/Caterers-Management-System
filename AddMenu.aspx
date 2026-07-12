<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AddMenu.aspx.cs" Inherits="WebApplicationFailDataDemo.WebForm6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Upload Image with Price</title>
    <style>
        body {
            background-color: #f5f6fa;
            font-family: 'Segoe UI', sans-serif;
        }

        .upload-card {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            max-width: 550px;
            margin: 50px auto;
        }

        .upload-card h2 {
            color: #333;
            text-align: center;
            margin-bottom: 25px;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }

        label {
            font-weight: 600;
            color: #444;
        }

        input[type="text"], textarea {
            border: 1px solid #ccc;
            border-radius: 6px;
            padding: 8px;
            width: 100%;
            margin-top: 4px;
        }

        input[type="file"] {
            margin-top: 8px;
        }

        .btn-upload {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.3s;
            width: 100%;
        }

        .btn-upload:hover {
            background-color: #0056b3;
        }

        .message {
            margin-top: 15px;
            font-weight: 600;
            text-align: center;
        }

        /* Table styling */
        .preview-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        .preview-table th, .preview-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        .preview-table th {
            background-color: #007bff;
            color: white;
        }

        .preview-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .preview-table img {
            width: 60px;
            height: 60px;
            border-radius: 6px;
            object-fit: cover;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="upload-card">
        <h2>Upload Item</h2>

        <asp:Label ID="lblTitle" runat="server" Text="Item Name:" AssociatedControlID="txtTitle"></asp:Label><br />
        <asp:TextBox ID="txtTitle" runat="server"></asp:TextBox>
        <br /><br />

        <asp:Label ID="lblDesc" runat="server" Text="Description:" AssociatedControlID="txtDescription"></asp:Label><br />
        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
        <br /><br />

        <asp:Label ID="lblPrice" runat="server" Text="Price (Rs.):" AssociatedControlID="txtPrice"></asp:Label><br />
        <asp:TextBox ID="txtPrice" runat="server"></asp:TextBox>
        <br /><br />

        <asp:Label ID="lblImage" runat="server" Text="Select Image:" AssociatedControlID="FileUpload1"></asp:Label><br />
        <asp:FileUpload ID="FileUpload1" runat="server" />
        <br /><br />

        <asp:Button ID="btnUpload" runat="server" CssClass="btn-upload" Text="Upload Item" OnClick="btnUpload_Click" />
        <br />

        <asp:Label ID="lblMessage" runat="server" CssClass="message" ForeColor="Green"></asp:Label>
    </div>

    

</asp:Content>

