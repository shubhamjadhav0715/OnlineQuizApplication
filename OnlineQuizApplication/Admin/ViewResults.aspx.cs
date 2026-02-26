using System;
using System.Data;
using System.Web.UI;

public partial class Admin_ViewResults : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Require admin access
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
            // Log error
            System.Diagnostics.Debug.WriteLine("Load Results Error: " + ex.Message);
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
