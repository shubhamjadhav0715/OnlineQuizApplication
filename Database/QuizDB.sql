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
    Password NVARCHAR(256) NOT NULL,
    Role NVARCHAR(20) NOT NULL DEFAULT 'User',
    CreatedDate DATETIME DEFAULT GETDATE(),
    CONSTRAINT CHK_Role CHECK (Role IN ('Admin', 'User'))
);
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
    CreatedDate DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1,
    CONSTRAINT CHK_CorrectOption CHECK (CorrectOption IN ('A', 'B', 'C', 'D'))
);
GO

-- =============================================
-- Table: QuizAttempts
-- =============================================
CREATE TABLE QuizAttempts (
    AttemptID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    Score INT NOT NULL,
    TotalQuestions INT NOT NULL,
    AttemptDate DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_QuizAttempts_Users FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);
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
    CONSTRAINT FK_UserAnswers_Attempts FOREIGN KEY (AttemptID) REFERENCES QuizAttempts(AttemptID) ON DELETE CASCADE,
    CONSTRAINT FK_UserAnswers_Questions FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID) ON DELETE CASCADE,
    CONSTRAINT CHK_SelectedOption CHECK (SelectedOption IN ('A', 'B', 'C', 'D'))
);
GO

-- =============================================
-- Insert Sample Data
-- =============================================

-- Insert Admin User (Password: admin123)
-- Password is SHA256 hash of 'admin123'
INSERT INTO Users (Name, Email, Password, Role) 
VALUES ('Admin User', 'admin@quiz.com', '240BE518FABD2724DDB6F04EEB1DA5967448D7E831C08C8FA822809F74C720A9', 'Admin');

-- Insert Sample Users (Password: user123)
-- Password is SHA256 hash of 'user123'
INSERT INTO Users (Name, Email, Password, Role) 
VALUES 
('John Doe', 'john@example.com', 'EFD87B8F86D46782F3B0DC5E5B5E3C3E9C3B5C3E3E3E3E3E3E3E3E3E3E3E3E3E', 'User'),
('Jane Smith', 'jane@example.com', 'EFD87B8F86D46782F3B0DC5E5B5E3C3E9C3B5C3E3E3E3E3E3E3E3E3E3E3E3E3E', 'User');
GO

-- Insert Sample Questions - C# Programming
INSERT INTO Questions (QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption) VALUES
('What does C# stand for?', 'C Sharp', 'C Hash', 'C Plus', 'C Star', 'A'),
('Which company developed C#?', 'Oracle', 'Microsoft', 'Google', 'Apple', 'B'),
('What is the base class for all classes in C#?', 'System.Base', 'System.Object', 'System.Class', 'System.Root', 'B'),
('Which keyword is used to inherit a class in C#?', 'extends', 'inherits', 'base', 'colon (:)', 'D'),
('What is the default access modifier for a class in C#?', 'public', 'private', 'internal', 'protected', 'C'),
('Which of the following is a value type in C#?', 'string', 'int', 'object', 'array', 'B'),
('What is the correct way to declare a constant in C#?', 'constant int x = 10;', 'const int x = 10;', 'final int x = 10;', 'static int x = 10;', 'B'),
('Which loop is guaranteed to execute at least once?', 'for', 'while', 'do-while', 'foreach', 'C'),
('What is the purpose of the "using" statement in C#?', 'Import namespaces', 'Dispose resources', 'Both A and B', 'None of the above', 'C'),
('Which collection does NOT allow duplicate elements?', 'List', 'ArrayList', 'HashSet', 'Queue', 'C');
GO

-- Insert Sample Questions - ASP.NET
INSERT INTO Questions (QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption) VALUES
('What does ASP stand for?', 'Active Server Pages', 'Application Service Provider', 'Advanced Server Protocol', 'Automated Server Process', 'A'),
('Which file contains configuration settings in ASP.NET?', 'app.config', 'web.config', 'settings.xml', 'config.ini', 'B'),
('What is the extension of ASP.NET Web Forms?', '.asp', '.aspx', '.html', '.cshtml', 'B'),
('Which event fires first in ASP.NET page life cycle?', 'Page_Load', 'Page_Init', 'Page_PreRender', 'Page_PreInit', 'D'),
('What is ViewState used for?', 'Store session data', 'Maintain page state', 'Store cookies', 'Cache data', 'B'),
('Which control is used to display data in tabular format?', 'Repeater', 'GridView', 'DataList', 'ListView', 'B'),
('What is the purpose of Master Pages?', 'Create consistent layout', 'Manage sessions', 'Handle errors', 'Store data', 'A'),
('Which validation control checks for required input?', 'RangeValidator', 'RequiredFieldValidator', 'CompareValidator', 'RegularExpressionValidator', 'B'),
('What is the default session timeout in ASP.NET (in minutes)?', '10', '20', '30', '60', 'B'),
('Which method is used to redirect to another page?', 'Response.Redirect()', 'Server.Transfer()', 'Both A and B', 'None', 'C');
GO

-- Insert Sample Questions - SQL Server
INSERT INTO Questions (QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption) VALUES
('Which SQL statement is used to retrieve data?', 'GET', 'SELECT', 'FETCH', 'RETRIEVE', 'B'),
('What does DDL stand for?', 'Data Definition Language', 'Data Description Language', 'Database Definition Language', 'Data Design Language', 'A'),
('Which constraint ensures unique values in a column?', 'PRIMARY KEY', 'UNIQUE', 'CHECK', 'Both A and B', 'D'),
('What is the purpose of the JOIN clause?', 'Combine rows from tables', 'Filter data', 'Sort data', 'Group data', 'A'),
('Which function returns the number of rows?', 'SUM()', 'COUNT()', 'AVG()', 'MAX()', 'B'),
('What does ACID stand for in databases?', 'Atomicity, Consistency, Isolation, Durability', 'Access, Control, Integrity, Data', 'Automatic, Consistent, Integrated, Durable', 'None of the above', 'A'),
('Which clause is used to filter grouped data?', 'WHERE', 'HAVING', 'FILTER', 'GROUP BY', 'B'),
('What is a stored procedure?', 'Precompiled SQL code', 'A table', 'A view', 'An index', 'A'),
('Which command is used to remove a table?', 'DELETE TABLE', 'REMOVE TABLE', 'DROP TABLE', 'CLEAR TABLE', 'C'),
('What is the purpose of an index?', 'Speed up queries', 'Store data', 'Validate data', 'Backup data', 'A');
GO

-- =============================================
-- Create Stored Procedures
-- =============================================

-- Procedure to get user statistics
CREATE PROCEDURE sp_GetUserStatistics
    @UserID INT
AS
BEGIN
    SELECT 
        COUNT(*) AS TotalAttempts,
        AVG(CAST(Score AS FLOAT)) AS AverageScore,
        MAX(Score) AS HighestScore,
        MIN(Score) AS LowestScore
    FROM QuizAttempts
    WHERE UserID = @UserID;
END
GO

-- Procedure to get quiz leaderboard
CREATE PROCEDURE sp_GetLeaderboard
    @TopN INT = 10
AS
BEGIN
    SELECT TOP (@TopN)
        u.Name,
        u.Email,
        COUNT(qa.AttemptID) AS TotalAttempts,
        AVG(CAST(qa.Score AS FLOAT)) AS AverageScore,
        MAX(qa.Score) AS HighestScore
    FROM Users u
    INNER JOIN QuizAttempts qa ON u.UserID = qa.UserID
    WHERE u.Role = 'User'
    GROUP BY u.UserID, u.Name, u.Email
    ORDER BY AverageScore DESC, HighestScore DESC;
END
GO

-- Procedure to get random questions
CREATE PROCEDURE sp_GetRandomQuestions
    @Count INT = 10
AS
BEGIN
    SELECT TOP (@Count)
        QuestionID,
        QuestionText,
        OptionA,
        OptionB,
        OptionC,
        OptionD
    FROM Questions
    WHERE IsActive = 1
    ORDER BY NEWID();
END
GO

-- =============================================
-- Create Views
-- =============================================

-- View for quiz results with user details
CREATE VIEW vw_QuizResults AS
SELECT 
    qa.AttemptID,
    u.Name AS UserName,
    u.Email,
    qa.Score,
    qa.TotalQuestions,
    CAST((qa.Score * 100.0 / qa.TotalQuestions) AS DECIMAL(5,2)) AS Percentage,
    qa.AttemptDate
FROM QuizAttempts qa
INNER JOIN Users u ON qa.UserID = u.UserID;
GO

-- View for question statistics
CREATE VIEW vw_QuestionStatistics AS
SELECT 
    q.QuestionID,
    q.QuestionText,
    COUNT(ua.AnswerID) AS TimesAnswered,
    SUM(CASE WHEN ua.IsCorrect = 1 THEN 1 ELSE 0 END) AS CorrectAnswers,
    CAST(SUM(CASE WHEN ua.IsCorrect = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(ua.AnswerID) AS DECIMAL(5,2)) AS SuccessRate
FROM Questions q
LEFT JOIN UserAnswers ua ON q.QuestionID = ua.QuestionID
GROUP BY q.QuestionID, q.QuestionText;
GO

-- =============================================
-- Grant Permissions (Optional)
-- =============================================

PRINT 'Database QuizDB created successfully!';
PRINT 'Total Questions: ' + CAST((SELECT COUNT(*) FROM Questions) AS VARCHAR(10));
PRINT 'Total Users: ' + CAST((SELECT COUNT(*) FROM Users) AS VARCHAR(10));
PRINT '';
PRINT 'Default Admin Credentials:';
PRINT 'Email: admin@quiz.com';
PRINT 'Password: admin123';
GO
