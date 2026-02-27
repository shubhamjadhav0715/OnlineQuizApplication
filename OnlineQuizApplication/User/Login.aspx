<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="User_Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-container">
        <div class="auth-card">
            <h2><i class="fas fa-sign-in-alt"></i> Login</h2>
            
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert" role="alert">
                <asp:Literal ID="litMessage" runat="server"></asp:Literal>
            </asp:Panel>

            <div class="form-group">
                <label for="txtEmail">
                    <i class="fas fa-envelope"></i> Email Address
                </label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" 
                    placeholder="Enter your email" required="required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                    ErrorMessage="Email is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label for="txtPassword">
                    <i class="fas fa-lock"></i> Password
                </label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" 
                    placeholder="Enter password" required="required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                    ErrorMessage="Password is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary btn-block" 
                    OnClick="btnLogin_Click" />
            </div>

            <div class="text-center">
                <p>Don't have an account? <a href="Register.aspx">Register here</a></p>
            </div>

            <hr />

            <div class="text-center">
                <h5>Demo Credentials</h5>
                <div class="row">
                    <div class="col-md-6">
                        <div class="card bg-light mb-2">
                            <div class="card-body p-2">
                                <h6 class="card-title mb-1">Admin</h6>
                                <small>
                                    <strong>Email:</strong> admin@quiz.com<br />
                                    <strong>Password:</strong> admin123
                                </small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card bg-light mb-2">
                            <div class="card-body p-2">
                                <h6 class="card-title mb-1">User</h6>
                                <small>
                                    <strong>Email:</strong> john@example.com<br />
                                    <strong>Password:</strong> user123
                                </small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
