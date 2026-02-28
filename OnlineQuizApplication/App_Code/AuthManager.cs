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
    // PBKDF2 configuration for secure password hashing
    private const int SaltSize = 16; // 128 bits
    private const int HashSize = 20; // 160 bits
    private const int Iterations = 10000; // PBKDF2 iterations

    /// <summary>
    /// Hash password using PBKDF2 with salt (secure method)
    /// </summary>
    /// <param name="password">Plain text password</param>
    /// <returns>Hashed password with salt (format: iterations:salt:hash)</returns>
    public static string HashPassword(string password)
    {
        // Generate random salt
        byte[] salt;
        new RNGCryptoServiceProvider().GetBytes(salt = new byte[SaltSize]);

        // Hash password with salt using PBKDF2
        var pbkdf2 = new Rfc2898DeriveBytes(password, salt, Iterations);
        byte[] hash = pbkdf2.GetBytes(HashSize);

        // Combine salt and hash
        byte[] hashBytes = new byte[SaltSize + HashSize];
        Array.Copy(salt, 0, hashBytes, 0, SaltSize);
        Array.Copy(hash, 0, hashBytes, SaltSize, HashSize);

        // Convert to base64 string with iterations prefix
        string base64Hash = Convert.ToBase64String(hashBytes);
        return $"{Iterations}:{base64Hash}";
    }

    /// <summary>
    /// Verify password against stored hash
    /// </summary>
    /// <param name="password">Plain text password to verify</param>
    /// <param name="hashedPassword">Stored hashed password</param>
    /// <returns>True if password matches</returns>
    public static bool VerifyPassword(string password, string hashedPassword)
    {
        try
        {
            // Check if it's old SHA256 hash (for backward compatibility)
            if (!hashedPassword.Contains(":"))
            {
                // Old SHA256 hash - verify using old method
                return hashedPassword == HashPasswordSHA256(password);
            }

            // Extract iteration count and base64 hash
            string[] parts = hashedPassword.Split(':');
            int iterations = int.Parse(parts[0]);
            string base64Hash = parts[1];

            // Get hash bytes
            byte[] hashBytes = Convert.FromBase64String(base64Hash);

            // Extract salt
            byte[] salt = new byte[SaltSize];
            Array.Copy(hashBytes, 0, salt, 0, SaltSize);

            // Compute hash of provided password
            var pbkdf2 = new Rfc2898DeriveBytes(password, salt, iterations);
            byte[] hash = pbkdf2.GetBytes(HashSize);

            // Compare hashes
            for (int i = 0; i < HashSize; i++)
            {
                if (hashBytes[i + SaltSize] != hash[i])
                {
                    return false;
                }
            }

            return true;
        }
        catch
        {
            return false;
        }
    }

    /// <summary>
    /// Legacy SHA256 hash method (for backward compatibility only)
    /// DO NOT USE for new passwords - use HashPassword() instead
    /// </summary>
    /// <param name="password">Plain text password</param>
    /// <returns>SHA256 hashed password</returns>
    [Obsolete("Use HashPassword() instead for better security")]
    private static string HashPasswordSHA256(string password)
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
            string query = "SELECT Password FROM Users WHERE Email = @Email";
            
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Email", email)
            };

            object result = DBHelper.ExecuteScalar(query, parameters);
            
            if (result != null)
            {
                string storedHash = result.ToString();
                return VerifyPassword(password, storedHash);
            }
            
            return false;
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
                HttpContext.Current.Session["LoginTime"] = DateTime.Now;
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
    /// Logout current user
    /// </summary>
    public static void Logout()
    {
        HttpContext.Current.Session.Clear();
        HttpContext.Current.Session.Abandon();
    }

    /// <summary>
    /// Require user to be logged in (redirect to login if not)
    /// </summary>
    public static void RequireLogin()
    {
        if (!IsLoggedIn())
        {
            HttpContext.Current.Response.Redirect("~/User/Login.aspx");
        }
    }

    /// <summary>
    /// Require admin access (redirect if not admin)
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
    /// Check if session has expired (20 minutes of inactivity)
    /// </summary>
    /// <returns>True if session expired</returns>
    public static bool IsSessionExpired()
    {
        if (HttpContext.Current.Session["LoginTime"] != null)
        {
            DateTime loginTime = (DateTime)HttpContext.Current.Session["LoginTime"];
            TimeSpan elapsed = DateTime.Now - loginTime;
            
            // Session timeout: 20 minutes
            if (elapsed.TotalMinutes > 20)
            {
                Logout();
                return true;
            }
        }
        return false;
    }

    /// <summary>
    /// Refresh session timeout
    /// </summary>
    public static void RefreshSession()
    {
        if (IsLoggedIn())
        {
            HttpContext.Current.Session["LoginTime"] = DateTime.Now;
        }
    }
}
