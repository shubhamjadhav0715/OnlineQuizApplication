<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container">
            <h1><i class="fas fa-graduation-cap"></i> Welcome to Online Quiz Application</h1>
            <p>Test your knowledge with our interactive quizzes!</p>
            <asp:PlaceHolder ID="phNotLoggedIn" runat="server">
                <a href="User/Register.aspx" class="btn btn-light btn-lg mr-2">
                    <i class="fas fa-user-plus"></i> Get Started
                </a>
                <a href="User/Login.aspx" class="btn btn-outline-light btn-lg">
                    <i class="fas fa-sign-in-alt"></i> Login
                </a>
            </asp:PlaceHolder>
            <asp:PlaceHolder ID="phLoggedIn" runat="server" Visible="false">
                <a href="User/Quiz.aspx" class="btn btn-light btn-lg">
                    <i class="fas fa-clipboard-list"></i> Start Quiz Now
                </a>
            </asp:PlaceHolder>
        </div>
    </div>

    <!-- Features Section -->
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <div class="feature-box">
                    <i class="fas fa-brain"></i>
                    <h3>Test Your Knowledge</h3>
                    <p>Challenge yourself with a variety of questions covering multiple topics including C#, ASP.NET, and SQL Server.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-box">
                    <i class="fas fa-chart-line"></i>
                    <h3>Track Your Progress</h3>
                    <p>Monitor your performance over time with detailed quiz history and score tracking.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-box">
                    <i class="fas fa-trophy"></i>
                    <h3>Instant Results</h3>
                    <p>Get immediate feedback on your quiz performance with detailed score breakdowns.</p>
                </div>
            </div>
        </div>

        <!-- Statistics Section -->
        <asp:PlaceHolder ID="phStats" runat="server">
            <div class="row mt-5">
                <div class="col-12">
                    <h2 class="text-center mb-4">Platform Statistics</h2>
                </div>
                <div class="col-md-4">
                    <div class="dashboard-card stat-card-primary text-center">
                        <i class="fas fa-question-circle icon"></i>
                        <h3><asp:Literal ID="litTotalQuestions" runat="server"></asp:Literal></h3>
                        <p>Total Questions</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="dashboard-card stat-card-success text-center">
                        <i class="fas fa-users icon"></i>
                        <h3><asp:Literal ID="litTotalUsers" runat="server"></asp:Literal></h3>
                        <p>Registered Users</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="dashboard-card stat-card-info text-center">
                        <i class="fas fa-clipboard-check icon"></i>
                        <h3><asp:Literal ID="litTotalAttempts" runat="server"></asp:Literal></h3>
                        <p>Quiz Attempts</p>
                    </div>
                </div>
            </div>
        </asp:PlaceHolder>

        <!-- How It Works Section -->
        <div class="row mt-5">
            <div class="col-12">
                <h2 class="text-center mb-4">How It Works</h2>
            </div>
            <div class="col-md-3">
                <div class="text-center">
                    <div class="rounded-circle bg-primary text-white d-inline-flex align-items-center justify-content-center" 
                         style="width: 80px; height: 80px; font-size: 2rem; margin-bottom: 15px;">
                        <span>1</span>
                    </div>
                    <h4>Register</h4>
                    <p>Create your free account in seconds</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="text-center">
                    <div class="rounded-circle bg-success text-white d-inline-flex align-items-center justify-content-center" 
                         style="width: 80px; height: 80px; font-size: 2rem; margin-bottom: 15px;">
                        <span>2</span>
                    </div>
                    <h4>Login</h4>
                    <p>Access your personalized dashboard</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="text-center">
                    <div class="rounded-circle bg-info text-white d-inline-flex align-items-center justify-content-center" 
                         style="width: 80px; height: 80px; font-size: 2rem; margin-bottom: 15px;">
                        <span>3</span>
                    </div>
                    <h4>Take Quiz</h4>
                    <p>Answer questions and test your skills</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="text-center">
                    <div class="rounded-circle bg-warning text-white d-inline-flex align-items-center justify-content-center" 
                         style="width: 80px; height: 80px; font-size: 2rem; margin-bottom: 15px;">
                        <span>4</span>
                    </div>
                    <h4>View Results</h4>
                    <p>Get instant feedback and track progress</p>
                </div>
            </div>
        </div>

        <!-- Call to Action -->
        <div class="row mt-5 mb-5">
            <div class="col-12">
                <div class="card bg-primary text-white text-center">
                    <div class="card-body py-5">
                        <h2>Ready to Test Your Knowledge?</h2>
                        <p class="lead">Join thousands of learners improving their skills every day!</p>
                        <asp:PlaceHolder ID="phCTA" runat="server">
                            <a href="User/Register.aspx" class="btn btn-light btn-lg mt-3">
                                <i class="fas fa-rocket"></i> Start Learning Now
                            </a>
                        </asp:PlaceHolder>
                        <asp:PlaceHolder ID="phCTALoggedIn" runat="server" Visible="false">
                            <a href="User/Quiz.aspx" class="btn btn-light btn-lg mt-3">
                                <i class="fas fa-play-circle"></i> Take a Quiz
                            </a>
                        </asp:PlaceHolder>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
