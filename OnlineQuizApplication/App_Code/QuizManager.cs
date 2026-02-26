using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;

/// <summary>
/// Quiz Manager Class
/// Handles all quiz-related operations
/// </summary>
public class QuizManager
{
    /// <summary>
    /// Get random questions for quiz
    /// </summary>
    /// <param name="count">Number of questions to retrieve</param>
    /// <returns>DataTable with questions</returns>
    public static DataTable GetRandomQuestions(int count = 10)
    {
        try
        {
            string query = @"SELECT TOP (@Count) QuestionID, QuestionText, OptionA, OptionB, OptionC, OptionD 
                           FROM Questions 
                           WHERE IsActive = 1 
                           ORDER BY NEWID()";
            
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Count", count)
            };

            return DBHelper.ExecuteQuery(query, parameters);
        }
        catch (Exception ex)
        {
            throw new Exception("Error loading questions: " + ex.Message);
        }
    }

    /// <summary>
    /// Get all questions
    /// </summary>
    /// <returns>DataTable with all questions</returns>
    public static DataTable GetAllQuestions()
    {
        try
        {
            string query = "SELECT * FROM Questions ORDER BY QuestionID DESC";
            return DBHelper.ExecuteQuery(query);
        }
        catch (Exception ex)
        {
            throw new Exception("Error loading questions: " + ex.Message);
        }
    }

    /// <summary>
    /// Get question by ID
    /// </summary>
    /// <param name="questionID">Question ID</param>
    /// <returns>DataRow with question details</returns>
    public static DataRow GetQuestionByID(int questionID)
    {
        try
        {
            string query = "SELECT * FROM Questions WHERE QuestionID = @QuestionID";
            
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@QuestionID", questionID)
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
            throw new Exception("Error getting question: " + ex.Message);
        }
    }

    /// <summary>
    /// Add new question
    /// </summary>
    /// <param name="questionText">Question text</param>
    /// <param name="optionA">Option A</param>
    /// <param name="optionB">Option B</param>
    /// <param name="optionC">Option C</param>
    /// <param name="optionD">Option D</param>
    /// <param name="correctOption">Correct option (A/B/C/D)</param>
    /// <returns>True if question added successfully</returns>
    public static bool AddQuestion(string questionText, string optionA, string optionB, 
                                   string optionC, string optionD, string correctOption)
    {
        try
        {
            string query = @"INSERT INTO Questions (QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption) 
                           VALUES (@QuestionText, @OptionA, @OptionB, @OptionC, @OptionD, @CorrectOption)";
            
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@QuestionText", questionText),
                new SqlParameter("@OptionA", optionA),
                new SqlParameter("@OptionB", optionB),
                new SqlParameter("@OptionC", optionC),
                new SqlParameter("@OptionD", optionD),
                new SqlParameter("@CorrectOption", correctOption)
            };

            int rowsAffected = DBHelper.ExecuteNonQuery(query, parameters);
            return rowsAffected > 0;
        }
        catch (Exception ex)
        {
            throw new Exception("Error adding question: " + ex.Message);
        }
    }

    /// <summary>
    /// Update existing question
    /// </summary>
    /// <param name="questionID">Question ID</param>
    /// <param name="questionText">Question text</param>
    /// <param name="optionA">Option A</param>
    /// <param name="optionB">Option B</param>
    /// <param name="optionC">Option C</param>
    /// <param name="optionD">Option D</param>
    /// <param name="correctOption">Correct option (A/B/C/D)</param>
    /// <returns>True if question updated successfully</returns>
    public static bool UpdateQuestion(int questionID, string questionText, string optionA, 
                                     string optionB, string optionC, string optionD, string correctOption)
    {
        try
        {
            string query = @"UPDATE Questions 
                           SET QuestionText = @QuestionText, 
                               OptionA = @OptionA, 
                               OptionB = @OptionB, 
                               OptionC = @OptionC, 
                               OptionD = @OptionD, 
                               CorrectOption = @CorrectOption 
                           WHERE QuestionID = @QuestionID";
            
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@QuestionID", questionID),
                new SqlParameter("@QuestionText", questionText),
                new SqlParameter("@OptionA", optionA),
                new SqlParameter("@OptionB", optionB),
                new SqlParameter("@OptionC", optionC),
                new SqlParameter("@OptionD", optionD),
                new SqlParameter("@CorrectOption", correctOption)
            };

            int rowsAffected = DBHelper.ExecuteNonQuery(query, parameters);
            return rowsAffected > 0;
        }
        catch (Exception ex)
        {
            throw new Exception("Error updating question: " + ex.Message);
        }
    }

    /// <summary>
    /// Delete question
    /// </summary>
    /// <param name="questionID">Question ID</param>
    /// <returns>True if question deleted successfully</returns>
    public static bool DeleteQuestion(int questionID)
    {
        try
        {
            string query = "DELETE FROM Questions WHERE QuestionID = @QuestionID";
            
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@QuestionID", questionID)
            };

            int rowsAffected = DBHelper.ExecuteNonQuery(query, parameters);
            return rowsAffected > 0;
        }
        catch (Exception ex)
        {
            throw new Exception("Error deleting question: " + ex.Message);
        }
    }

    /// <summary>
    /// Save quiz attempt and calculate score
    /// </summary>
    /// <param name="userID">User ID</param>
    /// <param name="answers">Dictionary of QuestionID and SelectedOption</param>
    /// <returns>AttemptID</returns>
    public static int SaveQuizAttempt(int userID, Dictionary<int, string> answers)
    {
        try
        {
            int score = 0;
            int totalQuestions = answers.Count;

            // Calculate score
            foreach (var answer in answers)
            {
                int questionID = answer.Key;
                string selectedOption = answer.Value;

                // Get correct answer
                string correctOption = GetCorrectOption(questionID);

                if (selectedOption == correctOption)
                {
                    score++;
                }
            }

            // Insert quiz attempt
            string insertAttemptQuery = @"INSERT INTO QuizAttempts (UserID, Score, TotalQuestions) 
                                        VALUES (@UserID, @Score, @TotalQuestions);
                                        SELECT SCOPE_IDENTITY();";
            
            SqlParameter[] attemptParams = new SqlParameter[]
            {
                new SqlParameter("@UserID", userID),
                new SqlParameter("@Score", score),
                new SqlParameter("@TotalQuestions", totalQuestions)
            };

            int attemptID = Convert.ToInt32(DBHelper.ExecuteScalar(insertAttemptQuery, attemptParams));

            // Insert user answers
            foreach (var answer in answers)
            {
                int questionID = answer.Key;
                string selectedOption = answer.Value;
                string correctOption = GetCorrectOption(questionID);
                bool isCorrect = selectedOption == correctOption;

                string insertAnswerQuery = @"INSERT INTO UserAnswers (AttemptID, QuestionID, SelectedOption, IsCorrect) 
                                           VALUES (@AttemptID, @QuestionID, @SelectedOption, @IsCorrect)";
                
                SqlParameter[] answerParams = new SqlParameter[]
                {
                    new SqlParameter("@AttemptID", attemptID),
                    new SqlParameter("@QuestionID", questionID),
                    new SqlParameter("@SelectedOption", selectedOption),
                    new SqlParameter("@IsCorrect", isCorrect)
                };

                DBHelper.ExecuteNonQuery(insertAnswerQuery, answerParams);
            }

            return attemptID;
        }
        catch (Exception ex)
        {
            throw new Exception("Error saving quiz attempt: " + ex.Message);
        }
    }

    /// <summary>
    /// Get correct option for a question
    /// </summary>
    /// <param name="questionID">Question ID</param>
    /// <returns>Correct option (A/B/C/D)</returns>
    private static string GetCorrectOption(int questionID)
    {
        try
        {
            string query = "SELECT CorrectOption FROM Questions WHERE QuestionID = @QuestionID";
            
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@QuestionID", questionID)
            };

            object result = DBHelper.ExecuteScalar(query, parameters);
            return result?.ToString() ?? "";
        }
        catch (Exception ex)
        {
            throw new Exception("Error getting correct option: " + ex.Message);
        }
    }

    /// <summary>
    /// Get quiz attempt details
    /// </summary>
    /// <param name="attemptID">Attempt ID</param>
    /// <returns>DataRow with attempt details</returns>
    public static DataRow GetAttemptDetails(int attemptID)
    {
        try
        {
            string query = "SELECT * FROM QuizAttempts WHERE AttemptID = @AttemptID";
            
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@AttemptID", attemptID)
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
            throw new Exception("Error getting attempt details: " + ex.Message);
        }
    }

    /// <summary>
    /// Get user's quiz history
    /// </summary>
    /// <param name="userID">User ID</param>
    /// <returns>DataTable with quiz history</returns>
    public static DataTable GetUserQuizHistory(int userID)
    {
        try
        {
            string query = @"SELECT AttemptID, Score, TotalQuestions, 
                           CAST((Score * 100.0 / TotalQuestions) AS DECIMAL(5,2)) AS Percentage,
                           AttemptDate 
                           FROM QuizAttempts 
                           WHERE UserID = @UserID 
                           ORDER BY AttemptDate DESC";
            
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@UserID", userID)
            };

            return DBHelper.ExecuteQuery(query, parameters);
        }
        catch (Exception ex)
        {
            throw new Exception("Error getting quiz history: " + ex.Message);
        }
    }

    /// <summary>
    /// Get all quiz results (for admin)
    /// </summary>
    /// <returns>DataTable with all results</returns>
    public static DataTable GetAllQuizResults()
    {
        try
        {
            string query = @"SELECT qa.AttemptID, u.Name, u.Email, qa.Score, qa.TotalQuestions,
                           CAST((qa.Score * 100.0 / qa.TotalQuestions) AS DECIMAL(5,2)) AS Percentage,
                           qa.AttemptDate 
                           FROM QuizAttempts qa
                           INNER JOIN Users u ON qa.UserID = u.UserID
                           ORDER BY qa.AttemptDate DESC";
            
            return DBHelper.ExecuteQuery(query);
        }
        catch (Exception ex)
        {
            throw new Exception("Error getting quiz results: " + ex.Message);
        }
    }

    /// <summary>
    /// Get total questions count
    /// </summary>
    /// <returns>Total number of questions</returns>
    public static int GetTotalQuestionsCount()
    {
        try
        {
            string query = "SELECT COUNT(*) FROM Questions WHERE IsActive = 1";
            return Convert.ToInt32(DBHelper.ExecuteScalar(query));
        }
        catch (Exception ex)
        {
            throw new Exception("Error getting questions count: " + ex.Message);
        }
    }

    /// <summary>
    /// Get total users count
    /// </summary>
    /// <returns>Total number of users</returns>
    public static int GetTotalUsersCount()
    {
        try
        {
            string query = "SELECT COUNT(*) FROM Users WHERE Role = 'User'";
            return Convert.ToInt32(DBHelper.ExecuteScalar(query));
        }
        catch (Exception ex)
        {
            throw new Exception("Error getting users count: " + ex.Message);
        }
    }

    /// <summary>
    /// Get total quiz attempts count
    /// </summary>
    /// <returns>Total number of attempts</returns>
    public static int GetTotalAttemptsCount()
    {
        try
        {
            string query = "SELECT COUNT(*) FROM QuizAttempts";
            return Convert.ToInt32(DBHelper.ExecuteScalar(query));
        }
        catch (Exception ex)
        {
            throw new Exception("Error getting attempts count: " + ex.Message);
        }
    }
}
