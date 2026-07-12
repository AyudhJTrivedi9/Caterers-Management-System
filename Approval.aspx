<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Approval.aspx.cs"
    Inherits="WebApplicationFailDataDemo.Approval"
    MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <!-- BOOTSTRAP 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            background: linear-gradient(135deg, #eef2f3, #8e9eab);
            font-family: 'Segoe UI', sans-serif;
        }
        .page-title {
            font-size: 28px;
            font-weight: 600;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .table th {
            background-color: #343a40 !important;
            color: white !important;
        }
        .btn-approve {
            background-color: #28a745;
            color: white;
            border-radius: 8px;
        }
        .btn-approve:hover {
            background-color: #1e7e34;
        }
        .btn-reject {
            background-color: #dc3545;
            color: white;
            border-radius: 8px;
        }
        .btn-reject:hover {
            background-color: #a71d2a;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5">

        <div class="text-center mb-4">
            <h2 class="page-title">Admin – User Approval Panel</h2>
            <p class="text-muted">Approve or Reject new user registration requests.</p>
        </div>

        <div class="card p-4">

            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False"
                CssClass="table table-bordered table-hover text-center"
                OnRowCommand="gvUsers_RowCommand">

                <Columns>

                    <asp:BoundField DataField="Email" HeaderText="Email" />

                    <asp:BoundField DataField="RequestDate"
                                    HeaderText="Requested On"
                                    DataFormatString="{0:dd MMM yyyy}" />

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>

                            <asp:Button ID="btnApprove" runat="server"
                                Text="Approve"
                                CssClass="btn btn-approve btn-sm me-2"
                                CommandName="Approve"
                                CommandArgument='<%# Eval("Email") %>' />

                            <asp:Button ID="btnReject" runat="server"
                                Text="Reject"
                                CssClass="btn btn-reject btn-sm"
                                CommandName="Reject"
                                CommandArgument='<%# Eval("Email") %>' />

                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

            </asp:GridView>

            <div class="text-center mt-3">
                <asp:Label ID="lblMsg" runat="server" CssClass="fw-bold"></asp:Label>
            </div>

        </div>

    </div>

</asp:Content>
