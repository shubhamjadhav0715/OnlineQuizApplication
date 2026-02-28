<%@ Page Title="Quiz Result" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Result.aspx.cs" Inherits="User_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <asp:Panel ID="pnlResult" runat="server">
            <div class="result-container">
                <h2 class="mb-4"><i class="fas fa-trophy"></i> Congratulations!</h2>
                
                <!-- Large Score Display -->
                <div class="result-score mb-3">
                    <asp:Literal ID="litScore" runat="server"></asp:Literal>/<asp:Literal ID="litTotal" runat="server"></asp:Literal>
                </div>
                
                <!-- Grade Badge -->
                <div class="mb-3">
                    <span class="badge badge-primary" style="font-size: 2rem; padding: 1rem 2rem;">
                        Grade: <asp:Literal ID="litGrade" runat="server"></asp:Literal>
                    </span>
                </div>
                
                <!-- Percentage -->
                <div class="result-grade mb-4">
                    <asp:Literal ID="litPercentage" runat="server"></asp:Literal>%
                </div>
                
                <!-- Message -->
                <div class="result-message mb-4">
                    <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                </div>

                <!-- Statistics Cards -->
                <div class="row mt-4 mb-4">
                    <div class="col-md-3">
                        <div class="card text-center shadow">
                            <div class="card-body">
                                <i class="fas fa-check-circle text-success fa-3x mb-2"></i>
                                <h3 class="mb-0"><asp:Literal ID="litCorrect" runat="server"></asp:Literal></h3>
                                <p class="text-muted mb-0">Correct Answers</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center shadow">
                            <div class="card-body">
                                <i class="fas fa-times-circle text-danger fa-3x mb-2"></i>
                                <h3 class="mb-0"><asp:Literal ID="litWrong" runat="server"></asp:Literal></h3>
                                <p class="text-muted mb-0">Wrong Answers</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center shadow">
                            <div class="card-body">
                                <i class="fas fa-clock text-info fa-3x mb-2"></i>
                                <h3 class="mb-0"><asp:Literal ID="litTimeTaken" runat="server">12:34</asp:Literal></h3>
                                <p class="text-muted mb-0">Time Taken</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center shadow">
                            <div class="card-body">
                                <i class="fas fa-percentage text-warning fa-3x mb-2"></i>
                                <h3 class="mb-0"><asp:Literal ID="litAccuracy" runat="server"></asp:Literal>%</h3>
                                <p class="text-muted mb-0">Percentage</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Detailed Answer Review -->
                <div class="card shadow-lg mt-4">
                    <div class="card-header">
                        <h4 class="mb-0"><i class="fas fa-list-check"></i> Detailed Answer Review</h4>
                    </div>
                    <div class="card-body">
                        <asp:Repeater ID="rptAnswers" runat="server">
                            <ItemTemplate>
                                <div class="question-review mb-3 p-3 <%# (bool)Eval("IsCorrect") ? "border-success" : "border-danger" %>" style="border-left: 4px solid; border-radius: 8px; background: #f8f9fa;">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div style="flex: 1;">
                                            <h6 class="mb-2">
                                                <strong>Q<%# Container.ItemIndex + 1 %>:</strong> <%# Eval("QuestionText") %>
                                            </h6>
                                            <p class="mb-1">
                                                <strong>Your Answer:</strong> 
                                                <span class="<%# (bool)Eval("IsCorrect") ? "text-success" : "text-danger" %>">
                                                    <%# Eval("SelectedOption") %>
                                                </span>
                                            </p>
                                            <%# !(bool)Eval("IsCorrect") ? "<p class='mb-0'><strong>Correct Answer:</strong> <span class='text-success'>" + Eval("CorrectOption") + "</span></p>" : "" %>
                                        </div>
                                        <div>
                                            <%# (bool)Eval("IsCorrect") ? 
                                                "<i class='fas fa-check-circle text-success fa-2x'></i>" : 
                                                "<i class='fas fa-times-circle text-danger fa-2x'></i>" %>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="mt-4 text-center">
                    <a href="Quiz.aspx" class="btn btn-primary btn-lg">
                        <i class="fas fa-redo"></i> Take Another Quiz
                    </a>
                    <a href="History.aspx" class="btn btn-info btn-lg ml-2">
                        <i class="fas fa-history"></i> View History
                    </a>
                    <a href="Dashboard.aspx" class="btn btn-secondary btn-lg ml-2">
                        <i class="fas fa-home"></i> Dashboard
                    </a>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlError" runat="server" Visible="false">
            <div class="alert alert-danger text-center">
                <i class="fas fa-exclamation-triangle fa-3x mb-3"></i>
                <h4>Invalid Request</h4>
                <p>No quiz result found. Please take a quiz first.</p>
                <a href="Quiz.aspx" class="btn btn-primary">Take Quiz</a>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
