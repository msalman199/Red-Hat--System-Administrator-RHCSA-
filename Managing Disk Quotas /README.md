# 💾 Managing Disk Quotas in Linux

> ## 📘 Overview
> Learn how to configure, manage, monitor, and troubleshoot disk quotas in Linux systems using enterprise-level administration tools.

---

# 🎯 Objectives

By the end of this lab, students will be able to:

✅ Understand the concept and importance of disk quotas in Linux systems  
✅ Enable quota support on file systems  
✅ Configure user disk quotas using the `edquota` command  
✅ Monitor quota limits using `quota` and `repquota`  
✅ Troubleshoot common quota-related issues  
✅ Implement quota policies for system administration  

---

# 📚 Prerequisites

Before starting this lab, students should have:

🔹 Basic understanding of Linux file systems  
🔹 Familiarity with Linux command-line interface  
🔹 Knowledge of user and group management  
🔹 Understanding of file permissions and ownership  
🔹 Basic text editor skills (`vi/vim` or `nano`)  

---

# 🖥️ Lab Environment

## ☁️ Ready-to-Use Cloud Machines

Al Nafi provides pre-configured Linux cloud machines for this lab.

### 🧰 Your environment includes:

- 🐧 CentOS/RHEL 8 or 9 system
- 🔑 Root access
- 📦 Pre-installed quota utilities
- 👥 Multiple test user accounts
- 💽 Additional disk partition for quota implementation

---

# 🚀 Task 1: Enable Quota on File Systems

---

# 🔹 Subtask 1.1: Check Current File System Configuration

## 🛠️ Tool: `df`

Check mounted file systems:

```bash
df -h
```

---

## 🛠️ Tool: `cat`

View current `fstab` configuration:

```bash
cat /etc/fstab
```

---

## 🛠️ Tool: `rpm`

Check installed quota packages:

```bash
rpm -qa | grep quota
```

---

## 🛠️ Tool: `yum`

Install quota packages if missing:

```bash
sudo yum install quota -y
```

---

# 🔹 Subtask 1.2: Modify File System for Quota Support

## 🛠️ Tool: `cp`

Create backup of `fstab`:

```bash
sudo cp /etc/fstab /etc/fstab.backup
```

---

## 🛠️ Tool: `vi`

Edit `fstab` file:

```bash
sudo vi /etc/fstab
```

### ✏️ Example Configuration

```bash
# Original line
/dev/mapper/rhel-home /home xfs defaults 0 0

# Modified line
/dev/mapper/rhel-home /home xfs defaults,usrquota,grpquota 0 0
```

> ⚠️ For XFS file systems use:
>
> ```bash
> uquota,gquota
> ```

---

# 🔹 Subtask 1.3: Remount File System

## 🛠️ Tool: `mount`

Remount `/home`:

```bash
sudo mount -o remount /home
```

Verify quota options:

```bash
mount | grep /home
```

✅ You should now see quota options enabled.

---

# 🔹 Subtask 1.4: Initialize Quota Database

# 📁 For ext4 File Systems

## 🛠️ Tool: `quotacheck`

```bash
sudo quotacheck -cug /home
```

---

# 📁 For XFS File Systems

## 🛠️ Tool: `xfs_quota`

Enable quotas:

```bash
sudo xfs_quota -x -c 'enable -uv' /home
sudo xfs_quota -x -c 'enable -gv' /home
```

---

## 🛠️ Tool: `quotaon`

Enable quota enforcement:

```bash
sudo quotaon /home
```

---

## 🛠️ Tool: `xfs_quota`

Check quota state:

```bash
sudo xfs_quota -x -c 'state' /home
```

---

# 👤 Task 2: Set User Quotas Using edquota

---

# 🔹 Subtask 2.1: Create Test Users

## 🛠️ Tool: `useradd`

```bash
sudo useradd testuser1
sudo useradd testuser2
sudo useradd testuser3
```

---

## 🛠️ Tool: `passwd`

Set passwords:

```bash
sudo passwd testuser1
sudo passwd testuser2
sudo passwd testuser3
```

### 🔐 Example Password

```text
password123
```

---

## 🛠️ Tool: `mkdir`

Create home directories:

```bash
sudo mkdir -p /home/testuser1
sudo mkdir -p /home/testuser2
sudo mkdir -p /home/testuser3
```

---

## 🛠️ Tool: `chown`

Set ownership:

```bash
sudo chown testuser1:testuser1 /home/testuser1
sudo chown testuser2:testuser2 /home/testuser2
sudo chown testuser3:testuser3 /home/testuser3
```

---

# 🔹 Subtask 2.2: Configure User Quotas

## 🛠️ Tool: `edquota`

Edit quota for `testuser1`:

```bash
sudo edquota -u testuser1
```

### ✏️ Example Values

```text
Disk quotas for user testuser1 (uid 1001):
Filesystem                   blocks       soft       hard     inodes     soft     hard
/dev/mapper/rhel-home             0      50000     100000          0        0        0
```

---

# 📖 Field Explanation

| 🔖 Field | 📘 Description |
|---|---|
| blocks | Current disk usage |
| soft | Warning limit |
| hard | Maximum limit |
| inodes | Number of files |
| inode limits | File count restrictions |

---

## 🛠️ Tool: `edquota`

Configure quota for `testuser2`:

```bash
sudo edquota -u testuser2
```

```text
Disk quotas for user testuser2 (uid 1002):
Filesystem                   blocks       soft       hard     inodes     soft     hard
/dev/mapper/rhel-home             0      25000      50000          0      100      150
```

---

## 🛠️ Tool: `edquota`

Copy quota settings:

```bash
sudo edquota -p testuser1 testuser3
```

---

# 🔹 Subtask 2.3: Configure Grace Periods

## 🛠️ Tool: `edquota`

```bash
sudo edquota -t
```

### ⏳ Example

```text
Grace period before enforcing soft limits for users:

Filesystem             Block grace period     Inode grace period
/dev/mapper/rhel-home           7days                  7days
```

---

# 📊 Task 3: Monitor Disk Usage

---

# 🔹 Subtask 3.1: Check User Quotas

## 🛠️ Tool: `quota`

Check quota:

```bash
sudo quota -u testuser1
```

Check multiple users:

```bash
sudo quota -u testuser1 testuser2 testuser3
```

Human-readable format:

```bash
sudo quota -u testuser1 -h
```

---

# 🔹 Subtask 3.2: Generate Reports

## 🛠️ Tool: `repquota`

Generate reports:

```bash
sudo repquota /home
```

```bash
sudo repquota -a
```

```bash
sudo repquota -h /home
```

```bash
sudo repquota -u /home
```

---

# 🔹 Subtask 3.3: Test Quota Enforcement

## 🛠️ Tool: `su`

Switch user:

```bash
sudo su - testuser1
```

---

## 🛠️ Tool: `dd`

Create large file:

```bash
dd if=/dev/zero of=testfile1 bs=1M count=40
```

---

## 🛠️ Tool: `quota`

Check usage:

```bash
quota -u
```

---

## 🛠️ Tool: `dd`

Exceed hard limit:

```bash
dd if=/dev/zero of=testfile2 bs=1M count=70
```

❌ You should receive a quota exceeded error.

---

## 🛠️ Tool: `exit`

Return to root:

```bash
exit
```

---

# 🔹 Subtask 3.4: Monitor Violations

## 🛠️ Tool: `repquota`

```bash
sudo repquota /home | grep -E '\+|\*'
```

| 🔣 Symbol | 📘 Meaning |
|---|---|
| + | Soft limit exceeded |
| * | Hard limit exceeded |

---

## 🛠️ Tool: `warnquota`

```bash
sudo warnquota
```

---

# ⚙️ Advanced Quota Management

---

# 👥 Setting Group Quotas

## 🛠️ Tool: `edquota`

```bash
sudo edquota -g users
```

---

## 🛠️ Tool: `quota`

```bash
sudo quota -g users
```

---

# 🔧 Quota Maintenance Commands

## 🛠️ Tool: `quotacheck`

```bash
sudo quotacheck -avug
```

---

## 🛠️ Tool: `quotaoff`

```bash
sudo quotaoff /home
```

---

## 🛠️ Tool: `quotaon`

```bash
sudo quotaon /home
```

---

## 🛠️ Tool: `quotaon`

```bash
sudo quotaon -p /home
```

---

# 🛑 Troubleshooting Common Issues

---

# ❗ Issue 1: Quota Not Working

## ✅ Solution

```bash
sudo quotaon -p /home
sudo quotaon /home
sudo xfs_quota -x -c 'state' /home
```

---

# ❗ Issue 2: Permission Denied

## ✅ Solution

```bash
sudo edquota -u username
ls -la /home/aquota.*
```

---

# ❗ Issue 3: Quota Database Corruption

## ✅ Solution

```bash
sudo quotaoff /home
sudo quotacheck -avug /home
sudo quotaon /home
```

---

# ✅ Lab Verification

## 🛠️ Tool: `mount`

```bash
mount | grep quota
```

---

## 🛠️ Tool: `repquota`

```bash
sudo repquota /home
```

---

## 🛠️ Tool: `su`

```bash
sudo su - testuser1
```

---

## 🛠️ Tool: `dd`

```bash
dd if=/dev/zero of=large_file bs=1M count=60
```

---

## 🛠️ Tool: `quota`

```bash
quota -u
```

---

## 🛠️ Tool: `exit`

```bash
exit
```

---

## 🛠️ Tool: `repquota`

```bash
sudo repquota -h /home
```

---

# 🎉 Conclusion

In this lab, you successfully learned how to implement and manage disk quotas on Linux systems.

---

# 🧠 What You Learned

✅ Enabled quota support on Linux file systems  
✅ Configured user quotas using `edquota`  
✅ Set soft and hard limits  
✅ Monitored quota usage using `quota` and `repquota`  
✅ Tested quota enforcement  
✅ Troubleshot common quota issues  
✅ Managed quota maintenance and reporting  

---

# 🌍 Real-World Applications

## 🖥️ Multi-user Servers

Shared hosting environments where multiple users share server resources.

## 🏢 Corporate Environments

Enterprise file servers with storage policies.

## ☁️ Cloud Infrastructure

Virtual servers with allocated storage limits.

---

# 🏆 RHCSA Relevance

Disk quota management is an essential RHCSA skill and widely used in enterprise Linux administration.

### 💡 Skills Demonstrated

- Linux storage administration
- Resource management
- System monitoring
- Enterprise server maintenance
- User policy enforcement

---
