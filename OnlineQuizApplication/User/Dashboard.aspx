<%@ Page Title="User Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="User_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <!-- Welcome Section -->
        <div class="row mb-4">
            <div class="col-12">
                <h2><i class="fas fa-home"></i> Welcome, <asp:Literal ID="litUserName" runat="server"></asp:Literal>!</h2>
                <p class="lead text-muted">Ready to test your knowledge?</p>
            </div>
        </div>

        <div class="row">
            <!-- Main Content - Start Quiz Card -->
            <div class="col-md-8">
                <div class="card shadow-lg mb-4">
                    <div class="card-body text-center p-5">
                        <i class="fas fa-clipboard-list fa-5x text-primary mb-4"></i>
                        <h3 class="mb-3">Start New Quiz</h3>
                        <p class="lead mb-4">Test your knowledge with 10 random questions</p>
                        <a href="Quiz.aspx" class="btn btn-primary btn-lg">
                            <i class="fas fa-play-circle"></i> Start Quiz
                        </a>
                    </div>
                </div>

                <!-- Recent Attempts -->
                <div class="card shadow-lg">
                    <div class="card-header">
                        <h4 class="mb-0"><i class="fas fa-history"></i> Recent Attempts</h4>
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="gvRecentAttempts" runat="server" CssClass="table table-hover" 
                            AutoGenerateColumns="False" EmptyDataText="No quiz attempts yet. Start your first quiz!">
                            <Columns>
                                <asp:BoundField DataField="AttemptDate" HeaderText="Date" DataFormatString="{0:MMM dd, yyyy}" />
                                <asp:BoundField DataField="Score" HeaderText="Score" />
                                <asp:BoundField DataField="TotalQuestions" HeaderText="Total" />
                                <asp:TemplateField HeaderText="Percentage">
                                    <ItemTemplate>
                                        <span class="badge badge-primary">
                                            <%# Eval("Percentage", "{0:F0}") %>%
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <div class="text-center mt-3">
                            <a href="History.aspx" class="btn btn-outline-primary">
                                <i class="fas fa-list"></i> View All History
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sidebar - Statistics -->
            <div class="col-md-4">
                <div class="card shadow-lg mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="fas fa-chart-bar"></i> Your Statistics</h5>
                    </div>
                    <div class="card-body">
                        <div class="stat-item mb-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="fas fa-clipboard-check text-primary fa-2x"></i>
                                </div>
                                <div class="text-right">
                                    <h3 class="mb-0"><asp:Literal ID="litTotalAttempts" runat="server">0</asp:Literal></h3>
                                    <small class="text-muted">Total Attempts</small>
                                </div>
                            </div>
                        </div>

                        <hr />

                        <div class="stat-item mb-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="fas fa-percentage text-success fa-2x"></i>
                                </div>
                                <div class="text-right">
                                    <h3 class="mb-0"><asp:Literal ID="litAvgScore" runat="server">0</asp:Literal>%</h3>
                                    <small class="text-muted">Average Score</small>
                                </div>
                            </div>
                        </div>

                        <hr />

                        <div class="stat-item">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="fas fa-trophy text-warning fa-2x"></i>
                                </div>
                                <div class="text-right">
                                    <h3 class="mb-0"><asp:Literal ID="litBestScore" runat="server">0</asp:Literal>%</h3>
                                    <small class="text-muted">Best Score</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Links -->
                <div class="card shadow-lg">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0"><i class="fas fa-link"></i> Quick Links</h5>
                    </div>
                    <div class="card-body">
                        <div class="list-group list-group-flush">
                            <a href="Quiz.aspx" class="list-group-item list-group-item-action">
                                <i class="fas fa-play-circle text-primary"></i> Take Quiz
                            </a>
                            <a href="Result.aspx" class="list-group-item list-group-item-action">
                                <i class="fas fa-chart-line text-success"></i> View Results
                            </a>
                            <a href="History.aspx" class="list-group-item list-group-item-action">
                                <i class="fas fa-history text-info"></i> Quiz History
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
