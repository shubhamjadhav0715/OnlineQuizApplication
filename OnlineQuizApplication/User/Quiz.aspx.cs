using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class User_Quiz : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Require login
        AuthManager.RequireLogin();

        if (!IsPostBack)
        {
            LoadQuestions();
        }
    }

    private void LoadQuestions()
    {
        try
        {
            // Get 10 random questions
            DataTable dt = QuizManager.GetRandomQuestions(10);

            if (dt.Rows.Count > 0)
            {
                rptQuestions.DataSource = dt;
                rptQuestions.DataBind();
                
                pnlQuiz.Visible = true;
                pnlNoQuestions.Visible = false;
            }
            else
            {
                pnlQuiz.Visible = false;
                pnlNoQuestions.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error loading questions: " + ex.Message, "danger");
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            // Collect answers
            Dictionary<int, string> answers = new Dictionary<int, string>();
            int unansweredCount = 0;

            foreach (RepeaterItem item in rptQuestions.Items)
            {
                HiddenField hfQuestionID = (HiddenField)item.FindControl("hfQuestionID");
                RadioButton rbA = (RadioButton)item.FindControl("rbOptionA");
                RadioButton rbB = (RadioButton)item.FindControl("rbOptionB");
                RadioButton rbC = (RadioButton)item.FindControl("rbOptionC");
                RadioButton rbD = (RadioButton)item.FindControl("rbOptionD");

                int questionID = Convert.ToInt32(hfQuestionID.Value);
                string selectedOption = "";

                if (rbA.Checked) selectedOption = "A";
                else if (rbB.Checked) selectedOption = "B";
                else if (rbC.Checked) selectedOption = "C";
                else if (rbD.Checked) selectedOption = "D";

                if (string.IsNullOrEmpty(selectedOption))
                {
                    unansweredCount++;
                }
                else
                {
                    answers.Add(questionID, selectedOption);
                }
            }

            // Check if all questions are answered
            if (unansweredCount > 0)
            {
                ShowMessage($"Please answer all questions. {unansweredCount} question(s) remaining.", "warning");
                return;
            }

            // Save quiz attempt
            int userID = AuthManager.GetCurrentUserID();
            int attemptID = QuizManager.SaveQuizAttempt(userID, answers);

            // Redirect to result page
            Response.Redirect("Result.aspx?attemptID=" + attemptID);
        }
        catch (Exception ex)
        {
            ShowMessage("Error submitting quiz: " + ex.Message, "danger");
        }
    }

    private void ShowMessage(string message, string type)
    {
        pnlMessage.Visible = true;
        pnlMessage.CssClass = "alert alert-" + type;
        litMessage.Text = message;
    }
}
