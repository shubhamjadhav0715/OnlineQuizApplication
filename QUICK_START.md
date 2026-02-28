# ⚡ QUICK START - Run in 5 Minutes!

<div align="center">

**Get your Online Quiz Application running on localhost in just 5 simple steps!**

</div>

---

## 🎯 Prerequisites (2 Minutes)

Before starting, ensure you have:

✅ **Visual Studio 2022** (Community/Professional/Enterprise)  
✅ **SQL Server 2022** or **LocalDB** (comes with Visual Studio)  
✅ **Internet connection** (for first-time setup)

---

## 🚀 5-Step Setup

### **STEP 1️⃣ - Clone Repository**

```bash
git clone https://github.com/shubhamjadhav0715/OnlineQuizApplication.git
cd OnlineQuizApplication
```

**OR Download ZIP:**
- Go to: https://github.com/shubhamjadhav0715/OnlineQuizApplication
- Click green "Code" → "Download ZIP"
- Extract to your preferred location

---

### **STEP 2️⃣ - Create Database**

#### **Option A: Using Visual Studio (Easiest)**

1. Open **Visual Studio 2022**
2. Go to: **View** → **SQL Server Object Explorer**
3. Expand: **SQL Server** → **(localdb)\MSSQLLocalDB** → **Databases**
4. Right-click **Databases** → **New Query**
5. Open file: `Database/QuizDB.sql`
6. Copy **ALL** content and paste in query window
7. Press **Ctrl + Shift + E** to execute

#### **Option B: Using SQL Server Management Studio (SSMS)**

1. Open **SSMS**
2. Connect to: **(localdb)\MSSQLLocalDB**
3. **File** → **Open** → **File** → Select `Database/QuizDB.sql`
4. Press **F5** to execute

**✅ Verify:** You should see **QuizDB** database with 4 tables (Users, Questions, QuizAttempts, UserAnswers)

---

### **STEP 3️⃣ - Open in Visual Studio**

**Easiest Method:**
1. Navigate to: `OnlineQuizApplication/OnlineQuizApplication/`
2. **Right-click** on `Default.aspx`
3. Select **"Open with Visual Studio 2022"**

**Alternative:**
1. Open Visual Studio 2022
2. **File** → **Open** → **Folder**
3. Select: `OnlineQuizApplication/OnlineQuizApplication/`

---

### **STEP 4️⃣ - Configure & Build**

#### **A. Check Connection String**

Open `Web.config` and verify:

```xml
<connectionStrings>
    <add name="QuizDB" 
         connectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=QuizDB;Integrated Security=True" 
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

**Common Connection Strings:**

| SQL Server Type | Connection String |
|----------------|-------------------|
| **LocalDB** (Default) | `Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=QuizDB;Integrated Security=True` |
| **SQL Express** | `Data Source=.\SQLEXPRESS;Initial Catalog=QuizDB;Integrated Security=True` |
| **SQL Server** | `Data Source=localhost;Initial Catalog=QuizDB;Integrated Security=True` |

#### **B. Set Start Page**

1. In **Solution Explorer**, find `Default.aspx`
2. **Right-click** → **Set As Start Page**

#### **C. Build Project**

1. **Build** → **Clean Solution**
2. **Build** → **Rebuild Solution**
3. Wait for "Build succeeded" message

---

### **STEP 5️⃣ - Run Application**

Press **F5** or click the green **Start** button

🎉 **Your browser will open automatically with the application!**

---

## 🔑 Default Login Credentials

### **👨‍💼 Admin Account**
```
Email: admin@quiz.com
Password: admin123
```
**Access:** Dashboard, Add/Manage Questions, View All Results

### **👤 Test User Accounts**
```
User 1:
Email: john@example.com
Password: user123

User 2:
Email: jane@example.com
Password: user123
```
**Access:** Take Quiz, View Results, View History

---

## ✅ Verify Everything Works

### **1. Home Page**
- ✅ Beautiful gradient hero section
- ✅ Navigation bar with links
- ✅ Feature boxes
- ✅ Statistics cards

### **2. User Features**
- ✅ Register new account
- ✅ Login successfully
- ✅ Take quiz (10 questions)
- ✅ View results with score
- ✅ Check quiz history

### **3. Admin Features**
- ✅ Access dashboard
- ✅ View statistics
- ✅ Add new questions
- ✅ Edit/delete questions
- ✅ View all user results

---

## 🐛 Quick Troubleshooting

### **❌ "Database does not exist"**
**Fix:**
```
1. Re-run Database/QuizDB.sql in SQL Server
2. Verify QuizDB appears in databases list
3. Check connection string in Web.config
```

### **❌ "Please select a valid startup item"**
**Fix:**
```
Right-click Default.aspx → Set As Start Page → Press F5
```

### **❌ "Build failed"**
**Fix:**
```
1. Right-click App_Code folder
2. Properties → Build Action → Compile
3. Build → Rebuild Solution
```

### **❌ "Connection failed"**
**Fix:**
```
Update Web.config connection string:
- For LocalDB: (localdb)\MSSQLLocalDB
- For SQL Express: .\SQLEXPRESS
- For SQL Server: localhost
```

### **❌ "CSS not loading / Page looks plain"**
**Fix:**
```
1. Clear browser cache (Ctrl + Shift + Delete)
2. Hard refresh (Ctrl + F5)
3. Verify Styles/site.css exists
```

---

## 📚 Need More Help?

| Resource | Description |
|----------|-------------|
| **[LOCALHOST_SETUP.md](LOCALHOST_SETUP.md)** | 📖 Complete step-by-step guide with screenshots |
| **[README.md](README.md)** | 📚 Full documentation |
| **[SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md)** | 🔧 Detailed setup instructions |

---

## 🎯 What's Next?

After successful setup:

1. ✅ **Explore Features** - Try all user and admin features
2. ✅ **Take Quizzes** - Test the quiz functionality
3. ✅ **Add Questions** - Create your own quiz questions
4. ✅ **Customize Design** - Modify colors and styles in `Styles/site.css`
5. ✅ **Learn Code** - Study the C# and ASP.NET code
6. ✅ **Extend Features** - Add new functionality

---

## 💡 Pro Tips

### **Development Tips:**
- 🔥 Use **Ctrl + F5** for faster startup (no debugging)
- 🔄 Press **Ctrl + Shift + B** to build without running
- 🐛 Use **F9** to set breakpoints for debugging
- 📝 Check **Output** window for build messages
- ⚡ Use **Ctrl + K, Ctrl + D** to format code

### **Database Tips:**
- 📊 Use **SQL Server Object Explorer** to view data
- 🔍 Right-click tables → **View Data** to see records
- ✏️ Edit data directly in the data viewer
- 🔄 Refresh database to see changes

### **Testing Tips:**
- 👤 Create multiple user accounts to test
- 📝 Add various types of questions
- 🎯 Take quizzes with different scores
- 📊 Check admin dashboard for statistics

---

## 🎉 Success Checklist

- [ ] Repository cloned/downloaded
- [ ] Database created and populated
- [ ] Project opened in Visual Studio
- [ ] Connection string configured
- [ ] Default.aspx set as start page
- [ ] Solution builds successfully
- [ ] Application runs in browser
- [ ] Can login with admin account
- [ ] Can take quiz as user
- [ ] All features working

---

## 📞 Support

**Having issues?**

1. 📖 Check [LOCALHOST_SETUP.md](LOCALHOST_SETUP.md) for detailed troubleshooting
2. 🐛 Open an [Issue](https://github.com/shubhamjadhav0715/OnlineQuizApplication/issues)
3. 📧 Email: itsmeshubzz07@gmail.com

---

<div align="center">

### 🌟 **That's It! You're Ready to Go!**

**Made with ❤️ by Shubham Jadhav**

⭐ **Star this repository if you find it helpful!**

**Repository:** https://github.com/shubhamjadhav0715/OnlineQuizApplication

[⬆ Back to Top](#-quick-start---run-in-5-minutes)

</div>