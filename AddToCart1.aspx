<%@ Page Title="View Item"
    Language="C#"
    MasterPageFile="~/Site1.Master"
    AutoEventWireup="true"
    CodeBehind="AddToCart1.aspx.cs"
    Inherits="WebApplicationFailDataDemo.ViewItem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #f4f8fb;
            font-family: Arial, sans-serif;
        }
        .item-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
            padding: 30px;
            margin-top: 20px;
        }
        .item-image {
            width: 100%;
            max-width: 300px;
            height: auto;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .item-details {
            text-align: center;
            max-width: 600px;
        }
        .item-title {
            font-size: 28px;
            font-weight: bold;
            color: #00334d;
        }
        .item-description {
            font-size: 16px;
            color: #666;
            margin-top: 10px;
        }
        .item-price {
            font-weight: bold;
            color: #009933;
            margin-top: 10px;
            font-size: 20px;
        }
        .quantity-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 15px;
            border: 2px solid #ddd;
            border-radius: 8px;
            padding: 5px 10px;
            background-color: #fff;
        }
        .quantity-input {
            width: 60px;
            text-align: center;
            padding: 8px;
            font-size: 16px;
            border: none;
            outline: none;
        }
        .decrement, .increment {
            background-color: #f1f1f1;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 6px 12px;
            cursor: pointer;
            font-size: 18px;
        }
        .decrement:hover, .increment:hover {
            background-color: #ddd;
        }
        .add-to-cart-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }
        .add-to-cart-button {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 18px;
            transition: all 0.3s ease;
        }
        .add-to-cart-button:hover {
            background-color: #218838;
        }
        .stock-status {
            font-size: 16px;
            color: blue;
            margin-top: 10px;
            display: block;
        }
        .remaining-status {
            color: #d9534f;
            font-weight: bold;
            font-size: 16px;
            margin-top: 8px;
            display: none;
            background-color: #fff5f5;
            padding: 8px 12px;
            border: 1px solid #f5c6cb;
            border-radius: 6px;
            width: fit-content;
            margin-left: auto;
            margin-right: auto;
            transition: opacity 0.6s ease-in-out;
        }
        .remaining-status.show {
            display: block;
            opacity: 1;
        }
    </style>

    <script type="text/javascript">
        function updateQuantity(btn) {
            var quantityInput = document.getElementById('<%= txtQuantity.ClientID %>');
            var currentValue = parseInt(quantityInput.value);

            if (btn.classList.contains('increment')) {
                quantityInput.value = currentValue + 1;
            } else if (btn.classList.contains('decrement')) {
                if (currentValue > 25) { // ✅ Prevent going below 25
                    quantityInput.value = currentValue - 1;
                } else {
                    alert("Minimum quantity is 25.");
                }
            }
        }

        function showRemainingMessage() {
            var lbl = document.getElementById('<%= lblRemaining.ClientID %>');
            lbl.classList.add('show');
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="item-container">
        <asp:Image ID="imgItem" runat="server" CssClass="item-image" />
        <div class="item-details">
            <asp:Label ID="lblTitle" runat="server" CssClass="item-title"></asp:Label><br />
            <asp:Label ID="lblDescription" runat="server" CssClass="item-description"></asp:Label><br />
            <asp:Label ID="lblPrice" runat="server" CssClass="item-price"></asp:Label><br />
            <asp:Label ID="lblStock" runat="server" CssClass="stock-status"></asp:Label><br />
            <asp:Label ID="lblRemaining" runat="server" CssClass="remaining-status"></asp:Label>
        </div>

        <div class="quantity-container" id="quantityPanel" runat="server">
            <button type="button" class="decrement" onclick="updateQuantity(this)">-</button>
            <asp:TextBox ID="txtQuantity" runat="server" CssClass="quantity-input" Text="25" />
            <button type="button" class="increment" onclick="updateQuantity(this)">+</button>
        </div>

        <div class="add-to-cart-container">
            <asp:Button
                ID="btnAddToCart"
                runat="server"
                Text="Add to Cart"
                CssClass="add-to-cart-button"
                OnClick="btnAddToCart_Click" />
        </div>

        <asp:HiddenField ID="hfSelectedItemId" runat="server" />
    </div>
</asp:Content>
