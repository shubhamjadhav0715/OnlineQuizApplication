<%@ Page Title="Take Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Quiz.aspx.cs" Inherits="User_Quiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="quiz-container">
        <div class="text-center mb-4">
            <h2><i class="fas fa-clipboard-list"></i> Online Quiz</h2>
            <p class="lead">Answer all questions and click Submit to see your results</p>
        </div>

        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert" role="alert">
            <asp:Literal ID="litMessage" runat="server"></asp:Literal>
        </asp:Panel>

        <asp:Panel ID="pnlQuiz" runat="server">
            <div class="alert alert-info">
                <i class="fas fa-info-circle"></i> 
                <strong>Instructions:</strong> Select one answer for each question. All questions are mandatory.
            </div>

            <asp:Repeater ID="rptQuestions" runat="server">
                <ItemTemplate>
                    <div class="question-card">
                        <div class="question-number">
                            Question <%# Container.ItemIndex + 1 %> of <%# ((System.Data.DataTable)((System.Web.UI.WebControls.Repeater)Container.Parent).DataSource).Rows.Count %>
                        </div>
                        <div class="question-text">
                            <%# Eval("QuestionText") %>
                        </div>
                        <div class="options">
                            <asp:HiddenField ID="hfQuestionID" runat="server" Value='<%# Eval("QuestionID") %>' />
                            
                            <label class="option-label">
                                <asp:RadioButton ID="rbOptionA" runat="server" GroupName='<%# "Q" + Eval("QuestionID") %>' />
                                <strong>A.</strong> <%# Eval("OptionA") %>
                            </label>
                            
                            <label class="option-label">
                                <asp:RadioButton ID="rbOptionB" runat="server" GroupName='<%# "Q" + Eval("QuestionID") %>' />
                                <strong>B.</strong> <%# Eval("OptionB") %>
                            </label>
                            
                            <label class="option-label">
                                <asp:RadioButton ID="rbOptionC" runat="server" GroupName='<%# "Q" + Eval("QuestionID") %>' />
                                <strong>C.</strong> <%# Eval("OptionC") %>
                            </label>
                            
                            <label class="option-label">
                                <asp:RadioButton ID="rbOptionD" runat="server" GroupName='<%# "Q" + Eval("QuestionID") %>' />
                                <strong>D.</strong> <%# Eval("OptionD") %>
                            </label>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <div class="text-center mt-4">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit Quiz" CssClass="btn btn-success btn-lg" 
                    OnClick="btnSubmit_Click" OnClientClick="return confirm('Are you sure you want to submit the quiz?');" />
                <a href="../Default.aspx" class="btn btn-secondary btn-lg ml-2">Cancel</a>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlNoQuestions" runat="server" Visible="false">
            <div class="alert alert-warning text-center">
                <i class="fas fa-exclamation-triangle fa-3x mb-3"></i>
                <h4>No Questions Available</h4>
                <p>There are currently no questions in the database. Please contact the administrator.</p>
                <a href="../Default.aspx" class="btn btn-primary">Go to Home</a>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
