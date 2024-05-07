<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PSMTaskManagementSystem.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <div class="container h-100">
            <div class="col my-auto w-50">
                <div class="row">
                    <h1>Login</h1>
                </div>
                <div class="row py-3">
                    <div class="col">
                        <asp:Label ID="usernameLabel" runat="server" Text="Matric/Staff No: "></asp:Label>
                    </div>
                    <div class="col">
                        <asp:TextBox ID="usernameText" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="row py-3">
                    <div class="col">
                        <asp:Label ID="pwdLabel" runat="server" Text="Password: "></asp:Label>
                    </div>
                    <div class="col">
                        <asp:TextBox ID="pwd" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                    </div>
                </div>
                <div class="row py-3">
                    <div class="col">
                        User Type: 
                    </div>
                    <div class="col">
                        <asp:DropDownList ID="DropDownType" runat="server" CssClass="form-control" Width="50%">
                            <asp:ListItem Value="Staff">Staff</asp:ListItem>
                            <asp:ListItem Value="Student">Student</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="row py-3">
                    <div class="col">
                        <asp:Button ID="LoginBtn" CssClass="btn bg-light-subtle w-25" runat="server" OnClick="LoginBtn_Click" Text="Login" />
                    </div>
                    <div class="col">
                        <asp:Label ID="LabelStatus" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="row">
                   <asp:Label ID="Label1" runat="server" Text=" Not signed up yet?"></asp:Label><asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Register Here</asp:LinkButton>
                </div>
            </div> 
        </div>
        
</asp:Content>
