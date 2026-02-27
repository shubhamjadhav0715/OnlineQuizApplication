# 🎓 Online Quiz Application - ASP.NET Web Forms

A complete, production-ready online quiz application built with ASP.NET Web Forms, C#, and SQL Server.

---

## 🚀 **QUICK START - GET RUNNING IN 5 MINUTES!**

**👉 [CLICK HERE FOR SUPER SIMPLE GUIDE](SIMPLE_RUN_GUIDE.md)** ← Start here!

**⚡ [QUICK START (One Page)](QUICK_START.md)** ← Even faster!

---

## 📊 **Project Overview**

A fully functional quiz application with:
- ✅ User registration and login
- ✅ Take quiz with random questions
- ✅ Instant results and grading
- ✅ Quiz history tracking
- ✅ Admin dashboard
- ✅ Question management (CRUD)
- ✅ Responsive Bootstrap UI

---

## 🎯 **Features**

### **User Features:**
- Register new account with validation
- Secure login (SHA256 password hashing)
- Take quiz (10 random questions per attempt)
- View instant results with score breakdown
- View complete quiz history with grades

### **Admin Features:**
- Dashboard with real-time statistics
- Add new questions
- Edit/Delete questions (GridView with inline editing)
- View all user quiz results

### **Security Features:**
- SHA256 password hashing
- SQL injection prevention (parameterized queries)
- Session-based authentication
- Role-based authorization (Admin/User)
- Protected admin routes

---

## 🛠️ **Technologies Used**

| Technology | Version | Purpose |
|------------|---------|---------|
| ASP.NET Web Forms | 4.7.2+ | Backend framework |
| C# | Latest | Programming language |
| SQL Server | 2022 | Database |
| Bootstrap | 4.5.2 | UI framework |
| jQuery | 3.5.1 | JavaScript library |
| Font Awesome | 5.15.4 | Icons |

---

## 📁 **Project Structure**

```
OnlineQuizApplication/
├── Database/
│   └── QuizDB.sql                     # Database schema + sample data
│
├── OnlineQuizApplication/
│   ├── Admin/                         # Admin module
│   │   ├── Dashboard.aspx
│   │   ├── AddQuestion.aspx
│   │   ├── ManageQuestions.aspx
│   │   └── ViewResults.aspx
│   │
│   ├── User/                          # User module
│   │   ├── Register.aspx
│   │   ├── Login.aspx
│   │   ├── Quiz.aspx
│   │   ├── Result.aspx
│   │   └── History.aspx
│   │
│   ├── App_Code/                      # Business logic
│   │   ├── DBHelper.cs
│   │   ├── AuthManager.cs
│   │   └── QuizManager.cs
│   │
│   ├── Styles/                        # CSS
│   │   └── site.css
│   │
│   ├── Scripts/                       # JavaScript
│   │   └── site.js
│   │
│   ├── Web.config                     # Configuration
│   ├── Site.Master                    # Master page
│   └── Default.aspx                   # Home page
│
├── SIMPLE_RUN_GUIDE.md               # ⭐ Detailed setup guide
├── QUICK_START.md                     # ⚡ Quick reference
└── README.md                          # This file
```

---

## 🚀 **Quick Setup**

### **Prerequisites:**
- Visual Studio 2022 (with ASP.NET workload)
- SQL Server 2022 or LocalDB

### **5-Step Setup:**

1. **Clone repository:**
   ```bash
   git clone https://github.com/shubhamjadhav0715/OnlineQuizApplication.git
   ```

2. **Create database:**
   - Execute `Database/QuizDB.sql` in SQL Server Management Studio

3. **Open in Visual Studio 2022:**
   - Right-click `Default.aspx` → Open with Visual Studio 2022

4. **Set start page:**
   - Right-click `Default.aspx` → Set As Start Page

5. **Run:**
   - Press F5

**📖 For detailed instructions, see [SIMPLE_RUN_GUIDE.md](SIMPLE_RUN_GUIDE.md)**

---

## 🔑 **Default Credentials**

### **Admin Account:**
```
Email: admin@quiz.com
Password: admin123
```

### **Test User Accounts:**
```
User 1:
Email: john@example.com
Password: user123

User 2:
Email: jane@example.com
Password: user123
```

---

## 📊 **Database Schema**

### **Tables:**

**1. Users**
- UserID (PK, Identity)
- Name, Email, Password (SHA256)
- Role (Admin/User)
- CreatedDate

**2. Questions**
- QuestionID (PK, Identity)
- QuestionText
- OptionA, OptionB, OptionC, OptionD
- CorrectOption
- IsActive, CreatedDate

**3. QuizAttempts**
- AttemptID (PK, Identity)
- UserID (FK)
- Score, TotalQuestions
- AttemptDate

**4. UserAnswers**
- AnswerID (PK, Identity)
- AttemptID (FK), QuestionID (FK)
- SelectedOption, IsCorrect

### **Sample Data:**
- 3 Users (1 Admin, 2 Test Users)
- 30 Questions (C#, ASP.NET, SQL Server topics)

---

## 🎨 **Screenshots**

### **Home Page**
Clean, professional landing page with navigation

### **User Dashboard**
Take quiz, view results, check history

### **Admin Dashboard**
Statistics, manage questions, view all results

### **Quiz Interface**
Interactive quiz with 10 random questions

### **Results Page**
Instant feedback with score breakdown and grade

---

## 🔒 **Security Features**

- ✅ **Password Hashing:** SHA256 encryption
- ✅ **SQL Injection Prevention:** Parameterized queries
- ✅ **Session Management:** Secure user sessions
- ✅ **Role-Based Access:** Admin vs User permissions
- ✅ **Input Validation:** Client and server-side validation
- ✅ **Protected Routes:** Admin pages require authentication

---

## 📖 **Documentation**

| Document | Description |
|----------|-------------|
| [SIMPLE_RUN_GUIDE.md](SIMPLE_RUN_GUIDE.md) | ⭐ **Start here!** Detailed step-by-step setup |
| [QUICK_START.md](QUICK_START.md) | ⚡ Quick reference (one page) |
| [SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md) | Complete setup guide |
| [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) | Project overview & statistics |
| [CODE_REVIEW_AND_FIXES.md](CODE_REVIEW_AND_FIXES.md) | Code review & fixes |
| [FINAL_STATUS.md](FINAL_STATUS.md) | Completion status |

---

## 🐛 **Troubleshooting**

### **Common Issues:**

**1. "Database does not exist"**
- Re-run `Database/QuizDB.sql`
- Check SQL Server is running

**2. "Please select a valid startup item"**
- Right-click Default.aspx → Set As Start Page

**3. "Build failed"**
- Right-click App_Code → Properties → Build Action → Compile
- Clean and rebuild solution

**4. "Connection string error"**
- Update Web.config connection string to match your SQL Server

**📖 See [SIMPLE_RUN_GUIDE.md](SIMPLE_RUN_GUIDE.md) for detailed troubleshooting**

---

## ✨ **Features Breakdown**

### **User Module:**
- ✅ Registration with validation
- ✅ Login with SHA256 hashing
- ✅ Take quiz (10 random questions)
- ✅ View results with grade
- ✅ Quiz history

### **Admin Module:**
- ✅ Dashboard with statistics
- ✅ Add questions
- ✅ Edit/Delete questions
- ✅ View all results

### **Database:**
- ✅ 4 normalized tables
- ✅ Foreign key relationships
- ✅ Sample data included

### **UI/UX:**
- ✅ Responsive Bootstrap design
- ✅ Professional styling
- ✅ Mobile-friendly
- ✅ Font Awesome icons

---

## 🎓 **Learning Outcomes**

This project demonstrates:
- ASP.NET Web Forms development
- SQL Server database design
- Authentication & authorization
- CRUD operations with GridView
- Session management
- Responsive web design
- Security best practices

---

## 📞 **Support**

**Repository:** https://github.com/shubhamjadhav0715/OnlineQuizApplication

**Developer:** Shubham Jadhav  
**Email:** itsmeshubzz07@gmail.com  
**GitHub:** [@shubhamjadhav0715](https://github.com/shubhamjadhav0715)

---

## 📄 **License**

This project is open source and available under the MIT License.

---

## 🙏 **Acknowledgments**

- Microsoft for ASP.NET Framework
- Bootstrap team for responsive UI components
- Font Awesome for icons
- SQL Server for database management

---

## ✅ **Project Status**

**Status:** ✅ **PRODUCTION READY**  
**Version:** 1.0.0  
**Last Updated:** February 26, 2026  
**Completion:** 100%

---

## 🎉 **Get Started Now!**

**👉 [CLICK HERE FOR SIMPLE SETUP GUIDE](SIMPLE_RUN_GUIDE.md)**

**Your complete Online Quiz Application is ready to run!**

**Happy Coding! 🚀**
