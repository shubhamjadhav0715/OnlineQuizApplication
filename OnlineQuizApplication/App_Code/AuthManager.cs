using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web;

/// <summary>
/// Authentication Manager Class
/// Handles user authentication, authorization, and session management
/// </summary>
public class AuthManager
{
    /// <summary>
    /// Hash password using SHA256
    /// </summary>
    /// <param name="password">Plain text password</param>
    /// <returns>Hashed password</returns>
    public static string HashPassword(string password)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
            StringBuilder builder = new StringBuilder();
            
            for (int i = 0; i < bytes.Length; i++)
            {
                builder.Append(bytes[i].ToString("X2"));
            }
            
            return builder.ToString();
        }
    }

    /// <summary>
    /// Validate user login credentials
    /// </summary>
    /// <param name="email">User email</param>
    /// <param name="password">User password</param>
    /// <returns>True if credentials are valid</returns>
    public static bool ValidateLogin(string email, string password)
    {
        try
        {
            string hashedPassword = HashPassword(password);
            
            string query = "SELECT COUNT(*) FROM Users WHERE Email = @Email AND Password = @Password";
            
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Email", email),
                new SqlParameter("@Password", hashedPassword)
            };

            int count = Convert.ToInt32(DBHelper.ExecuteScalar(query, parameters));
            
            return count > 0;
        }
        catch (Exception ex)
        {
            throw new Exception("Login validation error: " + ex.Message);
        }
    }

    /// <summary>
    /// Get user details by email
    /// </summary>
    /// <param name="email">User email</param>
    /// <returns>DataRow with user details</returns>
    public static DataRow GetUserByEmail(string email)
    {
        try
        {
            string query = "SELECT UserID, Name, Email, Role FROM Users WHERE Email = @Email";
            
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Email", email)
            };

            DataTable dt = DBHelper.ExecuteQuery(query, parameters);
            
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0];
            }
            
            return null;
        }
        catch (Exception ex)
        {
            throw new Exception("Error getting user: " + ex.Message);
        }
    }

    /// <summary>
    /// Register new user
    /// </summary>
    /// <param name="name">User name</param>
    /// <param name="email">User email</param>
    /// <param name="password">User password</param>
    /// <returns>True if registration successful</returns>
    public static bool RegisterUser(string name, string email, string password)
    {
        try
        {
            // Check if email already exists
            if (EmailExists(email))
            {
                return false;
            }

            string hashedPassword = HashPassword(password);
            
            string query = "INSERT INTO Users (Name, Email, Password, Role) VALUES (@Name, @Email, @Password, 'User')";
            
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Name", name),
                new SqlParameter("@Email", email),
                new SqlParameter("@Password", hashedPassword)
            };

            int rowsAffected = DBHelper.ExecuteNonQuery(query, parameters);
            
            return rowsAffected > 0;
        }
        catch (Exception ex)
        {
            throw new Exception("Registration error: " + ex.Message);
        }
    }

    /// <summary>
    /// Check if email already exists
    /// </summary>
    /// <param name="email">Email to check</param>
    /// <returns>True if email exists</returns>
    public static bool EmailExists(string email)
    {
        try
        {
            string query = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
            
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Email", email)
            };

            int count = Convert.ToInt32(DBHelper.ExecuteScalar(query, parameters));
            
            return count > 0;
        }
        catch (Exception ex)
        {
            throw new Exception("Error checking email: " + ex.Message);
        }
    }

    /// <summary>
    /// Create user session after successful login
    /// </summary>
    /// <param name="email">User email</param>
    public static void CreateSession(string email)
    {
        try
        {
            DataRow user = GetUserByEmail(email);
            
            if (user != null)
            {
                HttpContext.Current.Session["UserID"] = user["UserID"].ToString();
                HttpContext.Current.Session["UserName"] = user["Name"].ToString();
                HttpContext.Current.Session["UserEmail"] = user["Email"].ToString();
                HttpContext.Current.Session["UserRole"] = user["Role"].ToString();
                HttpContext.Current.Session["IsLoggedIn"] = true;
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Session creation error: " + ex.Message);
        }
    }

    /// <summary>
    /// Check if user is logged in
    /// </summary>
    /// <returns>True if user is logged in</returns>
    public static bool IsLoggedIn()
    {
        return HttpContext.Current.Session["IsLoggedIn"] != null && 
               (bool)HttpContext.Current.Session["IsLoggedIn"];
    }

    /// <summary>
    /// Check if current user is admin
    /// </summary>
    /// <returns>True if user is admin</returns>
    public static bool IsAdmin()
    {
        if (IsLoggedIn())
        {
            string role = HttpContext.Current.Session["UserRole"]?.ToString();
            return role == "Admin";
        }
        return false;
    }

    /// <summary>
    /// Get current user ID
    /// </summary>
    /// <returns>User ID or 0 if not logged in</returns>
    public static int GetCurrentUserID()
    {
        if (IsLoggedIn())
        {
            return Convert.ToInt32(HttpContext.Current.Session["UserID"]);
        }
        return 0;
    }

    /// <summary>
    /// Get current user name
    /// </summary>
    /// <returns>User name or empty string</returns>
    public static string GetCurrentUserName()
    {
        if (IsLoggedIn())
        {
            return HttpContext.Current.Session["UserName"]?.ToString() ?? "";
        }
        return "";
    }

    /// <summary>
    /// Get current user email
    /// </summary>
    /// <returns>User email or empty string</returns>
    public static string GetCurrentUserEmail()
    {
        if (IsLoggedIn())
        {
            return HttpContext.Current.Session["UserEmail"]?.ToString() ?? "";
        }
        return "";
    }

    /// <summary>
    /// Get current user role
    /// </summary>
    /// <returns>User role or empty string</returns>
    public static string GetCurrentUserRole()
    {
        if (IsLoggedIn())
        {
            return HttpContext.Current.Session["UserRole"]?.ToString() ?? "";
        }
        return "";
    }

    /// <summary>
    /// Logout user and clear session
    /// </summary>
    public static void Logout()
    {
        HttpContext.Current.Session.Clear();
        HttpContext.Current.Session.Abandon();
    }

    /// <summary>
    /// Require login - redirect to login page if not logged in
    /// </summary>
    public static void RequireLogin()
    {
        if (!IsLoggedIn())
        {
            HttpContext.Current.Response.Redirect("~/User/Login.aspx");
        }
    }

    /// <summary>
    /// Require admin - redirect to login if not admin
    /// </summary>
    public static void RequireAdmin()
    {
        if (!IsLoggedIn())
        {
            HttpContext.Current.Response.Redirect("~/User/Login.aspx");
        }
        else if (!IsAdmin())
        {
            HttpContext.Current.Response.Redirect("~/Default.aspx");
        }
    }

    /// <summary>
    /// Change user password
    /// </summary>
    /// <param name="userID">User ID</param>
    /// <param name="newPassword">New password</param>
    /// <returns>True if password changed successfully</returns>
    public static bool ChangePassword(int userID, string newPassword)
    {
        try
        {
            string hashedPassword = HashPassword(newPassword);
            
            string query = "UPDATE Users SET Password = @Password WHERE UserID = @UserID";
            
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Password", hashedPassword),
                new SqlParameter("@UserID", userID)
            };

            int rowsAffected = DBHelper.ExecuteNonQuery(query, parameters);
            
            return rowsAffected > 0;
        }
        catch (Exception ex)
        {
            throw new Exception("Password change error: " + ex.Message);
        }
    }
}
