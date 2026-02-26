using System;
using System.Web.UI;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadStatistics();
            SetVisibility();
        }
    }

    /// <summary>
    /// Load platform statistics
    /// </summary>
    private void LoadStatistics()
    {
        try
        {
            litTotalQuestions.Text = QuizManager.GetTotalQuestionsCount().ToString();
            litTotalUsers.Text = QuizManager.GetTotalUsersCount().ToString();
            litTotalAttempts.Text = QuizManager.GetTotalAttemptsCount().ToString();
        }
        catch (Exception ex)
        {
            // Log error (in production, use proper logging)
            litTotalQuestions.Text = "0";
            litTotalUsers.Text = "0";
            litTotalAttempts.Text = "0";
        }
    }

    /// <summary>
    /// Set visibility based on login status
    /// </summary>
    private void SetVisibility()
    {
        if (AuthManager.IsLoggedIn())
        {
            phNotLoggedIn.Visible = false;
            phLoggedIn.Visible = true;
            phCTA.Visible = false;
            phCTALoggedIn.Visible = true;
        }
        else
        {
            phNotLoggedIn.Visible = true;
            phLoggedIn.Visible = false;
            phCTA.Visible = true;
            phCTALoggedIn.Visible = false;
        }
    }
}
