<%@ Page Title="Order Booking"
    Language="C#"
    MasterPageFile="~/Site1.Master"
    AutoEventWireup="true"
    CodeBehind="OrderBook.aspx.cs"
    Inherits="WebApplicationFailDataDemo.OrderBook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5">

        <div class="order-card p-4 shadow">

            <h2 class="text-center text-primary mb-3">Order Booking Form</h2>

            <div class="row g-3">

                <div class="col-md-6">
                    <label class="form-label">User Name</label>
                    <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control"
                        placeholder="Enter user name"></asp:TextBox>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                        placeholder="Enter email"></asp:TextBox>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Order Date</label>
                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control"
                        placeholder="DD-MM-YYYY"></asp:TextBox>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Order Time</label>
                    <asp:TextBox ID="txtTime" runat="server" CssClass="form-control"
                        placeholder="HH:MM AM/PM"></asp:TextBox>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Enter Dish Quantity</label>
                    <asp:TextBox ID="txtQty" runat="server" CssClass="form-control"
                        AutoPostBack="true" OnTextChanged="txtQty_TextChanged"
                        placeholder="Enter quantity"></asp:TextBox>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Discount (%)</label>
                    <asp:TextBox ID="txtDiscount" runat="server" CssClass="form-control bg-light fw-bold"
                        ReadOnly="true"></asp:TextBox>
                </div>

                <div class="col-md-12 text-center mt-3">
                    <asp:Button ID="btnConfirm" runat="server"
                        Text="Save Order"
                        CssClass="btn btn-success px-4 py-2"
                        OnClick="btnConfirm_Click" />
                </div>

                <div class="col-md-12 text-center">
                    <asp:Label ID="lblMsg" runat="server" CssClass="fw-bold mt-2"></asp:Label>
                </div>

            </div>

        </div>

    </div>

</asp:Content>
