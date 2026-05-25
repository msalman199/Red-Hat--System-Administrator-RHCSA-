# 🚀 Using `journalctl` for System Logs

> ✨ A Complete RHCSA Lab Guide for System Log Management and Analysis using `journalctl`

---

# 📘 Objectives

By the end of this lab, you will be able to:

- ✅ Navigate and filter system logs using `journalctl`
- ✅ Configure persistent log storage
- ✅ Analyze system logs to troubleshoot issues
- ✅ Use advanced filtering options
- ✅ Understand journal structure and log levels
- ✅ Implement log rotation and storage best practices

---

# 📚 Prerequisites

Before starting this lab, you should have:

- 🖥️ Basic Linux command-line knowledge
- ⚙️ Familiarity with systemd services
- 📝 Basic text editing skills (`nano` / `vim`)
- 🔐 Understanding of file permissions
- 🧠 Basic troubleshooting mindset

---

# ☁️ Lab Environment Setup

## 🏢 Ready-to-Use Cloud Machines

Al Nafi provides pre-configured Linux cloud machines.

### 🔧 Environment Includes

- 🐧 CentOS/RHEL 8 or 9 system
- 🔑 Full root access
- 📄 Pre-installed `journalctl` and systemd tools
- 📊 Sample log data for practice

---

# 🧪 Task 1: View and Filter Logs Using `journalctl`

---

# 🔹 Subtask 1.1 — Basic `journalctl` Commands

## 🛠️ Step 1: Check journal service status

```bash
# Check if systemd-journald is running
sudo systemctl status systemd-journald

# View basic system information
hostnamectl
```

---

## 🛠️ Step 2: Display recent system logs

```bash
# View all logs
sudo journalctl

# View logs in real-time
sudo journalctl -f
```

> 🛑 Press `Ctrl + C` to stop real-time monitoring.

---

## 🛠️ Step 3: Navigate through logs

```bash
# Disable pager
sudo journalctl --no-pager

# Show last 20 entries
sudo journalctl -n 20

# Show first 50 entries
sudo journalctl --no-pager | head -50
```

---

# 🔹 Subtask 1.2 — Time-Based Filtering

## 🛠️ Step 1: Filter logs by time

```bash
# Logs from today
sudo journalctl --since today

# Logs from yesterday
sudo journalctl --since yesterday

# Logs from last hour
sudo journalctl --since "1 hour ago"

# Specific date
sudo journalctl --since "2024-01-01 00:00:00"
```

---

## 🛠️ Step 2: Use time ranges

```bash
# Between two dates
sudo journalctl --since "2024-01-01" --until "2024-01-02"

# Last 30 minutes
sudo journalctl --since "30 minutes ago"

# Logs until 1 hour ago
sudo journalctl --until "1 hour ago"
```

---

# 🔹 Subtask 1.3 — Service and Unit Filtering

## 🛠️ Step 1: Filter logs for services

```bash
# SSH logs
sudo journalctl -u sshd

# NetworkManager logs
sudo journalctl -u NetworkManager

# All service logs
sudo journalctl -u "*.service"
```

---

## 🛠️ Step 2: Combine filters

```bash
# SSH logs from today
sudo journalctl -u sshd --since today

# Multiple services
sudo journalctl -u sshd -u NetworkManager --since "1 hour ago"

# Follow SSH logs
sudo journalctl -u sshd -f
```

---

# 🔹 Subtask 1.4 — Priority and Log Level Filtering

## 🛠️ Step 1: Filter by severity

```bash
# Errors only
sudo journalctl -p err

# Warnings and above
sudo journalctl -p warning

# Info messages
sudo journalctl -p info

# Debug messages
sudo journalctl -p debug
```

---

## 🛠️ Step 2: Combine filters

```bash
# SSH errors today
sudo journalctl -u sshd -p err --since today

# Critical system errors
sudo journalctl -p crit --since "24 hours ago"
```

---

# 🧪 Task 2: Configure Persistent Log Storage

---

# 🔹 Subtask 2.1 — Check Current Configuration

## 🛠️ Step 1: Check journal storage status

```bash
# Check journal disk usage
sudo journalctl --disk-usage

# View journal configuration
sudo cat /etc/systemd/journald.conf

# Check persistent storage
ls -la /var/log/journal/
```

---

## 🛠️ Step 2: Examine storage locations

```bash
# Runtime journal location
ls -la /run/log/journal/

# Journald service status
sudo systemctl status systemd-journald

# Verify journal integrity
sudo journalctl --verify
```

---

# 🔹 Subtask 2.2 — Enable Persistent Journal Storage

## 🛠️ Step 1: Create persistent storage directory

```bash
# Create journal directory
sudo mkdir -p /var/log/journal

# Set ownership
sudo chown root:systemd-journal /var/log/journal

# Set permissions
sudo chmod 2755 /var/log/journal
```

---

## 🛠️ Step 2: Configure journald

```bash
# Backup configuration
sudo cp /etc/systemd/journald.conf /etc/systemd/journald.conf.backup

# Edit configuration
sudo nano /etc/systemd/journald.conf
```

### ✏️ Add these settings

```ini
[Journal]
Storage=persistent
Compress=yes
SystemMaxUse=1G
SystemKeepFree=500M
SystemMaxFileSize=100M
MaxRetentionSec=1month
```

---

## 🛠️ Step 3: Apply configuration changes

```bash
# Restart journald
sudo systemctl restart systemd-journald

# Verify service
sudo systemctl status systemd-journald

# Check storage
ls -la /var/log/journal/

# Verify usage
sudo journalctl --disk-usage
```

---

# 🔹 Subtask 2.3 — Configure Log Rotation and Retention

## 🛠️ Step 1: Configure size-based rotation

```bash
sudo nano /etc/systemd/journald.conf
```

### ✏️ Configure:

```ini
[Journal]
SystemMaxUse=2G
SystemKeepFree=1G
SystemMaxFileSize=200M
SystemMaxFiles=10
RuntimeMaxUse=500M
RuntimeKeepFree=100M
```

---

## 🛠️ Step 2: Configure time-based retention

```ini
MaxRetentionSec=2month
MaxFileSec=1week
```

---

## 🛠️ Step 3: Apply settings

```bash
# Restart journald
sudo systemctl restart systemd-journald

# Force rotation
sudo systemctl kill --signal=SIGUSR2 systemd-journald

# Check disk usage
sudo journalctl --disk-usage

# Check journal files
ls -lh /var/log/journal/*/
```

---

# 🧪 Task 3: Investigate Logs to Diagnose System Errors

---

# 🔹 Subtask 3.1 — Identify Common System Issues

## 🛠️ Step 1: Generate test log entries

```bash
# Generate test messages
logger -p user.info "Test info message"
logger -p user.warning "Test warning message"
logger -p user.err "Test error message"

# Create failed service attempt
sudo systemctl start nonexistent-service 2>/dev/null || true
```

---

## 🛠️ Step 2: Search authentication issues

```bash
# Failed SSH attempts
sudo journalctl -u sshd | grep -i "failed\|error\|denied"

# Authentication failures
sudo journalctl | grep -i "authentication failure"

# Sudo usage
sudo journalctl | grep -i sudo
```

---

## 🛠️ Step 3: Investigate boot issues

```bash
# Current boot logs
sudo journalctl -b

# Previous boot logs
sudo journalctl -b -1

# List all boots
sudo journalctl --list-boots

# Kernel messages
sudo journalctl -k
```

---

# 🔹 Subtask 3.2 — Advanced Log Analysis Techniques

## 🛠️ Step 1: JSON output

```bash
# JSON output
sudo journalctl -u sshd -o json | head -5

# Pretty JSON output
sudo journalctl -u sshd -o json-pretty -n 3
```

---

## 🛠️ Step 2: Search using grep

```bash
# Search errors
sudo journalctl --since "1 hour ago" | grep -i "error\|fail\|critical"

# Count errors
sudo journalctl --since today | grep -c -i error

# Unique errors
sudo journalctl -p err --since today | grep -o "error.*" | sort | uniq -c
```

---

## 🛠️ Step 3: Analyze system performance

```bash
# Memory issues
sudo journalctl | grep -i "out of memory\|oom\|memory"

# Disk space issues
sudo journalctl | grep -i "no space\|disk full\|filesystem"

# Network problems
sudo journalctl -u NetworkManager --since "1 hour ago"
```

---

# 🔹 Subtask 3.3 — Create a System Health Report

## 🛠️ Step 1: Create health-check script

```bash
sudo nano /usr/local/bin/system-health-check.sh
```

### ✏️ Add this script

```bash
#!/bin/bash

echo "=== System Health Report ==="
echo "Generated on: $(date)"
echo "Hostname: $(hostname)"
echo ""

echo "=== Disk Usage for Journal ==="
sudo journalctl --disk-usage
echo ""

echo "=== Recent Critical Errors ==="
sudo journalctl -p crit --since "24 hours ago" --no-pager
echo ""

echo "=== Failed Services ==="
sudo systemctl --failed
echo ""

echo "=== Recent Boot Information ==="
sudo journalctl -b --no-pager | head -20
echo ""

echo "=== Authentication Failures ==="
sudo journalctl --since "24 hours ago" | grep -i "authentication failure" | tail -10
echo ""

echo "=== System Resource Warnings ==="
sudo journalctl --since "24 hours ago" | grep -i "memory\|disk\|cpu" | grep -i "warning\|error" | tail -10
echo ""

echo "=== Report Complete ==="
```

---

## 🛠️ Step 2: Make executable and run

```bash
# Make executable
sudo chmod +x /usr/local/bin/system-health-check.sh

# Run script
sudo /usr/local/bin/system-health-check.sh
```

---

## 🛠️ Step 3: Schedule daily health checks

```bash
# Create cron job
echo "0 6 * * * /usr/local/bin/system-health-check.sh > /var/log/daily-health-report.log 2>&1" | sudo crontab -

# Verify cron job
sudo crontab -l
```

---

# 🛠️ Troubleshooting Tips

---

# ❌ Issue 1: Logs not persistent after reboot

## ✅ Solution

```bash
sudo mkdir -p /var/log/journal
sudo chown root:systemd-journal /var/log/journal
```

---

# ❌ Issue 2: Journal consuming too much disk space

## ✅ Solution

```bash
# Clean old logs
sudo journalctl --vacuum-size=1G
```

---

# ❌ Issue 3: Permission denied when viewing logs

## ✅ Solution

```bash
sudo usermod -a -G systemd-journal username
```

---

# ❌ Issue 4: Logs not showing recent entries

## ✅ Solution

```bash
sudo systemctl restart systemd-journald
timedatectl status
```

---

# ✅ Verification Commands

```bash
# Verify persistent storage
sudo journalctl --disk-usage
ls -la /var/log/journal/

# Verify service configuration
sudo systemctl status systemd-journald

# Test log filtering
sudo journalctl -p err --since "1 hour ago" -n 5

# Verify health-check script
ls -la /usr/local/bin/system-health-check.sh
sudo /usr/local/bin/system-health-check.sh | head -20
```

---

# 🎯 Best Practices

- ✅ Use persistent logging
- ✅ Monitor journal disk usage regularly
- ✅ Rotate logs to avoid disk exhaustion
- ✅ Use severity filtering for quick troubleshooting
- ✅ Automate health checks using cron jobs
- ✅ Verify journal integrity periodically

---

# 🏁 Conclusion

Congratulations! 🎉

You have successfully learned how to manage and analyze Linux system logs using `journalctl`.

## 📌 What You Learned

- 📖 Viewing and filtering logs
- 🗂️ Configuring persistent storage
- 🔄 Managing log rotation and retention
- 🔍 Diagnosing system issues
- ⚙️ Creating automated health-check scripts
- 📊 Performing advanced system log analysis

---

# 🌍 Real-World Importance

These skills are essential for:

- 🛡️ System Security Monitoring
- ⚡ Troubleshooting Production Systems
- 📈 Performance Optimization
- 🧰 RHCSA Certification Preparation
- ☁️ Enterprise Linux Administration
- 🚀 DevOps & Infrastructure Operations

---

# 🎓 Next Steps

Continue practicing with:

- 🔹 Advanced `journalctl` filtering
- 🔹 Centralized logging solutions
- 🔹 Log forwarding systems
- 🔹 Monitoring integrations
- 🔹 Security event analysis

