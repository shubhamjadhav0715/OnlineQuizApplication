<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Admin_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="mb-4">
        <h2><i class="fas fa-tachometer-alt"></i> Admin Dashboard</h2>
        <p class="lead">Welcome, <asp:Literal ID="litAdminName" runat="server"></asp:Literal>!</p>
    </div>

    <!-- Statistics Cards -->
    <div class="row">
        <div class="col-md-3">
            <div class="dashboard-card stat-card-primary text-center">
                <i class="fas fa-question-circle icon"></i>
                <h3><asp:Literal ID="litTotalQuestions" runat="server"></asp:Literal></h3>
                <p>Total Questions</p>
                <a href="AddQuestion.aspx" class="btn btn-light btn-sm mt-2">
                    <i class="fas fa-plus"></i> Add New
                </a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-card stat-card-success text-center">
                <i class="fas fa-users icon"></i>
                <h3><asp:Literal ID="litTotalUsers" runat="server"></asp:Literal></h3>
                <p>Registered Users</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-card stat-card-info text-center">
                <i class="fas fa-clipboard-check icon"></i>
                <h3><asp:Literal ID="litTotalAttempts" runat="server"></asp:Literal></h3>
                <p>Quiz Attempts</p>
                <a href="ViewResults.aspx" class="btn btn-light btn-sm mt-2">
                    <i class="fas fa-eye"></i> View All
                </a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-card stat-card-warning text-center">
                <i class="fas fa-chart-line icon"></i>
                <h3><asp:Literal ID="litAvgScore" runat="server"></asp:Literal>%</h3>
                <p>Average Score</p>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="mb-0"><i class="fas fa-bolt"></i> Quick Actions</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <a href="AddQuestion.aspx" class="btn btn-primary btn-block btn-lg mb-2">
                                <i class="fas fa-plus-circle"></i><br />
                                Add Question
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="ManageQuestions.aspx" class="btn btn-info btn-block btn-lg mb-2">
                                <i class="fas fa-tasks"></i><br />
                                Manage Questions
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="ViewResults.aspx" class="btn btn-success btn-block btn-lg mb-2">
                                <i class="fas fa-chart-bar"></i><br />
                                View Results
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="../Default.aspx" class="btn btn-secondary btn-block btn-lg mb-2">
                                <i class="fas fa-home"></i><br />
                                Go to Home
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Quiz Attempts -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="mb-0"><i class="fas fa-clock"></i> Recent Quiz Attempts</h4>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <asp:GridView ID="gvRecentAttempts" runat="server" CssClass="table table-striped table-hover" 
                            AutoGenerateColumns="False" EmptyDataText="No quiz attempts yet.">
                            <Columns>
                                <asp:BoundField DataField="AttemptID" HeaderText="ID" />
                                <asp:BoundField DataField="UserName" HeaderText="User" />
                                <asp:BoundField DataField="Email" HeaderText="Email" />
                                <asp:BoundField DataField="Score" HeaderText="Score" />
                                <asp:BoundField DataField="TotalQuestions" HeaderText="Total" />
                                <asp:TemplateField HeaderText="Percentage">
                                    <ItemTemplate>
                                        <span class='<%# GetPercentageClass(Eval("Percentage")) %>'>
                                            <%# Eval("Percentage", "{0:F2}") %>%
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="AttemptDate" HeaderText="Date" DataFormatString="{0:MMM dd, yyyy hh:mm tt}" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
