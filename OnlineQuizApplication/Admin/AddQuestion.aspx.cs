using System;
using System.Web.UI;

public partial class Admin_AddQuestion : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Require admin access
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

                // Validate that correct option is selected
                if (string.IsNullOrEmpty(correctOption))
                {
                    ShowMessage("Please select the correct answer option.", "warning");
                    return;
                }

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
