# 👥 Managing Users and Groups in Linux

> Complete RHCSA Practice Lab for Linux User & Group Administration

---

# 📌 Lab Objectives

By the end of this lab, you will be able to:

- 👤 Create Linux users using `useradd`
- 🛠️ Modify users using `usermod`
- 👥 Create and manage groups with `groupadd`
- 🔐 Configure passwords using `passwd`
- 🧩 Assign users to multiple groups
- 🔒 Apply Linux security best practices
- 📂 Understand Linux user/group configuration files

---

# 📚 Prerequisites

Before starting this lab, you should have:

- 💻 Basic Linux command-line knowledge
- 📁 Understanding of `cd`, `ls`, and `pwd`
- 🔑 Sudo or root access
- 🧠 Basic understanding of Linux permissions
- 🖥️ Access to a CentOS/RHEL-based Linux system

---

# ☁️ Lab Environment

Al Nafi provides:

- 🐧 Linux Cloud Machine
- 🔐 Root Access
- ⚙️ Pre-installed Utilities
- 🧪 Ready-to-use Environment

---

# 🛠️ Task 1 — Create Users with `useradd`

## 🔹 Step 1.1 — Switch to Root User

### 🧰 Command

```bash
sudo -i
```

### 🔍 Verify

```bash
whoami
```

Expected Output:

```bash
root
```

---

## 🔹 Step 1.2 — Create Basic User

### 🧰 Command

```bash
useradd john
```

### 🔍 Verify User

```bash
grep john /etc/passwd
```

Expected Output:

```bash
john:x:1001:1001::/home/john:/bin/bash
```

---

## 🔹 Step 1.3 — Create User with Custom Options

### 🧰 Command

```bash
useradd -c "Jane Smith, Marketing Department" -s /bin/bash -m -d /home/jsmith jsmith
```

### 📘 Command Breakdown

| Option | Purpose |
|---|---|
| `-c` | Add comment/full name |
| `-s` | Set login shell |
| `-m` | Create home directory |
| `-d` | Specify custom home directory |

### 🔍 Verify User

```bash
grep jsmith /etc/passwd
```

### 🔍 Verify Home Directory

```bash
ls -la /home/jsmith
```

---

## 🔹 Step 1.4 — Create System User

### 🧰 Command

```bash
useradd -r -s /sbin/nologin -c "Web Server User" webuser
```

### 📘 Explanation

| Option | Description |
|---|---|
| `-r` | Create system user |
| `-s /sbin/nologin` | Disable login shell |

### 🔍 Verify

```bash
grep webuser /etc/passwd
```

```bash
id webuser
```

---

# 🛠️ Task 2 — Modify Users with `usermod`

## 🔹 Step 2.1 — Change Home Directory

### 🧰 Create New Directory

```bash
mkdir /home/john_new
```

### 🧰 Modify Home Directory

```bash
usermod -d /home/john_new -m john
```

### 📘 Explanation

| Option | Purpose |
|---|---|
| `-d` | Set new home directory |
| `-m` | Move existing files |

### 🔍 Verify

```bash
grep john /etc/passwd
```

```bash
ls -la /home/john_new
```

---

## 🔹 Step 2.2 — Change User Shell

### 🧰 Install ZSH

```bash
yum install -y zsh
```

### 🧰 Change Shell

```bash
usermod -s /bin/zsh jsmith
```

### 🔍 Verify

```bash
grep jsmith /etc/passwd
```

---

## 🔹 Step 2.3 — Lock and Unlock User

### 🔒 Lock User

```bash
usermod -L john
```

### 🔍 Verify Lock

```bash
grep john /etc/shadow
```

> `!` in password field means account is locked.

### 🔓 Unlock User

```bash
usermod -U john
```

---

# 🛠️ Task 3 — Create and Manage Groups

## 🔹 Step 3.1 — Create Groups

### 🧰 Create Marketing Group

```bash
groupadd marketing
```

### 🧰 Create Developers Group

```bash
groupadd -g 2000 developers
```

### 🧰 Create System Group

```bash
groupadd -r services
```

### 🔍 Verify Groups

```bash
grep -E "(marketing|developers|services)" /etc/group
```

---

## 🔹 Step 3.2 — Assign Users to Groups

### 🧰 Set Primary Group

```bash
usermod -g marketing jsmith
```

### 🧰 Add Secondary Groups

```bash
usermod -G developers,marketing john
```

### ⚠️ Important

Use `-a -G` to append groups without removing existing memberships.

### 🧰 Append Additional Group

```bash
usermod -a -G services john
```

### 🔍 Verify Memberships

```bash
groups john
```

```bash
groups jsmith
```

```bash
id john
```

```bash
id jsmith
```

---

## 🔹 Step 3.3 — Create User with Group Assignments

### 🧰 Command

```bash
useradd -g developers -G marketing -c "Bob Developer" -m bdev
```

### 🔍 Verify

```bash
id bdev
```

```bash
groups bdev
```

---

# 🛠️ Task 4 — Manage Passwords

## 🔹 Step 4.1 — Set Passwords

### 🧰 Set Password for John

```bash
passwd john
```

### 🧰 Set Password for Jsmith

```bash
passwd jsmith
```

### 🧰 Set Password for Bdev

```bash
passwd bdev
```

---

## 🔹 Step 4.2 — Configure Password Policies

### 🧰 Set Password Expiration

```bash
chage -M 90 john
```

### 🧰 Set Minimum Password Age

```bash
chage -m 7 john
```

### 🧰 Set Warning Period

```bash
chage -W 7 john
```

### 🔍 Verify Password Policy

```bash
chage -l john
```

---

## 🔹 Step 4.3 — Force Password Change

### 🧰 Command

```bash
chage -d 0 jsmith
```

### 🔍 Verify

```bash
chage -l jsmith
```

---

# 🧪 Verification and Testing

## 🔹 Verify Users

### 🧰 Command

```bash
grep -E "(john|jsmith|bdev|webuser)" /etc/passwd
```

---

## 🔹 Verify Groups

### 🧰 Command

```bash
grep -E "(marketing|developers|services)" /etc/group
```

---

## 🔹 Switch User Test

### 🧰 Command

```bash
su - john
```

### 🧰 Verify Current User

```bash
whoami
```

### 🧰 Verify Groups

```bash
groups
```

### 🧰 Exit Session

```bash
exit
```

---

# 📁 File Ownership Testing

## 🔹 Create Files as Different Users

### 🧰 Command

```bash
su - john -c "touch /home/john_new/john_file.txt"
```

```bash
su - jsmith -c "touch /home/jsmith/jsmith_file.txt"
```

---

## 🔹 Verify Ownership

### 🧰 Command

```bash
ls -la /home/john_new/john_file.txt
```

```bash
ls -la /home/jsmith/jsmith_file.txt
```

---

# ⚙️ Advanced Configuration

## 🔹 Create Shared Group Directory

### 🧰 Create Directory

```bash
mkdir /shared/marketing
```

### 🧰 Change Group Ownership

```bash
chgrp marketing /shared/marketing
```

### 🧰 Set Permissions

```bash
chmod 770 /shared/marketing
```

### 🧰 Enable Group Collaboration

```bash
chmod g+s /shared/marketing
```

### 🔍 Verify

```bash
ls -la /shared/
```

---

# 🔍 User Default Settings

## 🔹 View Default Useradd Settings

### 🧰 Command

```bash
cat /etc/default/useradd
```

---

## 🔹 View Login Definitions

### 🧰 Command

```bash
cat /etc/login.defs | grep -E "(UID_MIN|GID_MIN|PASS_MAX_DAYS)"
```

---

# 🐞 Troubleshooting

## 🔹 Issue 1 — User Already Exists

### ❌ Error

```bash
user already exists
```

### ✅ Solution

```bash
id username
```

```bash
userdel username
```

---

## 🔹 Issue 2 — Permission Denied

### ✅ Solution

```bash
sudo -i
```

OR

```bash
sudo useradd username
```

---

## 🔹 Issue 3 — Home Directory Missing

### ✅ Solution

```bash
mkdir /home/username
```

```bash
cp -r /etc/skel/. /home/username/
```

```bash
chown -R username:username /home/username
```

---

## 🔹 Issue 4 — Group Assignment Failed

### ✅ Solution

```bash
groups username
```

```bash
usermod -a -G groupname username
```

```bash
id username
```

---

# 🔐 Security Best Practices

## 🔹 Strong Password Policies

### 🧰 Configuration File

```bash
/etc/security/pwquality.conf
```

---

## 🔹 Password Aging Settings

### 🧰 Configuration File

```bash
/etc/login.defs
```

### Recommended Settings

```bash
PASS_MAX_DAYS 90
PASS_MIN_DAYS 7
PASS_WARN_AGE 7
```

---

## 🔹 Lock Unused Accounts

### 🧰 Lock User

```bash
usermod -L username
```

### 🧰 Disable Login Shell

```bash
usermod -s /sbin/nologin username
```

---

## 🔹 Monitor User Activity

### 🧰 Recent Logins

```bash
last
```

### 🧰 Logged-in Users

```bash
who
```

### 🧰 User Activities

```bash
w
```

---

# 🧹 Cleanup

## 🔹 Remove Users

### 🧰 Commands

```bash
userdel -r john
userdel -r jsmith
userdel -r bdev
userdel webuser
```

---

## 🔹 Remove Groups

### 🧰 Commands

```bash
groupdel marketing
groupdel developers
groupdel services
```

---

## 🔹 Remove Shared Directories

### 🧰 Command

```bash
rm -rf /shared
```

---

# 📂 Script File Structure

```text
managing-users-groups/
│
├── README.md
│
├── scripts/
│   ├── create_users.sh
│   ├── modify_users.sh
│   ├── manage_groups.sh
│   ├── password_policy.sh
│   ├── security_checks.sh
│   └── cleanup.sh
│
├── configs/
│   ├── login.defs
│   ├── pwquality.conf
│   └── useradd
│
├── logs/
│   ├── user_creation.log
│   ├── group_changes.log
│   └── security_audit.log
│
├── screenshots/
│   ├── create_user.png
│   ├── groups.png
│   ├── passwd.png
│   └── security.png
│
└── notes/
    ├── troubleshooting.md
    └── security_best_practices.md
```

---

# 📜 Example Script — `create_users.sh`

```bash
#!/bin/bash

echo "Creating Users..."

useradd john
useradd -c "Jane Smith" -m jsmith
useradd -r -s /sbin/nologin webuser

echo "Users Created Successfully"
```

---

# 📜 Example Script — `manage_groups.sh`

```bash
#!/bin/bash

echo "Creating Groups..."

groupadd marketing
groupadd developers
groupadd services

usermod -a -G marketing john
usermod -a -G developers john

echo "Groups Configured Successfully"
```

---

# 📜 Example Script — `password_policy.sh`

```bash
#!/bin/bash

echo "Applying Password Policies..."

chage -M 90 john
chage -m 7 john
chage -W 7 john

echo "Password Policies Applied"
```

---

# 🎓 Lab Summary

In this lab, you successfully:

- 👤 Created Linux users
- 🛠️ Modified existing users
- 👥 Managed groups
- 🔐 Configured password policies
- 🧪 Tested permissions and ownership
- 🔒 Applied Linux security practices
- 🐞 Troubleshot common issues

---

# 🚀 Key Takeaways

- Always use strong passwords
- Use groups for permission management
- Lock unused accounts
- Monitor user activities regularly
- Use system users for services
- Maintain secure password aging policies

---

# 🏆 Conclusion

Linux user and group management is a core skill for every Linux administrator and RHCSA candidate.

These commands are widely used in:

- 🏢 Enterprise Infrastructure
- ☁️ Cloud Administration
- 🔒 Linux Security
- 🛠️ DevOps & Automation
- 🧪 Server Management

Practice these tasks regularly to build confidence in real-world Linux administration.

---
