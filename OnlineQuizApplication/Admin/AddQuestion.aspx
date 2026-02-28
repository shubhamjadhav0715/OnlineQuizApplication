<%@ Page Title="Add Question" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddQuestion.aspx.cs" Inherits="Admin_AddQuestion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <div class="card-header">
            <h3 class="mb-0"><i class="fas fa-plus-circle"></i> Add New Question</h3>
        </div>
        <div class="card-body">
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert" role="alert">
                <asp:Literal ID="litMessage" runat="server"></asp:Literal>
            </asp:Panel>

            <div class="form-group">
                <label for="txtQuestion">
                    <i class="fas fa-question-circle"></i> Question Text *
                </label>
                <asp:TextBox ID="txtQuestion" runat="server" CssClass="form-control" TextMode="MultiLine" 
                    Rows="3" placeholder="Enter the question" required="required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvQuestion" runat="server" ControlToValidate="txtQuestion" 
                    ErrorMessage="Question is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="txtOptionA">
                            <i class="fas fa-check-circle"></i> Option A *
                        </label>
                        <asp:TextBox ID="txtOptionA" runat="server" CssClass="form-control" 
                            placeholder="Enter option A" required="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvOptionA" runat="server" ControlToValidate="txtOptionA" 
                            ErrorMessage="Option A is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="txtOptionB">
                            <i class="fas fa-check-circle"></i> Option B *
                        </label>
                        <asp:TextBox ID="txtOptionB" runat="server" CssClass="form-control" 
                            placeholder="Enter option B" required="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvOptionB" runat="server" ControlToValidate="txtOptionB" 
                            ErrorMessage="Option B is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="txtOptionC">
                            <i class="fas fa-check-circle"></i> Option C *
                        </label>
                        <asp:TextBox ID="txtOptionC" runat="server" CssClass="form-control" 
                            placeholder="Enter option C" required="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvOptionC" runat="server" ControlToValidate="txtOptionC" 
                            ErrorMessage="Option C is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="txtOptionD">
                            <i class="fas fa-check-circle"></i> Option D *
                        </label>
                        <asp:TextBox ID="txtOptionD" runat="server" CssClass="form-control" 
                            placeholder="Enter option D" required="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvOptionD" runat="server" ControlToValidate="txtOptionD" 
                            ErrorMessage="Option D is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="ddlCorrectOption">
                    <i class="fas fa-star"></i> Correct Answer *
                </label>
                <asp:DropDownList ID="ddlCorrectOption" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">-- Select Correct Answer --</asp:ListItem>
                    <asp:ListItem Value="A">Option A</asp:ListItem>
                    <asp:ListItem Value="B">Option B</asp:ListItem>
                    <asp:ListItem Value="C">Option C</asp:ListItem>
                    <asp:ListItem Value="D">Option D</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCorrectOption" runat="server" ControlToValidate="ddlCorrectOption" 
                    ErrorMessage="Please select the correct answer" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <asp:Button ID="btnAdd" runat="server" Text="Add Question" CssClass="btn btn-primary" 
                    OnClick="btnAdd_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear Form" CssClass="btn btn-secondary ml-2" 
                    OnClick="btnClear_Click" CausesValidation="false" />
                <a href="Dashboard.aspx" class="btn btn-outline-secondary ml-2">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        </div>
    </div>
</asp:Content>
