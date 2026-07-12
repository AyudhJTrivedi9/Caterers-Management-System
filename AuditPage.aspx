<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AuditPage.aspx.cs" Inherits="WebApplicationFailDataDemo.WebForm5" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Page Container */
        .log-container {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            padding: 30px;
            max-width: 1000px;
            margin: 20px auto;
            transition: all 0.3s ease;
        }

        .log-container:hover {
            transform: scale(1.01);
            box-shadow: 0 6px 25px rgba(0,0,0,0.15);
        }

        .log-header {
            text-align: center;
            font-size: 26px;
            color: darkslateblue;
            margin-bottom: 25px;
            font-weight: bold;
        }

        /* GridView styling */
        .gridview {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
            font-family: 'Segoe UI', sans-serif;
        }

        .gridview th {
            background-color: darkorange;
            color: white;
            padding: 10px;
            font-size: 17px;
            border-bottom: 2px solid #ddd;
        }

        .gridview td {
            padding: 10px;
            border-bottom: 1px solid #f2f2f2;
        }

        .gridview tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .gridview tr:hover {
            background-color: #ffe9c6;
        }

        /* Buttons */
        .btn {
            background-color: darkslateblue;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 8px;
            font-weight: bold;
            margin: 10px 8px;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn:hover {
            background-color: #f5b301;
            color: black;
        }

        .btn-refresh {
            background-color: seagreen;
        }

        .btn-refresh:hover {
            background-color: mediumseagreen;
        }

        .log-footer {
            text-align: center;
            margin-top: 20px;
        }
    </style>

    <div class="log-container">
        <div class="log-header">
            🕒 User Login & Logout History
        </div>

        <asp:GridView ID="gvUserLogs" runat="server" CssClass="gridview" AutoGenerateColumns="False" GridLines="None">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Log ID" />
                <asp:BoundField DataField="UserId" HeaderText="User ID" />
                <asp:BoundField DataField="UserName" HeaderText="User Name" />
                <asp:BoundField DataField="Role" HeaderText="Role" />
                <asp:BoundField DataField="LoginTime" HeaderText="Login Time" DataFormatString="{0:dd-MM-yyyy hh:mm tt}" />
                <asp:BoundField DataField="LogoutTime" HeaderText="Logout Time" DataFormatString="{0:dd-MM-yyyy hh:mm tt}" />
            </Columns>
        </asp:GridView>

        <div class="log-footer">
            <asp:Button ID="btnRefresh" runat="server" Text="🔄 Refresh" CssClass="btn btn-refresh" OnClick="btnRefresh_Click" />
            <a href="AdminDeshboard.aspx" class="btn">⬅ Back to Dashboard</a>
        </div>
    </div>
</asp:Content>

