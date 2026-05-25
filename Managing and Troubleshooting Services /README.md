# 🛠️ Managing and Troubleshooting Services 

<div align="center">

![Linux](https://img.shields.io/badge/Linux-Systemd-blue?style=for-the-badge&logo=linux)
![Systemctl](https://img.shields.io/badge/Systemctl-Service_Management-red?style=for-the-badge)
![Journalctl](https://img.shields.io/badge/Journalctl-Log_Analysis-orange?style=for-the-badge)
![Networking](https://img.shields.io/badge/Networking-Troubleshooting-green?style=for-the-badge)

# 📚 Complete Service Management & Troubleshooting 

</div>

---

# 📘 Overview

This lab provides hands-on experience with managing and troubleshooting Linux system services using:

- ⚙️ `systemctl`
- 📜 `journalctl`
- 🌐 Network troubleshooting tools
- 🛡️ System monitoring techniques

You will learn how to diagnose service failures, analyze logs, troubleshoot network problems, and create automated health check scripts.

---

# 🎯 Objectives

By the end of this lab, students will be able to:

| ✅ Skills | 📘 Description |
|---|---|
| ⚙️ Manage Services | Use `systemctl` for service management |
| 📜 Analyze Logs | Use `journalctl` to investigate failures |
| 🌐 Troubleshoot Networking | Diagnose DNS and connectivity issues |
| 🔍 Monitor Services | Check service health and statuses |
| 🛠️ Apply Troubleshooting | Use systematic troubleshooting methodologies |
| 🧪 Create Health Checks | Build automated service monitoring scripts |

---

# 📋 Prerequisites

Before starting this lab, students should have:

- 🛠️ Basic Linux command line knowledge
- 🛠️ Familiarity with file system navigation
- 🛠️ Understanding of networking basics
- 🛠️ Knowledge of system services and daemons
- 🛠️ Access to terminal or SSH client

---

# ☁️ Lab Environment

## 🖥️ Ready-to-Use Cloud Machines

| 🖥️ Component | 📘 Description |
|---|---|
| 🐧 Operating System | CentOS/RHEL 8 or 9 |
| 🔑 Access | Root access available |
| ⚙️ Services | Pre-installed systemd services |
| 🌐 Networking | Network configuration tools included |
| 🛠️ Practice Environment | Sample services for troubleshooting |

---

# 🚀 Task 1: Using systemctl and journalctl for Troubleshooting

---

# 🔹 Subtask 1.1: Understanding systemctl Basics

## 🛠️ Tool: List All Services

```bash
systemctl list-units --type=service
```

---

## 🛠️ Tool: View Failed Services

```bash
systemctl list-units --type=service --state=failed
```

---

## 🛠️ Tool: Check SSH Service Status

```bash
systemctl status sshd
```

---

## 🛠️ Tool: View Detailed Service Information

```bash
systemctl show sshd
```

---

# 🔹 Subtask 1.2: Creating a Problematic Service

## 🛠️ Tool: Create Script Directory

```bash
sudo mkdir -p /opt/lab-scripts
```

---

## 🛠️ Tool: Create a Failing Script

```bash
sudo tee /opt/lab-scripts/failing-service.sh > /dev/null << 'EOF'
#!/bin/bash
echo "Service starting..."
sleep 5
echo "Service attempting to access non-existent file..."
cat /nonexistent/file.txt
echo "This line will never execute"
EOF
```

---

## 🛠️ Tool: Make Script Executable

```bash
sudo chmod +x /opt/lab-scripts/failing-service.sh
```

---

## 🛠️ Tool: Create systemd Service File

```bash
sudo tee /etc/systemd/system/lab-failing.service > /dev/null << 'EOF'
[Unit]
Description=Lab Failing Service for Troubleshooting Practice
After=network.target

[Service]
Type=simple
ExecStart=/opt/lab-scripts/failing-service.sh
Restart=no
User=root

[Install]
WantedBy=multi-user.target
EOF
```

---

## 🛠️ Tool: Reload systemd and Enable Service

```bash
sudo systemctl daemon-reload
sudo systemctl enable lab-failing.service
```

---

# 🔹 Subtask 1.3: Troubleshooting Failed Services

## 🛠️ Tool: Start the Problematic Service

```bash
sudo systemctl start lab-failing.service
```

---

## 🛠️ Tool: Check Service Status

```bash
systemctl status lab-failing.service
```

---

## 🛠️ Tool: View Service Logs

```bash
sudo journalctl -u lab-failing.service
```

---

## 🛠️ Tool: Monitor Logs in Real-Time

```bash
sudo journalctl -u lab-failing.service -f
```

---

## 🛠️ Tool: View Recent Logs

```bash
sudo journalctl -u lab-failing.service --since "10 minutes ago"
```

---

## 🛠️ Tool: Show Verbose Logs

```bash
sudo journalctl -u lab-failing.service -o verbose
```

---

# 🔹 Subtask 1.4: Fixing the Service

## 🛠️ Tool: Replace the Broken Script

```bash
sudo tee /opt/lab-scripts/failing-service.sh > /dev/null << 'EOF'
#!/bin/bash
echo "Service starting..."
sleep 5
echo "Service running successfully..."
echo "Current date: $(date)"
echo "Service completed successfully"
EOF
```

---

## 🛠️ Tool: Restart the Service

```bash
sudo systemctl restart lab-failing.service
```

---

## 🛠️ Tool: Verify Service Fix

```bash
systemctl status lab-failing.service
sudo journalctl -u lab-failing.service --since "1 minute ago"
```

---

# 🚀 Task 2: Resolving Network Issues and Misconfigurations

---

# 🔹 Subtask 2.1: Network Diagnostics

## 🛠️ Tool: Check Network Interfaces

```bash
ip addr show
```

---

## 🛠️ Tool: View Routing Table

```bash
ip route show
```

---

## 🛠️ Tool: Check DNS Configuration

```bash
cat /etc/resolv.conf
```

---

## 🛠️ Tool: Test Internet Connectivity

```bash
ping -c 4 8.8.8.8
ping -c 4 google.com
```

---

# 🔹 Subtask 2.2: Simulating DNS Problems

## 🛠️ Tool: Backup DNS Configuration

```bash
sudo cp /etc/resolv.conf /etc/resolv.conf.backup
```

---

## 🛠️ Tool: Create Invalid DNS Configuration

```bash
sudo tee /etc/resolv.conf > /dev/null << 'EOF'
nameserver 192.168.999.999
nameserver 10.0.0.999
EOF
```

---

## 🛠️ Tool: Test DNS Failure

```bash
nslookup google.com
dig google.com
```

---

# 🔹 Subtask 2.3: Troubleshooting Network Services

## 🛠️ Tool: Check NetworkManager Status

```bash
systemctl status NetworkManager
```

---

## 🛠️ Tool: View NetworkManager Logs

```bash
sudo journalctl -u NetworkManager --since "10 minutes ago"
```

---

## 🛠️ Tool: Check Network Devices

```bash
nmcli device status
```

---

## 🛠️ Tool: View Network Connections

```bash
nmcli connection show
```

---

## 🛠️ Tool: Restart NetworkManager

```bash
sudo systemctl restart NetworkManager
```

---

# 🔹 Subtask 2.4: Fixing Network Configuration

## 🛠️ Tool: Restore DNS Configuration

```bash
sudo cp /etc/resolv.conf.backup /etc/resolv.conf
```

---

## 🛠️ Tool: Verify DNS Resolution

```bash
nslookup google.com
dig google.com
```

---

## 🛠️ Tool: Test Connectivity Again

```bash
ping -c 4 google.com
```

---

# 🚀 Task 3: Comprehensive Service Status and Log Analysis

---

# 🔹 Subtask 3.1: System-Wide Service Analysis

## 🛠️ Tool: View Overall System Status

```bash
systemctl status
```

---

## 🛠️ Tool: List Active Services

```bash
systemctl list-units --type=service --state=active
```

---

## 🛠️ Tool: List Inactive Services

```bash
systemctl list-units --type=service --state=inactive
```

---

## 🛠️ Tool: Show Failed Services

```bash
systemctl --failed
```

---

# 🔹 Subtask 3.2: Monitoring Critical Services

## 🛠️ Tool: Check SSH Service

```bash
systemctl status sshd
sudo journalctl -u sshd --since today
```

---

## 🛠️ Tool: Check Firewall Service

```bash
systemctl status firewalld
sudo journalctl -u firewalld --since today
```

---

## 🛠️ Tool: Check Logging Service

```bash
systemctl status rsyslog
sudo journalctl -u rsyslog --since today
```

---

# 🔹 Subtask 3.3: Advanced Log Analysis

## 🛠️ Tool: View Boot Logs

```bash
sudo journalctl -b
```

---

## 🛠️ Tool: View Kernel Logs

```bash
sudo journalctl -k
```

---

## 🛠️ Tool: Show Error Logs Only

```bash
sudo journalctl -p err
```

---

## 🛠️ Tool: Check Journal Disk Usage

```bash
sudo journalctl --disk-usage
```

---

## 🛠️ Tool: View Logs in JSON Format

```bash
sudo journalctl -u sshd -o json-pretty | head -20
```

---

# 🔹 Subtask 3.4: Creating a Service Health Check Script

## 🛠️ Tool: Create Health Check Script

```bash
sudo tee /opt/lab-scripts/service-health-check.sh > /dev/null << 'EOF'
#!/bin/bash

echo "=== System Service Health Check ==="
echo "Date: $(date)"
echo

# Check critical services
CRITICAL_SERVICES=("sshd" "NetworkManager" "firewalld" "rsyslog")

echo "=== Critical Services Status ==="
for service in "${CRITICAL_SERVICES[@]}"; do
    if systemctl is-active --quiet "$service"; then
        echo "✓ $service: ACTIVE"
    else
        echo "✗ $service: INACTIVE"
    fi
done

echo
echo "=== Failed Services ==="
failed_services=$(systemctl --failed --no-legend | wc -l)
if [ "$failed_services" -eq 0 ]; then
    echo "✓ No failed services"
else
    echo "✗ $failed_services failed services found:"
    systemctl --failed --no-legend
fi

echo
echo "=== Network Connectivity ==="
if ping -c 1 8.8.8.8 &> /dev/null; then
    echo "✓ Internet connectivity: OK"
else
    echo "✗ Internet connectivity: FAILED"
fi

if nslookup google.com &> /dev/null; then
    echo "✓ DNS resolution: OK"
else
    echo "✗ DNS resolution: FAILED"
fi

echo
echo "=== Disk Space ==="
df -h / | tail -1 | awk '{print "Root filesystem: " $5 " used"}'

echo
echo "=== Recent Errors ==="
error_count=$(sudo journalctl -p err --since "1 hour ago" --no-pager | wc -l)
echo "Errors in last hour: $error_count"

echo
echo "Health check completed."
EOF
```

---

## 🛠️ Tool: Make Script Executable

```bash
sudo chmod +x /opt/lab-scripts/service-health-check.sh
```

---

## 🛠️ Tool: Run Health Check Script

```bash
sudo /opt/lab-scripts/service-health-check.sh
```

---

# 🚨 Troubleshooting Common Issues

---

# 🔹 Issue 1: Service Won't Start

## 📌 Symptoms

- Service fails after `systemctl start`
- Service enters failed state

---

## 🛠️ Troubleshooting Commands

```bash
# Check service status
systemctl status service-name

# View service configuration
systemctl cat service-name

# View logs
sudo journalctl -u service-name

# Verify permissions
ls -la /path/to/service/files
```

---

# 🔹 Issue 2: Network Connectivity Problems

## 📌 Symptoms

- Cannot reach external hosts
- DNS lookups fail

---

## 🛠️ Troubleshooting Commands

```bash
# Check interfaces
ip addr show

# Check routing
ip route show

# Check DNS
cat /etc/resolv.conf
nslookup google.com

# Check firewall
sudo firewall-cmd --list-all
```

---

# 🔹 Issue 3: Service Keeps Restarting

## 📌 Symptoms

- Service repeatedly restarts
- Logs continuously generate errors

---

## 🛠️ Troubleshooting Commands

```bash
# Check restart policy
systemctl show service-name | grep Restart

# Monitor logs live
sudo journalctl -u service-name -f

# Check current status
systemctl status service-name
```

---

# 🧪 Lab Validation

## 🛠️ Tool: Verify systemctl Knowledge

```bash
systemctl list-units --type=service --state=failed
systemctl status lab-failing.service
```

---

## 🛠️ Tool: Verify journalctl Skills

```bash
sudo journalctl -u lab-failing.service --since "30 minutes ago"
```

---

## 🛠️ Tool: Verify Network Troubleshooting

```bash
ping -c 2 google.com
nslookup google.com
```

---

## 🛠️ Tool: Run Health Check Validation

```bash
sudo /opt/lab-scripts/service-health-check.sh
```

---

# 📚 Useful Commands Reference

| 💻 Command | 📘 Description |
|---|---|
| `systemctl status` | Check service status |
| `systemctl --failed` | List failed services |
| `journalctl -u service` | View service logs |
| `journalctl -f` | Follow logs in real-time |
| `ip addr show` | View IP configuration |
| `ip route show` | Display routing table |
| `nmcli device status` | Check network devices |
| `ping` | Test connectivity |
| `nslookup` | Test DNS resolution |

---

# 🏁 Conclusion

In this lab, you successfully learned how to:

- ✅ Manage services using `systemctl`
- ✅ Analyze logs using `journalctl`
- ✅ Troubleshoot service failures
- ✅ Diagnose network connectivity issues
- ✅ Build automated health check scripts
- ✅ Apply enterprise troubleshooting methodologies

---

# 🔑 Key Takeaways

| 💡 Best Practice | 📘 Explanation |
|---|---|
| Check service status first | Always identify the exact failure |
| Use filtered logs | Narrow down errors quickly |
| Verify DNS and routing | Common causes of network failures |
| Troubleshoot systematically | Prevent unnecessary changes |
| Automate checks | Save time with scripts |


## 🚀 You are now ready to troubleshoot Linux services and networks like a professional system administrator.

</div>
