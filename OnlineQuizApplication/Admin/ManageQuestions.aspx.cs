using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ManageQuestions : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Require admin access
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

            string questionText = ((TextBox)row.FindControl("txtQuestion")).Text.Trim();
            string optionA = ((TextBox)row.FindControl("txtOptionA")).Text.Trim();
            string optionB = ((TextBox)row.FindControl("txtOptionB")).Text.Trim();
            string optionC = ((TextBox)row.FindControl("txtOptionC")).Text.Trim();
            string optionD = ((TextBox)row.FindControl("txtOptionD")).Text.Trim();
            string correctOption = ((DropDownList)row.FindControl("ddlCorrectOption")).SelectedValue;

            // Validate inputs
            if (string.IsNullOrEmpty(questionText) || string.IsNullOrEmpty(optionA) || 
                string.IsNullOrEmpty(optionB) || string.IsNullOrEmpty(optionC) || 
                string.IsNullOrEmpty(optionD) || string.IsNullOrEmpty(correctOption))
            {
                ShowMessage("All fields are required.", "warning");
                return;
            }

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
