# 🚀 SUPER SIMPLE RUN GUIDE - Online Quiz Application

## ✅ **FOLLOW THESE EXACT STEPS - DON'T SKIP ANY!**

---

## 📋 **WHAT YOU NEED FIRST:**

1. ✅ **Visual Studio 2022** (NOT VS Code) - Download from: https://visualstudio.microsoft.com/downloads/
   - Install with **"ASP.NET and web development"** workload
2. ✅ **SQL Server** (LocalDB comes with Visual Studio 2022)

---

## 🎯 **STEP-BY-STEP GUIDE**

---

### **STEP 1: CLONE THE REPOSITORY**

Open Command Prompt or Git Bash and run:

```bash
git clone https://github.com/shubhamjadhav0715/OnlineQuizApplication.git
cd OnlineQuizApplication
```

**OR** Download ZIP:
1. Go to: https://github.com/shubhamjadhav0715/OnlineQuizApplication
2. Click **Code** → **Download ZIP**
3. Extract to: `C:\Projects\OnlineQuizApplication`

---

### **STEP 2: CREATE THE DATABASE**

1. **Open SQL Server Management Studio (SSMS)**
   - If you don't have it, use Visual Studio's SQL Server Object Explorer

2. **Connect to:** `(localdb)\MSSQLLocalDB`

3. **Open the SQL file:**
   - File → Open → File
   - Navigate to: `OnlineQuizApplication\Database\QuizDB.sql`
   - Click **Execute** (F5)

4. **Verify database created:**
   ```sql
   USE QuizDB;
   SELECT COUNT(*) FROM Users;      -- Should show 3
   SELECT COUNT(*) FROM Questions;  -- Should show 30
   ```

---

### **STEP 3: OPEN PROJECT IN VISUAL STUDIO 2022**

**METHOD 1 - Using File Explorer (EASIEST):**

1. Open File Explorer
2. Navigate to: `OnlineQuizApplication\OnlineQuizApplication\`
3. Find **`Default.aspx`** file
4. **Right-click** on `Default.aspx`
5. Click **"Open with"** → **"Visual Studio 2022"**
6. Visual Studio will open

**METHOD 2 - Using Visual Studio:**

1. Open **Visual Studio 2022**
2. Click **File** → **Open** → **Web Site...**
3. Browse to: `OnlineQuizApplication\OnlineQuizApplication\`
4. Click **"Open"** or **"Select Folder"**

---

### **STEP 4: UPDATE CONNECTION STRING**

1. In **Solution Explorer** (right panel), find and open **Web.config**
2. Find the `<connectionStrings>` section (around line 6-10)
3. Make sure it looks like this:

```xml
<connectionStrings>
  <add name="QuizDBConnection" 
       connectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=QuizDB;Integrated Security=True" 
       providerName="System.Data.SqlClient"/>
</connectionStrings>
```

4. **Save** the file (Ctrl+S)

---

### **STEP 5: SET DEFAULT.ASPX AS START PAGE**

1. In **Solution Explorer** (right panel), find **Default.aspx**
2. **Right-click** on **Default.aspx**
3. Click **"Set As Start Page"**

---

### **STEP 6: BUILD THE PROJECT**

1. Click **Build** → **Build Web Site** (or press **Ctrl+Shift+B**)
2. Check the **Output** window at the bottom
3. Should see: **"Build succeeded"**

**If you get errors:**
- Right-click on **App_Code** folder → Properties → Build Action → **Compile**
- Rebuild: **Build** → **Rebuild Web Site**

---

### **STEP 7: RUN THE APPLICATION**

1. **Press F5** on your keyboard
   - OR click the **green play button** ▶️ at the top

2. **Your browser will open** with the application

3. **You should see:** Online Quiz Application Home Page

---

### **STEP 8: LOGIN AND TEST**

**Admin Login:**
```
Email: admin@quiz.com
Password: admin123
```

**What you can do as Admin:**
- View Dashboard with statistics
- Add new questions
- Edit/Delete questions
- View all quiz results

**User Login:**
```
Email: john@example.com
Password: user123
```

**What you can do as User:**
- Take quiz (10 random questions)
- View results
- View quiz history

---

## 🚨 **COMMON ERRORS & FIXES**

---

### **Error 1: "Database does not exist"**

**Fix:**
1. Open SQL Server Object Explorer in Visual Studio
2. Expand **(localdb)\MSSQLLocalDB** → **Databases**
3. Check if **QuizDB** exists
4. If not, re-run the SQL script from Step 2

---

### **Error 2: "Could not find type 'SiteMaster'"**

**Fix:**
1. Make sure both **Site.Master** and **Site.Master.cs** are in the project
2. Clean solution: **Build** → **Clean Web Site**
3. Rebuild: **Build** → **Rebuild Web Site**

---

### **Error 3: "Please select a valid startup item"**

**Fix:**
1. Right-click on **Default.aspx** in Solution Explorer
2. Click **"Set As Start Page"**
3. Press F5 again

---

### **Error 4: "App_Code compilation error"**

**Fix:**
1. Right-click on **App_Code** folder
2. Click **Properties**
3. Set **Build Action** to **Compile**
4. Rebuild the project

---

### **Error 5: "Connection string error"**

**Fix:**
Update Web.config connection string to match your SQL Server:

**For LocalDB (default):**
```xml
Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=QuizDB;Integrated Security=True
```

**For SQL Server Express:**
```xml
Data Source=.\SQLEXPRESS;Initial Catalog=QuizDB;Integrated Security=True
```

**For SQL Server:**
```xml
Data Source=localhost;Initial Catalog=QuizDB;Integrated Security=True
```

---

## 📁 **PROJECT STRUCTURE**

After opening, you should see:

```
OnlineQuizApplication/
├── Admin/
│   ├── Dashboard.aspx
│   ├── AddQuestion.aspx
│   ├── ManageQuestions.aspx
│   └── ViewResults.aspx
├── User/
│   ├── Register.aspx
│   ├── Login.aspx
│   ├── Quiz.aspx
│   ├── Result.aspx
│   └── History.aspx
├── App_Code/
│   ├── DBHelper.cs
│   ├── AuthManager.cs
│   └── QuizManager.cs
├── Styles/
│   └── site.css
├── Scripts/
│   └── site.js
├── Web.config
├── Site.Master
└── Default.aspx
```

---

## ✅ **VERIFICATION CHECKLIST**

After running, verify:

- [ ] Home page loads
- [ ] Can register new user
- [ ] Can login as user
- [ ] Can take quiz
- [ ] Can view results
- [ ] Can login as admin
- [ ] Admin dashboard shows statistics
- [ ] Can add questions
- [ ] Can edit/delete questions
- [ ] Can view all results

---

## 🎯 **QUICK TROUBLESHOOTING**

**Application won't run?**
1. Make sure you're using **Visual Studio 2022** (not VS Code)
2. Make sure database is created
3. Make sure Default.aspx is set as start page
4. Try **Clean** then **Rebuild**

**Database connection fails?**
1. Check SQL Server is running
2. Verify connection string in Web.config
3. Test connection in SQL Server Object Explorer

**Build errors?**
1. Check all files are in correct folders
2. Set App_Code build action to Compile
3. Clean and rebuild

---

## 📞 **STILL HAVING ISSUES?**

1. Check **Error List** window: View → Error List
2. Check **Output** window for detailed errors
3. Make sure all prerequisites are installed
4. Verify database has data (3 users, 30 questions)

---

## 🎉 **SUCCESS!**

If you see the home page and can login, **CONGRATULATIONS!** 

Your Online Quiz Application is running successfully!

**Enjoy testing your quiz application!** 🚀

---

**Repository:** https://github.com/shubhamjadhav0715/OnlineQuizApplication  
**Developer:** Shubham Jadhav  
**Email:** itsmeshubzz07@gmail.com

---

**Last Updated:** February 26, 2026  
**Version:** 1.0.0  
**Status:** Production Ready ✅
