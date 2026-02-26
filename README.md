# 🎓 Online Quiz Application

A complete production-ready web-based quiz application built with ASP.NET Web Forms, C#, SQL Server 2022, and Bootstrap.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
- [Database Setup](#database-setup)
- [Running the Application](#running-the-application)
- [Default Credentials](#default-credentials)
- [Project Structure](#project-structure)
- [Usage Guide](#usage-guide)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)

## 🌟 Overview

The Online Quiz Application is a comprehensive web-based platform that allows users to take quizzes and administrators to manage questions and view results. Built with ASP.NET Web Forms and SQL Server, it provides a robust, scalable solution for online assessments.

## ✨ Features

### 👨‍🎓 User Features
- ✅ User Registration & Login
- ✅ Secure Authentication with Password Hashing (SHA256)
- ✅ Take Multiple Choice Quizzes
- ✅ Instant Score Calculation
- ✅ View Quiz Results
- ✅ Quiz History Tracking
- ✅ Responsive UI with Bootstrap

### 👨‍💼 Admin Features
- ✅ Admin Dashboard with Statistics
- ✅ Add New Questions
- ✅ Edit/Delete Existing Questions
- ✅ View All Quiz Results
- ✅ User Management
- ✅ Question Management with GridView

### 🔐 Security Features
- ✅ Session-based Authentication
- ✅ Role-based Authorization (Admin/User)
- ✅ Password Hashing using SHA256
- ✅ SQL Injection Prevention
- ✅ Protected Admin Routes

## 🛠️ Technologies Used

- **Frontend:**
  - HTML5
  - CSS3
  - Bootstrap 4.5
  - JavaScript
  - jQuery

- **Backend:**
  - ASP.NET Web Forms (.NET Framework 4.7.2+)
  - C#
  - ADO.NET

- **Database:**
  - SQL Server 2022 (Compatible with 2019, 2017)

- **IDE:**
  - Visual Studio 2022

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

1. **Visual Studio 2022** (Community, Professional, or Enterprise)
   - Download: https://visualstudio.microsoft.com/downloads/
   - Workloads Required:
     - ASP.NET and web development
     - .NET desktop development

2. **SQL Server 2022** (Express, Developer, or Standard)
   - Download: https://www.microsoft.com/en-us/sql-server/sql-server-downloads
   - SQL Server Management Studio (SSMS) - Recommended
   - Download SSMS: https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms

3. **.NET Framework 4.7.2 or higher**
   - Usually included with Visual Studio 2022

## 🚀 Installation & Setup

### Step 1: Clone the Repository

```bash
git clone https://github.com/shubhamjadhav0715/OnlineQuizApplication.git
cd OnlineQuizApplication
```

### Step 2: Database Setup

#### Option A: Using SQL Server Management Studio (SSMS)

1. Open **SQL Server Management Studio (SSMS)**
2. Connect to your SQL Server instance
3. Open the file: `Database/QuizDB.sql`
4. Execute the script (Press F5 or click Execute)
5. Verify the database is created:
   ```sql
   USE QuizDB;
   SELECT * FROM Users;
   SELECT * FROM Questions;
   ```

#### Option B: Using Visual Studio

1. Open **Visual Studio 2022**
2. Go to **View** → **SQL Server Object Explorer**
3. Connect to your SQL Server instance
4. Right-click on **Databases** → **Add New Database** → Name it `QuizDB`
5. Right-click on `QuizDB` → **New Query**
6. Copy and paste the contents of `Database/QuizDB.sql`
7. Execute the query

### Step 3: Configure Connection String

1. Open the solution in Visual Studio 2022
2. Open `Web.config` file
3. Update the connection string with your SQL Server details:

```xml
<connectionStrings>
  <add name="QuizDBConnection" 
       connectionString="Data Source=YOUR_SERVER_NAME;Initial Catalog=QuizDB;Integrated Security=True" 
       providerName="System.Data.SqlClient"/>
</connectionStrings>
```

**Common Server Names:**
- Local SQL Server: `localhost` or `(local)` or `.`
- SQL Server Express: `localhost\SQLEXPRESS` or `.\SQLEXPRESS`
- Named Instance: `YOUR_COMPUTER_NAME\INSTANCE_NAME`

**Example Connection Strings:**

```xml
<!-- Windows Authentication (Recommended) -->
<add name="QuizDBConnection" 
     connectionString="Data Source=localhost;Initial Catalog=QuizDB;Integrated Security=True" 
     providerName="System.Data.SqlClient"/>

<!-- SQL Server Authentication -->
<add name="QuizDBConnection" 
     connectionString="Data Source=localhost;Initial Catalog=QuizDB;User ID=sa;Password=YourPassword" 
     providerName="System.Data.SqlClient"/>
```

### Step 4: Build the Solution

1. Open `OnlineQuizApplication.sln` in Visual Studio 2022
2. Right-click on the solution in Solution Explorer
3. Click **Restore NuGet Packages** (if prompted)
4. Click **Build** → **Build Solution** (or press Ctrl+Shift+B)
5. Ensure there are no build errors

## ▶️ Running the Application

### Method 1: Using Visual Studio

1. Open the solution in Visual Studio 2022
2. Press **F5** or click **Start Debugging** (Green Play button)
3. The application will open in your default browser
4. Default URL: `http://localhost:port/Default.aspx`

### Method 2: Using IIS Express

1. Right-click on the project in Solution Explorer
2. Select **Properties**
3. Go to **Web** tab
4. Select **IIS Express**
5. Click **Create Virtual Directory**
6. Press F5 to run

### Method 3: Deploy to IIS (Production)

1. Right-click on the project → **Publish**
2. Choose **Folder** as publish target
3. Select a folder location
4. Click **Publish**
5. Configure IIS:
   - Open IIS Manager
   - Add New Website
   - Point to published folder
   - Set Application Pool to .NET Framework v4.x
   - Browse the website

## 🔑 Default Credentials

### Admin Account
- **Email:** `admin@quiz.com`
- **Password:** `admin123`
- **Role:** Administrator

### Test User Accounts
- **Email:** `john@example.com`
- **Password:** `user123`
- **Role:** User

- **Email:** `jane@example.com`
- **Password:** `user123`
- **Role:** User

## 📁 Project Structure

```
OnlineQuizApplication/
│
├── Database/
│   └── QuizDB.sql                    # Database schema and sample data
│
├── OnlineQuizApplication/
│   │
│   ├── Admin/                        # Admin Module
│   │   ├── Dashboard.aspx            # Admin dashboard with statistics
│   │   ├── Dashboard.aspx.cs
│   │   ├── AddQuestion.aspx          # Add new questions
│   │   ├── AddQuestion.aspx.cs
│   │   ├── ManageQuestions.aspx      # Edit/Delete questions
│   │   ├── ManageQuestions.aspx.cs
│   │   ├── ViewResults.aspx          # View all quiz results
│   │   └── ViewResults.aspx.cs
│   │
│   ├── User/                         # User Module
│   │   ├── Register.aspx             # User registration
│   │   ├── Register.aspx.cs
│   │   ├── Login.aspx                # User login
│   │   ├── Login.aspx.cs
│   │   ├── Quiz.aspx                 # Take quiz
│   │   ├── Quiz.aspx.cs
│   │   ├── Result.aspx               # View quiz result
│   │   ├── Result.aspx.cs
│   │   ├── History.aspx              # Quiz history
│   │   └── History.aspx.cs
│   │
│   ├── App_Code/                     # Business Logic Layer
│   │   ├── DBHelper.cs               # Database operations
│   │   ├── AuthManager.cs            # Authentication & authorization
│   │   └── QuizManager.cs            # Quiz operations
│   │
│   ├── Styles/
│   │   └── site.css                  # Custom styles
│   │
│   ├── Scripts/
│   │   └── site.js                   # Custom JavaScript
│   │
│   ├── Web.config                    # Configuration file
│   ├── Site.Master                   # Master page layout
│   ├── Site.Master.cs
│   ├── Default.aspx                  # Home page
│   └── Default.aspx.cs
│
├── OnlineQuizApplication.sln         # Visual Studio solution file
└── README.md                         # This file
```

## 📖 Usage Guide

### For Users

1. **Registration**
   - Navigate to the home page
   - Click "Register" in the navigation bar
   - Fill in your details (Name, Email, Password)
   - Click "Register" button
   - You'll be redirected to the login page

2. **Login**
   - Enter your email and password
   - Click "Login"
   - You'll be redirected to your dashboard

3. **Taking a Quiz**
   - Click "Start Quiz" from your dashboard
   - Answer all multiple-choice questions
   - Click "Submit Quiz" when finished
   - View your instant results

4. **Viewing History**
   - Click "Quiz History" to see all your past attempts
   - View scores, dates, and percentages

### For Administrators

1. **Login**
   - Use admin credentials to login
   - Access admin dashboard

2. **Managing Questions**
   - **Add Questions:** Navigate to "Add Question" and fill in the form
   - **Edit Questions:** Go to "Manage Questions", click Edit on any question
   - **Delete Questions:** Click Delete to remove questions

3. **Viewing Results**
   - Navigate to "View Results"
   - See all user quiz attempts
   - Filter and analyze performance

## 🎨 Customization

### Changing Theme Colors

Edit `Styles/site.css`:

```css
:root {
    --primary-color: #007bff;
    --secondary-color: #6c757d;
    --success-color: #28a745;
    --danger-color: #dc3545;
}
```

### Adding More Questions

1. Login as admin
2. Navigate to "Add Question"
3. Fill in the question form
4. Click "Add Question"

Or directly insert into database:

```sql
INSERT INTO Questions (QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption)
VALUES ('Your Question?', 'Option A', 'Option B', 'Option C', 'Option D', 'A');
```

### Modifying Quiz Settings

Edit `QuizManager.cs` to change:
- Number of questions per quiz
- Time limits
- Passing score
- Question randomization

## 🐛 Troubleshooting

### Common Issues

**1. Cannot connect to database**
- Verify SQL Server is running
- Check connection string in Web.config
- Ensure database QuizDB exists
- Test connection in SQL Server Object Explorer

**2. Login not working**
- Verify user exists in database
- Check password hash matches
- Clear browser cookies and cache
- Check session configuration in Web.config

**3. Build errors**
- Clean and rebuild solution
- Restore NuGet packages
- Check .NET Framework version (4.7.2+)
- Verify all files are included in project

**4. Pages not loading**
- Check IIS Express is running
- Verify port is not blocked by firewall
- Check Web.config for errors
- Review browser console for JavaScript errors

## 🔒 Security Best Practices

- ✅ Passwords are hashed using SHA256
- ✅ SQL parameters prevent SQL injection
- ✅ Session timeout configured (20 minutes default)
- ✅ Role-based access control implemented
- ✅ Input validation on all forms
- ⚠️ For production: Use HTTPS
- ⚠️ For production: Implement rate limiting
- ⚠️ For production: Add CAPTCHA to registration

## 📊 Database Schema

### Users Table
| Column | Type | Description |
|--------|------|-------------|
| UserID | INT | Primary Key |
| Name | NVARCHAR(100) | User's full name |
| Email | NVARCHAR(100) | Unique email |
| Password | NVARCHAR(256) | SHA256 hashed password |
| Role | NVARCHAR(20) | Admin or User |
| CreatedDate | DATETIME | Registration date |

### Questions Table
| Column | Type | Description |
|--------|------|-------------|
| QuestionID | INT | Primary Key |
| QuestionText | NVARCHAR(500) | Question text |
| OptionA-D | NVARCHAR(200) | Answer options |
| CorrectOption | CHAR(1) | Correct answer (A/B/C/D) |
| IsActive | BIT | Active status |

### QuizAttempts Table
| Column | Type | Description |
|--------|------|-------------|
| AttemptID | INT | Primary Key |
| UserID | INT | Foreign Key to Users |
| Score | INT | Score achieved |
| TotalQuestions | INT | Total questions |
| AttemptDate | DATETIME | Attempt timestamp |

### UserAnswers Table
| Column | Type | Description |
|--------|------|-------------|
| AnswerID | INT | Primary Key |
| AttemptID | INT | Foreign Key to QuizAttempts |
| QuestionID | INT | Foreign Key to Questions |
| SelectedOption | CHAR(1) | User's answer |
| IsCorrect | BIT | Correct or not |

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

**Shubham Jadhav**
- Email: itsmeshubzz07@gmail.com
- GitHub: [@shubhamjadhav0715](https://github.com/shubhamjadhav0715)

## 🙏 Acknowledgments

- Bootstrap for responsive UI components
- Microsoft for ASP.NET Framework
- SQL Server for robust database management

## 📞 Support

For issues, questions, or suggestions:
- Open an issue on GitHub
- Email: itsmeshubzz07@gmail.com

---

**Happy Coding! 🚀**

Made with ❤️ using ASP.NET Web Forms
