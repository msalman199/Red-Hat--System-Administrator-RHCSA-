# ⏰ Using Cron Jobs for Task Automation

> ## 📘 Overview
> Learn how to automate repetitive Linux tasks using `cron` and `at` commands for efficient system administration and maintenance.

---

# 🎯 Objectives

By the end of this lab, you will be able to:

✅ Understand the purpose and functionality of cron jobs  
✅ Create and configure cron jobs using `crontab`  
✅ Schedule one-time tasks using the `at` command  
✅ Monitor and verify cron job execution  
✅ Troubleshoot common cron job issues  
✅ Implement real-world automation scenarios  

---

# 📚 Prerequisites

Before starting this lab, you should have:

🔹 Basic Linux command-line knowledge  
🔹 Understanding of file permissions and ownership  
🔹 Familiarity with `nano` or `vi` text editors  
🔹 Basic shell scripting concepts  
🔹 Understanding of system services and processes  

---

# 🖥️ Lab Environment

## ☁️ Ready-to-Use Cloud Machines

Al Nafi provides pre-configured Linux cloud machines for this lab.

### 🧰 Your Environment Includes

- 🐧 CentOS/RHEL 8 or 9 system
- 🔑 Root access
- ⏰ Pre-installed cron service
- 📝 Text editors (`nano`, `vi`)
- ⚙️ Standard Linux utilities

---

# 🚀 Task 1: Understanding and Creating Cron Jobs

---

# 🔹 Subtask 1.1: Verify Cron Service Status

---

## 🛠️ Tool: `systemctl`

Check cron service status:

```bash
systemctl status crond
```

---

## 🛠️ Tool: `systemctl`

Start cron service if not running:

```bash
sudo systemctl start crond
```

---

## 🛠️ Tool: `systemctl`

Enable cron service at boot:

```bash
sudo systemctl enable crond
```

---

# 🔹 Subtask 1.2: Understanding Cron Syntax

---

# 📖 Cron Format

```text
* * * * * command-to-execute
| | | | |
| | | | +-- Day of week (0-7)
| | | +---- Month (1-12)
| | +------ Day of month (1-31)
| +-------- Hour (0-23)
+---------- Minute (0-59)
```

---

# 🧾 Common Cron Examples

| ⏰ Schedule | 📘 Meaning |
|---|---|
| `0 2 * * *` | Run daily at 2:00 AM |
| `30 14 * * 1` | Run every Monday at 2:30 PM |
| `0 0 1 * *` | Run on first day of month |
| `*/15 * * * *` | Run every 15 minutes |

---

# 🔹 Subtask 1.3: Create Your First Cron Job

---

## 🛠️ Tool: `crontab`

Open crontab editor:

```bash
crontab -e
```

> 💡 If prompted, choose `nano` for beginners.

---

## 🛠️ Tool: `cron`

Add the following cron job:

```bash
# Log system uptime every 5 minutes
*/5 * * * * echo "$(date): System uptime: $(uptime)" >> /home/$(whoami)/system_log.txt
```

---

# 💾 Save and Exit Editor

## 📝 Nano

```text
Ctrl + X → Y → Enter
```

## 📝 Vi/Vim

```text
Esc → :wq → Enter
```

---

# 🔹 Subtask 1.4: Create and Schedule Backup Script

---

## 🛠️ Tool: `mkdir`

Create backup directory:

```bash
mkdir -p /home/$(whoami)/backups
```

---

## 🛠️ Tool: `cat`

Create backup script:

```bash
cat > /home/$(whoami)/backup_script.sh << 'EOF'
#!/bin/bash

BACKUP_DIR="/home/$(whoami)/backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="backup_$DATE.tar.gz"

tar -czf "$BACKUP_DIR/$BACKUP_FILE" \
    --exclude="$BACKUP_DIR" \
    /home/$(whoami)/ 2>/dev/null

cd "$BACKUP_DIR"
ls -t backup_*.tar.gz | tail -n +6 | xargs -r rm

echo "$(date): Backup completed - $BACKUP_FILE" >> /home/$(whoami)/backup_log.txt
EOF
```

---

## 🛠️ Tool: `chmod`

Make script executable:

```bash
chmod +x /home/$(whoami)/backup_script.sh
```

---

## 🛠️ Tool: `crontab`

Schedule backup daily at 3:00 AM:

```bash
crontab -e
```

Add:

```bash
0 3 * * * /home/$(whoami)/backup_script.sh
```

---

# 🔹 Subtask 1.5: Create Disk Monitoring Cron Job

---

## 🛠️ Tool: `cat`

Create monitoring script:

```bash
cat > /home/$(whoami)/disk_monitor.sh << 'EOF'
#!/bin/bash

THRESHOLD=80
LOG_FILE="/home/$(whoami)/disk_monitor.log"

USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "$(date): WARNING - Disk usage is ${USAGE}%" >> "$LOG_FILE"
else
    echo "$(date): OK - Disk usage is ${USAGE}%" >> "$LOG_FILE"
fi
EOF
```

---

## 🛠️ Tool: `chmod`

```bash
chmod +x /home/$(whoami)/disk_monitor.sh
```

---

## 🛠️ Tool: `crontab`

Run every hour:

```bash
0 * * * * /home/$(whoami)/disk_monitor.sh
```

---

# 🚀 Task 2: Using the `at` Command

---

# 🔹 Subtask 2.1: Install and Configure `at`

---

## 🛠️ Tool: `systemctl`

Check atd service:

```bash
systemctl status atd
```

---

## 🛠️ Tool: `yum`

Install `at` package:

```bash
sudo yum install at -y
```

---

## 🛠️ Tool: `apt`

Ubuntu/Debian systems:

```bash
sudo apt install at -y
```

---

## 🛠️ Tool: `systemctl`

Start and enable service:

```bash
sudo systemctl start atd
sudo systemctl enable atd
```

---

# 🔹 Subtask 2.2: Schedule One-Time Tasks

---

## 🛠️ Tool: `at`

Run task after 2 minutes:

```bash
echo "echo 'Hello from at command!' >> /home/$(whoami)/at_test.txt" | at now + 2 minutes
```

---

## 🛠️ Tool: `at`

Schedule for a specific time:

```bash
echo "echo 'Scheduled task executed' >> /home/$(whoami)/scheduled_task.txt" | at 16:30
```

---

## 🛠️ Tool: `at`

Schedule task for tomorrow:

```bash
echo "echo 'Tomorrow task executed' >> /home/$(whoami)/tomorrow_task.txt" | at 10:00 tomorrow
```

---

## 🛠️ Tool: `at`

Create system report task:

```bash
at now + 1 minute << 'EOF'
echo "=== System Information Report ===" > /home/$(whoami)/system_report.txt
echo "Date: $(date)" >> /home/$(whoami)/system_report.txt
echo "Uptime: $(uptime)" >> /home/$(whoami)/system_report.txt
free -h >> /home/$(whoami)/system_report.txt
df -h >> /home/$(whoami)/system_report.txt
EOF
```

---

# 🔹 Subtask 2.3: Manage `at` Jobs

---

## 🛠️ Tool: `atq`

List pending jobs:

```bash
atq
```

---

## 🛠️ Tool: `at`

View job details:

```bash
at -c 1
```

---

## 🛠️ Tool: `atrm`

Remove job:

```bash
atrm 1
```

---

## 🛠️ Tool: `atrm`

Remove all jobs:

```bash
atq | awk '{print $1}' | xargs -r atrm
```

---

# 📊 Task 3: Monitor and Verify Cron Jobs

---

# 🔹 Subtask 3.1: View Current Cron Jobs

---

## 🛠️ Tool: `crontab`

List current user jobs:

```bash
crontab -l
```

---

## 🛠️ Tool: `crontab`

List root cron jobs:

```bash
sudo crontab -l
```

---

## 🛠️ Tool: `crontab`

List another user cron jobs:

```bash
sudo crontab -u username -l
```

---

# 🔹 Subtask 3.2: Monitor Cron Execution

---

## 🛠️ Tool: `tail`

Monitor cron logs:

```bash
sudo tail -f /var/log/cron
```

---

## 🛠️ Tool: `grep`

Search cron messages:

```bash
sudo grep CRON /var/log/messages | tail -10
```

---

## 🛠️ Tool: `journalctl`

View journald cron logs:

```bash
sudo journalctl -u crond -f
```

---

# 🔹 Subtask 3.3: Create Cron Test Script

---

## 🛠️ Tool: `cat`

Create test script:

```bash
cat > /home/$(whoami)/cron_test.sh << 'EOF'
#!/bin/bash

LOG_FILE="/home/$(whoami)/cron_test.log"
TEST_FILE="/home/$(whoami)/cron_test_output.txt"

echo "$(date): Cron test started" >> "$LOG_FILE"

echo "Cron executed at $(date)" >> "$TEST_FILE"

UPTIME_INFO=$(uptime)
echo "Uptime: $UPTIME_INFO" >> "$LOG_FILE"

echo "$(date): Cron test completed" >> "$LOG_FILE"
EOF
```

---

## 🛠️ Tool: `chmod`

```bash
chmod +x /home/$(whoami)/cron_test.sh
```

---

## 🛠️ Tool: `crontab`

Schedule every 2 minutes:

```bash
*/2 * * * * /home/$(whoami)/cron_test.sh
```

---

# 🔹 Subtask 3.4: Create Cron Dashboard

---

## 🛠️ Tool: `cat`

Create dashboard script:

```bash
cat > /home/$(whoami)/cron_dashboard.sh << 'EOF'
#!/bin/bash

echo "=================================="
echo "    CRON JOB STATUS DASHBOARD"
echo "=================================="

echo "Generated on: $(date)"
echo

echo "Current Cron Jobs:"
crontab -l

echo
echo "Pending at Jobs:"
atq

echo
echo "Cron Service Status:"
systemctl is-active crond
EOF
```

---

## 🛠️ Tool: `chmod`

```bash
chmod +x /home/$(whoami)/cron_dashboard.sh
```

---

## 🛠️ Tool: `bash`

Run dashboard:

```bash
./cron_dashboard.sh
```

---

# 🔹 Subtask 3.5: Verify Cron Job Execution

---

## 🛠️ Tool: `ls`

Check system log:

```bash
ls -la /home/$(whoami)/system_log.txt
```

---

## 🛠️ Tool: `tail`

View recent entries:

```bash
tail -5 /home/$(whoami)/system_log.txt
```

---

## 🛠️ Tool: `tail`

View cron test logs:

```bash
tail -10 /home/$(whoami)/cron_test.log
```

---

## 🛠️ Tool: `tail`

View disk monitor logs:

```bash
tail -5 /home/$(whoami)/disk_monitor.log
```

---

## 🛠️ Tool: `cat`

Check at command output:

```bash
cat /home/$(whoami)/at_test.txt
```

---

# ⚙️ Advanced Cron Job Examples

---

# 📁 Example 1: Log Rotation Script

---

## 🛠️ Tool: `cat`

```bash
cat > /home/$(whoami)/log_rotation.sh << 'EOF'
#!/bin/bash

LOG_DIR="/home/$(whoami)"
MAX_SIZE=1048576

for log_file in "$LOG_DIR"/*.log; do
    if [ -f "$log_file" ] && [ $(stat -c%s "$log_file") -gt $MAX_SIZE ]; then
        mv "$log_file" "${log_file}.old"
        touch "$log_file"
    fi
done
EOF
```

---

## 🛠️ Tool: `chmod`

```bash
chmod +x /home/$(whoami)/log_rotation.sh
```

---

## 🛠️ Tool: `crontab`

Schedule daily:

```bash
0 0 * * * /home/$(whoami)/log_rotation.sh
```

---

# 💓 Example 2: System Health Check

---

## 🛠️ Tool: `cat`

```bash
cat > /home/$(whoami)/health_check.sh << 'EOF'
#!/bin/bash

HEALTH_LOG="/home/$(whoami)/health_check.log"

echo "=== Health Check - $(date) ===" >> "$HEALTH_LOG"

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
echo "CPU Usage: ${CPU_USAGE}%" >> "$HEALTH_LOG"

MEM_USAGE=$(free | grep Mem | awk '{printf "%.2f", $3/$2 * 100.0}')
echo "Memory Usage: ${MEM_USAGE}%" >> "$HEALTH_LOG"

DISK_USAGE=$(df / | awk 'NR==2 {print $5}')
echo "Disk Usage: $DISK_USAGE" >> "$HEALTH_LOG"
EOF
```

---

## 🛠️ Tool: `chmod`

```bash
chmod +x /home/$(whoami)/health_check.sh
```

---

## 🛠️ Tool: `crontab`

Run every 30 minutes:

```bash
*/30 * * * * /home/$(whoami)/health_check.sh
```

---

# 🛑 Troubleshooting Common Issues

---

# ❗ Issue 1: Cron Job Not Running

---

## ✅ Solutions

```bash
systemctl status crond
sudo tail -f /var/log/cron
ls -la /path/to/script.sh
/path/to/script.sh
```

---

# ❗ Issue 2: Environment Variables Missing

---

## ✅ Solutions

Add environment variables:

```bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
HOME=/home/yourusername
```

---

## ✅ Alternative Solution

Inside script:

```bash
#!/bin/bash
source /etc/environment
source ~/.bashrc
```

---

# ❗ Issue 3: Permission Denied

---

## ✅ Solutions

```bash
chmod +x /path/to/script.sh
ls -la /path/to/script.sh
chown username:username /path/to/script.sh
```

---

# 🌟 Best Practices for Cron Jobs

---

# ✅ 1. Always Use Full Paths

```bash
# Good
0 2 * * * /usr/bin/python3 /home/user/script.py
```

---

# ✅ 2. Redirect Output Properly

```bash
0 2 * * * /path/to/script.sh >> /var/log/script.log 2>&1
```

---

# ✅ 3. Test Scripts Before Scheduling

```bash
./your_script.sh
```

---

## 🛠️ Tool: `env`

Test cron environment:

```bash
env -i /bin/bash --noprofile --norc -c './your_script.sh'
```

---

# ✅ 4. Use Error Handling

```bash
#!/bin/bash
set -e

if ! command_that_might_fail; then
    echo "Error occurred"
    exit 1
fi
```

---

# 🎉 Conclusion

In this lab, you successfully learned how to automate Linux tasks using `cron` and `at`.

---

# 🧠 What You Learned

✅ Automated repetitive system tasks  
✅ Created cron jobs using `crontab`  
✅ Scheduled one-time tasks with `at`  
✅ Monitored cron execution logs  
✅ Built monitoring and backup scripts  
✅ Troubleshot automation issues  
✅ Applied cron job best practices  

---

# 🌍 Why This Matters

Task automation is essential for:

- ⚙️ System maintenance
- 📦 Automated backups
- 📊 Monitoring and reporting
- 🔄 Log rotation
- ☁️ Enterprise Linux administration
- 🏆 RHCSA certification preparation

---

# 🚀 Real-World Use Cases

✅ Automated database backups  
✅ Server monitoring scripts  
✅ Security log analysis  
✅ Scheduled cleanup tasks  
✅ Automated reporting systems  

---

# 📌 End of Lab
