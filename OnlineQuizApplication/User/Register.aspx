<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="User_Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-container">
        <div class="auth-card">
            <h2><i class="fas fa-user-plus"></i> Create Account</h2>
            
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert" role="alert">
                <asp:Literal ID="litMessage" runat="server"></asp:Literal>
            </asp:Panel>

            <div class="form-group">
                <label for="txtName">
                    <i class="fas fa-user"></i> Full Name
                </label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter your full name" required="required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" 
                    ErrorMessage="Name is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label for="txtEmail">
                    <i class="fas fa-envelope"></i> Email Address
                </label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" 
                    placeholder="Enter your email" required="required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                    ErrorMessage="Email is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" 
                    ErrorMessage="Invalid email format" CssClass="text-danger" Display="Dynamic"
                    ValidationExpression="^\w+([-+.']\w+)*@\w+([-.']\w+)*\.\w+([-.']\w+)*$"></asp:RegularExpressionValidator>
            </div>

            <div class="form-group">
                <label for="txtPassword">
                    <i class="fas fa-lock"></i> Password
                </label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" 
                    placeholder="Enter password" required="required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                    ErrorMessage="Password is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                <small class="form-text text-muted">Password must be at least 6 characters long</small>
            </div>

            <div class="form-group">
                <label for="txtConfirmPassword">
                    <i class="fas fa-lock"></i> Confirm Password
                </label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" 
                    placeholder="Confirm password" required="required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" 
                    ErrorMessage="Confirm password is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" 
                    ControlToCompare="txtPassword" ErrorMessage="Passwords do not match" 
                    CssClass="text-danger" Display="Dynamic"></asp:CompareValidator>
            </div>

            <div class="form-group">
                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary btn-block" 
                    OnClick="btnRegister_Click" />
            </div>

            <div class="text-center">
                <p>Already have an account? <a href="Login.aspx">Login here</a></p>
            </div>
        </div>
    </div>
</asp:Content>
