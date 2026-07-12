<%@ Page Title="My Orders" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true" CodeBehind="MyOrders.aspx.cs"
    Inherits="WebApplicationFailDataDemo.MyOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #eef3f9;
            font-family: 'Segoe UI', sans-serif;
        }

        .orders-container {
            padding: 30px;
            max-width: 1000px;
            margin: 40px auto;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #007bff;
            margin-bottom: 20px;
        }

        .add-btn {
            display: inline-block;
            background-color: #28a745;
            color: #fff;
            padding: 10px 18px;
            border-radius: 8px;
            font-weight: bold;
            text-decoration: none;
            transition: 0.3s;
            margin-bottom: 15px;
        }

        .add-btn:hover {
            background-color: #218838;
            text-decoration: none;
            color: white;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.2);
        }

        .top-summary {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: bold;
            font-size: 16px;
            color: #333;
            margin-bottom: 10px;
        }

        .summary-right {
            display: flex;
            gap: 30px;
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .gridview th {
            background-color: #007bff;
            color: white;
            padding: 10px;
            text-align: center;
        }

        .gridview td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .gridview tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        img {
            width: 80px;
            height: 80px;
            border-radius: 8px;
        }

        .empty {
            text-align: center;
            color: #888;
            font-size: 18px;
            margin-top: 30px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="orders-container">
        <h2>📦 My Orders</h2>

        <div class="top-summary">
            <a href="Add.aspx" class="add-btn">➕ Add New Order</a>
            <div class="summary-right">
                <div>Total Orders: <asp:Label ID="lblTotalOrders" runat="server" Text="0"></asp:Label></div>
                <div>Total Amount: ₹<asp:Label ID="lblTotalAmount" runat="server" Text="0.00"></asp:Label></div>
            </div>
        </div>

     <asp:GridView ID="GridViewOrders" runat="server" AutoGenerateColumns="False" CssClass="gridview"
    OnRowCommand="GridViewOrders_RowCommand" DataKeyNames="OrderId">
    <Columns>
        <asp:BoundField DataField="OrderId" HeaderText="Order ID" />
        <asp:ImageField DataImageUrlField="ImagePath" HeaderText="Dish Image">
            <ControlStyle Width="80px" Height="80px" />
        </asp:ImageField>
        <asp:BoundField DataField="Title" HeaderText="Dish Name" />
        <asp:BoundField DataField="Price" HeaderText="Price (₹)" DataFormatString="{0:0.00}" />
        <asp:BoundField DataField="Quantity" HeaderText="Qty" />
        <asp:BoundField DataField="TotalPrice" HeaderText="Total (₹)" DataFormatString="{0:0.00}" />
        <asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:dd-MMM-yyyy}" />
        <asp:ButtonField ButtonType="Button" ControlStyle-BackColor="Red" CommandName="DeleteOrder" Text="❌ Remove" />
    </Columns>
</asp:GridView>


        <asp:Label ID="lblMessage" runat="server" CssClass="empty" Visible="false"></asp:Label>
    </div>
</asp:Content>
