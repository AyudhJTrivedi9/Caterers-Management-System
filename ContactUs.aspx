<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="WebApplicationFailDataDemo.WebForm9" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Form Container */
        .form-container {
            max-width: 500px;
            background: #ffffff;
            padding: 35px;
            margin: 50px auto;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .form-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }

        /* Form Header */
        .form-container h2 {
            text-align: center;
            color: #007bff;
            font-size: 28px;
            margin-bottom: 25px;
            position: relative;
        }

        .form-container h2::after {
            content: "";
            display: block;
            width: 60px;
            height: 3px;
            background-color: #007bff;
            margin: 8px auto 0;
            border-radius: 2px;
        }

        /* Form Inputs */
        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            font-weight: 600;
            color: #333;
            display: block;
            margin-bottom: 6px;
        }

        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group textarea {
            width: 100%;
            padding: 10px 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            outline: none;
            transition: 0.3s;
        }

        .form-group input[type="text"]:focus,
        .form-group input[type="email"]:focus,
        .form-group textarea:focus {
            border-color: #007bff;
            box-shadow: 0 0 8px rgba(0,123,255,0.2);
        }

        /* Submit Button */
        .btn {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 8px;
            background: linear-gradient(90deg, #007bff, #0056b3);
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn:hover {
            background: linear-gradient(90deg, #0056b3, #003f7f);
        }

        /* Status Message */
        .message {
            text-align: center;
            margin-top: 18px;
            font-weight: bold;
            font-size: 15px;
        }

        /* Responsive */
        @media screen and (max-width: 520px) {
            .form-container {
                width: 90%;
                padding: 25px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h2>📬 Contact Us</h2>

        <div class="form-group">
            <label for="txtName">Name:</label>
            <asp:TextBox ID="txtName" runat="server" Placeholder="Your Name"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="txtEmail">Email:</label>
            <asp:TextBox ID="txtEmail" runat="server" Placeholder="Your Email" TextMode="Email"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="txtSubject">Subject:</label>
            <asp:TextBox ID="txtSubject" runat="server" Placeholder="Subject"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="txtMessage">Message:</label>
            <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="5" Placeholder="Write your message"></asp:TextBox>
        </div>

        <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn" OnClick="btnSubmit_Click" />

        <asp:Label ID="lblStatus" runat="server" CssClass="message"></asp:Label>
    </div>
</asp:Content>
