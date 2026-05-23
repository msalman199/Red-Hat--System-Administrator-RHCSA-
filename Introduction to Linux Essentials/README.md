# 🐧 Introduction to Linux Essentials

## 🎯 Objectives

By the end of this lab, students will be able to:

- Navigate the Linux command-line interface with confidence
- Execute fundamental Linux commands for file and directory operations
- Understand the Linux directory structure and filesystem hierarchy
- Use manual pages (`man`) to explore command documentation
- Apply basic command-line skills essential for system administration
- Demonstrate terminal proficiency required for RHCSA certification

---

# 📋 Prerequisites

Before starting this lab, students should have:

- 💻 Basic computer literacy
- 📁 Understanding of files and folders
- 🐧 No prior Linux experience required
- 🌐 Access to a web browser for the cloud-based lab environment

---

# ☁️ Lab Environment Setup

## 🛠️ Ready-to-Use Cloud Machines

Al Nafi provides pre-configured Linux-based cloud machines for this lab.

### ✅ Your Cloud Machine Includes:

- CentOS/RHEL-based Linux distribution
- Pre-configured terminal access
- Necessary Linux tools and commands
- Persistent lab storage

---

# 🚀 Task 1: Getting Started with the Terminal and Basic Commands

---

# 🔹 Subtask 1.1: Opening and Understanding the Terminal

## 🛠️ Step 1: Access Your Terminal

- Click the terminal icon from the taskbar
- OR press:

```bash
Ctrl + Alt + T
```

Expected Prompt:

```bash
[student@lab-machine ~]$
```

---

## 🛠️ Step 2: Understanding the Command Prompt

| Component | Meaning |
|---|---|
| `student` | Username |
| `lab-machine` | Hostname |
| `~` | Home directory |
| `$` | Regular user |

---

# 🔹 Subtask 1.2: Using the `pwd` Command

## 🛠️ Step 1: Check Current Location

```bash
pwd
```

### ✅ Expected Output

```bash
/home/student
```

### 📘 Explanation

`pwd` means:

```bash
Print Working Directory
```

It displays your current location in the Linux filesystem.

---

# 🔹 Subtask 1.3: Exploring with the `ls` Command

## 🛠️ Step 1: List Directory Contents

```bash
ls
```

---

## 🛠️ Step 2: Detailed File Information

```bash
ls -l
```

---

## 🛠️ Step 3: Show Hidden Files

```bash
ls -la
```

---

## 🛠️ Step 4: Human Readable File Sizes

```bash
ls -lh
```

---

## 📘 Understanding the Output

- First column → File permissions
- Owner and group information
- File sizes and dates
- Hidden files begin with `.`

---

# 🔹 Subtask 1.4: Navigating with the `cd` Command

## 🛠️ Step 1: Go to Root Directory

```bash
cd /
```

---

## 🛠️ Step 2: Verify Location

```bash
pwd
```

### ✅ Expected Output

```bash
/
```

---

## 🛠️ Step 3: List Root Directory

```bash
ls
```

---

## 🛠️ Step 4: Return Home Using `~`

```bash
cd ~
```

---

## 🛠️ Step 5: Verify Home Directory

```bash
pwd
```

---

## 🛠️ Step 6: Use Relative Paths

```bash
cd ..
ls
pwd
```

---

## 🛠️ Step 7: Return Home Quickly

```bash
cd
pwd
```

---

# 📘 Key Navigation Tips

```bash
cd /        # Root directory
cd ~        # Home directory
cd ..       # One level up
cd -        # Previous directory
```

---

# 🗂️ Task 2: Understanding Linux Directory Structure

---

# 🔹 Subtask 2.1: Exploring the Root Filesystem

## 🛠️ Step 1: Explore Root Filesystem

```bash
cd /
ls -l
```

---

## 🛠️ Step 2: Examine Important Directories

### 📂 Explore `/bin`

```bash
ls /bin | head -10
```

### 📂 Explore `/etc`

```bash
ls /etc | head -10
```

### 📂 Explore `/home`

```bash
ls /home
```

### 📂 Explore `/var`

```bash
ls /var
```

### 📂 Explore `/usr`

```bash
ls /usr
```

---

# 🔹 Subtask 2.2: Understanding Directory Purposes

## 🛠️ Step 1: Learn System Directories

| Directory | Purpose |
|---|---|
| `/bin` | Essential binaries |
| `/etc` | Configuration files |
| `/home` | User directories |
| `/root` | Root user home |
| `/var` | Variable data |
| `/usr` | User programs |
| `/tmp` | Temporary files |
| `/dev` | Device files |
| `/proc` | Process information |
| `/sys` | System information |

---

## 🛠️ Step 2: Verify Directories

```bash
ls /tmp
ls /dev | head -5
ls /proc | head -5
```

---

# 🔹 Subtask 2.3: Working with Paths

## 🛠️ Step 1: Practice Absolute Paths

```bash
cd /usr/bin
pwd
ls | head -5
```

---

## 🛠️ Step 2: Practice Relative Paths

```bash
cd ../share
pwd

cd ../../home
pwd
```

---

## 🛠️ Step 3: Return Home

```bash
cd
pwd
```

---

# 📖 Task 3: Using Manual Pages (`man`)

---

# 🔹 Subtask 3.1: Introduction to Manual Pages

## 🛠️ Step 1: Open `ls` Manual

```bash
man ls
```

---

# 📘 Man Page Navigation

| Key | Action |
|---|---|
| Space | Next page |
| b | Previous page |
| / | Search |
| q | Quit |

---

## 🛠️ Step 2: Search Inside Manual

Search for:

```bash
/color
```

Then:

- Press `n` for next match
- Press `q` to exit

---

# 🔹 Subtask 3.2: Exploring Manuals

## 🛠️ Step 1: View `pwd` Manual

```bash
man pwd
```

---

## 🛠️ Step 2: View `cd` Help

```bash
man cd
```

If unavailable:

```bash
help cd
```

---

## 🛠️ Step 3: Open `find` Manual

```bash
man find
```

---

## 🛠️ Step 4: Use `whatis`

```bash
whatis ls
whatis pwd
whatis cp
whatis mv
```

---

# 🔹 Subtask 3.3: Manual Sections

## 🛠️ Step 1: Open Manual About Manuals

```bash
man man
```

---

## 🛠️ Step 2: Explore Sections

```bash
man 1 passwd
man 5 passwd
```

---

# 📘 Manual Sections Explained

| Section | Description |
|---|---|
| 1 | User commands |
| 2 | System calls |
| 3 | Library functions |
| 4 | Device files |
| 5 | Config files |
| 6 | Games |
| 7 | Miscellaneous |
| 8 | Admin commands |

---

# 🔹 Subtask 3.4: Finding Commands with `apropos`

## 🛠️ Step 1: Search File Commands

```bash
apropos file | head -10
```

---

## 🛠️ Step 2: Search Directory Commands

```bash
apropos directory | head -5
```

---

## 🛠️ Step 3: Search Text Commands

```bash
apropos text | head -5
```

---

# 🧪 Additional Practice Exercises

---

# 🔹 Exercise 1: Command Combination Practice

## 🛠️ Step 1: Combine Commands

```bash
cd /
pwd
ls -la | head -10

cd /usr/bin
ls | wc -l

cd
pwd
```

---

# 🔹 Exercise 2: Exploring Your Environment

## 🛠️ Step 1: Discover System Information

```bash
whoami
hostname
date
uptime
```

---

## 🛠️ Step 2: Explore Home Directory

```bash
cd
ls -la

file .bashrc
file .bash_profile
```

---

# ⚠️ Troubleshooting Common Issues

---

# 🔹 Issue 1: Command Not Found

## ❌ Problem

```bash
command not found
```

## ✅ Solution

```bash
which commandname
echo $PATH
```

---

# 🔹 Issue 2: Permission Denied

## ❌ Problem

Cannot access system directories.

## ✅ Solution

- Use:

```bash
ls -l
```

- Some directories require root access

---

# 🔹 Issue 3: Manual Page Not Found

## ❌ Problem

```bash
No manual entry
```

## ✅ Solution

```bash
help commandname
commandname --help
```

---

# 📚 Key Commands Summary

## 🧭 Navigation Commands

```bash
pwd
cd
cd ~
cd ..
cd -
```

---

## 📂 File Listing Commands

```bash
ls
ls -l
ls -la
ls -lh
```

---

## 📖 Help Commands

```bash
man command
help command
whatis command
apropos keyword
```

---

## 🖥️ System Information Commands

```bash
whoami
hostname
date
uptime
```

---

# 🎉 Conclusion

Congratulations! You have successfully completed:

# 🐧 Lab 1: Introduction to Linux Essentials

---

# ✅ Key Achievements

- Mastered terminal navigation
- Learned essential Linux commands
- Understood Linux filesystem hierarchy
- Used manual pages for self-learning
- Built foundational RHCSA skills

---

# 🚀 Why This Matters

These Linux fundamentals are critical for:

- RHCSA Certification
- Linux System Administration
- DevOps Engineering
- Cloud Computing
- Cybersecurity
- IT Career Growth

---

# 📈 Next Steps

You are now ready to learn:

- File management
- Text processing
- User management
- Permissions
- Shell scripting
- System configuration

---

# 💡 Practice Reminder

The more you practice Linux commands, the more natural they become.

Practice daily to build confidence and command-line proficiency.

---

# 🏆 Author

**Hafiz Muhammad Salman**  
Linux & DevOps Enthusiast 🚀

---
