# Understanding and Managing SELinux

## 📘 Overview

This lab introduces SELinux (Security-Enhanced Linux) and teaches how to manage, configure, and troubleshoot SELinux policies on enterprise Linux systems such as Red Hat Enterprise Linux, CentOS, and Fedora Linux.

---

# 🎯 Objectives

By the end of this lab, students will be able to:

- Understand what SELinux is and why it is important
- Check and interpret SELinux status using `sestatus`
- Configure SELinux modes using `setenforce`
- Troubleshoot SELinux issues using `ausearch` and `audit2allow`
- Apply SELinux security policies to protect resources
- Identify and resolve common SELinux permission problems

---

# 📋 Prerequisites

Before starting this lab, students should have:

- Basic Linux command-line knowledge
- Understanding of file permissions and ownership concepts
- Familiarity with system administration tasks
- Understanding of log files and system monitoring
- Access to a Linux system with SELinux installed

---

# ☁️ Ready-to-Use Cloud Machines

Al Nafi provides pre-configured Linux-based cloud machines with:

- SELinux already installed and configured
- All necessary SELinux tools and utilities pre-installed
- Sample files and directories for testing
- Audit logging configured and running

---

# 🛠️ Lab Environment Setup

Your cloud machine includes:

- Red Hat Enterprise Linux or CentOS with SELinux enabled
- All necessary SELinux tools and utilities pre-installed
- Sample files and directories for testing
- Audit logging configured and running

---

# 🧩 Task 1: Check SELinux Status with `sestatus`

## 🔹 Subtask 1.1: Understanding SELinux Basics

SELinux (Security-Enhanced Linux) is a mandatory access control system that provides an additional layer of security beyond traditional Linux permissions.

---

### 🛠️ Step 1: Open a terminal and check if you have root privileges

```bash
whoami
```

If you are not root, switch to the root user:

```bash
sudo su -
```

---

### 🛠️ Step 2: Check the current SELinux status

```bash
sestatus
```

Example Output:

```bash
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   enforcing
Mode from config file:          enforcing
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Memory protection checking:     actual (secure)
Max kernel policy version:      33
```

---

## 🔹 Subtask 1.2: Understanding SELinux Modes

SELinux operates in three modes:

| Mode | Description |
|------|-------------|
| Enforcing | SELinux actively enforces security policies |
| Permissive | SELinux logs violations but does not block them |
| Disabled | SELinux is completely turned off |

---

### 🛠️ Step 3: Check the current mode specifically

```bash
getenforce
```

---

### 🛠️ Step 4: View SELinux configuration file

```bash
cat /etc/selinux/config
```

This file shows the default SELinux mode that will be used after system reboot.

---

## 🔹 Subtask 1.3: Examining SELinux Contexts

### 🛠️ Step 5: Check SELinux contexts of files

```bash
ls -Z /etc/passwd
```

The output shows the SELinux context in the format:

```text
user:role:type:level
```

---

### 🛠️ Step 6: Check SELinux contexts of processes

```bash
ps -eZ | head -10
```

---

### 🛠️ Step 7: Check your current SELinux user context

```bash
id -Z
```

---

# 🧩 Task 2: Configure SELinux Modes with `setenforce`

## 🔹 Subtask 2.1: Temporarily Changing SELinux Mode

The `setenforce` command allows you to temporarily change SELinux mode without rebooting.

---

### 🛠️ Step 1: Check current mode

```bash
getenforce
```

---

### 🛠️ Step 2: Switch to permissive mode

```bash
setenforce 0
```

---

### 🛠️ Step 3: Verify the mode change

```bash
getenforce
```

Expected Output:

```bash
Permissive
```

---

### 🛠️ Step 4: Check the status again

```bash
sestatus
```

Notice that the current mode shows permissive while the config file mode remains enforcing.

---

## 🔹 Subtask 2.2: Testing Mode Differences

### 🛠️ Step 5: Create a test scenario in permissive mode

```bash
mkdir /tmp/selinux-test
cd /tmp/selinux-test

echo "This is a test file" > testfile.txt

ls -Z testfile.txt
```

---

### 🛠️ Step 6: Try to change the context incorrectly

```bash
chcon -t httpd_exec_t testfile.txt

ls -Z testfile.txt
```

---

## 🔹 Subtask 2.3: Switching Back to Enforcing Mode

### 🛠️ Step 7: Return to enforcing mode

```bash
setenforce 1
```

---

### 🛠️ Step 8: Verify the change

```bash
getenforce
```

---

## 🔹 Subtask 2.4: Permanently Changing SELinux Mode

### 🛠️ Step 9: Backup the SELinux configuration file

```bash
cp /etc/selinux/config /etc/selinux/config.backup
```

View the current configuration:

```bash
cat /etc/selinux/config
```

---

### 🛠️ Step 10: Example of permanent configuration change

```bash
# Example only - do not run
# sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config
```

---

# 🧩 Task 3: Troubleshoot SELinux Issues using `ausearch` and `audit2allow`

## 🔹 Subtask 3.1: Understanding SELinux Logging

SELinux logs policy violations to the audit log located at:

```text
/var/log/audit/audit.log
```

---

### 🛠️ Step 1: Check if auditd service is running

```bash
systemctl status auditd
```

---

### 🛠️ Step 2: Look at recent audit log entries

```bash
tail -20 /var/log/audit/audit.log
```

---

## 🔹 Subtask 3.2: Creating a SELinux Violation for Testing

### 🛠️ Step 3: Create a simple web directory

```bash
mkdir -p /var/www/html/test

echo "<h1>Test Page</h1>" > /var/www/html/test/index.html

ls -Z /var/www/html/test/index.html
```

---

### 🛠️ Step 4: Move a file from `/tmp` to web directory

```bash
echo "<h1>Moved Test Page</h1>" > /tmp/moved-page.html

mv /tmp/moved-page.html /var/www/html/test/

ls -Z /var/www/html/test/moved-page.html
```

---

## 🔹 Subtask 3.3: Using `ausearch` to Find SELinux Denials

### 🛠️ Step 5: Search for recent SELinux denials

```bash
ausearch -m AVC -ts recent
```

---

### 🛠️ Step 6: Install and start Apache HTTP server

```bash
yum install -y httpd

systemctl start httpd
systemctl enable httpd

curl http://localhost/test/moved-page.html
```

---

### 🛠️ Step 7: Search for SELinux denials related to httpd

```bash
ausearch -m AVC -c httpd
```

---

## 🔹 Subtask 3.4: Using `audit2allow`

### 🛠️ Step 8: Analyze denials and suggest solutions

```bash
ausearch -m AVC -c httpd | audit2allow
```

---

### 🛠️ Step 9: Get human-readable explanations

```bash
ausearch -m AVC -c httpd | audit2allow -w
```

---

### 🛠️ Step 10: Generate a custom policy module

```bash
ausearch -m AVC -c httpd | audit2allow -M myhttpd

ls -l myhttpd.*
```

---

## 🔹 Subtask 3.5: Proper SELinux Context Management

### 🛠️ Step 11: Restore proper SELinux contexts

```bash
restorecon -Rv /var/www/html/test/
```

---

### 🛠️ Step 12: Verify the context

```bash
ls -Z /var/www/html/test/
```

---

### 🛠️ Step 13: Test access again

```bash
curl http://localhost/test/moved-page.html
```

---

## 🔹 Subtask 3.6: Using `sealert`

### 🛠️ Step 14: Install setroubleshoot tools

```bash
yum install -y setroubleshoot-server
```

---

### 🛠️ Step 15: Analyze recent denials with `sealert`

```bash
sealert -a /var/log/audit/audit.log
```

---

# 🚀 Advanced Troubleshooting Techniques

## 🔹 Subtask 3.7: Common SELinux Commands

### 🛠️ Step 16: Check SELinux booleans

List all booleans:

```bash
getsebool -a | grep httpd
```

Check a specific boolean:

```bash
getsebool httpd_can_network_connect
```

---

### 🛠️ Step 17: Enable a boolean temporarily

```bash
setsebool httpd_can_network_connect on
```

Permanent change:

```bash
# setsebool -P httpd_can_network_connect on
```

---

### 🛠️ Step 18: Check file context rules and port contexts

```bash
semanage fcontext -l | grep "/var/www"
```

```bash
semanage port -l | grep http
```

---

# 🧪 Practical Exercise: Complete SELinux Scenario

### 🛠️ Step 19: Create a custom application directory

```bash
mkdir -p /opt/myapp/bin
mkdir -p /opt/myapp/data

cat > /opt/myapp/bin/myapp.sh << 'EOF'
#!/bin/bash
echo "MyApp is running"
echo "Data directory contents:"
ls -la /opt/myapp/data/
EOF

chmod +x /opt/myapp/bin/myapp.sh

echo "Important data" > /opt/myapp/data/data1.txt
echo "More data" > /opt/myapp/data/data2.txt
```

---

### 🛠️ Step 20: Check and fix SELinux contexts

Check current contexts:

```bash
ls -Z /opt/myapp/bin/
ls -Z /opt/myapp/data/
```

Set appropriate contexts:

```bash
semanage fcontext -a -t bin_t "/opt/myapp/bin(/.*)?"

semanage fcontext -a -t var_t "/opt/myapp/data(/.*)?"
```

Apply the contexts:

```bash
restorecon -Rv /opt/myapp/
```

Verify changes:

```bash
ls -Z /opt/myapp/bin/

ls -Z /opt/myapp/data/
```

---

# 🧹 Cleanup and Verification

### 🛠️ Step 21: Clean up test files

```bash
rm -rf /tmp/selinux-test
rm -rf /var/www/html/test
rm -rf /opt/myapp
```

Verify SELinux status:

```bash
sestatus
getenforce
```

Check recent denials:

```bash
ausearch -m AVC -ts today | tail -5
```

---

# ✅ Conclusion

In this lab, you learned how to:

- Check SELinux status using `sestatus`
- Configure SELinux modes using `setenforce`
- Troubleshoot denials using `ausearch`
- Generate policies with `audit2allow`
- Restore contexts with `restorecon`
- Manage SELinux booleans and policies
- Secure applications using proper SELinux contexts

---

# 🔐 Why SELinux Matters

SELinux is critical in enterprise Linux environments because it:

- Adds mandatory access controls
- Protects systems even if permissions are compromised
- Helps meet compliance requirements
- Improves overall system security
- Is essential knowledge for Linux administrators

---

# 📌 Key Takeaways

- Always check SELinux when troubleshooting permission issues
- Use permissive mode temporarily for testing
- Proper file contexts are usually better than custom policies
- Audit logs are essential for troubleshooting
- `sealert` and `audit2allow` simplify SELinux debugging

---

# 📚 Next Steps

To continue improving your SELinux skills:

- Practice with database and mail services
- Learn SELinux policy development
- Explore MLS (Multi-Level Security)
- Study SELinux in containers
- Prepare for RHCSA certification

