<%@ Page Title="Rate Us" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Rating.aspx.cs" Inherits="WebApplicationFailDataDemo.WebForm8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #89f7fe, #66a6ff);
            margin: 0;
            padding: 0;
        }

        .rating-container {
            max-width: 450px;
            margin: 80px auto;
            background: linear-gradient(145deg, #ffffff, #f0f0f0);
            border-radius: 20px;
            padding: 35px 30px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.2);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .rating-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 40px rgba(0,0,0,0.25);
        }

        h2 {
            font-size: 30px;
            color: #333;
            margin-bottom: 25px;
        }

        /* Stars */
        .stars {
            display: flex;
            justify-content: center;
            flex-direction: row-reverse;
            font-size: 50px;
            margin-bottom: 15px;
        }

        .stars input {
            display: none;
        }

        .stars label {
            color: #ccc;
            cursor: pointer;
            transition: color 0.2s, transform 0.3s;
            margin: 0 5px;
        }

        .stars input:checked ~ label,
        .stars label:hover,
        .stars label:hover ~ label {
            color: #f5b301;
            transform: scale(1.3) rotate(-5deg);
        }

        /* Emoji display */
        .emoji {
            font-size: 50px;
            margin: 15px 0;
            transition: transform 0.3s;
        }

        textarea {
            width: 100%;
            height: 100px;
            margin-top: 15px;
            padding: 12px;
            font-size: 16px;
            border-radius: 15px;
            border: 1px solid #ccc;
            resize: none;
            box-shadow: inset 0 3px 6px rgba(0,0,0,0.1);
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        textarea:focus {
            border-color: #f5b301;
            box-shadow: 0 0 15px rgba(245,179,1,0.5);
            outline: none;
        }

        .btn-submit {
            margin-top: 20px;
            font-size: 18px;
            padding: 12px 25px;
            background: #f5b301;
            border: none;
            color: white;
            font-weight: bold;
            border-radius: 15px;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
        }

        .btn-submit:hover {
            background: #e0a500;
            transform: scale(1.05);
        }

        #lblMessage {
            margin-top: 20px;
            font-weight: bold;
            font-size: 16px;
            color: #28a745;
            animation: fadeIn 1s;
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(-10px);}
            to {opacity: 1; transform: translateY(0);}
        }

        @media (max-width: 480px) {
            .rating-container {
                margin: 50px 15px;
                padding: 25px;
            }
            .stars label {
                font-size: 40px;
            }
            .emoji {
                font-size: 40px;
            }
        }
    </style>
    <script type="text/javascript">
        function showEmoji(starNumber) {
            var emoji = document.getElementById("emojiDisplay");
            var emojis = ["😡", "😞", "😐", "😊", "😍"];
            emoji.innerHTML = emojis[starNumber - 1];
            emoji.style.transform = "scale(1.3)";
            setTimeout(function () { emoji.style.transform = "scale(1)"; }, 300);
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="rating-container">
        <h2>⭐ Rate Our Service</h2>

        <div class="stars">
            <asp:RadioButton ID="star5" runat="server" GroupName="rating" onclick="showEmoji(5)" />
            <label for="<%= star5.ClientID %>">★</label>

            <asp:RadioButton ID="star4" runat="server" GroupName="rating" onclick="showEmoji(4)" />
            <label for="<%= star4.ClientID %>">★</label>

            <asp:RadioButton ID="star3" runat="server" GroupName="rating" onclick="showEmoji(3)" />
            <label for="<%= star3.ClientID %>">★</label>

            <asp:RadioButton ID="star2" runat="server" GroupName="rating" onclick="showEmoji(2)" />
            <label for="<%= star2.ClientID %>">★</label>

            <asp:RadioButton ID="star1" runat="server" GroupName="rating" onclick="showEmoji(1)" />
            <label for="<%= star1.ClientID %>">★</label>
        </div>

        <div class="emoji" id="emojiDisplay">😐</div>

        <asp:TextBox ID="txtFeedback" runat="server" TextMode="MultiLine" Placeholder="Write your feedback (optional)"></asp:TextBox>

        <asp:Button ID="btnSubmit" runat="server" Text="Submit Rating" CssClass="btn-submit" OnClick="btnSubmit_Click" />
        <asp:Label ID="lblMessage" runat="server"></asp:Label>
    </div>
</asp:Content>
