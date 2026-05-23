# 🐧 Navigating the Linux File System

## 📌 Lab Overview

This lab introduces the fundamentals of navigating the Linux file system using essential command-line tools. You will explore Linux directory structures, understand absolute and relative paths, and learn how to locate files efficiently using commands like `find`, `locate`, and `which`.

---

# 🎯 Objectives

By the end of this lab, students will be able to:

- Understand the hierarchical structure of the Linux file system
- Navigate the file system using both absolute and relative paths
- Use essential file location commands: `find`, `locate`, and `which`
- Distinguish between different types of paths and when to use each
- Apply file system navigation skills in real-world scenarios

---

# 📚 Prerequisites

Before starting this lab, students should have:

- Basic understanding of operating systems
- Familiarity with files and folders
- Access to a Linux terminal or command line
- Basic command typing skills

> 💡 **Note:** Al Nafi provides ready-to-use Linux cloud machines. Simply click **Start Lab** to begin.

---

# 🖥️ Lab Environment Setup

Your Al Nafi cloud machine comes pre-configured with:

- CentOS/RHEL-based Linux distribution
- Pre-installed Linux utilities
- Standard Linux filesystem hierarchy
- Sample practice files and directories

---

# 📂 Task 1: Explore Different File System Paths

---

## 🔹 Understanding Linux File System Structure

Linux uses a hierarchical tree structure beginning from the root directory `/`.

---

## 🛠️ Subtask 1.1: Examine the Root Directory

### 🔧 Display Current Working Directory

```bash
pwd
```

### 🔧 Navigate to Root Directory

```bash
cd /
```

### 🔧 List Root Directory Contents

```bash
ls -la
```

### 🔧 Explore Important System Directories

```bash
# System binaries
ls /bin

# User home directories
ls /home

# System configuration files
ls /etc

# Variable data files
ls /var
```

---

## 🛠️ Subtask 1.2: Navigate Using Absolute Paths

### 📌 What is an Absolute Path?

An absolute path starts from `/` and shows the full location.

### 🔧 Navigate to Home Directory

```bash
cd /home/$(whoami)
```

### 🔧 Create Directory Structure

```bash
mkdir -p /home/$(whoami)/lab2/documents/projects
mkdir -p /home/$(whoami)/lab2/downloads
mkdir -p /home/$(whoami)/lab2/scripts
```

### 🔧 Navigate Using Absolute Paths

```bash
# Go to projects directory
cd /home/$(whoami)/lab2/documents/projects

# Verify current location
pwd

# Go to downloads directory
cd /home/$(whoami)/lab2/downloads

# Verify current location
pwd
```

---

## 🛠️ Subtask 1.3: Navigate Using Relative Paths

### 📌 What is a Relative Path?

A relative path works from your current directory and does not begin with `/`.

### 🔧 Start from Home Directory

```bash
cd ~
```

### 🔧 Navigate Using Relative Paths

```bash
# Move into lab2
cd lab2

# Move into documents
cd documents

# Move up one level
cd ..

# Move into scripts
cd scripts

# Move up two levels
cd ../..
```

### 🔧 Practice Special Relative Symbols

```bash
# Current directory
ls .

# Parent directory
ls ..

# Go to parent
cd ..

# Return to previous directory
cd -
```

---

## 🛠️ Subtask 1.4: Create Sample Files for Testing

### 🔧 Create Sample Files

```bash
touch ~/lab2/documents/report.txt
touch ~/lab2/documents/projects/project1.txt
touch ~/lab2/downloads/software.tar.gz
touch ~/lab2/scripts/backup.sh
```

### 🔧 Create Executable Script

```bash
echo '#!/bin/bash' > ~/lab2/scripts/hello.sh
echo 'echo "Hello, World!"' >> ~/lab2/scripts/hello.sh
chmod +x ~/lab2/scripts/hello.sh
```

### 🔧 Verify Files

```bash
find ~/lab2 -type f
```

---

# 🔎 Task 2: Use find, locate, and which to Locate Files

---

## 🛠️ Subtask 2.1: Using the find Command

### 📌 About find

`find` searches files and directories in real-time.

### 🔧 Basic Examples

```bash
# Find all files
find ~/lab2 -type f

# Find directories
find ~/lab2 -type d

# Find text files
find ~/lab2 -name "*.txt"

# Case-insensitive search
find ~/lab2 -iname "*.TXT"
```

### 🔧 Advanced find Usage

```bash
# Files modified in last 10 minutes
find ~/lab2 -mtime -10

# Find executable files
find ~/lab2 -type f -executable

# Find files larger than 0 bytes
find ~/lab2 -type f -size +0c

# Execute commands on results
find ~/lab2 -name "*.sh" -exec ls -la {} \;
```

### 🔧 Find System Files

```bash
# Configuration files
find /etc -name "*.conf" 2>/dev/null | head -10

# Log files
find /var/log -name "*.log" 2>/dev/null | head -5
```

---

## 🛠️ Subtask 2.2: Using the locate Command

### 📌 About locate

`locate` uses a pre-built database for fast searching.

### 🔧 Update Database

```bash
sudo updatedb
```

### 🔧 Locate Files

```bash
# Locate by filename
locate report.txt

# Locate pattern
locate "*.conf" | head -10

# Case-insensitive locate
locate -i REPORT.TXT

# Count results
locate -c "*.log"
```

### 🔧 Compare locate vs find

```bash
# Time locate
time locate passwd

# Time find
time find / -name "passwd" 2>/dev/null
```

---

## 🛠️ Subtask 2.3: Using the which Command

### 📌 About which

`which` finds executable programs in your PATH.

### 🔧 Locate Commands

```bash
which ls
which find
which bash
which python3
```

### 🔧 Multiple Commands

```bash
which ls find grep awk
```

### 🔧 Display PATH Variable

```bash
echo $PATH
```

### 🔧 Show All Command Locations

```bash
which -a python
```

### 🔧 Add Custom Script to PATH

```bash
export PATH=$PATH:~/lab2/scripts
```

### 🔧 Locate Custom Script

```bash
which hello.sh
```

### 🔧 Execute Script

```bash
hello.sh
```

---

# 🧭 Task 3: Practice Using Relative and Absolute Paths

---

## 🛠️ Subtask 3.1: Path Navigation Exercises

### 🔧 Create Complex Structure

```bash
mkdir -p ~/lab2/company/{hr,finance,it}/{reports,archives}
mkdir -p ~/lab2/company/it/{servers,workstations}
```

### 🔧 Practice Navigation

```bash
# Start from home
cd ~

# Absolute path
cd ~/lab2/company/it

# Relative path
cd servers

# Move back
cd ..

# HR reports
cd ../hr/reports

# Finance archives
cd ~/lab2/company/finance/archives

# IT workstations
cd ../../it/workstations
```

---

## 🛠️ Subtask 3.2: File Operations with Different Paths

### 🔧 Create Files

```bash
echo "HR Report 2024" > ~/lab2/company/hr/reports/annual.txt
echo "Server Config" > ~/lab2/company/it/servers/config.txt
```

### 🔧 Copy Files

```bash
# Absolute paths
cp ~/lab2/company/hr/reports/annual.txt ~/lab2/company/finance/reports/

# Relative paths
cd ~/lab2/company/it/servers
cp config.txt ../workstations/
```

### 🔧 Move Files

```bash
cd ~/lab2/company/hr

mv reports/annual.txt archives/

ls archives/
ls reports/
```

---

## 🛠️ Subtask 3.3: Advanced Path Manipulation

### 🔧 Deep Navigation

```bash
cd ~/lab2/company/finance/archives

cd ../../../it/servers

cd ~/lab2/documents/projects
```

### 🔧 Toggle Between Directories

```bash
cd ~/lab2/company/hr/reports
cd -
cd -
```

### 🔧 Combine find with Paths

```bash
# Show absolute paths
find ~/lab2 -name "*.txt" -exec readlink -f {} \;

# Copy all text files
mkdir ~/lab2/all_txt_files
find ~/lab2 -name "*.txt" -exec cp {} ~/lab2/all_txt_files/ \;
```

---

# 🌍 Practical Real-World Scenarios

---

## 🖥️ Scenario 1: System Administration

```bash
# Configuration files
find /etc -name "*.conf" -type f 2>/dev/null | head -10

# Log files
find /var/log -name "*.log" -type f 2>/dev/null | head -5

# Recently modified logs
find /var/log -mtime -1 -type f 2>/dev/null
```

---

## 💻 Scenario 2: Development Environment Setup

```bash
mkdir -p ~/development/{projects,tools,documentation}
mkdir -p ~/development/projects/{web,mobile,desktop}

cd ~/development/projects/web
cd ../mobile
cd ../../tools
```

---

# 🛑 Troubleshooting Common Issues

---

## ⚠️ Permission Denied

```bash
find /etc -name "*.conf" 2>/dev/null
```

---

## ⚠️ locate Not Finding Files

```bash
sudo updatedb

find ~ -name "filename"
```

---

## ⚠️ Path Not Found

```bash
pwd

ls -la /path/to/directory

cd ~/lab2/[TAB][TAB]
```

---

# ✅ Verification and Testing

---

## 🔧 Navigation Test

```bash
cd ~

# Navigate using relative paths only

# Navigate using absolute paths
pwd
```

---

## 🔧 File Location Test

```bash
# Find shell scripts
find ~/lab2 -name "*.sh"

# Locate bash executable
which bash

# Files modified recently
find ~/lab2 -mtime -1
```

---

# 🎓 Conclusion

In this lab, you successfully learned:

- Linux filesystem hierarchy
- Absolute and relative path navigation
- Real-time file searching using `find`
- Fast searching using `locate`
- Executable discovery using `which`
- Real-world navigation and file management techniques

---

# 🚀 Why These Skills Matter

These Linux navigation skills are essential for:

- 🖥️ System Administration
- 💻 Software Development
- 📜 RHCSA Certification Preparation
- ⚙️ Daily Linux Usage

---

# 🔑 Key Takeaways

| Command | Purpose |
|---|---|
| `pwd` | Show current directory |
| `cd` | Change directory |
| `ls` | List files/directories |
| `find` | Search files in real-time |
| `locate` | Fast file lookup |
| `which` | Find executable locations |

---

# 📁 Recommended File Structure

```text
lab2/
├── documents/
│   ├── report.txt
│   └── projects/
│       └── project1.txt
├── downloads/
│   └── software.tar.gz
├── scripts/
│   ├── backup.sh
│   └── hello.sh
├── company/
│   ├── hr/
│   │   ├── reports/
│   │   └── archives/
│   ├── finance/
│   │   ├── reports/
│   │   └── archives/
│   └── it/
│       ├── servers/
│       ├── workstations/
│       ├── reports/
│       └── archives/
└── all_txt_files/
```

---

# 📖 Final Notes

Practice these commands regularly to improve speed and confidence in Linux environments. Mastering file system navigation is one of the most important foundational Linux skills for every system administrator and developer.

---
