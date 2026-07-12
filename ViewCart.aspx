<%@ Page Title="View Cart" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true" CodeBehind="ViewCart11.aspx.cs"
    Inherits="WebApplicationFailDataDemo.ViewCart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: Arial;
            background-color: #f4f8fb;
        }
        .cart-container {
            width: 80%;
            margin: 30px auto;
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ccc;
            text-align: center;
        }
        th {
            background-color: #0078D4;
            color: white;
        }
        .total {
            text-align: right;
            font-size: 18px;
            font-weight: bold;
            margin-top: 20px;
        }
        .btn {
            background-color: #28a745;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #218838;
        }
        .empty {
            text-align: center;
            padding: 30px;
            color: #888;
            font-size: 18px;
        }
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cart-container">
        <h2>🛒 Your Shopping Cart</h2>

        <asp:GridView ID="GridViewCart" runat="server" AutoGenerateColumns="false"
            OnRowDeleting="GridViewCart_RowDeleting" CssClass="cart-grid">
            <Columns>
                <asp:BoundField DataField="ItemName" HeaderText="Item Name" />
                <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                <asp:BoundField DataField="Price" HeaderText="Price (₹)" />
                <asp:BoundField DataField="Total" HeaderText="Total (₹)" />
                <asp:CommandField ShowDeleteButton="true" DeleteText="Remove" />
            </Columns>
        </asp:GridView>

        <asp:Label ID="lblTotal" runat="server" CssClass="total" Text=""></asp:Label>
        <br /><br />

        <div style="text-align:center;">
            <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Payment"
                CssClass="btn" OnClick="btnCheckout_Click" />
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="empty"></asp:Label>
    </div>
</asp:Content>
