using System;
using System.Data;
using System.Web.UI;

public partial class User_Result : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Require login
        AuthManager.RequireLogin();

        if (!IsPostBack)
        {
            LoadResult();
        }
    }

    private void LoadResult()
    {
        try
        {
            // Get attempt ID from query string
            if (Request.QueryString["attemptID"] != null)
            {
                int attemptID = Convert.ToInt32(Request.QueryString["attemptID"]);
                
                // Get attempt details
                DataRow attempt = QuizManager.GetAttemptDetails(attemptID);

                if (attempt != null)
                {
                    // Verify this attempt belongs to current user
                    int userID = Convert.ToInt32(attempt["UserID"]);
                    if (userID != AuthManager.GetCurrentUserID())
                    {
                        ShowError();
                        return;
                    }

                    // Display results
                    int score = Convert.ToInt32(attempt["Score"]);
                    int totalQuestions = Convert.ToInt32(attempt["TotalQuestions"]);
                    int wrong = totalQuestions - score;
                    decimal percentage = (decimal)score / totalQuestions * 100;

                    litScore.Text = score.ToString();
                    litTotal.Text = totalQuestions.ToString();
                    litPercentage.Text = percentage.ToString("F2");
                    litCorrect.Text = score.ToString();
                    litWrong.Text = wrong.ToString();
                    litAccuracy.Text = percentage.ToString("F2");

                    // Set message based on percentage
                    string message = "";
                    string messageClass = "";

                    if (percentage >= 90)
                    {
                        message = "🎉 Excellent! Outstanding performance!";
                        messageClass = "excellent";
                    }
                    else if (percentage >= 70)
                    {
                        message = "👍 Good job! Well done!";
                        messageClass = "good";
                    }
                    else if (percentage >= 50)
                    {
                        message = "👌 Not bad! Keep practicing!";
                        messageClass = "average";
                    }
                    else
                    {
                        message = "📚 Keep learning! Practice makes perfect!";
                        messageClass = "poor";
                    }

                    litMessage.Text = $"<span class='{messageClass}'>{message}</span>";

                    pnlResult.Visible = true;
                    pnlError.Visible = false;
                }
                else
                {
                    ShowError();
                }
            }
            else
            {
                ShowError();
            }
        }
        catch (Exception ex)
        {
            ShowError();
        }
    }

    private void ShowError()
    {
        pnlResult.Visible = false;
        pnlError.Visible = true;
    }
}
