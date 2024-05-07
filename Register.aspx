<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="PSMTaskManagementSystem.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <h1>Register</h1>
        </div>
        <div class="row py-3">
            <div class="col">
                Name:
            </div>
            <div class="col">
                <asp:TextBox ID="TxtName" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="row py-3">
            <div class="col">
                Matric Number:
            </div>
            <div class="col">
                <asp:TextBox ID="TxtMatric" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="row py-3">
            <div class="col">
                Password:
            </div>
            <div class="col">
                <asp:TextBox ID="TxtPwd" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
            </div>
        </div>
        <div class="row py-3">
            <div class="col">
                Re-type Password:
            </div>
            <div class="col">
                <asp:TextBox ID="TxtPwd2" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
            </div>
        </div>
        <div class="row py-3">
            <div class="col">
                Programme:
            </div>
            <div class="col">
                <asp:RadioButtonList ID="programmeList" runat="server" DataSourceID="progamme" DataTextField="programme_code" DataValueField="programme_id">
                </asp:RadioButtonList>
                <asp:SqlDataSource ID="progamme" runat="server" ConnectionString="<%$ ConnectionStrings:psmtmsConnectionString %>" SelectCommand="SELECT [programme_id], [programme_code] FROM [programme]"></asp:SqlDataSource>
            </div>
        </div>
        <div class="row py-3">
            <div class="col">
                <asp:Button ID="BtnSubmit" CssClass="btn bg-light-subtle w-25" runat="server" Text="Register" OnClick="BtnSubmit_Click" />
            </div>
            <div class="col">
                <asp:Label ID="LblStatus" runat="server" Text=""></asp:Label>
            </div>
        </div>
        <div class="row">
           <asp:Label ID="Label1" runat="server" Text="Already Registered?"></asp:Label><asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Login Here</asp:LinkButton>
        </div>
    </div>
</asp:Content>
