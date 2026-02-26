using System;
using System.Web.UI;

public partial class User_Register : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Redirect if already logged in
            if (AuthManager.IsLoggedIn())
            {
                Response.Redirect("~/Default.aspx");
            }
        }
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                string name = txtName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text;

                // Validate password length
                if (password.Length < 6)
                {
                    ShowMessage("Password must be at least 6 characters long", "danger");
                    return;
                }

                // Register user
                bool success = AuthManager.RegisterUser(name, email, password);

                if (success)
                {
                    ShowMessage("Registration successful! Please login to continue.", "success");
                    
                    // Clear form
                    ClearForm();
                    
                    // Redirect to login page after 2 seconds
                    Response.AddHeader("REFRESH", "2;URL=Login.aspx");
                }
                else
                {
                    ShowMessage("Email already exists. Please use a different email or login.", "warning");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Registration failed: " + ex.Message, "danger");
            }
        }
    }

    private void ShowMessage(string message, string type)
    {
        pnlMessage.Visible = true;
        pnlMessage.CssClass = "alert alert-" + type;
        litMessage.Text = message;
    }

    private void ClearForm()
    {
        txtName.Text = "";
        txtEmail.Text = "";
        txtPassword.Text = "";
        txtConfirmPassword.Text = "";
    }
}
