<%@ Page Title="Manage Questions" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="ManageQuestions.aspx.cs" Inherits="Admin_ManageQuestions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <div class="card-header">
            <h3 class="mb-0"><i class="fas fa-tasks"></i> Manage Questions</h3>
        </div>
        <div class="card-body">
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert" role="alert">
                <asp:Literal ID="litMessage" runat="server"></asp:Literal>
            </asp:Panel>

            <div class="mb-3">
                <a href="AddQuestion.aspx" class="btn btn-primary">
                    <i class="fas fa-plus-circle"></i> Add New Question
                </a>
                <a href="Dashboard.aspx" class="btn btn-secondary ml-2">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>

            <div class="table-responsive">
                <asp:GridView ID="gvQuestions" runat="server" CssClass="table table-striped table-hover" 
                    AutoGenerateColumns="False" DataKeyNames="QuestionID" 
                    OnRowEditing="gvQuestions_RowEditing" 
                    OnRowCancelingEdit="gvQuestions_RowCancelingEdit"
                    OnRowUpdating="gvQuestions_RowUpdating" 
                    OnRowDeleting="gvQuestions_RowDeleting"
                    EmptyDataText="No questions found. Click 'Add New Question' to create one.">
                    <Columns>
                        <asp:BoundField DataField="QuestionID" HeaderText="ID" ReadOnly="True" />
                        
                        <asp:TemplateField HeaderText="Question">
                            <ItemTemplate>
                                <div style="max-width: 300px; overflow: hidden; text-overflow: ellipsis;">
                                    <%# Eval("QuestionText") %>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuestion" runat="server" Text='<%# Bind("QuestionText") %>' 
                                    CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Option A">
                            <ItemTemplate>
                                <%# Eval("OptionA") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtOptionA" runat="server" Text='<%# Bind("OptionA") %>' 
                                    CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Option B">
                            <ItemTemplate>
                                <%# Eval("OptionB") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtOptionB" runat="server" Text='<%# Bind("OptionB") %>' 
                                    CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Option C">
                            <ItemTemplate>
                                <%# Eval("OptionC") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtOptionC" runat="server" Text='<%# Bind("OptionC") %>' 
                                    CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Option D">
                            <ItemTemplate>
                                <%# Eval("OptionD") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtOptionD" runat="server" Text='<%# Bind("OptionD") %>' 
                                    CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Correct">
                            <ItemTemplate>
                                <span class="badge badge-success"><%# Eval("CorrectOption") %></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlCorrectOption" runat="server" CssClass="form-control"
                                    SelectedValue='<%# Bind("CorrectOption") %>'>
                                    <asp:ListItem Value="A">A</asp:ListItem>
                                    <asp:ListItem Value="B">B</asp:ListItem>
                                    <asp:ListItem Value="C">C</asp:ListItem>
                                    <asp:ListItem Value="D">D</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:CommandField ShowEditButton="True" ButtonType="Button" 
                            ControlStyle-CssClass="btn btn-sm btn-info mr-1" 
                            EditText="Edit" UpdateText="Update" CancelText="Cancel" />
                        
                        <asp:CommandField ShowDeleteButton="True" ButtonType="Button" 
                            ControlStyle-CssClass="btn btn-sm btn-danger btn-delete" 
                            DeleteText="Delete" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
