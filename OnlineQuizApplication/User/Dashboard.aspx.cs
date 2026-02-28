using System;
using System.Data;
using System.Web.UI;

public partial class User_Dashboard : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Require user to be logged in
            AuthManager.RequireLogin();

            // Load user data
            LoadUserData();
            LoadStatistics();
            LoadRecentAttempts();
        }
    }

    private void LoadUserData()
    {
        if (Session["UserName"] != null)
        {
            litUserName.Text = Session["UserName"].ToString();
        }
    }

    private void LoadStatistics()
    {
        try
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            // Get total attempts
            string queryAttempts = "SELECT COUNT(*) FROM QuizAttempts WHERE UserID = @UserID";
            object totalAttempts = DBHelper.ExecuteScalar(queryAttempts, 
                new System.Data.SqlClient.SqlParameter("@UserID", userId));
            litTotalAttempts.Text = totalAttempts != null ? totalAttempts.ToString() : "0";

            // Get average score
            string queryAvg = @"SELECT AVG(CAST(Score AS FLOAT) / TotalQuestions * 100) 
                               FROM QuizAttempts WHERE UserID = @UserID";
            object avgScore = DBHelper.ExecuteScalar(queryAvg, 
                new System.Data.SqlClient.SqlParameter("@UserID", userId));
            
            if (avgScore != null && avgScore != DBNull.Value)
            {
                litAvgScore.Text = Convert.ToDouble(avgScore).ToString("F0");
            }
            else
            {
                litAvgScore.Text = "0";
            }

            // Get best score
            string queryBest = @"SELECT MAX(CAST(Score AS FLOAT) / TotalQuestions * 100) 
                                FROM QuizAttempts WHERE UserID = @UserID";
            object bestScore = DBHelper.ExecuteScalar(queryBest, 
                new System.Data.SqlClient.SqlParameter("@UserID", userId));
            
            if (bestScore != null && bestScore != DBNull.Value)
            {
                litBestScore.Text = Convert.ToDouble(bestScore).ToString("F0");
            }
            else
            {
                litBestScore.Text = "0";
            }
        }
        catch (Exception ex)
        {
            // Log error (in production, use proper logging)
            System.Diagnostics.Debug.WriteLine("Error loading statistics: " + ex.Message);
        }
    }

    private void LoadRecentAttempts()
    {
        try
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            string query = @"SELECT TOP 5 
                            AttemptID,
                            Score,
                            TotalQuestions,
                            CAST(Score AS FLOAT) / TotalQuestions * 100 AS Percentage,
                            AttemptDate
                           FROM QuizAttempts 
                           WHERE UserID = @UserID 
                           ORDER BY AttemptDate DESC";

            DataTable dt = DBHelper.ExecuteQuery(query, 
                new System.Data.SqlClient.SqlParameter("@UserID", userId));

            gvRecentAttempts.DataSource = dt;
            gvRecentAttempts.DataBind();
        }
        catch (Exception ex)
        {
            // Log error (in production, use proper logging)
            System.Diagnostics.Debug.WriteLine("Error loading recent attempts: " + ex.Message);
        }
    }
}
