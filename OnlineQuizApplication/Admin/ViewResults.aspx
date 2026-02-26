<%@ Page Title="View Results" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="ViewResults.aspx.cs" Inherits="Admin_ViewResults" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <div class="card-header">
            <h3 class="mb-0"><i class="fas fa-chart-bar"></i> All Quiz Results</h3>
        </div>
        <div class="card-body">
            <div class="mb-3">
                <a href="Dashboard.aspx" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>

            <div class="table-responsive">
                <asp:GridView ID="gvResults" runat="server" CssClass="table table-striped table-hover" 
                    AutoGenerateColumns="False" EmptyDataText="No quiz results found yet.">
                    <Columns>
                        <asp:BoundField DataField="AttemptID" HeaderText="Attempt #" />
                        <asp:BoundField DataField="UserName" HeaderText="User Name" />
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
                        <asp:TemplateField HeaderText="Grade">
                            <ItemTemplate>
                                <%# GetGrade(Eval("Percentage")) %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="AttemptDate" HeaderText="Date" DataFormatString="{0:MMM dd, yyyy hh:mm tt}" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
