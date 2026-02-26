using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Database Helper Class
/// Provides reusable methods for database operations
/// </summary>
public class DBHelper
{
    // Get connection string from Web.config
    private static string connectionString = ConfigurationManager.ConnectionStrings["QuizDBConnection"].ConnectionString;

    /// <summary>
    /// Get SQL Connection
    /// </summary>
    /// <returns>SqlConnection object</returns>
    public static SqlConnection GetConnection()
    {
        return new SqlConnection(connectionString);
    }

    /// <summary>
    /// Execute SELECT query and return DataTable
    /// </summary>
    /// <param name="query">SQL SELECT query</param>
    /// <returns>DataTable with results</returns>
    public static DataTable ExecuteQuery(string query)
    {
        DataTable dt = new DataTable();
        
        try
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        conn.Open();
                        adapter.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Error executing query: " + ex.Message);
        }

        return dt;
    }

    /// <summary>
    /// Execute SELECT query with parameters and return DataTable
    /// </summary>
    /// <param name="query">SQL SELECT query with parameters</param>
    /// <param name="parameters">SQL parameters</param>
    /// <returns>DataTable with results</returns>
    public static DataTable ExecuteQuery(string query, SqlParameter[] parameters)
    {
        DataTable dt = new DataTable();

        try
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        conn.Open();
                        adapter.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Error executing query: " + ex.Message);
        }

        return dt;
    }

    /// <summary>
    /// Execute INSERT, UPDATE, DELETE queries
    /// </summary>
    /// <param name="query">SQL query</param>
    /// <returns>Number of rows affected</returns>
    public static int ExecuteNonQuery(string query)
    {
        int rowsAffected = 0;

        try
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();
                }
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Error executing non-query: " + ex.Message);
        }

        return rowsAffected;
    }

    /// <summary>
    /// Execute INSERT, UPDATE, DELETE queries with parameters
    /// </summary>
    /// <param name="query">SQL query with parameters</param>
    /// <param name="parameters">SQL parameters</param>
    /// <returns>Number of rows affected</returns>
    public static int ExecuteNonQuery(string query, SqlParameter[] parameters)
    {
        int rowsAffected = 0;

        try
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();
                }
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Error executing non-query: " + ex.Message);
        }

        return rowsAffected;
    }

    /// <summary>
    /// Execute scalar query (returns single value)
    /// </summary>
    /// <param name="query">SQL query</param>
    /// <returns>Single value result</returns>
    public static object ExecuteScalar(string query)
    {
        object result = null;

        try
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    result = cmd.ExecuteScalar();
                }
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Error executing scalar query: " + ex.Message);
        }

        return result;
    }

    /// <summary>
    /// Execute scalar query with parameters (returns single value)
    /// </summary>
    /// <param name="query">SQL query with parameters</param>
    /// <param name="parameters">SQL parameters</param>
    /// <returns>Single value result</returns>
    public static object ExecuteScalar(string query, SqlParameter[] parameters)
    {
        object result = null;

        try
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    conn.Open();
                    result = cmd.ExecuteScalar();
                }
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Error executing scalar query: " + ex.Message);
        }

        return result;
    }

    /// <summary>
    /// Test database connection
    /// </summary>
    /// <returns>True if connection successful</returns>
    public static bool TestConnection()
    {
        try
        {
            using (SqlConnection conn = GetConnection())
            {
                conn.Open();
                return true;
            }
        }
        catch
        {
            return false;
        }
    }

    /// <summary>
    /// Get DataReader for efficient data reading
    /// </summary>
    /// <param name="query">SQL query</param>
    /// <returns>SqlDataReader</returns>
    public static SqlDataReader ExecuteReader(string query)
    {
        SqlConnection conn = GetConnection();
        SqlCommand cmd = new SqlCommand(query, conn);
        
        try
        {
            conn.Open();
            return cmd.ExecuteReader(CommandBehavior.CloseConnection);
        }
        catch (Exception ex)
        {
            conn.Close();
            throw new Exception("Error executing reader: " + ex.Message);
        }
    }

    /// <summary>
    /// Get DataReader with parameters
    /// </summary>
    /// <param name="query">SQL query with parameters</param>
    /// <param name="parameters">SQL parameters</param>
    /// <returns>SqlDataReader</returns>
    public static SqlDataReader ExecuteReader(string query, SqlParameter[] parameters)
    {
        SqlConnection conn = GetConnection();
        SqlCommand cmd = new SqlCommand(query, conn);

        if (parameters != null)
        {
            cmd.Parameters.AddRange(parameters);
        }

        try
        {
            conn.Open();
            return cmd.ExecuteReader(CommandBehavior.CloseConnection);
        }
        catch (Exception ex)
        {
            conn.Close();
            throw new Exception("Error executing reader: " + ex.Message);
        }
    }
}
