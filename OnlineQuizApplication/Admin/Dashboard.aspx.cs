using System;
using System.Data;
using System.Web.UI;

public partial class Admin_Dashboard : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Require admin access
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
            // Set admin name
            litAdminName.Text = AuthManager.GetCurrentUserName();

            // Load statistics
            litTotalQuestions.Text = QuizManager.GetTotalQuestionsCount().ToString();
            litTotalUsers.Text = QuizManager.GetTotalUsersCount().ToString();
            litTotalAttempts.Text = QuizManager.GetTotalAttemptsCount().ToString();

            // Calculate average score
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

            // Load recent attempts (top 10)
            LoadRecentAttempts();
        }
        catch (Exception ex)
        {
            // Log error (in production, use proper logging)
            System.Diagnostics.Debug.WriteLine("Dashboard Error: " + ex.Message);
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
            // Log error
            System.Diagnostics.Debug.WriteLine("Load Recent Attempts Error: " + ex.Message);
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
