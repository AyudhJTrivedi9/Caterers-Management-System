<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="TotalContact.aspx.cs" Inherits="WebApplicationFailDataDemo.WebForm15" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
        }

        /* Center container */
        .container {
            max-width: 90%;
            width: 1000px;
            margin: 50px auto;
            padding: 25px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #222;
            font-size: 28px;
        }

        /* GridView styling */
        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
            border-radius: 10px;
            overflow: hidden;
        }

        .gridview th {
            background-color: #007bff;
            color: #fff;
            padding: 12px 10px;
            text-align: center;
            font-weight: 600;
        }

        .gridview td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #e0e0e0;
        }

        .gridview tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .gridview tr:hover {
            background-color: #eef6ff;
            transition: background 0.2s ease-in-out;
        }

        /* Delete button styling */
        .delete-button, .gridview input[type="submit"] {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 6px 14px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }

        .delete-button:hover, .gridview input[type="submit"]:hover {
            background-color: #a71d2a;
        }

        /* Status message */
        .message {
            text-align: center;
            font-weight: bold;
            margin-top: 20px;
            font-size: 16px;
        }

        /* Responsive behavior */
        @media (max-width: 768px) {
            .container {
                width: 95%;
                padding: 15px;
            }
            .gridview th, .gridview td {
                font-size: 14px;
                padding: 8px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>📩 Contact Messages</h2>

        <asp:GridView ID="gvMessages" runat="server" AutoGenerateColumns="False" 
            CssClass="gridview" DataKeyNames="Id" OnRowDeleting="gvMessages_RowDeleting">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="ID" ReadOnly="True" />
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Subject" HeaderText="Subject" />
                <asp:BoundField DataField="Message" HeaderText="Message" />
                <asp:BoundField DataField="DateSent" HeaderText="Date Sent" 
                    DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                <asp:CommandField ShowDeleteButton="True" DeleteText="Delete" ButtonType="Button" />
            </Columns>
        </asp:GridView>

        <asp:Label ID="lblStatus" runat="server" CssClass="message"></asp:Label>
    </div>
</asp:Content>
