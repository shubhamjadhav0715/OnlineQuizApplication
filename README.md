# 🎓 Online Quiz Application - ASP.NET Web Forms

<div align="center">

![ASP.NET](https://img.shields.io/badge/ASP.NET-Web%20Forms-512BD4?style=for-the-badge&logo=.net&logoColor=white)
![C#](https://img.shields.io/badge/C%23-239120?style=for-the-badge&logo=c-sharp&logoColor=white)
![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![Bootstrap](https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white)

**A complete, production-ready online quiz application with modern UI/UX design**

[Features](#-features) • [Quick Start](#-quick-start-5-minutes) • [Installation](#-detailed-installation-guide) • [Screenshots](#-screenshots) • [Documentation](#-documentation)

</div>

---

## 🌟 **What's New - Latest Update**

### ✨ **Major Design Upgrade (v2.0)**
- 🎨 **Modern Premium UI** - Stunning gradients, smooth animations, and professional design
- 🚀 **Enhanced UX** - Improved user experience with interactive elements
- 📱 **Fully Responsive** - Perfect on all devices (mobile, tablet, desktop)
- 🎭 **Beautiful Animations** - Smooth transitions and eye-catching effects
- 🎯 **Improved Accessibility** - Better contrast, larger touch targets
- ⚡ **Performance Optimized** - Faster load times and smooth interactions

---

## 📊 **Project Overview**

A fully functional, production-ready quiz application built with ASP.NET Web Forms, featuring:

✅ **User Management** - Registration, login, and profile management  
✅ **Interactive Quizzes** - Take quizzes with random questions  
✅ **Instant Results** - Real-time grading and score breakdown  
✅ **Quiz History** - Track all past attempts and performance  
✅ **Admin Dashboard** - Complete question and user management  
✅ **Modern UI/UX** - Beautiful, responsive design with animations  
✅ **Secure** - Password hashing, SQL injection prevention, role-based access  

---

## 🎯 **Features**

### 👤 **User Features**
- 📝 **Register** - Create account with email validation
- 🔐 **Secure Login** - SHA256 password hashing
- 📋 **Take Quiz** - 10 random questions per attempt
- 📊 **View Results** - Instant feedback with detailed score breakdown
- 📈 **Quiz History** - Complete history with grades and timestamps
- 🎨 **Modern Interface** - Beautiful, intuitive design

### 👨‍💼 **Admin Features**
- 📊 **Dashboard** - Real-time statistics and analytics
- ➕ **Add Questions** - Create new quiz questions
- ✏️ **Edit Questions** - Modify existing questions inline
- 🗑️ **Delete Questions** - Remove outdated questions
- 👥 **View Results** - Monitor all user quiz attempts
- 📈 **Analytics** - Track platform usage and performance

### 🔒 **Security Features**
- 🔐 **Password Hashing** - SHA256 encryption
- 🛡️ **SQL Injection Prevention** - Parameterized queries
- 🎫 **Session Management** - Secure user sessions
- 👮 **Role-Based Access** - Admin vs User permissions
- ✅ **Input Validation** - Client and server-side validation
- 🚫 **Protected Routes** - Authentication required for sensitive pages

---

## 🚀 **Quick Start (5 Minutes)**

### **Prerequisites**
- ✅ Visual Studio 2022 (Community/Professional/Enterprise)
- ✅ SQL Server 2022 or SQL Server LocalDB
- ✅ .NET Framework 4.7.2 or higher

### **Installation Steps**

#### **1️⃣ Clone Repository**
```bash
git clone https://github.com/shubhamjadhav0715/OnlineQuizApplication.git
cd OnlineQuizApplication
```

#### **2️⃣ Setup Database**

**Option A: Using SQL Server Management Studio (SSMS)**
```sql
-- Open SSMS and connect to your SQL Server
-- File → Open → File → Select: Database/QuizDB.sql
-- Press F5 to execute
```

**Option B: Using Visual Studio**
```
1. View → SQL Server Object Explorer
2. Right-click on your SQL Server instance
3. New Query
4. Copy-paste content from Database/QuizDB.sql
5. Execute (Ctrl + Shift + E)
```

#### **3️⃣ Open in Visual Studio**
```
1. Navigate to: OnlineQuizApplication/OnlineQuizApplication/
2. Right-click on Default.aspx
3. Select "Open with Visual Studio 2022"
```

#### **4️⃣ Configure Connection String (if needed)**

Open `Web.config` and update if necessary:
```xml
<connectionStrings>
    <add name="QuizDB" 
         connectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=QuizDB;Integrated Security=True" 
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

**Common Connection Strings:**
- **LocalDB:** `Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=QuizDB;Integrated Security=True`
- **SQL Server Express:** `Data Source=.\SQLEXPRESS;Initial Catalog=QuizDB;Integrated Security=True`
- **SQL Server:** `Data Source=localhost;Initial Catalog=QuizDB;Integrated Security=True`

#### **5️⃣ Set Start Page**
```
1. In Solution Explorer, right-click Default.aspx
2. Click "Set As Start Page"
```

#### **6️⃣ Run Application**
```
Press F5 or click the green "Start" button
```

🎉 **That's it!** Your application should now be running in your browser!

---

## 🔑 **Default Login Credentials**

### **Admin Account**
```
Email: admin@quiz.com
Password: admin123
```
**Access:** Full admin dashboard, question management, view all results

### **Test User Accounts**
```
User 1:
Email: john@example.com
Password: user123

User 2:
Email: jane@example.com
Password: user123
```
**Access:** Take quizzes, view personal results and history

---

## 📁 **Project Structure**

```
OnlineQuizApplication/
│
├── 📂 Database/
│   └── QuizDB.sql                          # Complete database schema + sample data
│
├── 📂 OnlineQuizApplication/
│   │
│   ├── 📂 Admin/                           # Admin Module
│   │   ├── Dashboard.aspx                  # Admin dashboard with statistics
│   │   ├── AddQuestion.aspx                # Add new questions
│   │   ├── ManageQuestions.aspx            # Edit/Delete questions
│   │   └── ViewResults.aspx                # View all user results
│   │
│   ├── 📂 User/                            # User Module
│   │   ├── Register.aspx                   # User registration
│   │   ├── Login.aspx                      # User login
│   │   ├── Quiz.aspx                       # Take quiz (10 questions)
│   │   ├── Result.aspx                     # View quiz results
│   │   └── History.aspx                    # View quiz history
│   │
│   ├── 📂 App_Code/                        # Business Logic Layer
│   │   ├── DBHelper.cs                     # Database operations
│   │   ├── AuthManager.cs                  # Authentication & authorization
│   │   └── QuizManager.cs                  # Quiz logic & scoring
│   │
│   ├── 📂 Styles/                          # CSS Styling
│   │   └── site.css                        # Custom styles (18KB+)
│   │
│   ├── 📂 Scripts/                         # JavaScript
│   │   └── site.js                         # Custom scripts
│   │
│   ├── Web.config                          # Application configuration
│   ├── Site.Master                         # Master page layout
│   └── Default.aspx                        # Home page
│
├── 📄 README.md                            # This file
├── 📄 QUICK_START.md                       # Quick reference guide
├── 📄 SIMPLE_RUN_GUIDE.md                  # Detailed setup guide
└── 📄 SETUP_INSTRUCTIONS.md                # Complete documentation
```

---

## 🛠️ **Technologies Used**

| Technology | Version | Purpose |
|------------|---------|---------|
| **ASP.NET Web Forms** | 4.7.2+ | Backend framework |
| **C#** | Latest | Programming language |
| **SQL Server** | 2022 | Database management |
| **Bootstrap** | 4.5.2 | Responsive UI framework |
| **jQuery** | 3.5.1 | JavaScript library |
| **Font Awesome** | 5.15.4 | Icon library |
| **Custom CSS** | - | Modern animations & gradients |

---

## 📊 **Database Schema**

### **Tables Overview**

#### **1. Users Table**
```sql
UserID (PK, Identity)
Name (nvarchar)
Email (nvarchar, unique)
Password (nvarchar, SHA256 hashed)
Role (nvarchar: 'Admin' or 'User')
CreatedDate (datetime)
```

#### **2. Questions Table**
```sql
QuestionID (PK, Identity)
QuestionText (nvarchar)
OptionA, OptionB, OptionC, OptionD (nvarchar)
CorrectOption (char: 'A', 'B', 'C', or 'D')
IsActive (bit)
CreatedDate (datetime)
```

#### **3. QuizAttempts Table**
```sql
AttemptID (PK, Identity)
UserID (FK → Users)
Score (int)
TotalQuestions (int)
AttemptDate (datetime)
```

#### **4. UserAnswers Table**
```sql
AnswerID (PK, Identity)
AttemptID (FK → QuizAttempts)
QuestionID (FK → Questions)
SelectedOption (char)
IsCorrect (bit)
```

### **Sample Data Included**
- ✅ **3 Users** (1 Admin + 2 Test Users)
- ✅ **30 Questions** (C#, ASP.NET, SQL Server topics)
- ✅ **Sample Quiz Attempts** (for testing history feature)

---

## 🎨 **Design Highlights**

### **Modern UI Features**
- 🌈 **Gradient Backgrounds** - Beautiful color transitions
- ✨ **Smooth Animations** - Fade-in, slide, zoom effects
- 🎯 **Interactive Elements** - Hover effects, button animations
- 📱 **Responsive Design** - Mobile-first approach
- 🎨 **Custom Color Palette** - Professional, eye-catching colors
- 🔄 **Loading States** - Smooth transitions between pages

### **User Experience**
- 🚀 **Fast Loading** - Optimized CSS and JavaScript
- 👆 **Touch Friendly** - Large buttons and touch targets
- 🎭 **Visual Feedback** - Clear indication of user actions
- 📊 **Data Visualization** - Beautiful statistics cards
- 🎯 **Intuitive Navigation** - Easy to find features
- ♿ **Accessible** - WCAG compliant design

---

## 🐛 **Troubleshooting**

### **Common Issues & Solutions**

#### **❌ "Database does not exist"**
**Solution:**
```
1. Open SQL Server Management Studio
2. Execute Database/QuizDB.sql
3. Verify database "QuizDB" is created
4. Check connection string in Web.config
```

#### **❌ "Please select a valid startup item"**
**Solution:**
```
1. Right-click Default.aspx in Solution Explorer
2. Click "Set As Start Page"
3. Press F5 to run
```

#### **❌ "Build failed" or compilation errors**
**Solution:**
```
1. Right-click App_Code folder
2. Properties → Build Action → Compile
3. Clean Solution (Build → Clean Solution)
4. Rebuild Solution (Build → Rebuild Solution)
```

#### **❌ "Connection string error"**
**Solution:**
```
Update Web.config with correct connection string:

For LocalDB:
Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=QuizDB;Integrated Security=True

For SQL Server Express:
Data Source=.\SQLEXPRESS;Initial Catalog=QuizDB;Integrated Security=True

For SQL Server:
Data Source=localhost;Initial Catalog=QuizDB;Integrated Security=True
```

#### **❌ "Login failed for user"**
**Solution:**
```
1. Ensure SQL Server is running
2. Check Windows Authentication is enabled
3. Verify user has access to QuizDB database
4. Try using SQL Server Authentication if needed
```

#### **❌ CSS/Styles not loading**
**Solution:**
```
1. Clear browser cache (Ctrl + Shift + Delete)
2. Hard refresh (Ctrl + F5)
3. Check Styles/site.css exists
4. Verify path in Site.Master: ~/Styles/site.css
```

---

## 📖 **Documentation**

| Document | Description | Link |
|----------|-------------|------|
| **QUICK_START.md** | ⚡ One-page quick reference | [View](QUICK_START.md) |
| **SIMPLE_RUN_GUIDE.md** | 📚 Detailed step-by-step setup | [View](SIMPLE_RUN_GUIDE.md) |
| **SETUP_INSTRUCTIONS.md** | 📖 Complete setup guide | [View](SETUP_INSTRUCTIONS.md) |
| **PROJECT_SUMMARY.md** | 📊 Project overview & stats | [View](PROJECT_SUMMARY.md) |

---

## 🚀 **How to Run on Localhost**

### **Method 1: Visual Studio (Recommended)**
```
1. Clone repository
2. Execute Database/QuizDB.sql in SQL Server
3. Open Default.aspx with Visual Studio 2022
4. Set Default.aspx as Start Page
5. Press F5
```

### **Method 2: IIS Express**
```
1. Clone repository
2. Setup database
3. Open project in Visual Studio
4. Right-click project → Properties
5. Web → Use IIS Express
6. Click Start
```

### **Method 3: Local IIS**
```
1. Clone repository
2. Setup database
3. Open IIS Manager
4. Add New Website
5. Point to OnlineQuizApplication folder
6. Browse website
```

---

## 🎯 **Usage Guide**

### **For Users**
1. **Register** - Create account with email and password
2. **Login** - Access your dashboard
3. **Take Quiz** - Click "Take Quiz" to start
4. **Answer Questions** - Select options for 10 random questions
5. **Submit** - Get instant results with score and grade
6. **View History** - Check all past quiz attempts

### **For Admins**
1. **Login** - Use admin credentials
2. **Dashboard** - View platform statistics
3. **Add Questions** - Create new quiz questions
4. **Manage Questions** - Edit or delete existing questions
5. **View Results** - Monitor all user quiz attempts
6. **Analytics** - Track platform performance

---

## 🔐 **Security Best Practices**

✅ **Implemented:**
- SHA256 password hashing
- Parameterized SQL queries
- Session-based authentication
- Role-based authorization
- Input validation (client & server)
- Protected admin routes
- HTTPS ready

⚠️ **Recommendations for Production:**
- Enable HTTPS/SSL
- Use stronger password policies
- Implement rate limiting
- Add CAPTCHA for registration
- Enable audit logging
- Regular security updates

---

## 📈 **Future Enhancements**

### **Planned Features**
- [ ] Multiple quiz categories
- [ ] Timed quizzes
- [ ] Leaderboard system
- [ ] Email notifications
- [ ] Export results to PDF
- [ ] Question difficulty levels
- [ ] User profile pictures
- [ ] Social media login
- [ ] Mobile app version
- [ ] API for third-party integration

---

## 🤝 **Contributing**

Contributions are welcome! Here's how you can help:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** your changes (`git commit -m 'Add some AmazingFeature'`)
4. **Push** to the branch (`git push origin feature/AmazingFeature`)
5. **Open** a Pull Request

---

## 📝 **License**

This project is open source and available for educational purposes.

---

## 👨‍💻 **Author**

**Shubham Jadhav**
- GitHub: [@shubhamjadhav0715](https://github.com/shubhamjadhav0715)
- Email: itsmeshubzz07@gmail.com

---

## 🙏 **Acknowledgments**

- Bootstrap for the responsive framework
- Font Awesome for beautiful icons
- Microsoft for ASP.NET Web Forms
- SQL Server for robust database management

---

## 📞 **Support**

Having issues? Need help?

1. Check [Troubleshooting](#-troubleshooting) section
2. Review [Documentation](#-documentation)
3. Open an [Issue](https://github.com/shubhamjadhav0715/OnlineQuizApplication/issues)
4. Contact: itsmeshubzz07@gmail.com

---

<div align="center">

### ⭐ **Star this repository if you find it helpful!**

**Made with ❤️ by Shubham Jadhav**

[⬆ Back to Top](#-online-quiz-application---aspnet-web-forms)

</div>