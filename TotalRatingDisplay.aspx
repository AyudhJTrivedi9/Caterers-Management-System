<%@ Page Title="User Ratings" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" 
    CodeBehind="TotalRatingDisplay.aspx.cs" Inherits="WebApplicationFailDataDemo.WebForm12" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f8;
        }

        .container {
            max-width: 1100px;
            margin: 50px auto;
            background: #fff;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.1);
            animation: fadeIn 0.6s ease-out;
        }

        h2 {
            text-align: center;
            color: #222;
            margin-bottom: 25px;
            font-size: 28px;
        }

        /* GridView styling */
        .gridview {
            width: 100%;
            border-collapse: collapse;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .gridview th {
            background-color: #007bff;
            color: #fff;
            text-align: center;
            padding: 12px;
            font-weight: 600;
            font-size: 15px;
        }

        .gridview td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            font-size: 14px;
        }

        .gridview tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .gridview tr:hover {
            background-color: #eef5ff;
            transition: 0.25s;
        }

        /* Red delete button */
        .delete-button, .gridview input[type="submit"] {
            background-color: #dc3545;
            color: #fff;
            border: none;
            padding: 6px 14px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            box-shadow: 0 2px 6px rgba(220, 53, 69, 0.3);
            transition: all 0.2s ease-in-out;
        }

        .delete-button:hover, .gridview input[type="submit"]:hover {
            background-color: #b02a37;
            transform: scale(1.05);
            box-shadow: 0 4px 10px rgba(220, 53, 69, 0.4);
        }

        /* Fade animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                width: 95%;
                padding: 15px;
            }

            .gridview th, .gridview td {
                font-size: 13px;
                padding: 8px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>⭐ User Ratings</h2>

        <asp:GridView ID="gvRatings" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="RatingID" OnRowDeleting="gvRatings_RowDeleting"
            CssClass="gridview">

            <Columns>
                <asp:BoundField DataField="RatingID" HeaderText="ID" ReadOnly="True" />
                <asp:BoundField DataField="RatingValue" HeaderText="Rating" />
                <asp:BoundField DataField="Feedback" HeaderText="Feedback" />
                <asp:BoundField DataField="CreatedAt" HeaderText="Date Created" 
                                DataFormatString="{0:yyyy-MM-dd HH:mm}" />

                <%-- Red Delete Button --%>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:Button ID="btnDelete" runat="server" Text="🗑 Delete" 
                            CommandName="Delete" CssClass="delete-button" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
