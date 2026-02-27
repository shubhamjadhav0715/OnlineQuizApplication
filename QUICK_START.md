# ⚡ QUICK START - 5 Minutes to Run

## 🎯 **SUPER FAST SETUP**

---

### **1️⃣ CLONE**
```bash
git clone https://github.com/shubhamjadhav0715/OnlineQuizApplication.git
```

---

### **2️⃣ CREATE DATABASE**

Open **SQL Server Management Studio** or **Visual Studio SQL Server Object Explorer**:

```sql
-- Execute this file:
OnlineQuizApplication\Database\QuizDB.sql
```

---

### **3️⃣ OPEN IN VISUAL STUDIO 2022**

**Easiest way:**
1. Open File Explorer
2. Go to: `OnlineQuizApplication\OnlineQuizApplication\`
3. **Right-click** on `Default.aspx`
4. Click **"Open with Visual Studio 2022"**

---

### **4️⃣ SET START PAGE**

In Visual Studio:
1. **Right-click** on `Default.aspx` (in Solution Explorer)
2. Click **"Set As Start Page"**

---

### **5️⃣ RUN**

Press **F5**

---

## 🔑 **LOGIN**

**Admin:**
- Email: `admin@quiz.com`
- Password: `admin123`

**User:**
- Email: `john@example.com`
- Password: `user123`

---

## 🚨 **IF IT DOESN'T WORK**

### **Error: "Please select a valid startup item"**
→ Right-click Default.aspx → Set As Start Page → Press F5

### **Error: "Database does not exist"**
→ Re-run the SQL script: `Database\QuizDB.sql`

### **Error: "Build failed"**
→ Right-click App_Code folder → Properties → Build Action → Compile → Rebuild

### **Error: "Connection failed"**
→ Open Web.config → Update connection string:
```xml
Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=QuizDB;Integrated Security=True
```

---

## ✅ **THAT'S IT!**

Your application should now be running in your browser!

**Full guide:** See `SIMPLE_RUN_GUIDE.md` for detailed instructions.

---

**Repository:** https://github.com/shubhamjadhav0715/OnlineQuizApplication
