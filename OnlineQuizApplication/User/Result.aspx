<%@ Page Title="Quiz Result" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="User_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="quiz-container">
        <asp:Panel ID="pnlResult" runat="server">
            <div class="result-container">
                <h2><i class="fas fa-check-circle"></i> Quiz Completed!</h2>
                
                <div class="result-score">
                    <asp:Literal ID="litScore" runat="server"></asp:Literal>/<asp:Literal ID="litTotal" runat="server"></asp:Literal>
                </div>
                
                <div class="result-percentage">
                    <asp:Literal ID="litPercentage" runat="server"></asp:Literal>%
                </div>
                
                <div class="result-message">
                    <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                </div>

                <div class="row mt-4">
                    <div class="col-md-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <i class="fas fa-check-circle text-success fa-3x mb-2"></i>
                                <h4><asp:Literal ID="litCorrect" runat="server"></asp:Literal></h4>
                                <p class="text-muted">Correct Answers</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <i class="fas fa-times-circle text-danger fa-3x mb-2"></i>
                                <h4><asp:Literal ID="litWrong" runat="server"></asp:Literal></h4>
                                <p class="text-muted">Wrong Answers</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <i class="fas fa-percentage text-info fa-3x mb-2"></i>
                                <h4><asp:Literal ID="litAccuracy" runat="server"></asp:Literal>%</h4>
                                <p class="text-muted">Accuracy</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-4">
                    <a href="Quiz.aspx" class="btn btn-primary btn-lg">
                        <i class="fas fa-redo"></i> Take Another Quiz
                    </a>
                    <a href="History.aspx" class="btn btn-info btn-lg ml-2">
                        <i class="fas fa-history"></i> View History
                    </a>
                    <a href="../Default.aspx" class="btn btn-secondary btn-lg ml-2">
                        <i class="fas fa-home"></i> Go to Home
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
