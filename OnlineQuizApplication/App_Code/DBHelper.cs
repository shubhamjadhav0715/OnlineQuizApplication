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
    private static string connectionString = ConfigurationManager.ConnectionStrings["QuizDBConnection"]?.ConnectionString;

    /// <summary>
    /// Validate connection string exists
    /// </summary>
    private static void ValidateConnectionString()
    {
        if (string.IsNullOrEmpty(connectionString))
        {
            throw new Exception("Database connection string 'QuizDBConnection' not found in Web.config");
        }
    }

    /// <summary>
    /// Get SQL Connection
    /// </summary>
    /// <returns>SqlConnection object</returns>
    public static SqlConnection GetConnection()
    {
        ValidateConnectionString();
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
                    cmd.CommandTimeout = 30; // 30 seconds timeout
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        conn.Open();
                        adapter.Fill(dt);
                    }
                }
            }
        }
        catch (SqlException ex)
        {
            throw new Exception("Database error executing query: " + ex.Message);
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
                    cmd.CommandTimeout = 30; // 30 seconds timeout
                    
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
        catch (SqlException ex)
        {
            throw new Exception("Database error executing query: " + ex.Message);
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
                    cmd.CommandTimeout = 30; // 30 seconds timeout
                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();
                }
            }
        }
        catch (SqlException ex)
        {
            throw new Exception("Database error executing non-query: " + ex.Message);
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
                    cmd.CommandTimeout = 30; // 30 seconds timeout
                    
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();
                }
            }
        }
        catch (SqlException ex)
        {
            throw new Exception("Database error executing non-query: " + ex.Message);
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
                    cmd.CommandTimeout = 30; // 30 seconds timeout
                    conn.Open();
                    result = cmd.ExecuteScalar();
                }
            }
        }
        catch (SqlException ex)
        {
            throw new Exception("Database error executing scalar query: " + ex.Message);
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
                    cmd.CommandTimeout = 30; // 30 seconds timeout
                    
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    conn.Open();
                    result = cmd.ExecuteScalar();
                }
            }
        }
        catch (SqlException ex)
        {
            throw new Exception("Database error executing scalar query: " + ex.Message);
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
    /// NOTE: Caller is responsible for closing the connection
    /// </summary>
    /// <param name="query">SQL query</param>
    /// <returns>SqlDataReader</returns>
    public static SqlDataReader ExecuteReader(string query)
    {
        SqlConnection conn = null;
        SqlDataReader reader = null;
        
        try
        {
            conn = GetConnection();
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.CommandTimeout = 30; // 30 seconds timeout
            
            conn.Open();
            // CommandBehavior.CloseConnection ensures connection closes when reader is closed
            reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            return reader;
        }
        catch (Exception ex)
        {
            // Clean up connection if reader creation fails
            if (conn != null && conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            throw new Exception("Error executing reader: " + ex.Message);
        }
    }

    /// <summary>
    /// Get DataReader with parameters for efficient data reading
    /// NOTE: Caller is responsible for closing the connection
    /// </summary>
    /// <param name="query">SQL query with parameters</param>
    /// <param name="parameters">SQL parameters</param>
    /// <returns>SqlDataReader</returns>
    public static SqlDataReader ExecuteReader(string query, SqlParameter[] parameters)
    {
        SqlConnection conn = null;
        SqlDataReader reader = null;
        
        try
        {
            conn = GetConnection();
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.CommandTimeout = 30; // 30 seconds timeout
            
            if (parameters != null)
            {
                cmd.Parameters.AddRange(parameters);
            }
            
            conn.Open();
            // CommandBehavior.CloseConnection ensures connection closes when reader is closed
            reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            return reader;
        }
        catch (Exception ex)
        {
            // Clean up connection if reader creation fails
            if (conn != null && conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            throw new Exception("Error executing reader: " + ex.Message);
        }
    }

    /// <summary>
    /// Execute stored procedure with parameters
    /// </summary>
    /// <param name="procedureName">Stored procedure name</param>
    /// <param name="parameters">SQL parameters</param>
    /// <returns>DataTable with results</returns>
    public static DataTable ExecuteStoredProcedure(string procedureName, SqlParameter[] parameters = null)
    {
        DataTable dt = new DataTable();

        try
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(procedureName, conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandTimeout = 30; // 30 seconds timeout
                    
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
        catch (SqlException ex)
        {
            throw new Exception("Database error executing stored procedure: " + ex.Message);
        }
        catch (Exception ex)
        {
            throw new Exception("Error executing stored procedure: " + ex.Message);
        }

        return dt;
    }

    /// <summary>
    /// Begin a database transaction
    /// </summary>
    /// <returns>SqlTransaction object</returns>
    public static SqlTransaction BeginTransaction(out SqlConnection connection)
    {
        try
        {
            connection = GetConnection();
            connection.Open();
            return connection.BeginTransaction();
        }
        catch (Exception ex)
        {
            throw new Exception("Error beginning transaction: " + ex.Message);
        }
    }

    /// <summary>
    /// Execute query within a transaction
    /// </summary>
    /// <param name="query">SQL query</param>
    /// <param name="transaction">Active transaction</param>
    /// <param name="parameters">SQL parameters</param>
    /// <returns>Number of rows affected</returns>
    public static int ExecuteNonQueryTransaction(string query, SqlTransaction transaction, SqlParameter[] parameters = null)
    {
        try
        {
            using (SqlCommand cmd = new SqlCommand(query, transaction.Connection, transaction))
            {
                cmd.CommandTimeout = 30; // 30 seconds timeout
                
                if (parameters != null)
                {
                    cmd.Parameters.AddRange(parameters);
                }

                return cmd.ExecuteNonQuery();
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Error executing transaction query: " + ex.Message);
        }
    }
}
