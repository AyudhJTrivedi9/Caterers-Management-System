<%@ Page Title="Add Order" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true" CodeBehind="SelectMenu.aspx.cs"
    Inherits="WebApplicationFailDataDemo.WebForm10" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .menu-card {
            width: 320px;
            background: #ffffff;
            border-radius: 12px;
            padding: 15px;
            margin: 10px;
            box-shadow: 0 0 10px #cfcfcf;
            display: inline-block;
            vertical-align: top;
        }
        .menu-img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 12px;
        }
        .btn-select {
            width: 100%;
            margin-top: 10px;
            padding: 10px;
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2 class="text-primary text-center mt-4">Select Dish for Payment</h2>

    <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
        <ItemTemplate>
            <div class="menu-card">

                <!-- FIXED IMAGE PATH -->
                <img class="menu-img" src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' alt="Food Image" />

                <h4 class="mt-2 text-dark"><%# Eval("Title") %></h4>
                <p><b>Price: ₹</b> <%# Eval("Price") %></p>

                <!-- Hidden field for Item ID -->
                <asp:HiddenField ID="hfItemId" runat="server" Value='<%# Eval("Id") %>' />

                <asp:Button ID="btnAdd" runat="server" Text="Add Order"
                    CssClass="btn btn-success btn-select"
                    CommandName="SelectDish"
                    CommandArgument='<%# Eval("Id") + "|" + Eval("Price") %>' />
            </div>
        </ItemTemplate>
    </asp:Repeater>

    <asp:Label ID="lblMsg" runat="server" CssClass="mt-3 fw-bold"></asp:Label>

</asp:Content>  