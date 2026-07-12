<%@ Page Title="Total Users" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true" CodeBehind="TotalUser.aspx.cs"
    Inherits="WebApplicationFailDataDemo.WebFormTotalUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Segoe UI', sans-serif;
        }

        .container {
            max-width: 1100px;
            margin: 50px auto;
            background: #fff;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .top-bar {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 10px;
        }

        .add-button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 16px;
            border-radius: 6px;
            cursor: pointer;
        }

        .add-button:hover {
            background-color: #0056b3;
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
        }

        .gridview th {
            background-color: #007bff;
            color: #fff;
            padding: 10px;
            text-align: center;
        }

        .gridview td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        .gridview tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .delete-button {
            background-color: #dc3545;
            color: #fff;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
        }

        .delete-button:hover {
            background-color: #a71d2a;
        }

        .edit-button {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            margin-right: 5px;
        }

        .edit-button:hover {
            background-color: #218838;
        }

        .message {
            text-align: center;
            font-weight: bold;
            margin-top: 15px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>Total Registered Users</h2>

        <div class="top-bar">
            <asp:Button ID="btnAddUser" runat="server" Text="Add New User" CssClass="add-button"
                OnClick="btnAddUser_Click" />
        </div>

        <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="gridview"
            DataKeyNames="Id" OnRowDeleting="gvUsers_RowDeleting" OnRowEditing="gvUsers_RowEditing">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="ID" ReadOnly="True" />
                <asp:BoundField DataField="F_Name" HeaderText="First Name" />
                <asp:BoundField DataField="L_Name" HeaderText="Last Name" />
                <asp:BoundField DataField="E_id" HeaderText="Email ID" />
                <asp:BoundField DataField="Mobile_No" HeaderText="Mobile No" />
                <asp:BoundField DataField="Gender" HeaderText="Gender" />
                <asp:BoundField DataField="City" HeaderText="City" />
                <asp:BoundField DataField="Roll" HeaderText="Role" />

                <%-- Edit and Delete buttons --%>
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" CssClass="edit-button" />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" CssClass="delete-button" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <asp:Label ID="lblStatus" runat="server" CssClass="message"></asp:Label>
    </div>
</asp:Content>
