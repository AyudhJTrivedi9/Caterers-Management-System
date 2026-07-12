<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AddToCart.aspx.cs" Inherits="WebApplicationFailDataDemo.WebForm5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #f4f8fb;
            font-family: Arial, sans-serif;
        }

        h2 {
            text-align: center;
            color: #004d66;
            margin-bottom: 25px;
        }

        .img-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 25px;
            padding: 20px;
        }

        .img-card {
            border: 1px solid #ddd;
            border-radius: 15px;
            background-color: #fff;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
            text-align: center;
            width: 250px;
            transition: transform 0.2s, box-shadow 0.2s;
            padding: 15px;
        }

        .img-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }

        .img-card img {
            max-width: 100%;
            height: 150px;
            border-radius: 10px;
        }

        .img-title {
            font-weight: bold;
            margin-top: 10px;
            color: #00334d;
        }

        .img-desc {
            font-size: 13px;
            color: #666;
            margin-top: 5px;
        }

        .img-price {
            font-weight: bold;
            color: #009933;
            margin-top: 8px;
        }

        .dish-status {
            background-color: #e6f7ff;
            color: #005580;
            border-radius: 8px;
            padding: 6px;
            font-size: 13px;
            margin-top: 8px;
        }

        .quantity-input {
            margin-top: 8px;
            width: 60px;
            text-align: center;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 4px;
        }

        .add-button {
            margin-top: 10px;
            background-color: #007acc;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 6px 12px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .add-button:hover {
            background-color: #005f99;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding: 30px;">
        <h2>Available Dishes</h2>

        <div class="img-grid">
            <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>
                    <div class="img-card">
                        <img src='<%# Eval("ImagePath") %>' alt="Dish Image" />
                        <div class="img-title"><%# Eval("Title") %></div>
                        <div class="img-desc"><%# Eval("Description") %></div>
                        <div class="img-price">₹ <%# String.Format("{0:0.00}", Eval("Price")) %></div>

                        <div class="dish-status">
                            Total: <%# Eval("TotalDishLimit") %> |
                            Added: <%# Eval("AddedCount") %> |
                            Remaining: <%# Eval("Remaining") %>
                        </div>

                        <asp:HiddenField ID="hfImageId" runat="server" Value='<%# Eval("Id") %>' />
                        <asp:TextBox ID="txtQuantity" runat="server" Text="1" CssClass="quantity-input" />
                        <br />
                        <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="add-button" OnClick="btnAddToCart_Click" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
