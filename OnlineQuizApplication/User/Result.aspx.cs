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
            // Get attempt ID from query string or session
            int attemptID = 0;
            
            if (Request.QueryString["attemptID"] != null)
            {
                attemptID = Convert.ToInt32(Request.QueryString["attemptID"]);
            }
            else if (Session["LastAttemptID"] != null)
            {
                attemptID = Convert.ToInt32(Session["LastAttemptID"]);
            }

            if (attemptID > 0)
            {
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
                    litPercentage.Text = percentage.ToString("F0");
                    litCorrect.Text = score.ToString();
                    litWrong.Text = wrong.ToString();
                    litAccuracy.Text = percentage.ToString("F0");

                    // Calculate and display grade
                    string grade = GetGrade(percentage);
                    litGrade.Text = grade;

                    // Set message based on percentage
                    string message = GetMessage(percentage);
                    litMessage.Text = message;

                    // Load detailed answer review
                    LoadAnswerReview(attemptID);

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
            System.Diagnostics.Debug.WriteLine("Error loading result: " + ex.Message);
        }
    }

    private string GetGrade(decimal percentage)
    {
        if (percentage >= 90) return "A+";
        if (percentage >= 85) return "A";
        if (percentage >= 80) return "B+";
        if (percentage >= 75) return "B";
        if (percentage >= 70) return "C+";
        if (percentage >= 65) return "C";
        if (percentage >= 60) return "D+";
        if (percentage >= 50) return "D";
        return "F";
    }

    private string GetMessage(decimal percentage)
    {
        if (percentage >= 90)
            return "🎉 Excellent! Outstanding performance!";
        else if (percentage >= 80)
            return "👍 Great job! Very well done!";
        else if (percentage >= 70)
            return "👌 Good work! Keep it up!";
        else if (percentage >= 60)
            return "📚 Fair attempt! Keep practicing!";
        else if (percentage >= 50)
            return "💪 You can do better! Keep learning!";
        else
            return "📖 Don't give up! Practice makes perfect!";
    }

    private void LoadAnswerReview(int attemptID)
    {
        try
        {
            string query = @"
                SELECT 
                    q.QuestionText,
                    ua.SelectedOption,
                    q.CorrectOption,
                    ua.IsCorrect
                FROM UserAnswers ua
                INNER JOIN Questions q ON ua.QuestionID = q.QuestionID
                WHERE ua.AttemptID = @AttemptID
                ORDER BY ua.AnswerID";

            DataTable dt = DBHelper.ExecuteQuery(query, 
                new System.Data.SqlClient.SqlParameter("@AttemptID", attemptID));

            rptAnswers.DataSource = dt;
            rptAnswers.DataBind();
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error loading answer review: " + ex.Message);
        }
    }

    private void ShowError()
    {
        pnlResult.Visible = false;
        pnlError.Visible = true;
    }
}
