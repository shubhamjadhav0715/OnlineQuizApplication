# 🎯 How to Run This Application on Your Localhost

<div align="center">

**Simple, Visual Guide for Beginners**

No technical jargon - just follow the pictures and steps!

</div>

---

## 📋 What You Need

Before starting, download and install these (if you don't have them):

### **1. Visual Studio 2022** (Free)
- 🔗 Download: https://visualstudio.microsoft.com/downloads/
- ✅ Choose: **Community Edition** (it's free!)
- ⏱️ Installation time: ~30-60 minutes
- 💾 Space needed: ~10 GB

**During installation, select:**
- ✅ ASP.NET and web development
- ✅ .NET desktop development

### **2. SQL Server** (Comes with Visual Studio)
- ✅ Already included with Visual Studio 2022
- ✅ Called "LocalDB" - no extra setup needed!

---

## 🚀 Step-by-Step Guide

### **STEP 1: Get the Code** 📥

#### **Option A: Download ZIP (Easiest)**

1. Go to: https://github.com/shubhamjadhav0715/OnlineQuizApplication
2. Click the green **"Code"** button
3. Click **"Download ZIP"**
4. Save to your computer (e.g., `C:\Projects\`)
5. **Right-click** the ZIP file → **Extract All**
6. Choose location: `C:\Projects\OnlineQuizApplication`

#### **Option B: Use Git (If you have it)**

```bash
# Open Command Prompt (Win + R, type "cmd", press Enter)
cd C:\Projects
git clone https://github.com/shubhamjadhav0715/OnlineQuizApplication.git
```

---

### **STEP 2: Create the Database** 🗄️

#### **Using Visual Studio (Recommended)**

1. **Open Visual Studio 2022**
   - Double-click the Visual Studio icon on your desktop

2. **Open SQL Server Object Explorer**
   - Click **View** menu (top)
   - Click **SQL Server Object Explorer**
   - A panel opens on the left side

3. **Find Your Database Server**
   - Look for: **SQL Server**
   - Click the ▶ arrow to expand
   - You'll see: **(localdb)\MSSQLLocalDB**
   - Click the ▶ arrow to expand it
   - You'll see: **Databases**

4. **Create New Database**
   - Right-click on **Databases**
   - Click **New Query**
   - A blank window opens

5. **Run the Database Script**
   - Go to: `C:\Projects\OnlineQuizApplication\Database\`
   - Open `QuizDB.sql` with Notepad
   - Press **Ctrl + A** (select all)
   - Press **Ctrl + C** (copy)
   - Go back to Visual Studio query window
   - Press **Ctrl + V** (paste)
   - Press **Ctrl + Shift + E** (execute)
   - Wait for "Command completed successfully"

6. **Verify Database Created**
   - Right-click **Databases** → **Refresh**
   - You should see **QuizDB** in the list
   - Click ▶ next to **QuizDB**
   - Click ▶ next to **Tables**
   - You should see 4 tables:
     - ✅ Users
     - ✅ Questions
     - ✅ QuizAttempts
     - ✅ UserAnswers

---

### **STEP 3: Open the Project** 📂

1. **Navigate to Project Folder**
   - Open File Explorer (Win + E)
   - Go to: `C:\Projects\OnlineQuizApplication\OnlineQuizApplication\`
   - You'll see many files

2. **Find Default.aspx**
   - Look for a file named **Default.aspx**
   - It has a white page icon

3. **Open with Visual Studio**
   - **Right-click** on **Default.aspx**
   - Hover over **"Open with"**
   - Click **"Visual Studio 2022"**
   - Visual Studio opens with the project

4. **Wait for Project to Load**
   - You'll see "Solution Explorer" on the right
   - Wait until all files appear (takes 5-10 seconds)

---

### **STEP 4: Configure the Project** ⚙️

#### **A. Check Connection String**

1. **Open Web.config**
   - In **Solution Explorer** (right panel)
   - Find **Web.config**
   - Double-click to open

2. **Find Connection String**
   - Press **Ctrl + F** (Find)
   - Type: `connectionStrings`
   - Press Enter

3. **Verify It Looks Like This:**
   ```xml
   <connectionStrings>
       <add name="QuizDB" 
            connectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=QuizDB;Integrated Security=True" 
            providerName="System.Data.SqlClient" />
   </connectionStrings>
   ```

4. **If Different, Update It:**
   - Copy the text above
   - Replace the existing `<connectionStrings>` section
   - Press **Ctrl + S** to save

#### **B. Set Start Page**

1. **Find Default.aspx in Solution Explorer**
   - Look in the right panel
   - Find **Default.aspx**

2. **Set as Start Page**
   - **Right-click** on **Default.aspx**
   - Click **"Set As Start Page"**
   - Default.aspx should now be **bold**

#### **C. Build the Project**

1. **Clean Solution**
   - Click **Build** menu (top)
   - Click **Clean Solution**
   - Wait for "Clean succeeded"

2. **Rebuild Solution**
   - Click **Build** menu (top)
   - Click **Rebuild Solution**
   - Wait for "Build succeeded" (takes 10-30 seconds)
   - Check the **Output** window at bottom

3. **If Build Fails:**
   - Find **App_Code** folder in Solution Explorer
   - **Right-click** on **App_Code**
   - Click **Properties**
   - Change **Build Action** to **Compile**
   - Click **Build** → **Rebuild Solution** again

---

### **STEP 5: Run the Application** ▶️

1. **Press F5**
   - Just press the **F5** key on your keyboard
   - OR click the green **▶ Start** button at the top

2. **Wait for Browser to Open**
   - Visual Studio compiles the code (10-20 seconds)
   - Your default browser opens automatically
   - The application loads

3. **You Should See:**
   - 🎨 Beautiful purple gradient header
   - 📝 "Welcome to Online Quiz Application"
   - 🔘 "Get Started" and "Login" buttons
   - 📊 Statistics cards
   - ✨ Smooth animations

---

## 🎉 Success! What to Do Next?

### **Test the Application:**

#### **1. Login as Admin**
```
Email: admin@quiz.com
Password: admin123
```

**What you can do:**
- ✅ View dashboard with statistics
- ✅ Add new quiz questions
- ✅ Edit existing questions
- ✅ Delete questions
- ✅ View all user results

#### **2. Login as User**
```
Email: john@example.com
Password: user123
```

**What you can do:**
- ✅ Take a quiz (10 random questions)
- ✅ View your results
- ✅ Check your quiz history

#### **3. Create Your Own Account**
- Click **"Register"**
- Fill in your details
- Create account
- Login and take quizzes!

---

## 🐛 Something Not Working?

### **Problem: "Database does not exist"**

**Solution:**
1. Go back to **STEP 2**
2. Make sure you executed the SQL script
3. Check if **QuizDB** appears in databases list
4. If not, try again from STEP 2

---

### **Problem: "Please select a valid startup item"**

**Solution:**
1. In Solution Explorer, find **Default.aspx**
2. Right-click → **Set As Start Page**
3. Press **F5** again

---

### **Problem: "Build failed" or Red Errors**

**Solution:**
1. Find **App_Code** folder in Solution Explorer
2. Right-click → **Properties**
3. Change **Build Action** to **Compile**
4. Click **Build** → **Rebuild Solution**

---

### **Problem: Page Looks Plain (No Colors/Design)**

**Solution:**
1. Press **Ctrl + Shift + Delete** in browser
2. Check **"Cached images and files"**
3. Click **"Clear data"**
4. Close browser
5. Press **F5** in Visual Studio again

---

### **Problem: Can't Login**

**Solution:**
1. Make sure you executed the database script (STEP 2)
2. Try these credentials:
   - Email: `admin@quiz.com`
   - Password: `admin123`
3. Check if **Users** table has data:
   - SQL Server Object Explorer
   - QuizDB → Tables → Users → Right-click → View Data

---

### **Problem: SQL Server Not Running**

**Solution:**
1. Press **Win + R**
2. Type: `services.msc`
3. Press Enter
4. Find **SQL Server (MSSQLSERVER)** or **SQL Server (SQLEXPRESS)**
5. Right-click → **Start**

---

## 📞 Still Need Help?

### **Check These Guides:**

| Guide | Best For |
|-------|----------|
| **[QUICK_START.md](QUICK_START.md)** | Quick 5-minute setup |
| **[LOCALHOST_SETUP.md](LOCALHOST_SETUP.md)** | Detailed step-by-step with troubleshooting |
| **[README.md](README.md)** | Complete documentation |

### **Contact:**
- 📧 Email: itsmeshubzz07@gmail.com
- 🐛 Report Issue: [GitHub Issues](https://github.com/shubhamjadhav0715/OnlineQuizApplication/issues)

---

## ✅ Checklist

Use this to make sure everything is done:

- [ ] Visual Studio 2022 installed
- [ ] Project downloaded/cloned
- [ ] Database created (QuizDB)
- [ ] SQL script executed
- [ ] 4 tables created with data
- [ ] Project opened in Visual Studio
- [ ] Web.config connection string correct
- [ ] Default.aspx set as start page
- [ ] Solution builds successfully (no errors)
- [ ] Application runs in browser
- [ ] Home page displays with design
- [ ] Can login with admin credentials
- [ ] Can take quiz as user

---

## 💡 Pro Tips

### **Keyboard Shortcuts:**
- **F5** - Run with debugging
- **Ctrl + F5** - Run without debugging (faster)
- **Ctrl + Shift + B** - Build project
- **Ctrl + S** - Save file
- **Ctrl + F** - Find in file

### **Development Tips:**
- 🔍 Use **Solution Explorer** to navigate files
- 📊 Check **Output** window for build messages
- 🐛 Use **Error List** to see errors
- 💾 Save often (Ctrl + S)

### **Testing Tips:**
- 👤 Create multiple user accounts
- 📝 Add your own quiz questions
- 🎯 Take quizzes with different scores
- 📊 Check admin dashboard for stats

---

## 🎓 What You've Learned

By completing this setup, you've learned:

- ✅ How to use Visual Studio 2022
- ✅ How to create SQL Server databases
- ✅ How to run ASP.NET Web Forms applications
- ✅ How to configure connection strings
- ✅ How to build and debug projects
- ✅ Basic troubleshooting skills

---

<div align="center">

## 🌟 Congratulations!

**You've successfully set up and run your Online Quiz Application!**

### **What's Next?**

1. ✅ Explore all features
2. ✅ Customize the design
3. ✅ Add your own questions
4. ✅ Learn from the code
5. ✅ Build something amazing!

---

**Made with ❤️ by Shubham Jadhav**

⭐ **Star this repository if you find it helpful!**

**Repository:** https://github.com/shubhamjadhav0715/OnlineQuizApplication

[⬆ Back to Top](#-how-to-run-this-application-on-your-localhost)

</div>