# Working with Text Processing Tools

## 📘 Objectives

By the end of this lab, you will be able to:

- Use `grep` to search for patterns and text within files
- Apply `sed` for search and replace operations on text files
- Create basic `awk` scripts for pattern scanning and data processing
- Combine text processing tools to solve real-world system administration tasks
- Understand command-line text manipulation for RHCSA exam preparation

---

# 📋 Prerequisites

Before starting this lab, you should have:

- Basic understanding of Linux command line navigation
- Familiarity with file creation and editing using `vi` or `nano`
- Knowledge of Linux file permissions
- Understanding of input/output redirection concepts

---

# 🖥️ Lab Environment Setup

This lab uses Linux-based cloud machines provided by Al Nafi.

Your environment includes:

- CentOS/RHEL Linux distribution
- Pre-installed text processing tools
- Practice sample files
- Full root access

---

# 🚀 Task 1: Using grep for Text Searching

## 🔧 Subtask 1.1: Basic grep Operations

### 🛠️ Tool: mkdir, cd

```bash
mkdir ~/textlab
cd ~/textlab
```

### 🛠️ Tool: cat

```bash
cat > system.log << 'EOF'
Jan 15 10:30:15 server1 sshd[1234]: Accepted password for admin from 192.168.1.100
Jan 15 10:31:22 server1 httpd[5678]: GET /index.html 200 OK
Jan 15 10:32:45 server1 sshd[1235]: Failed password for root from 192.168.1.200
Jan 15 10:33:10 server1 httpd[5679]: POST /login.php 404 Not Found
Jan 15 10:34:55 server1 sshd[1236]: Accepted password for user1 from 192.168.1.150
Jan 15 10:35:20 server1 kernel: Out of memory: Kill process 9876
Jan 15 10:36:30 server1 httpd[5680]: GET /admin.php 403 Forbidden
Jan 15 10:37:45 server1 sshd[1237]: Failed password for admin from 192.168.1.200
EOF
```

### 🛠️ Tool: cat

```bash
cat > users.txt << 'EOF'
john:x:1001:1001:John Smith:/home/john:/bin/bash
mary:x:1002:1002:Mary Johnson:/home/mary:/bin/bash
admin:x:1003:1003:System Admin:/home/admin:/bin/bash
guest:x:1004:1004:Guest User:/home/guest:/bin/false
root:x:0:0:Root User:/root:/bin/bash
EOF
```

### 🛠️ Tool: cat

```bash
cat > config.conf << 'EOF'
# Web Server Configuration
ServerName example.com
DocumentRoot /var/www/html
Port 80
Port 443
MaxClients 150
# Database Configuration
DBHost localhost
DBPort 3306
DBUser webapp
DBPassword secret123
# Security Settings
AllowOverride None
Options Indexes
EOF
```

---

## 🔧 Subtask 1.2: Basic Pattern Searching

### 🛠️ Tool: grep

```bash
grep "sshd" system.log
```

### 🛠️ Tool: grep

```bash
grep -i "failed" system.log
```

### 🛠️ Tool: grep

```bash
grep -c "httpd" system.log
```

### 🛠️ Tool: grep

```bash
grep -n "admin" system.log
```

---

## 🔧 Subtask 1.3: Advanced grep Options

### 🛠️ Tool: grep

```bash
grep -v "httpd" system.log
```

### 🛠️ Tool: mkdir, cp, grep

```bash
mkdir logs
cp system.log logs/
grep -r "Failed" .
```

### 🛠️ Tool: grep

```bash
grep -w "admin" users.txt
```

### 🛠️ Tool: grep

```bash
grep -E "sshd|httpd" system.log
```

### 🛠️ Tool: grep

```bash
grep "^Jan 15 10:3[0-5]" system.log
```

---

## 🔧 Subtask 1.4: Regular Expressions with grep

### 🛠️ Tool: grep

```bash
grep -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" system.log
```

### 🛠️ Tool: grep

```bash
grep "bash$" users.txt
```

### 🛠️ Tool: grep

```bash
grep "[0-9]" config.conf
```

### 🛠️ Tool: grep

```bash
grep "[A-Z]" config.conf
```

---

# 🚀 Task 2: Using sed for Search and Replace

## 🔧 Subtask 2.1: Basic sed Operations

### 🛠️ Tool: sed

```bash
sed -n '1,3p' users.txt
```

### 🛠️ Tool: sed

```bash
sed '2d' users.txt
```

### 🛠️ Tool: sed

```bash
sed 's/admin/administrator/' users.txt
```

### 🛠️ Tool: sed

```bash
sed 's/:/|/g' users.txt
```

---

## 🔧 Subtask 2.2: In-Place File Editing

### 🛠️ Tool: cp

```bash
cp config.conf config.conf.backup
```

### 🛠️ Tool: sed

```bash
sed -i 's/Port 80/Port 8080/' config.conf
```

### 🛠️ Tool: grep

```bash
grep "Port" config.conf
```

### 🛠️ Tool: sed

```bash
sed -i -e 's/localhost/127.0.0.1/' -e 's/secret123/newpassword/' config.conf
```

### 🛠️ Tool: cat

```bash
cat config.conf
```

---

# 🎯 Conclusion

In this lab, you learned how to use:

- `grep` for searching patterns
- `sed` for editing and replacing text
- `awk` for data processing and reporting

These tools are essential for Linux system administration, automation, troubleshooting, and RHCSA exam preparation.
