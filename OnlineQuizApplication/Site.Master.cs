using System;
using System.Web.UI;

public partial class SiteMaster : MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SetNavigationVisibility();
        }
    }

    /// <summary>
    /// Set navigation visibility based on user login status and role
    /// </summary>
    private void SetNavigationVisibility()
    {
        if (AuthManager.IsLoggedIn())
        {
            // User is logged in
            phLoggedOut.Visible = false;
            phLoggedIn.Visible = true;

            // Set user info
            litUserName.Text = AuthManager.GetCurrentUserName();
            litUserEmail.Text = AuthManager.GetCurrentUserEmail();

            // Check if admin
            if (AuthManager.IsAdmin())
            {
                phAdmin.Visible = true;
                phUser.Visible = false;
            }
            else
            {
                phAdmin.Visible = false;
                phUser.Visible = true;
            }
        }
        else
        {
            // User is not logged in
            phLoggedOut.Visible = true;
            phLoggedIn.Visible = false;
        }
    }

    /// <summary>
    /// Logout button click event
    /// </summary>
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        AuthManager.Logout();
        Response.Redirect("~/Default.aspx");
    }
}
