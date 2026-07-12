<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="TotalOrder.aspx.cs" Inherits="WebApplicationFailDataDemo.WebForm7" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .orders-container {
            padding: 30px;
            max-width: 1000px;
            margin: auto;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
        }

        .gridview th {
            background-color: #007bff;
            color: white;
            padding: 8px;
            text-align: left;
        }

        .gridview td {
            padding: 8px;
            border: 1px solid #ddd;
        }

        .gridview tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        img {
            width: 80px;
            height: 80px;
            border-radius: 8px;
        }

        .delete-btn {
            background-color: red;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="orders-container">
        <h2>All Orders</h2>

        <asp:GridView ID="GridViewOrders" runat="server" AutoGenerateColumns="False" CssClass="gridview" DataKeyNames="OrderId" OnRowCommand="GridViewOrders_RowCommand">
            <Columns>
                <asp:BoundField DataField="OrderId" HeaderText="Order ID" />
                <asp:ImageField DataImageUrlField="ImagePath" HeaderText="Product Image">
                    <ControlStyle Width="80px" Height="80px" />
                </asp:ImageField>
                <asp:BoundField DataField="Title" HeaderText="Item Name" />
                <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                <asp:BoundField DataField="Price" HeaderText="Price (Rs.)" DataFormatString="{0:0.00}" />
                <asp:BoundField DataField="TotalPrice" HeaderText="Total (Rs.)" DataFormatString="{0:0.00}" />
                <asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:dd-MMM-yyyy}" />

                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:Button ID="btnDelete" runat="server" CommandName="DeleteOrder" CommandArgument='<%# Eval("OrderId") %>' Text="Delete" CssClass="delete-btn" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>