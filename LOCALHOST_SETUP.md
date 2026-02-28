# 🚀 Complete Localhost Setup Guide

## 📋 Table of Contents
- [Prerequisites](#-prerequisites)
- [Step-by-Step Installation](#-step-by-step-installation)
- [Running the Application](#-running-the-application)
- [Verification Steps](#-verification-steps)
- [Troubleshooting](#-troubleshooting)
- [Video Tutorial](#-video-tutorial)

---

## ✅ Prerequisites

Before you begin, ensure you have the following installed:

### **1. Visual Studio 2022**
- **Download:** [Visual Studio 2022 Community (Free)](https://visualstudio.microsoft.com/downloads/)
- **Required Workloads:**
  - ✅ ASP.NET and web development
  - ✅ .NET desktop development
  - ✅ Data storage and processing

**Installation Steps:**
```
1. Download Visual Studio Installer
2. Run installer
3. Select "ASP.NET and web development" workload
4. Click Install (may take 30-60 minutes)
```

### **2. SQL Server 2022 or LocalDB**

**Option A: SQL Server LocalDB (Recommended for beginners)**
- ✅ Comes with Visual Studio 2022
- ✅ Lightweight, no configuration needed
- ✅ Perfect for development

**Option B: SQL Server 2022 Express (For advanced users)**
- **Download:** [SQL Server 2022 Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)
- **Also Download:** [SQL Server Management Studio (SSMS)](https://aka.ms/ssmsfullsetup)

### **3. .NET Framework 4.7.2 or Higher**
- Usually comes with Visual Studio 2022
- If needed: [Download .NET Framework](https://dotnet.microsoft.com/download/dotnet-framework)

---

## 📥 Step-by-Step Installation

### **STEP 1: Clone or Download Repository**

#### **Option A: Using Git (Recommended)**
```bash
# Open Command Prompt or PowerShell
cd C:\Projects  # or your preferred location

# Clone repository
git clone https://github.com/shubhamjadhav0715/OnlineQuizApplication.git

# Navigate to project
cd OnlineQuizApplication
```

#### **Option B: Download ZIP**
```
1. Go to: https://github.com/shubhamjadhav0715/OnlineQuizApplication
2. Click green "Code" button
3. Click "Download ZIP"
4. Extract to C:\Projects\OnlineQuizApplication
```

---

### **STEP 2: Setup Database**

#### **Method 1: Using Visual Studio (Easiest)**

1. **Open Visual Studio 2022**

2. **Open SQL Server Object Explorer**
   ```
   View → SQL Server Object Explorer
   ```

3. **Expand SQL Server**
   ```
   SQL Server → (localdb)\MSSQLLocalDB → Databases
   ```

4. **Create Database**
   ```
   Right-click on "Databases" → Add New Database
   Name: QuizDB
   Click OK
   ```

5. **Execute SQL Script**
   ```
   a. Right-click on "QuizDB" database
   b. Click "New Query"
   c. Open file: C:\Projects\OnlineQuizApplication\Database\QuizDB.sql
   d. Copy ALL content
   e. Paste in query window
   f. Press Ctrl + Shift + E (or click Execute)
   ```

6. **Verify Database**
   ```
   Refresh "QuizDB" database
   You should see:
   - Tables (4): Users, Questions, QuizAttempts, UserAnswers
   - Data in all tables
   ```

#### **Method 2: Using SQL Server Management Studio (SSMS)**

1. **Open SSMS**

2. **Connect to Server**
   ```
   Server name: (localdb)\MSSQLLocalDB
   Authentication: Windows Authentication
   Click Connect
   ```

3. **Create Database**
   ```
   Right-click "Databases" → New Database
   Database name: QuizDB
   Click OK
   ```

4. **Execute Script**
   ```
   File → Open → File
   Select: C:\Projects\OnlineQuizApplication\Database\QuizDB.sql
   Press F5 to execute
   ```

5. **Verify**
   ```
   Refresh Databases
   Expand QuizDB → Tables
   You should see 4 tables with data
   ```

---

### **STEP 3: Open Project in Visual Studio**

#### **Method 1: Direct File Open (Recommended)**

1. **Navigate to Project Folder**
   ```
   C:\Projects\OnlineQuizApplication\OnlineQuizApplication\
   ```

2. **Open Default.aspx**
   ```
   Right-click on "Default.aspx"
   Select "Open with Visual Studio 2022"
   ```

3. **Visual Studio Opens**
   - Solution Explorer appears on right
   - All project files are visible

#### **Method 2: Open Folder**

1. **In Visual Studio 2022**
   ```
   File → Open → Folder
   Navigate to: C:\Projects\OnlineQuizApplication\OnlineQuizApplication
   Click "Select Folder"
   ```

---

### **STEP 4: Configure Connection String**

1. **Open Web.config**
   ```
   In Solution Explorer, double-click "Web.config"
   ```

2. **Find Connection String Section**
   ```xml
   <connectionStrings>
       <add name="QuizDB" 
            connectionString="..." 
            providerName="System.Data.SqlClient" />
   </connectionStrings>
   ```

3. **Update Based on Your Setup**

   **For LocalDB (Default):**
   ```xml
   <add name="QuizDB" 
        connectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=QuizDB;Integrated Security=True" 
        providerName="System.Data.SqlClient" />
   ```

   **For SQL Server Express:**
   ```xml
   <add name="QuizDB" 
        connectionString="Data Source=.\SQLEXPRESS;Initial Catalog=QuizDB;Integrated Security=True" 
        providerName="System.Data.SqlClient" />
   ```

   **For SQL Server (Full):**
   ```xml
   <add name="QuizDB" 
        connectionString="Data Source=localhost;Initial Catalog=QuizDB;Integrated Security=True" 
        providerName="System.Data.SqlClient" />
   ```

4. **Save File** (Ctrl + S)

---

### **STEP 5: Set Start Page**

1. **In Solution Explorer**
   ```
   Find "Default.aspx"
   Right-click on it
   Select "Set As Start Page"
   ```

2. **Verify**
   ```
   Default.aspx should now be bold in Solution Explorer
   ```

---

### **STEP 6: Build Project**

1. **Clean Solution**
   ```
   Build → Clean Solution
   Wait for completion
   ```

2. **Rebuild Solution**
   ```
   Build → Rebuild Solution
   Wait for build to complete
   Check Output window for "Build succeeded"
   ```

3. **Fix Build Errors (if any)**
   ```
   If App_Code errors:
   - Right-click App_Code folder
   - Properties
   - Build Action → Compile
   - Rebuild again
   ```

---

## ▶️ Running the Application

### **Method 1: Press F5 (Debug Mode)**
```
1. Press F5 on keyboard
2. Browser opens automatically
3. Application runs with debugging enabled
```

### **Method 2: Ctrl + F5 (Without Debugging)**
```
1. Press Ctrl + F5
2. Faster startup
3. No debugging overhead
```

### **Method 3: Click Start Button**
```
1. Click green "Start" button in toolbar
2. Select browser (Chrome, Edge, Firefox)
3. Application launches
```

---

## ✅ Verification Steps

### **1. Home Page Loads**
```
✅ Beautiful gradient hero section
✅ "Welcome to Online Quiz Application" heading
✅ Navigation bar with links
✅ Feature boxes visible
✅ Statistics cards showing numbers
```

### **2. Test User Registration**
```
1. Click "Register" or "Get Started"
2. Fill form:
   - Name: Test User
   - Email: test@example.com
   - Password: test123
   - Confirm Password: test123
3. Click Register
4. Should redirect to Login page
```

### **3. Test Login**
```
1. Use admin credentials:
   - Email: admin@quiz.com
   - Password: admin123
2. Click Login
3. Should see admin dashboard
```

### **4. Test Quiz**
```
1. Login as user (john@example.com / user123)
2. Click "Take Quiz"
3. Answer 10 questions
4. Click Submit
5. See results page with score
```

### **5. Test Admin Features**
```
1. Login as admin
2. Click "Dashboard" - see statistics
3. Click "Add Question" - add new question
4. Click "Manage Questions" - see all questions
5. Click "View Results" - see all user attempts
```

---

## 🐛 Troubleshooting

### **Issue 1: "Database does not exist"**

**Symptoms:**
- Error message about QuizDB not found
- Cannot connect to database

**Solutions:**
```
1. Verify database exists:
   - Open SQL Server Object Explorer
   - Check if QuizDB is listed under Databases

2. Re-run SQL script:
   - Delete QuizDB if exists
   - Execute Database/QuizDB.sql again

3. Check connection string:
   - Verify server name matches your SQL Server instance
   - Try different connection strings (see Step 4)
```

---

### **Issue 2: "Please select a valid startup item"**

**Symptoms:**
- Error when pressing F5
- Cannot start application

**Solutions:**
```
1. Set Default.aspx as start page:
   - Right-click Default.aspx
   - Set As Start Page

2. Verify project type:
   - Should be Web Application
   - Not Website project

3. Rebuild solution:
   - Build → Rebuild Solution
```

---

### **Issue 3: Build Failed / Compilation Errors**

**Symptoms:**
- Red errors in Error List
- Build output shows errors

**Solutions:**
```
1. Fix App_Code:
   - Right-click App_Code folder
   - Properties → Build Action → Compile
   - Rebuild

2. Clean and rebuild:
   - Build → Clean Solution
   - Build → Rebuild Solution

3. Check .NET Framework:
   - Right-click project → Properties
   - Target framework: .NET Framework 4.7.2 or higher

4. Restore NuGet packages:
   - Tools → NuGet Package Manager → Manage NuGet Packages
   - Click "Restore" if prompted
```

---

### **Issue 4: CSS/Styles Not Loading**

**Symptoms:**
- Page looks plain, no colors
- No gradients or animations

**Solutions:**
```
1. Clear browser cache:
   - Press Ctrl + Shift + Delete
   - Clear cached images and files
   - Close and reopen browser

2. Hard refresh:
   - Press Ctrl + F5 in browser

3. Check file path:
   - Verify Styles/site.css exists
   - Check Site.Master has: ~/Styles/site.css

4. Check file properties:
   - Right-click site.css
   - Properties → Build Action → Content
```

---

### **Issue 5: Login Failed / Authentication Error**

**Symptoms:**
- Cannot login with default credentials
- "Invalid email or password" message

**Solutions:**
```
1. Verify database has users:
   - Open SQL Server Object Explorer
   - QuizDB → Tables → Users → View Data
   - Should see admin@quiz.com

2. Re-run database script:
   - This recreates users with correct passwords

3. Check password hashing:
   - Passwords are SHA256 hashed
   - Cannot see plain text in database
```

---

### **Issue 6: Port Already in Use**

**Symptoms:**
- Error: "Port 44300 is already in use"
- Cannot start application

**Solutions:**
```
1. Change port:
   - Right-click project → Properties
   - Web → Project Url
   - Change port number
   - Click "Create Virtual Directory"

2. Stop other applications:
   - Close other Visual Studio instances
   - Stop IIS Express from system tray

3. Restart Visual Studio:
   - Close Visual Studio
   - Reopen and try again
```

---

### **Issue 7: SQL Server Not Running**

**Symptoms:**
- "Cannot connect to SQL Server"
- "Network-related error"

**Solutions:**
```
1. Start SQL Server:
   - Press Win + R
   - Type: services.msc
   - Find "SQL Server (MSSQLSERVER)" or "SQL Server (SQLEXPRESS)"
   - Right-click → Start

2. For LocalDB:
   - Open Command Prompt as Administrator
   - Run: sqllocaldb start MSSQLLocalDB

3. Verify connection:
   - Open SQL Server Object Explorer
   - Try to connect
   - If fails, check SQL Server Configuration Manager
```

---

## 🎥 Video Tutorial

### **Quick Setup (5 Minutes)**
```
Coming soon! Subscribe to get notified.
```

### **Detailed Walkthrough (15 Minutes)**
```
Coming soon! Full step-by-step video guide.
```

---

## 📞 Need More Help?

### **Resources:**
- 📚 [README.md](README.md) - Complete documentation
- ⚡ [QUICK_START.md](QUICK_START.md) - Quick reference
- 📖 [SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md) - Detailed guide

### **Contact:**
- 📧 Email: itsmeshubzz07@gmail.com
- 🐛 Issues: [GitHub Issues](https://github.com/shubhamjadhav0715/OnlineQuizApplication/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/shubhamjadhav0715/OnlineQuizApplication/discussions)

---

## ✅ Checklist

Use this checklist to ensure everything is set up correctly:

- [ ] Visual Studio 2022 installed with ASP.NET workload
- [ ] SQL Server or LocalDB installed
- [ ] Repository cloned/downloaded
- [ ] Database created (QuizDB)
- [ ] SQL script executed successfully
- [ ] 4 tables created with data
- [ ] Project opened in Visual Studio
- [ ] Web.config connection string updated
- [ ] Default.aspx set as start page
- [ ] Solution builds without errors
- [ ] Application runs in browser
- [ ] Home page displays correctly
- [ ] Can login with admin credentials
- [ ] Can take quiz as user
- [ ] Admin dashboard accessible

---

## 🎉 Success!

If you've completed all steps and the application is running:

**Congratulations! 🎊**

You now have a fully functional Online Quiz Application running on your localhost!

### **Next Steps:**
1. ✅ Explore all features
2. ✅ Try admin and user accounts
3. ✅ Take some quizzes
4. ✅ Add your own questions
5. ✅ Customize the design
6. ✅ Learn from the code

---

<div align="center">

**Made with ❤️ by Shubham Jadhav**

⭐ **Star this repository if you find it helpful!**

[⬆ Back to Top](#-complete-localhost-setup-guide)

</div>