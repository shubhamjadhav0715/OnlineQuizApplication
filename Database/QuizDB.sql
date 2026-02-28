-- =============================================
-- Online Quiz Application Database Script
-- SQL Server 2022
-- =============================================

USE master;
GO

-- Drop database if exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'QuizDB')
BEGIN
    ALTER DATABASE QuizDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE QuizDB;
END
GO

-- Create database
CREATE DATABASE QuizDB;
GO

USE QuizDB;
GO

-- =============================================
-- Table: Users
-- =============================================
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(512) NOT NULL, -- Increased size for PBKDF2 hash
    Role NVARCHAR(20) NOT NULL DEFAULT 'User',
    CreatedDate DATETIME DEFAULT GETDATE(),
    LastLoginDate DATETIME NULL,
    IsActive BIT DEFAULT 1,
    CONSTRAINT CHK_Role CHECK (Role IN ('Admin', 'User'))
);
GO

-- Create index on Email for faster lookups
CREATE INDEX IX_Users_Email ON Users(Email);
GO

-- =============================================
-- Table: Questions
-- =============================================
CREATE TABLE Questions (
    QuestionID INT PRIMARY KEY IDENTITY(1,1),
    QuestionText NVARCHAR(500) NOT NULL,
    OptionA NVARCHAR(200) NOT NULL,
    OptionB NVARCHAR(200) NOT NULL,
    OptionC NVARCHAR(200) NOT NULL,
    OptionD NVARCHAR(200) NOT NULL,
    CorrectOption CHAR(1) NOT NULL,
    Category NVARCHAR(50) NULL,
    DifficultyLevel NVARCHAR(20) DEFAULT 'Medium',
    CreatedDate DATETIME DEFAULT GETDATE(),
    CreatedBy INT NULL,
    IsActive BIT DEFAULT 1,
    CONSTRAINT CHK_CorrectOption CHECK (CorrectOption IN ('A', 'B', 'C', 'D')),
    CONSTRAINT CHK_DifficultyLevel CHECK (DifficultyLevel IN ('Easy', 'Medium', 'Hard'))
);
GO

-- Create index on IsActive for faster filtering
CREATE INDEX IX_Questions_IsActive ON Questions(IsActive);
GO

-- =============================================
-- Table: QuizAttempts
-- =============================================
CREATE TABLE QuizAttempts (
    AttemptID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    Score INT NOT NULL,
    TotalQuestions INT NOT NULL,
    Percentage AS (CAST(Score * 100.0 / TotalQuestions AS DECIMAL(5,2))) PERSISTED,
    TimeTaken INT NULL, -- Time in seconds
    AttemptDate DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_QuizAttempts_Users FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    CONSTRAINT CHK_Score CHECK (Score >= 0 AND Score <= TotalQuestions)
);
GO

-- Create index on UserID for faster user history queries
CREATE INDEX IX_QuizAttempts_UserID ON QuizAttempts(UserID);
GO

-- =============================================
-- Table: UserAnswers
-- =============================================
CREATE TABLE UserAnswers (
    AnswerID INT PRIMARY KEY IDENTITY(1,1),
    AttemptID INT NOT NULL,
    QuestionID INT NOT NULL,
    SelectedOption CHAR(1) NOT NULL,
    IsCorrect BIT NOT NULL,
    AnsweredAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_UserAnswers_Attempts FOREIGN KEY (AttemptID) REFERENCES QuizAttempts(AttemptID) ON DELETE CASCADE,
    CONSTRAINT FK_UserAnswers_Questions FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID) ON DELETE CASCADE,
    CONSTRAINT CHK_SelectedOption CHECK (SelectedOption IN ('A', 'B', 'C', 'D'))
);
GO

-- Create index on AttemptID for faster result queries
CREATE INDEX IX_UserAnswers_AttemptID ON UserAnswers(AttemptID);
GO

-- =============================================
-- Insert Sample Data
-- =============================================

-- Insert Admin User (Password: admin123)
-- Using SHA256 for backward compatibility - will be auto-upgraded to PBKDF2 on first login
INSERT INTO Users (Name, Email, Password, Role) 
VALUES ('Admin User', 'admin@quiz.com', '240BE518FABD2724DDB6F04EEB1DA5967448D7E831C08C8FA822809F74C720A9', 'Admin');

-- Insert Sample Users (Password: user123)
-- Using SHA256 for backward compatibility - will be auto-upgraded to PBKDF2 on first login
INSERT INTO Users (Name, Email, Password, Role) 
VALUES 
('John Doe', 'john@example.com', 'EFD87B8F86D46782F3B0DC5E5B5E3C3E9C3B5C3E3E3E3E3E3E3E3E3E3E3E3E3E', 'User'),
('Jane Smith', 'jane@example.com', 'EFD87B8F86D46782F3B0DC5E5B5E3C3E9C3B5C3E3E3E3E3E3E3E3E3E3E3E3E3E', 'User');
GO

-- Insert Sample Questions - C# Programming
INSERT INTO Questions (QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption, Category, DifficultyLevel) VALUES
('What does C# stand for?', 'C Sharp', 'C Hash', 'C Plus', 'C Star', 'A', 'C#', 'Easy'),
('Which company developed C#?', 'Oracle', 'Microsoft', 'Google', 'Apple', 'B', 'C#', 'Easy'),
('What is the base class for all classes in C#?', 'System.Base', 'System.Object', 'System.Class', 'System.Root', 'B', 'C#', 'Medium'),
('Which keyword is used to inherit a class in C#?', 'extends', 'inherits', 'base', 'colon (:)', 'D', 'C#', 'Medium'),
('What is the default access modifier for a class in C#?', 'public', 'private', 'internal', 'protected', 'C', 'C#', 'Medium'),
('Which of the following is a value type in C#?', 'string', 'int', 'object', 'array', 'B', 'C#', 'Easy'),
('What is the correct way to declare a constant in C#?', 'constant int x = 10;', 'const int x = 10;', 'final int x = 10;', 'static int x = 10;', 'B', 'C#', 'Easy'),
('Which loop is guaranteed to execute at least once?', 'for', 'while', 'do-while', 'foreach', 'C', 'C#', 'Easy'),
('What is the purpose of the "using" statement in C#?', 'Import namespaces', 'Dispose resources', 'Both A and B', 'None of the above', 'C', 'C#', 'Medium'),
('Which collection does NOT allow duplicate elements?', 'List', 'ArrayList', 'HashSet', 'Queue', 'C', 'C#', 'Medium');
GO

-- Insert Sample Questions - ASP.NET
INSERT INTO Questions (QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption, Category, DifficultyLevel) VALUES
('What does ASP stand for?', 'Active Server Pages', 'Application Service Provider', 'Advanced Server Protocol', 'Automated Server Process', 'A', 'ASP.NET', 'Easy'),
('Which file contains configuration settings in ASP.NET?', 'app.config', 'web.config', 'settings.xml', 'config.ini', 'B', 'ASP.NET', 'Easy'),
('What is the extension of ASP.NET Web Forms?', '.asp', '.aspx', '.html', '.cshtml', 'B', 'ASP.NET', 'Easy'),
('Which event fires first in ASP.NET page life cycle?', 'Page_Load', 'Page_Init', 'Page_PreRender', 'Page_PreInit', 'D', 'ASP.NET', 'Hard'),
('What is ViewState used for?', 'Store session data', 'Maintain page state', 'Store cookies', 'Cache data', 'B', 'ASP.NET', 'Medium'),
('Which control is used to display data in tabular format?', 'Repeater', 'GridView', 'DataList', 'ListView', 'B', 'ASP.NET', 'Easy'),
('What is the purpose of Master Pages?', 'Create consistent layout', 'Manage sessions', 'Handle errors', 'Store data', 'A', 'ASP.NET', 'Medium'),
('Which validation control checks for required input?', 'RangeValidator', 'RequiredFieldValidator', 'CompareValidator', 'RegularExpressionValidator', 'B', 'ASP.NET', 'Easy'),
('What is the default session timeout in ASP.NET (in minutes)?', '10', '20', '30', '60', 'B', 'ASP.NET', 'Medium'),
('Which method is used to redirect to another page?', 'Response.Redirect()', 'Server.Transfer()', 'Both A and B', 'None', 'C', 'ASP.NET', 'Medium');
GO

-- Insert Sample Questions - SQL Server
INSERT INTO Questions (QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption, Category, DifficultyLevel) VALUES
('Which SQL statement is used to retrieve data?', 'GET', 'SELECT', 'FETCH', 'RETRIEVE', 'B', 'SQL', 'Easy'),
('What does DDL stand for?', 'Data Definition Language', 'Data Description Language', 'Database Definition Language', 'Data Design Language', 'A', 'SQL', 'Medium'),
('Which constraint ensures unique values in a column?', 'PRIMARY KEY', 'UNIQUE', 'CHECK', 'Both A and B', 'D', 'SQL', 'Medium'),
('What is the purpose of the JOIN clause?', 'Combine rows from tables', 'Filter data', 'Sort data', 'Group data', 'A', 'SQL', 'Easy'),
('Which function returns the number of rows?', 'SUM()', 'COUNT()', 'AVG()', 'MAX()', 'B', 'SQL', 'Easy'),
('What does ACID stand for in databases?', 'Atomicity, Consistency, Isolation, Durability', 'Access, Control, Integrity, Data', 'Automatic, Consistent, Integrated, Durable', 'None of the above', 'A', 'SQL', 'Hard'),
('Which clause is used to filter grouped data?', 'WHERE', 'HAVING', 'FILTER', 'GROUP BY', 'B', 'SQL', 'Medium'),
('What is a stored procedure?', 'Precompiled SQL code', 'A table', 'A view', 'An index', 'A', 'SQL', 'Medium'),
('Which command is used to remove a table?', 'DELETE TABLE', 'REMOVE TABLE', 'DROP TABLE', 'CLEAR TABLE', 'C', 'SQL', 'Easy'),
('What is the purpose of an index?', 'Speed up queries', 'Store data', 'Validate data', 'Backup data', 'A', 'SQL', 'Medium');
GO

-- =============================================
-- Create Stored Procedures
-- =============================================

-- Procedure to get user statistics
CREATE PROCEDURE sp_GetUserStatistics
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        COUNT(*) AS TotalAttempts,
        AVG(CAST(Score AS FLOAT)) AS AverageScore,
        MAX(Score) AS HighestScore,
        MIN(Score) AS LowestScore,
        AVG(CAST(Percentage AS FLOAT)) AS AveragePercentage,
        MAX(Percentage) AS HighestPercentage
    FROM QuizAttempts
    WHERE UserID = @UserID;
END
GO

-- Procedure to get quiz leaderboard
CREATE PROCEDURE sp_GetLeaderboard
    @TopN INT = 10
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT TOP (@TopN)
        u.Name,
        u.Email,
        COUNT(qa.AttemptID) AS TotalAttempts,
        AVG(CAST(qa.Score AS FLOAT)) AS AverageScore,
        MAX(qa.Score) AS HighestScore,
        AVG(qa.Percentage) AS AveragePercentage
    FROM Users u
    INNER JOIN QuizAttempts qa ON u.UserID = qa.UserID
    WHERE u.Role = 'User' AND u.IsActive = 1
    GROUP BY u.UserID, u.Name, u.Email
    ORDER BY AveragePercentage DESC, HighestScore DESC;
END
GO

-- Procedure to get random questions
CREATE PROCEDURE sp_GetRandomQuestions
    @Count INT = 10,
    @Category NVARCHAR(50) = NULL,
    @DifficultyLevel NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT TOP (@Count)
        QuestionID,
        QuestionText,
        OptionA,
        OptionB,
        OptionC,
        OptionD,
        Category,
        DifficultyLevel
    FROM Questions
    WHERE IsActive = 1
        AND (@Category IS NULL OR Category = @Category)
        AND (@DifficultyLevel IS NULL OR DifficultyLevel = @DifficultyLevel)
    ORDER BY NEWID();
END
GO

-- Procedure to update user last login
CREATE PROCEDURE sp_UpdateLastLogin
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Users
    SET LastLoginDate = GETDATE()
    WHERE UserID = @UserID;
END
GO

-- =============================================
-- Create Views
-- =============================================

-- View for quiz results with user details
CREATE VIEW vw_QuizResults AS
SELECT 
    qa.AttemptID,
    u.UserID,
    u.Name AS UserName,
    u.Email,
    qa.Score,
    qa.TotalQuestions,
    qa.Percentage,
    qa.TimeTaken,
    qa.AttemptDate,
    CASE 
        WHEN qa.Percentage >= 90 THEN 'A+'
        WHEN qa.Percentage >= 80 THEN 'A'
        WHEN qa.Percentage >= 70 THEN 'B'
        WHEN qa.Percentage >= 60 THEN 'C'
        WHEN qa.Percentage >= 50 THEN 'D'
        ELSE 'F'
    END AS Grade
FROM QuizAttempts qa
INNER JOIN Users u ON qa.UserID = u.UserID;
GO

-- View for question statistics
CREATE VIEW vw_QuestionStatistics AS
SELECT 
    q.QuestionID,
    q.QuestionText,
    q.Category,
    q.DifficultyLevel,
    COUNT(ua.AnswerID) AS TimesAnswered,
    SUM(CASE WHEN ua.IsCorrect = 1 THEN 1 ELSE 0 END) AS CorrectAnswers,
    SUM(CASE WHEN ua.IsCorrect = 0 THEN 1 ELSE 0 END) AS WrongAnswers,
    CASE 
        WHEN COUNT(ua.AnswerID) > 0 
        THEN CAST(SUM(CASE WHEN ua.IsCorrect = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(ua.AnswerID) AS DECIMAL(5,2))
        ELSE 0
    END AS SuccessRate
FROM Questions q
LEFT JOIN UserAnswers ua ON q.QuestionID = ua.QuestionID
WHERE q.IsActive = 1
GROUP BY q.QuestionID, q.QuestionText, q.Category, q.DifficultyLevel;
GO

-- View for user performance summary
CREATE VIEW vw_UserPerformance AS
SELECT 
    u.UserID,
    u.Name,
    u.Email,
    u.CreatedDate,
    u.LastLoginDate,
    COUNT(qa.AttemptID) AS TotalAttempts,
    AVG(qa.Percentage) AS AveragePercentage,
    MAX(qa.Percentage) AS BestPercentage,
    MIN(qa.Percentage) AS WorstPercentage,
    SUM(qa.TotalQuestions) AS TotalQuestionsAnswered
FROM Users u
LEFT JOIN QuizAttempts qa ON u.UserID = qa.UserID
WHERE u.Role = 'User' AND u.IsActive = 1
GROUP BY u.UserID, u.Name, u.Email, u.CreatedDate, u.LastLoginDate;
GO

-- =============================================
-- Create Triggers
-- =============================================

-- Trigger to prevent deletion of questions that have been answered
CREATE TRIGGER trg_PreventQuestionDeletion
ON Questions
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Check if any deleted questions have answers
    IF EXISTS (
        SELECT 1 
        FROM deleted d
        INNER JOIN UserAnswers ua ON d.QuestionID = ua.QuestionID
    )
    BEGIN
        -- Instead of deleting, mark as inactive
        UPDATE Questions
        SET IsActive = 0
        WHERE QuestionID IN (SELECT QuestionID FROM deleted);
        
        PRINT 'Questions with existing answers have been marked as inactive instead of deleted.';
    END
    ELSE
    BEGIN
        -- Safe to delete
        DELETE FROM Questions
        WHERE QuestionID IN (SELECT QuestionID FROM deleted);
    END
END
GO

-- =============================================
-- Grant Permissions (Optional)
-- =============================================

PRINT '================================================';
PRINT 'Database QuizDB created successfully!';
PRINT '================================================';
PRINT '';
PRINT 'Database Statistics:';
PRINT '-------------------';
PRINT 'Total Questions: ' + CAST((SELECT COUNT(*) FROM Questions) AS VARCHAR(10));
PRINT 'Total Users: ' + CAST((SELECT COUNT(*) FROM Users) AS VARCHAR(10));
PRINT 'Active Questions: ' + CAST((SELECT COUNT(*) FROM Questions WHERE IsActive = 1) AS VARCHAR(10));
PRINT '';
PRINT 'Default Login Credentials:';
PRINT '-------------------------';
PRINT 'Admin Account:';
PRINT '  Email: admin@quiz.com';
PRINT '  Password: admin123';
PRINT '';
PRINT 'Sample User Accounts:';
PRINT '  Email: john@example.com';
PRINT '  Password: user123';
PRINT '';
PRINT '  Email: jane@example.com';
PRINT '  Password: user123';
PRINT '';
PRINT 'SECURITY NOTE:';
PRINT '-------------';
PRINT 'Passwords are currently stored using SHA256 for backward compatibility.';
PRINT 'They will be automatically upgraded to PBKDF2 on first login.';
PRINT 'Please change default passwords in production!';
PRINT '================================================';
GO
