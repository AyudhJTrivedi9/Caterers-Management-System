<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="WebApplicationFailDataDemo.WebForm2" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - Caterers Management System</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body, html {
            height: 100%;
            font-family: 'Segoe UI', sans-serif;
            background-image: url('image/img01.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        /* Dark overlay */
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 0;
        }

        .login-box {
            position: relative;
            z-index: 1;
            background-color: powderblue;
            border-radius: 15px;
            padding: 30px;
            max-width: 405px;
            margin: auto;
            margin-top: 0%;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            transition: transform 0.3s, box-shadow 0.3s;
        }

            .login-box:hover {
                transform: translateY(-5px);
                box-shadow: 0 20px 40px rgba(0,0,0,0.5);
            }

            .login-box h2 {
                text-align: center;
                color: #ff8c00;
                margin-bottom: 25px;
                font-weight: bold;
            }

            .login-box .form-control {
                border-radius: 10px;
                padding: 12px;
            }

            .login-box .btn-primary {
                background-color: #ff8c00;
                border: none;
                font-weight: bold;
                transition: background 0.3s, transform 0.2s;
            }

                .login-box .btn-primary:hover {
                    background-color: #e67600;
                    transform: scale(1.05);
                }

            .login-box h1 {
                text-align: center;
                font-size: 32px;
                font-weight: 800;
                margin-bottom: 15px;
                letter-spacing: 1px;
                /* Gradient Text */
                background: linear-gradient(90deg, #00c6ff, #0072ff, #6a11cb, #2575fc);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                /* Smooth effect */
                text-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
                /* Animation */
                animation: glow 3s ease-in-out infinite;
            }

        /* Glow animation */
        @keyframes glow {
            0% {
                text-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            }

            50% {
                text-shadow: 0 4px 15px rgba(0, 115, 255, 0.6);
            }

            100% {
                text-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            }
        }


        .options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
            font-size: 14px;
        }

        .signup {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

            .signup a {
                color: #ff8c00;
                text-decoration: underline;
            }

        .error-msg {
            color: red;
            font-weight: bold;
            margin-top: 10px;
            text-align: center;
        }

        .role-selection {
            margin-top: 10px;
            display: flex;
            justify-content: center;
            gap: 20px;
        }
    </style>
</head>
<body>
    <div class="overlay"></div>

    <form id="form1" runat="server">
        <div class="login-box">
            <h1 class="system-title">Caterers Management System</h1>
            <h2>Login</h2>

            <!-- Username -->
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control mb-3" Placeholder="Username"></asp:TextBox>

            <!-- Password -->
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control mb-3" Placeholder="Password"></asp:TextBox>

            <!-- Role Selection -->
            <div class="role-selection">
                <asp:RadioButton ID="rbUser" runat="server" GroupName="roleGroup" Text="User" Checked="True" />
                <asp:RadioButton ID="rbAdmin" runat="server" GroupName="roleGroup" Text="Admin" />
            </div>

            <!-- Remember Me & Forgot Password -->
            <div class="options">
                <div>
                    <asp:CheckBox ID="chkRemember" runat="server" />
                    Remember Me
                </div>
                <a href="FotgetPassword.aspx" style="color: #ff8c00;">Forgot Password?</a>
            </div>

            <!-- Login Button -->
            <asp:Button ID="btnLogin" runat="server" Text="Log in" CssClass="btn btn-primary w-100 mt-3" OnClick="btnLogin_Click" />

            <!-- Error Message -->
            <asp:Label ID="lblMessage" runat="server" CssClass="error-msg"></asp:Label>

            <!-- Sign up -->
            <div class="signup">
                Don’t have an account? <a href="Registration.aspx">Register here</a>
            </div>
        </div>
    </form>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
