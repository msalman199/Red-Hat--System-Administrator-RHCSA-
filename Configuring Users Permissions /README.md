# 🔐 Configuring User Permissions in Linux

A complete hands-on Linux lab for managing file ownership, permissions, and Access Control Lists (ACLs) using `chown`, `chmod`, `setfacl`, and `getfacl`.

---

# 📚 Objectives

By the end of this lab, you will be able to:

- Understand Linux file ownership concepts and user/group relationships
- Change file and directory ownership using the `chown` command
- Modify file permissions using the `chmod` command with symbolic and numeric notation
- Implement Access Control Lists (ACLs)
- Apply secure permission management in real-world scenarios
- Troubleshoot common permission-related issues

---

# 🧰 Prerequisites

Before starting this lab, you should have:

- Basic Linux command-line knowledge
- Familiarity with `ls`, `cd`, `mkdir`, and `touch`
- Understanding of Linux users and groups
- Access to a Linux terminal

---

# 🖥️ Lab Environment

This lab uses a CentOS/RHEL-based Linux system with:

- Root access
- ACL utilities installed
- Multiple test users and groups

---

# 🚀 Task 1 — Change File Ownership Using `chown`

## 📖 Understanding File Ownership

Every Linux file and directory has:

- A user owner
- A group owner

The `chown` command changes ownership.

---

# 🔹 Subtask 1.1 — Examine Current File Ownership

## 🛠️ Step 1 — Create Working Directory and Files

```bash
mkdir ~/permissions_lab
cd ~/permissions_lab

touch file1.txt file2.txt file3.txt
mkdir testdir

echo "This is file 1" > file1.txt
echo "This is file 2" > file2.txt
echo "This is file 3" > file3.txt
```

---

## 🛠️ Step 2 — Check Current Ownership

```bash
ls -l

ls -l | awk '{print $3, $4, $9}' | column -t
```

### ✅ Expected Output

```bash
-rw-rw-r-- 1 student student 14 Nov 15 10:30 file1.txt
-rw-rw-r-- 1 student student 14 Nov 15 10:30 file2.txt
-rw-rw-r-- 1 student student 14 Nov 15 10:30 file3.txt
drwxrwxr-x 2 student student 40 Nov 15 10:30 testdir
```

---

# 🔹 Subtask 1.2 — Change User Ownership

## 🛠️ Step 1 — Change Owner to Root

```bash
sudo chown root file1.txt

ls -l file1.txt
```

---

## 🛠️ Step 2 — Restore Original Owner

```bash
sudo chown $USER file1.txt

ls -l file1.txt
```

---

# 🔹 Subtask 1.3 — Change Group Ownership

## 🛠️ Step 1 — View Available Groups

```bash
groups

cat /etc/group | head -10
```

---

## 🛠️ Step 2 — Change Group Ownership

```bash
sudo chown :users file2.txt

ls -l file2.txt
```

---

# 🔹 Subtask 1.4 — Change User and Group Ownership

## 🛠️ Step 1 — Change User and Group Together

```bash
sudo chown root:root file3.txt

ls -l file3.txt
```

---

## 🛠️ Step 2 — Restore Original Ownership

```bash
sudo chown $USER:$USER file3.txt

ls -l file3.txt
```

---

# 🔹 Subtask 1.5 — Recursive Ownership Changes

## 🛠️ Step 1 — Create Nested Directory Structure

```bash
mkdir -p testdir/subdir1/subdir2

touch testdir/nested_file.txt
touch testdir/subdir1/another_file.txt
touch testdir/subdir1/subdir2/deep_file.txt
```

---

## 🛠️ Step 2 — Apply Recursive Ownership

```bash
sudo chown -R root:root testdir/

ls -lR testdir/
```

---

## 🛠️ Step 3 — Restore Recursive Ownership

```bash
sudo chown -R $USER:$USER testdir/

ls -lR testdir/
```

---

# 🚀 Task 2 — Modify File Permissions Using `chmod`

# 📖 Understanding Linux Permissions

| Permission | Symbol | Numeric |
|---|---|---|
| Read | r | 4 |
| Write | w | 2 |
| Execute | x | 1 |

Permission categories:

- User (`u`)
- Group (`g`)
- Others (`o`)

---

# 🔹 Subtask 2.1 — Understanding Current Permissions

## 🛠️ Step 1 — View Current Permissions

```bash
ls -l

echo '#!/bin/bash' > test_script.sh
echo 'echo "Hello from script!"' >> test_script.sh

ls -l test_script.sh
```

---

## 🛠️ Step 2 — Execute Script Without Permission

```bash
./test_script.sh
```

---

# 🔹 Subtask 2.2 — Using Symbolic Notation with `chmod`

## 🛠️ Step 1 — Add Execute Permission

```bash
chmod u+x test_script.sh

ls -l test_script.sh

./test_script.sh
```

---

## 🛠️ Step 2 — Modify Permissions

```bash
chmod go-w file1.txt

chmod a+r file2.txt

chmod o-rwx file3.txt

ls -l file*.txt
```

---

## 🛠️ Step 3 — Configure Specific Permissions

```bash
chmod u=rw,g=r,o= file1.txt

chmod u=rwx,go=rx testdir/

ls -l file1.txt
ls -ld testdir/
```

---

# 🔹 Subtask 2.3 — Using Numeric Notation with `chmod`

## 🛠️ Step 1 — Apply Numeric Permissions

```bash
touch numeric_test.txt

chmod 755 numeric_test.txt

chmod 644 file1.txt

chmod 600 file2.txt

chmod 777 file3.txt

ls -l *test*.txt file*.txt
```

---

## 🛠️ Step 2 — Common Permission Examples

```bash
touch readme.txt config.conf executable.sh

chmod 644 readme.txt

chmod 600 config.conf

chmod 755 executable.sh

ls -l readme.txt config.conf executable.sh
```

---

# 🔹 Subtask 2.4 — Recursive Permission Changes

## 🛠️ Step 1 — Apply Recursive Permissions

```bash
chmod -R 755 testdir/

ls -lR testdir/
```

---

## 🛠️ Step 2 — Fix Recursive Permission Problems

```bash
chmod -R 644 testdir/

find testdir/ -type d -exec chmod 755 {} \;

find testdir/ -type f -exec chmod 644 {} \;

ls -lR testdir/
```

---

# 🚀 Task 3 — Configure Access Control Lists (ACLs)

# 📖 Understanding ACLs

ACLs allow fine-grained permissions for specific users and groups.

Tools used:

- `setfacl`
- `getfacl`

---

# 🔹 Subtask 3.1 — Check ACL Support

## 🛠️ Step 1 — Verify ACL Utilities

```bash
mount | grep acl

which getfacl setfacl

sudo yum install -y acl
```

---

## 🛠️ Step 2 — Create ACL Test Files

```bash
mkdir acl_test
cd acl_test

touch sensitive_file.txt shared_document.txt

echo "Sensitive information" > sensitive_file.txt
echo "Shared document content" > shared_document.txt
```

---

# 🔹 Subtask 3.2 — View Current ACLs

## 🛠️ Step 1 — Display ACL Information

```bash
getfacl sensitive_file.txt

getfacl shared_document.txt

getfacl --omit-header sensitive_file.txt
```

### ✅ Expected Output

```bash
# file: sensitive_file.txt
# owner: student
# group: student
user::rw-
group::rw-
other::r--
```

---

# 🔹 Subtask 3.3 — Set User-Specific ACLs

## 🛠️ Step 1 — Create User and Assign ACL

```bash
sudo useradd testuser1 2>/dev/null || echo "User exists"

setfacl -m u:testuser1:rw sensitive_file.txt

getfacl sensitive_file.txt

ls -l sensitive_file.txt
```

---

## 🛠️ Step 2 — Add Read-Only User ACL

```bash
sudo useradd testuser2 2>/dev/null || echo "User exists"

setfacl -m u:testuser2:r sensitive_file.txt

getfacl sensitive_file.txt
```

---

# 🔹 Subtask 3.4 — Set Group-Specific ACLs

## 🛠️ Step 1 — Create Groups and Apply ACLs

```bash
sudo groupadd developers 2>/dev/null || echo "Group exists"

sudo groupadd managers 2>/dev/null || echo "Group exists"

setfacl -m g:developers:rwx shared_document.txt

setfacl -m g:managers:r shared_document.txt

getfacl shared_document.txt
```

---

# 🔹 Subtask 3.5 — Configure Default ACLs

## 🛠️ Step 1 — Set Default ACLs

```bash
mkdir project_dir

setfacl -d -m u:testuser1:rw project_dir/

setfacl -d -m g:developers:rwx project_dir/

setfacl -d -m other::r project_dir/

getfacl project_dir/
```

---

## 🛠️ Step 2 — Verify ACL Inheritance

```bash
touch project_dir/new_file.txt

getfacl project_dir/new_file.txt

mkdir project_dir/subdir

getfacl project_dir/subdir/
```

---

# 🔹 Subtask 3.6 — Modify and Remove ACLs

## 🛠️ Step 1 — Modify ACL Permissions

```bash
setfacl -m u:testuser1:rwx sensitive_file.txt

getfacl sensitive_file.txt
```

---

## 🛠️ Step 2 — Remove ACL Entries

```bash
setfacl -x u:testuser2 sensitive_file.txt

setfacl -x g:developers shared_document.txt

getfacl sensitive_file.txt

getfacl shared_document.txt
```

---

## 🛠️ Step 3 — Remove All ACLs

```bash
setfacl -b sensitive_file.txt

getfacl sensitive_file.txt

ls -l sensitive_file.txt
```

---

# 🔹 Subtask 3.7 — Advanced ACL Operations

## 🛠️ Step 1 — Copy ACLs Between Files

```bash
setfacl -m u:testuser1:rwx shared_document.txt

setfacl -m g:developers:rw shared_document.txt

setfacl -m g:managers:r shared_document.txt

touch target_file.txt

getfacl shared_document.txt | setfacl --set-file=- target_file.txt

getfacl target_file.txt
```

---

## 🛠️ Step 2 — Backup ACLs

```bash
getfacl -R . > acl_backup.txt

cat acl_backup.txt
```

---

# 🌐 Practical Scenarios

# 🔹 Scenario 1 — Web Server File Permissions

## 🛠️ Configure Web Server Permissions

```bash
mkdir -p /tmp/webserver/{html,logs,config}

sudo chmod 755 /tmp/webserver/html

sudo chmod 644 /tmp/webserver/html/*

sudo chmod 600 /tmp/webserver/config/*

sudo chmod 755 /tmp/webserver/logs

sudo chmod 644 /tmp/webserver/logs/*
```

---

# 🔹 Scenario 2 — Shared Project Directory

## 🛠️ Configure Shared Collaboration Directory

```bash
mkdir /tmp/shared_project

sudo chown :developers /tmp/shared_project

sudo chmod 2775 /tmp/shared_project

sudo setfacl -d -m g:developers:rwx /tmp/shared_project/

sudo setfacl -d -m other::r /tmp/shared_project/
```

---

# 🛠️ Troubleshooting Common Issues

# 🔹 Issue 1 — Permission Denied Errors

## 🛠️ Troubleshooting Commands

```bash
whoami

groups

ls -l filename

getfacl filename

ls -ld /path/to/parent/directory
```

---

# 🔹 Issue 2 — ACL Not Working

## 🛠️ Verify ACL Support

```bash
mount | grep acl

rpm -qa | grep acl

sudo mount -o remount,acl /
```

---

# 🔹 Issue 3 — Recursive Permission Problems

## 🛠️ Fix Recursive Permissions

```bash
find /path -type f -exec chmod 644 {} \;

find /path -type d -exec chmod 755 {} \;
```

---

# 🧹 Lab Cleanup

## 🛠️ Step 1 — Remove Test Files

```bash
cd ~

rm -rf permissions_lab acl_test
```

---

## 🛠️ Step 2 — Remove Test Users and Groups

```bash
sudo userdel testuser1 2>/dev/null

sudo userdel testuser2 2>/dev/null

sudo groupdel developers 2>/dev/null

sudo groupdel managers 2>/dev/null
```

---

## 🛠️ Step 3 — Remove Temporary Directories

```bash
sudo rm -rf /tmp/webserver /tmp/shared_project
```

---

# ✅ Conclusion

In this lab, you learned how to:

- Manage Linux file ownership using `chown`
- Configure permissions with `chmod`
- Implement advanced ACL management with `setfacl` and `getfacl`
- Apply real-world permission strategies
- Troubleshoot permission-related issues

These skills are essential for Linux system administration, security hardening, and RHCSA exam preparation.

---
