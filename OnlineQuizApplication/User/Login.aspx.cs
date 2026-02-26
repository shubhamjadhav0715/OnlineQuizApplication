using System;
using System.Web.UI;

public partial class User_Login : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Redirect if already logged in
            if (AuthManager.IsLoggedIn())
            {
                RedirectUser();
            }
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text;

                // Validate login
                bool isValid = AuthManager.ValidateLogin(email, password);

                if (isValid)
                {
                    // Create session
                    AuthManager.CreateSession(email);

                    // Redirect based on role
                    RedirectUser();
                }
                else
                {
                    ShowMessage("Invalid email or password. Please try again.", "danger");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Login failed: " + ex.Message, "danger");
            }
        }
    }

    private void RedirectUser()
    {
        if (AuthManager.IsAdmin())
        {
            Response.Redirect("~/Admin/Dashboard.aspx");
        }
        else
        {
            Response.Redirect("~/Default.aspx");
        }
    }

    private void ShowMessage(string message, string type)
    {
        pnlMessage.Visible = true;
        pnlMessage.CssClass = "alert alert-" + type;
        litMessage.Text = message;
    }
}
