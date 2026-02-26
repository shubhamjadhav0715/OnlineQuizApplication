# 🚀 Complete Setup Instructions for Online Quiz Application

## ✅ Files Already Created

The following files have been successfully created in the repository:

### Database
- ✅ `Database/QuizDB.sql` - Complete database schema with sample data

### Configuration & Layout
- ✅ `Web.config` - Application configuration
- ✅ `Site.Master` - Master page layout
- ✅ `Site.Master.cs` - Master page code-behind
- ✅ `Default.aspx` - Home page
- ✅ `Default.aspx.cs` - Home page code-behind

### Business Logic (App_Code)
- ✅ `App_Code/DBHelper.cs` - Database operations
- ✅ `App_Code/AuthManager.cs` - Authentication & authorization
- ✅ `App_Code/QuizManager.cs` - Quiz operations

### Styles & Scripts
- ✅ `Styles/site.css` - Custom CSS styles

### User Module
- ✅ `User/Register.aspx` & `.cs` - User registration
- ✅ `User/Login.aspx` & `.cs` - User login
- ✅ `User/Quiz.aspx` & `.cs` - Take quiz
- ✅ `User/Result.aspx` & `.cs` - View results
- ✅ `User/History.aspx` & `.cs` - Quiz history

### Admin Module (Partial)
- ✅ `Admin/Dashboard.aspx` - Admin dashboard
- ✅ `Admin/AddQuestion.aspx` - Add question form

### Documentation
- ✅ `README.md` - Comprehensive documentation

---

## 📝 Remaining Files to Create

You need to manually create the following files in Visual Studio:

### 1. Scripts/site.js
Create this file with the JavaScript code for client-side functionality.

### 2. Admin Module Code-Behind Files

#### Admin/Dashboard.aspx.cs
```csharp
using System;
using System.Data;
using System.Web.UI;

public partial class Admin_Dashboard : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AuthManager.RequireAdmin();
        if (!IsPostBack)
        {
            LoadDashboard();
        }
    }

    private void LoadDashboard()
    {
        try
        {
            litAdminName.Text = AuthManager.GetCurrentUserName();
            litTotalQuestions.Text = QuizManager.GetTotalQuestionsCount().ToString();
            litTotalUsers.Text = QuizManager.GetTotalUsersCount().ToString();
            litTotalAttempts.Text = QuizManager.GetTotalAttemptsCount().ToString();

            string query = "SELECT AVG(CAST(Score AS FLOAT) / TotalQuestions * 100) AS AvgScore FROM QuizAttempts";
            object avgScore = DBHelper.ExecuteScalar(query);
            
            if (avgScore != null && avgScore != DBNull.Value)
            {
                litAvgScore.Text = Convert.ToDecimal(avgScore).ToString("F2");
            }
            else
            {
                litAvgScore.Text = "0.00";
            }

            LoadRecentAttempts();
        }
        catch (Exception ex)
        {
            // Handle error
        }
    }

    private void LoadRecentAttempts()
    {
        try
        {
            string query = @"SELECT TOP 10 qa.AttemptID, u.Name AS UserName, u.Email, qa.Score, qa.TotalQuestions,
                           CAST((qa.Score * 100.0 / qa.TotalQuestions) AS DECIMAL(5,2)) AS Percentage,
                           qa.AttemptDate 
                           FROM QuizAttempts qa
                           INNER JOIN Users u ON qa.UserID = u.UserID
                           ORDER BY qa.AttemptDate DESC";

            DataTable dt = DBHelper.ExecuteQuery(query);
            gvRecentAttempts.DataSource = dt;
            gvRecentAttempts.DataBind();
        }
        catch (Exception ex)
        {
            // Handle error
        }
    }

    protected string GetPercentageClass(object percentage)
    {
        if (percentage == null) return "";
        decimal percent = Convert.ToDecimal(percentage);
        if (percent >= 90) return "badge badge-success";
        if (percent >= 70) return "badge badge-info";
        if (percent >= 50) return "badge badge-warning";
        return "badge badge-danger";
    }
}
```

#### Admin/AddQuestion.aspx.cs
```csharp
using System;
using System.Web.UI;

public partial class Admin_AddQuestion : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AuthManager.RequireAdmin();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                string questionText = txtQuestion.Text.Trim();
                string optionA = txtOptionA.Text.Trim();
                string optionB = txtOptionB.Text.Trim();
                string optionC = txtOptionC.Text.Trim();
                string optionD = txtOptionD.Text.Trim();
                string correctOption = ddlCorrectOption.SelectedValue;

                bool success = QuizManager.AddQuestion(questionText, optionA, optionB, optionC, optionD, correctOption);

                if (success)
                {
                    ShowMessage("Question added successfully!", "success");
                    ClearForm();
                }
                else
                {
                    ShowMessage("Failed to add question. Please try again.", "danger");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, "danger");
            }
        }
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearForm();
    }

    private void ShowMessage(string message, string type)
    {
        pnlMessage.Visible = true;
        pnlMessage.CssClass = "alert alert-" + type;
        litMessage.Text = message;
    }

    private void ClearForm()
    {
        txtQuestion.Text = "";
        txtOptionA.Text = "";
        txtOptionB.Text = "";
        txtOptionC.Text = "";
        txtOptionD.Text = "";
        ddlCorrectOption.SelectedIndex = 0;
        pnlMessage.Visible = false;
    }
}
```

#### Admin/ManageQuestions.aspx
```aspx
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
            </div>

            <div class="table-responsive">
                <asp:GridView ID="gvQuestions" runat="server" CssClass="table table-striped table-hover" 
                    AutoGenerateColumns="False" DataKeyNames="QuestionID" 
                    OnRowEditing="gvQuestions_RowEditing" 
                    OnRowCancelingEdit="gvQuestions_RowCancelingEdit"
                    OnRowUpdating="gvQuestions_RowUpdating" 
                    OnRowDeleting="gvQuestions_RowDeleting"
                    EmptyDataText="No questions found.">
                    <Columns>
                        <asp:BoundField DataField="QuestionID" HeaderText="ID" ReadOnly="True" />
                        <asp:TemplateField HeaderText="Question">
                            <ItemTemplate>
                                <%# Eval("QuestionText") %>
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
                            ControlStyle-CssClass="btn btn-sm btn-info mr-1" />
                        <asp:CommandField ShowDeleteButton="True" ButtonType="Button" 
                            ControlStyle-CssClass="btn btn-sm btn-danger btn-delete" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
```

#### Admin/ManageQuestions.aspx.cs
```csharp
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ManageQuestions : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AuthManager.RequireAdmin();
        if (!IsPostBack)
        {
            LoadQuestions();
        }
    }

    private void LoadQuestions()
    {
        try
        {
            DataTable dt = QuizManager.GetAllQuestions();
            gvQuestions.DataSource = dt;
            gvQuestions.DataBind();
        }
        catch (Exception ex)
        {
            ShowMessage("Error loading questions: " + ex.Message, "danger");
        }
    }

    protected void gvQuestions_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvQuestions.EditIndex = e.NewEditIndex;
        LoadQuestions();
    }

    protected void gvQuestions_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvQuestions.EditIndex = -1;
        LoadQuestions();
    }

    protected void gvQuestions_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            int questionID = Convert.ToInt32(gvQuestions.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvQuestions.Rows[e.RowIndex];

            string questionText = ((TextBox)row.FindControl("txtQuestion")).Text;
            string optionA = ((TextBox)row.FindControl("txtOptionA")).Text;
            string optionB = ((TextBox)row.FindControl("txtOptionB")).Text;
            string optionC = ((TextBox)row.FindControl("txtOptionC")).Text;
            string optionD = ((TextBox)row.FindControl("txtOptionD")).Text;
            string correctOption = ((DropDownList)row.FindControl("ddlCorrectOption")).SelectedValue;

            bool success = QuizManager.UpdateQuestion(questionID, questionText, optionA, optionB, optionC, optionD, correctOption);

            if (success)
            {
                ShowMessage("Question updated successfully!", "success");
                gvQuestions.EditIndex = -1;
                LoadQuestions();
            }
            else
            {
                ShowMessage("Failed to update question.", "danger");
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error: " + ex.Message, "danger");
        }
    }

    protected void gvQuestions_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int questionID = Convert.ToInt32(gvQuestions.DataKeys[e.RowIndex].Value);
            bool success = QuizManager.DeleteQuestion(questionID);

            if (success)
            {
                ShowMessage("Question deleted successfully!", "success");
                LoadQuestions();
            }
            else
            {
                ShowMessage("Failed to delete question.", "danger");
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error: " + ex.Message, "danger");
        }
    }

    private void ShowMessage(string message, string type)
    {
        pnlMessage.Visible = true;
        pnlMessage.CssClass = "alert alert-" + type;
        litMessage.Text = message;
    }
}
```

#### Admin/ViewResults.aspx
```aspx
<%@ Page Title="View Results" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="ViewResults.aspx.cs" Inherits="Admin_ViewResults" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <div class="card-header">
            <h3 class="mb-0"><i class="fas fa-chart-bar"></i> All Quiz Results</h3>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <asp:GridView ID="gvResults" runat="server" CssClass="table table-striped table-hover" 
                    AutoGenerateColumns="False" EmptyDataText="No quiz results found.">
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
```

#### Admin/ViewResults.aspx.cs
```csharp
using System;
using System.Data;
using System.Web.UI;

public partial class Admin_ViewResults : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AuthManager.RequireAdmin();
        if (!IsPostBack)
        {
            LoadResults();
        }
    }

    private void LoadResults()
    {
        try
        {
            DataTable dt = QuizManager.GetAllQuizResults();
            gvResults.DataSource = dt;
            gvResults.DataBind();
        }
        catch (Exception ex)
        {
            // Handle error
        }
    }

    protected string GetPercentageClass(object percentage)
    {
        if (percentage == null) return "";
        decimal percent = Convert.ToDecimal(percentage);
        if (percent >= 90) return "badge badge-success";
        if (percent >= 70) return "badge badge-info";
        if (percent >= 50) return "badge badge-warning";
        return "badge badge-danger";
    }

    protected string GetGrade(object percentage)
    {
        if (percentage == null) return "F";
        decimal percent = Convert.ToDecimal(percentage);
        if (percent >= 90) return "<span class='badge badge-success'>A</span>";
        if (percent >= 80) return "<span class='badge badge-info'>B</span>";
        if (percent >= 70) return "<span class='badge badge-primary'>C</span>";
        if (percent >= 60) return "<span class='badge badge-warning'>D</span>";
        return "<span class='badge badge-danger'>F</span>";
    }
}
```

---

## 🔧 Step-by-Step Setup in Visual Studio 2022

### 1. Clone the Repository
```bash
git clone https://github.com/shubhamjadhav0715/OnlineQuizApplication.git
cd OnlineQuizApplication
```

### 2. Create Visual Studio Solution
1. Open Visual Studio 2022
2. Create New Project → ASP.NET Web Application (.NET Framework)
3. Name: `OnlineQuizApplication`
4. Framework: .NET Framework 4.7.2 or higher
5. Template: Empty (we'll add files manually)

### 3. Add Existing Files
1. Copy all files from the cloned repository into your Visual Studio project folder
2. In Visual Studio, right-click project → Add → Existing Item
3. Select all `.aspx`, `.cs`, `.css`, `.js`, `.config` files
4. Ensure folder structure matches the repository

### 4. Create Missing Files
Manually create the files listed in the "Remaining Files" section above using the provided code.

### 5. Setup Database
1. Open SQL Server Management Studio
2. Execute `Database/QuizDB.sql`
3. Verify tables and data are created

### 6. Configure Connection String
Update `Web.config`:
```xml
<connectionStrings>
  <add name="QuizDBConnection" 
       connectionString="Data Source=YOUR_SERVER;Initial Catalog=QuizDB;Integrated Security=True" 
       providerName="System.Data.SqlClient"/>
</connectionStrings>
```

### 7. Build and Run
1. Build Solution (Ctrl+Shift+B)
2. Fix any compilation errors
3. Press F5 to run
4. Login with admin credentials: admin@quiz.com / admin123

---

## ✅ Verification Checklist

- [ ] Database created successfully
- [ ] All files added to Visual Studio project
- [ ] Connection string configured
- [ ] Solution builds without errors
- [ ] Can access home page
- [ ] Can register new user
- [ ] Can login as user
- [ ] Can take quiz
- [ ] Can view results
- [ ] Can login as admin
- [ ] Can add questions
- [ ] Can manage questions
- [ ] Can view all results

---

## 🆘 Troubleshooting

### Build Errors
- Ensure .NET Framework 4.7.2+ is installed
- Check all using statements are correct
- Verify all files are in correct folders

### Database Connection Errors
- Verify SQL Server is running
- Check connection string
- Test connection in Server Explorer

### Runtime Errors
- Check Web.config for errors
- Verify App_Code files are set to "Compile"
- Clear browser cache

---

## 📞 Support

For issues or questions:
- Check README.md for detailed documentation
- Review code comments
- Contact: itsmeshubzz07@gmail.com

---

**Project Complete! Happy Coding! 🎉**
