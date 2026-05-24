# 🛠️ Managing Systemd Services 

## 📌 Objectives

By the end of this lab, you will be able to:

- Start, stop, restart, and enable/disable system services using `systemctl`
- Check the status and configuration of systemd services
- Configure system boot targets and understand their purpose
- Troubleshoot systemd services using `journalctl`
- Understand the relationship between systemd units and system initialization
- Manage service dependencies and boot behavior

---

# 📋 Prerequisites

Before starting this lab, you should have:

- Basic understanding of Linux command line interface
- Familiarity with file permissions and basic system administration concepts
- Knowledge of text editors like `nano` or `vim`
- Understanding of process management concepts
- Access to a Linux system with `systemd`

---

# ☁️ Ready-to-Use Cloud Machines

Al Nafi provides Linux-based cloud machines for this lab.

Your cloud machine includes:

- CentOS/RHEL or Ubuntu Linux with systemd
- All necessary tools and services pre-installed
- Root access for system administration tasks
- Sample services for practice

---

# 🚀 Task 1: Managing Services with systemctl

---

# 🔹 Subtask 1.1: Understanding systemctl Basics

## 🛠️ Step 1: Check the status of systemd itself

```bash
systemctl status
```

---

## 🛠️ Step 2: List all active services

```bash
systemctl list-units --type=service --state=active
```

---

## 🛠️ Step 3: List all available services

```bash
systemctl list-units --type=service --all
```

---

## 🛠️ Step 4: Check if services are enabled

```bash
systemctl is-enabled sshd
systemctl is-enabled httpd
```

---

# 🔹 Subtask 1.2: Starting and Stopping Services

## 🛠️ Step 1: Check SSH service status

```bash
systemctl status sshd
```

---

## 🛠️ Step 2: Stop SSH service temporarily

```bash
sudo systemctl stop sshd
```

---

## 🛠️ Step 3: Verify service has stopped

```bash
systemctl status sshd
```

---

## 🛠️ Step 4: Start SSH service again

```bash
sudo systemctl start sshd
```

---

## 🛠️ Step 5: Restart SSH service

```bash
sudo systemctl restart sshd
```

---

## 🛠️ Step 6: Reload SSH configuration

```bash
sudo systemctl reload sshd
```

---

# 🔹 Subtask 1.3: Enabling and Disabling Services

## 🛠️ Step 1: Check if SSH starts automatically

```bash
systemctl is-enabled sshd
```

---

## 🛠️ Step 2: Enable SSH at boot

```bash
sudo systemctl enable sshd
```

---

## 🛠️ Step 3: Disable SSH at boot

```bash
sudo systemctl disable sshd
```

---

## 🛠️ Step 4: Enable and start SSH simultaneously

```bash
sudo systemctl enable --now sshd
```

---

## 🛠️ Step 5: Disable and stop SSH simultaneously

```bash
sudo systemctl disable --now sshd
```

---

## 🛠️ Step 6: Re-enable SSH for remaining tasks

```bash
sudo systemctl enable --now sshd
```

---

# 🔹 Subtask 1.4: Working with Apache HTTP Server

## 🛠️ Step 1: Install Apache

### RHEL/CentOS

```bash
sudo yum install -y httpd
```

### Ubuntu/Debian

```bash
sudo apt update
sudo apt install -y apache2
```

---

## 🛠️ Step 2: Start Apache service

### RHEL/CentOS

```bash
sudo systemctl start httpd
```

### Ubuntu/Debian

```bash
sudo systemctl start apache2
```

---

## 🛠️ Step 3: Check Apache status

### RHEL/CentOS

```bash
systemctl status httpd
```

### Ubuntu/Debian

```bash
systemctl status apache2
```

---

## 🛠️ Step 4: Enable Apache at boot

### RHEL/CentOS

```bash
sudo systemctl enable httpd
```

### Ubuntu/Debian

```bash
sudo systemctl enable apache2
```

---

# 🚀 Task 2: Configure System Boot Targets

---

# 🔹 Subtask 2.1: Understanding Boot Targets

## 🛠️ Step 1: Check current boot target

```bash
systemctl get-default
```

---

## 🛠️ Step 2: List all available targets

```bash
systemctl list-units --type=target
```

---

## 🛠️ Step 3: Show details of multi-user target

```bash
systemctl show multi-user.target
```

---

## 🛠️ Step 4: List dependencies

```bash
systemctl list-dependencies
```

---

# 🔹 Subtask 2.2: Common Boot Targets

## 🛠️ Step 1: View graphical target details

```bash
systemctl cat graphical.target
```

---

## 🛠️ Step 2: View multi-user target details

```bash
systemctl cat multi-user.target
```

---

## 🛠️ Step 3: Check services wanted by multi-user target

```bash
systemctl list-dependencies multi-user.target
```

---

# 🔹 Subtask 2.3: Changing Boot Targets

## 🛠️ Step 1: Set default boot target to multi-user

```bash
sudo systemctl set-default multi-user.target
```

---

## 🛠️ Step 2: Verify change

```bash
systemctl get-default
```

---

## 🛠️ Step 3: Set default back to graphical target

```bash
sudo systemctl set-default graphical.target
```

---

## 🛠️ Step 4: Switch to multi-user target immediately

```bash
sudo systemctl isolate multi-user.target
```

---

## 🛠️ Step 5: Switch back to graphical target

```bash
sudo systemctl isolate graphical.target
```

---

# 🔹 Subtask 2.4: Emergency and Rescue Targets

## 🛠️ Step 1: View rescue target information

```bash
systemctl cat rescue.target
```

---

## 🛠️ Step 2: View emergency target information

```bash
systemctl cat emergency.target
```

> ⚠️ Do not isolate emergency or rescue targets in this lab environment.

---

# 🚀 Task 3: Troubleshooting with journalctl

---

# 🔹 Subtask 3.1: Basic journalctl Usage

## 🛠️ Step 1: View all journal entries

```bash
journalctl
```

---

## 🛠️ Step 2: View current boot logs

```bash
journalctl -b
```

---

## 🛠️ Step 3: View previous boot logs

```bash
journalctl -b -1
```

---

## 🛠️ Step 4: Follow logs in real-time

```bash
journalctl -f
```

Press `Ctrl + C` to stop.

---

# 🔹 Subtask 3.2: Service-Specific Logs

## 🛠️ Step 1: View SSH logs

```bash
journalctl -u sshd
```

---

## 🛠️ Step 2: View Apache logs

### RHEL/CentOS

```bash
journalctl -u httpd
```

### Ubuntu/Debian

```bash
journalctl -u apache2
```

---

## 🛠️ Step 3: View logs since specific time

```bash
journalctl -u sshd --since "1 hour ago"
```

---

## 🛠️ Step 4: View only error logs

```bash
journalctl -u sshd -p err
```

---

# 🔹 Subtask 3.3: Advanced journalctl Filtering

## 🛠️ Step 1: View logs from specific date

```bash
journalctl --since "2024-01-01" --until "2024-01-02"
```

---

## 🛠️ Step 2: Filter logs by systemd unit

```bash
journalctl _SYSTEMD_UNIT=sshd.service
```

---

## 🛠️ Step 3: View kernel messages

```bash
journalctl -k
```

---

## 🛠️ Step 4: View logs in JSON format

```bash
journalctl -u sshd -o json-pretty
```

---

# 🔹 Subtask 3.4: Troubleshooting Failed Services

## 🛠️ Step 1: Create failing service

```bash
sudo tee /etc/systemd/system/test-fail.service > /dev/null << 'EOF'
[Unit]
Description=Test Service That Fails
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/nonexistent-command
Restart=no

[Install]
WantedBy=multi-user.target
EOF
```

---

## 🛠️ Step 2: Reload systemd

```bash
sudo systemctl daemon-reload
```

---

## 🛠️ Step 3: Start failing service

```bash
sudo systemctl start test-fail.service
```

---

## 🛠️ Step 4: Check service status

```bash
systemctl status test-fail.service
```

---

## 🛠️ Step 5: View service logs

```bash
journalctl -u test-fail.service
```

---

## 🛠️ Step 6: View last 10 logs

```bash
journalctl -u test-fail.service -n 10
```

---

## 🛠️ Step 7: Remove test service

```bash
sudo systemctl stop test-fail.service 2>/dev/null || true
sudo systemctl disable test-fail.service 2>/dev/null || true
sudo rm /etc/systemd/system/test-fail.service
sudo systemctl daemon-reload
```

---

# 🔹 Subtask 3.5: Monitoring System Boot Process

## 🛠️ Step 1: View boot messages

```bash
journalctl -b --no-pager
```

---

## 🛠️ Step 2: Analyze boot time

```bash
systemd-analyze
```

---

## 🛠️ Step 3: Show boot timing details

```bash
systemd-analyze blame
```

---

## 🛠️ Step 4: Show critical boot chain

```bash
systemd-analyze critical-chain
```

---

# 🧪 Practical Exercise: Web Server Management

## 🛠️ Step 1: Install and enable Apache

### RHEL/CentOS

```bash
sudo yum install -y httpd
sudo systemctl enable --now httpd
```

### Ubuntu/Debian

```bash
sudo apt update
sudo apt install -y apache2
sudo systemctl enable --now apache2
```

---

## 🛠️ Step 2: Create sample web page

```bash
sudo tee /var/www/html/index.html > /dev/null << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Systemd Lab Test Page</title>
</head>
<body>
    <h1>Welcome to the Systemd Management Lab!</h1>
    <p>This page is served by Apache, managed through systemd.</p>
    <p>Current time: $(date)</p>
</body>
</html>
EOF
```

---

## 🛠️ Step 3: Test web server

```bash
curl http://localhost
```

---

## 🛠️ Step 4: Monitor Apache logs

### RHEL/CentOS

```bash
journalctl -u httpd -f
```

### Ubuntu/Debian

```bash
journalctl -u apache2 -f
```

---

## 🛠️ Step 5: Generate web traffic

```bash
for i in {1..5}; do curl http://localhost; sleep 1; done
```

---

## 🛠️ Step 6: Check service status and logs

### RHEL/CentOS

```bash
systemctl status httpd
journalctl -u httpd --since "5 minutes ago"
```

### Ubuntu/Debian

```bash
systemctl status apache2
journalctl -u apache2 --since "5 minutes ago"
```

---

## 🛠️ Step 7: Practice service management

```bash
# Stop service
sudo systemctl stop httpd

# Verify stopped
curl http://localhost

# Start service again
sudo systemctl start httpd

# Verify working
curl http://localhost
```

---

# 🧰 Useful Commands Reference

## 📌 Service Management

```bash
systemctl start servicename
systemctl stop servicename
systemctl restart servicename
systemctl reload servicename
systemctl status servicename
systemctl enable servicename
systemctl disable servicename
systemctl is-active servicename
systemctl is-enabled servicename
```

---

## 📌 Target Management

```bash
systemctl get-default
systemctl set-default target
systemctl isolate target
systemctl list-units --type=target
```

---

## 📌 Log Management

```bash
journalctl
journalctl -u servicename
journalctl -f
journalctl -b
journalctl --since "1 hour ago"
journalctl -p err
```

---

# ⚠️ Troubleshooting Tips

## ❌ Issue 1: Service fails to start

### ✅ Solution

- Use:

```bash
systemctl status servicename
journalctl -u servicename
```

- Check configuration errors and dependencies.

---

## ❌ Issue 2: Service works incorrectly

### ✅ Solution

- Monitor logs in real-time:

```bash
journalctl -u servicename -f
```

- Verify permissions and configuration files.

---

## ❌ Issue 3: Service does not start at boot

### ✅ Solution

```bash
systemctl enable servicename
```

Check service dependencies.

---

## ❌ Issue 4: Cannot find logs

### ✅ Solution

```bash
journalctl -u servicename
```

Some services may still log to `/var/log/`.

---

# ✅ Conclusion

In this lab, you learned how to:

- Manage services using `systemctl`
- Configure boot targets
- Troubleshoot services with `journalctl`
- Monitor system startup behavior
- Understand service dependencies

These are essential Linux system administration skills and are heavily used in real-world production environments and RHCSA certification preparation.

Continue practicing these commands regularly to strengthen your Linux administration expertise.

---
```
