<%@ Page Title="Quiz History" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="History.aspx.cs" Inherits="User_History" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <div class="card-header">
            <h3 class="mb-0"><i class="fas fa-history"></i> My Quiz History</h3>
        </div>
        <div class="card-body">
            <asp:Panel ID="pnlHistory" runat="server">
                <div class="table-responsive">
                    <asp:GridView ID="gvHistory" runat="server" CssClass="table table-striped table-hover" 
                        AutoGenerateColumns="False" EmptyDataText="No quiz attempts found. Take a quiz to see your history!">
                        <Columns>
                            <asp:BoundField DataField="AttemptID" HeaderText="Attempt #" />
                            <asp:BoundField DataField="Score" HeaderText="Score" />
                            <asp:BoundField DataField="TotalQuestions" HeaderText="Total Questions" />
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
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <a href='Result.aspx?attemptID=<%# Eval("AttemptID") %>' class="btn btn-sm btn-info">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <div class="mt-4">
                    <a href="Quiz.aspx" class="btn btn-primary">
                        <i class="fas fa-plus-circle"></i> Take New Quiz
                    </a>
                    <a href="../Default.aspx" class="btn btn-secondary ml-2">
                        <i class="fas fa-home"></i> Go to Home
                    </a>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
