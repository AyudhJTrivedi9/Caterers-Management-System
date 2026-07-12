<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="Registration.aspx.cs" Inherits="WebApplicationFailDataDemo.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

       <script>
           function toggleAdminKey() {
               var role = document.getElementById('<%= ddlRole.ClientID %>').value;
            var box = document.getElementById('<%= AdminKeyDiv.ClientID %>');
               box.style.display = (role === "Admin") ? "block" : "none";
           }
       </script>

    <style>
        .box {
            width: 450px;
            margin: auto;
            padding: 25px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 10px #aaa;
        }
        label { font-weight: bold; margin-top: 10px; display: block; }
        input, select { width: 100%; padding: 8px; margin-top: 5px; }
        .btn {
            margin-top: 15px; width: 100%; padding: 10px;
            background: #007bff; color: white; border: none; border-radius: 5px;
        }
        .error { color: red; font-weight: bold; }
        .success { color: green; font-weight: bold; }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="box">

        <h2>Register Account</h2>

        <label>First Name*</label>
        <asp:TextBox ID="txtFName" runat="server"></asp:TextBox>

        <label>Last Name</label>
        <asp:TextBox ID="txtLName" runat="server"></asp:TextBox>

        <label>Date of Birth</label>
        <asp:TextBox ID="txtDOB" runat="server" TextMode="Date"></asp:TextBox>

        <label>Mobile No</label>
        <asp:TextBox ID="txtMobile" runat="server"></asp:TextBox>

        <label>Email*</label>
        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>

        <label>Password*</label>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>

        <label>Confirm Password*</label>
        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>

        <label>Gender</label>
        <asp:DropDownList ID="ddlGender" runat="server">
            <asp:ListItem Value="">Select</asp:ListItem>
            <asp:ListItem>Male</asp:ListItem>
            <asp:ListItem>Female</asp:ListItem>
        </asp:DropDownList>

        <label>City</label>
        <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>

        <label>Address</label>
        <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"></asp:TextBox>

        <label>Role*</label>
        <asp:DropDownList ID="ddlRole" runat="server" onchange="toggleAdminKey()">
            <asp:ListItem>Customer</asp:ListItem>
            <asp:ListItem>Admin</asp:ListItem>
        </asp:DropDownList>

        <!-- ADMIN PASS KEY FIELD -->
        <div id="AdminKeyDiv" runat="server" style="display:none;">
            <label>Admin Pass Key*</label>
            <asp:TextBox ID="txtAdminKey" runat="server" TextMode="Password"></asp:TextBox>
        </div>

        <asp:Label ID="lblMsg" runat="server" CssClass="error"></asp:Label>

        <asp:Button ID="btnRegister" runat="server" Text="Register"
            CssClass="btn" OnClick="btnRegister_Click" />

    </div>

</asp:Content>