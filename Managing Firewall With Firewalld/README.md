# 🔥 Managing Firewall with firewalld

## 📘 Overview

This lab provides hands-on experience with managing Linux firewalls using **firewalld** on CentOS/RHEL systems. You will learn how to configure firewall rules, manage zones, test connectivity, and apply security best practices.

---

# 🎯 Objectives

By the end of this lab, students will be able to:

- Understand the fundamentals of firewalld and its architecture
- Configure firewall rules using firewalld command-line tools
- Manage firewall zones and assign network interfaces to appropriate zones
- Configure services and ports for different zones
- Test and validate firewall configurations
- Troubleshoot common firewall issues
- Implement security best practices using firewalld

---

# 📋 Prerequisites

Before starting this lab, students should have:

- Basic understanding of Linux command line interface
- Knowledge of network concepts (IP addresses, ports, protocols)
- Familiarity with systemd services
- Understanding of basic security concepts
- Access to a Linux system with root or sudo privileges

---

# 🖥️ Lab Environment

Ready-to-Use Cloud Machines: Al Nafi provides pre-configured Linux-based cloud machines for this lab.

### Environment Includes

- CentOS/RHEL 8 or 9 system with firewalld pre-installed
- Root access via sudo
- Network connectivity for testing
- All necessary tools and utilities

---

# 🛠️ Task 1: Configure Firewall Rules Using firewalld

---

# 🔹 Subtask 1.1: Understanding firewalld Basics

## 🧰 Step 1: Check if firewalld is running

```bash
sudo systemctl status firewalld
```

---

## 🧰 Step 2: Start and enable firewalld

```bash
sudo systemctl start firewalld
sudo systemctl enable firewalld
```

---

## 🧰 Step 3: Verify firewalld is active

```bash
sudo firewall-cmd --state
```

---

## 🧰 Step 4: Display current firewall configuration

```bash
sudo firewall-cmd --list-all
```

### ✅ Expected Output

You should see the default zone configuration with allowed services and ports.

---

# 🔹 Subtask 1.2: Working with Basic Firewall Rules

## 🧰 Step 1: Check the default zone

```bash
sudo firewall-cmd --get-default-zone
```

---

## 🧰 Step 2: List all available zones

```bash
sudo firewall-cmd --get-zones
```

---

## 🧰 Step 3: View detailed information about the public zone

```bash
sudo firewall-cmd --zone=public --list-all
```

---

## 🧰 Step 4: Add HTTP service temporarily

```bash
sudo firewall-cmd --add-service=http
```

---

## 🧰 Step 5: Verify the service was added

```bash
sudo firewall-cmd --list-services
```

---

## 🧰 Step 6: Make the rule permanent

```bash
sudo firewall-cmd --add-service=http --permanent
```

---

## 🧰 Step 7: Reload firewall

```bash
sudo firewall-cmd --reload
```

---

# 🔹 Subtask 1.3: Managing Ports and Protocols

## 🧰 Step 1: Add a TCP port temporarily

```bash
sudo firewall-cmd --add-port=8080/tcp
```

---

## 🧰 Step 2: Add multiple ports

```bash
sudo firewall-cmd --add-port=3000-3005/tcp
```

---

## 🧰 Step 3: Make port rules permanent

```bash
sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --add-port=3000-3005/tcp --permanent
```

---

## 🧰 Step 4: Remove a port rule

```bash
sudo firewall-cmd --remove-port=3000-3005/tcp --permanent
```

---

## 🧰 Step 5: Add UDP port

```bash
sudo firewall-cmd --add-port=53/udp --permanent
```

---

## 🧰 Step 6: Reload and verify changes

```bash
sudo firewall-cmd --reload
sudo firewall-cmd --list-ports
```

---

# 🛠️ Task 2: Manage Zones and Services

---

# 🔹 Subtask 2.1: Understanding and Working with Zones

## 🧰 Step 1: List all available zones

```bash
sudo firewall-cmd --list-all-zones
```

---

## 🧰 Step 2: Get information about specific zones

```bash
sudo firewall-cmd --zone=dmz --list-all
sudo firewall-cmd --zone=internal --list-all
sudo firewall-cmd --zone=trusted --list-all
```

---

## 🧰 Step 3: Check active zones

```bash
sudo firewall-cmd --get-active-zones
```

---

## 🧰 Step 4: Change default zone

```bash
sudo firewall-cmd --set-default-zone=internal
```

---

## 🧰 Step 5: Verify default zone

```bash
sudo firewall-cmd --get-default-zone
```

---

# 🔹 Subtask 2.2: Assigning Interfaces to Zones

## 🧰 Step 1: List network interfaces

```bash
ip addr show
```

---

## 🧰 Step 2: Assign interface to a zone

```bash
sudo firewall-cmd --zone=public --change-interface=eth0 --permanent
```

---

## 🧰 Step 3: Verify interface assignment

```bash
sudo firewall-cmd --get-zone-of-interface=eth0
```

---

## 🧰 Step 4: Add source IP range to a zone

```bash
sudo firewall-cmd --zone=trusted --add-source=192.168.1.0/24 --permanent
```

---

## 🧰 Step 5: Remove source IP range

```bash
sudo firewall-cmd --zone=trusted --remove-source=192.168.1.0/24 --permanent
```

---

# 🔹 Subtask 2.3: Managing Services in Different Zones

## 🧰 Step 1: List all services

```bash
sudo firewall-cmd --get-services
```

---

## 🧰 Step 2: Add services to specific zones

```bash
sudo firewall-cmd --zone=public --add-service=ssh --permanent
sudo firewall-cmd --zone=public --add-service=https --permanent
sudo firewall-cmd --zone=internal --add-service=samba --permanent
```

---

## 🧰 Step 3: Remove a service

```bash
sudo firewall-cmd --zone=public --remove-service=dhcpv6-client --permanent
```

---

## 🧰 Step 4: Create a custom service

```bash
sudo firewall-cmd --permanent --new-service=myapp
```

---

## 🧰 Step 5: Configure custom service

```bash
sudo firewall-cmd --permanent --service=myapp --set-description="My Custom Application"
sudo firewall-cmd --permanent --service=myapp --set-short="MyApp"
sudo firewall-cmd --permanent --service=myapp --add-port=9090/tcp
```

---

## 🧰 Step 6: Add custom service to zone

```bash
sudo firewall-cmd --zone=public --add-service=myapp --permanent
```

---

## 🧰 Step 7: Reload firewall and verify

```bash
sudo firewall-cmd --reload
sudo firewall-cmd --zone=public --list-services
```

---

# 🛠️ Task 3: Test Firewall Configurations

---

# 🔹 Subtask 3.1: Testing Port Accessibility

## 🧰 Step 1: Install testing tools

```bash
sudo yum install -y nmap telnet nc
```

---

## 🧰 Step 2: Start a simple web server

```bash
sudo python3 -m http.server 8080 &
```

---

## 🧰 Step 3: Test local connectivity

```bash
curl http://localhost:8080
```

---

## 🧰 Step 4: Test port accessibility

```bash
nmap -p 8080 YOUR_SERVER_IP
```

---

## 🧰 Step 5: Test blocked port

```bash
nmap -p 9999 YOUR_SERVER_IP
```

---

## 🧰 Step 6: Stop the web server

```bash
sudo pkill -f "python3 -m http.server"
```

---

# 🔹 Subtask 3.2: Testing Zone Configurations

## 🧰 Step 1: Configure services in zones

```bash
sudo firewall-cmd --zone=public --add-service=http --permanent
sudo firewall-cmd --zone=internal --add-service=ssh --permanent
sudo firewall-cmd --zone=dmz --add-port=8443/tcp --permanent
sudo firewall-cmd --reload
```

---

## 🧰 Step 2: Verify zone configurations

```bash
sudo firewall-cmd --zone=public --list-services
sudo firewall-cmd --zone=internal --list-services
sudo firewall-cmd --zone=dmz --list-ports
```

---

## 🧰 Step 3: Simulate zone switching

```bash
sudo firewall-cmd --set-default-zone=dmz
sudo firewall-cmd --get-default-zone
sudo firewall-cmd --list-all
```

---

## 🧰 Step 4: Switch back to public zone

```bash
sudo firewall-cmd --set-default-zone=public
```

---

# 🔹 Subtask 3.3: Advanced Testing and Validation

## 🧰 Step 1: Enable firewall logging

```bash
sudo firewall-cmd --set-log-denied=all
```

---

## 🧰 Step 2: Monitor firewall logs

```bash
sudo tail -f /var/log/messages | grep -i firewall &
```

---

## 🧰 Step 3: Attempt blocked connection

```bash
telnet YOUR_SERVER_IP 9999
```

---

## 🧰 Step 4: Check firewall direct rules

```bash
sudo firewall-cmd --direct --get-all-rules
```

---

## 🧰 Step 5: Create rich rule

```bash
sudo firewall-cmd --add-rich-rule='rule family="ipv4" source address="192.168.1.100" service name="ssh" accept' --permanent
```

---

## 🧰 Step 6: Verify rich rules

```bash
sudo firewall-cmd --list-rich-rules
```

---

## 🧰 Step 7: Remove rich rule

```bash
sudo firewall-cmd --remove-rich-rule='rule family="ipv4" source address="192.168.1.100" service name="ssh" accept' --permanent
```

---

# 🚨 Troubleshooting Common Issues

---

# ❌ Issue 1: Firewall Rules Not Taking Effect

## 🧰 Solution

```bash
sudo firewall-cmd --reload
sudo firewall-cmd --list-all --permanent
sudo firewall-cmd --list-all
```

---

# ❌ Issue 2: firewalld Service Not Starting

## 🧰 Solution

```bash
sudo systemctl status firewalld -l
sudo systemctl status iptables
sudo systemctl stop iptables
sudo systemctl disable iptables
sudo systemctl restart firewalld
```

---

# ❌ Issue 3: Interface Not in Correct Zone

## 🧰 Solution

```bash
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=public --change-interface=eth0 --permanent
sudo firewall-cmd --reload
```

---

# 🔐 Best Practices and Security Tips

## ✅ Security Best Practices

- Use the Principle of Least Privilege
- Open only necessary ports
- Regularly audit firewall rules
- Use different zones appropriately
- Enable firewall logging
- Backup configurations regularly

---

# ⚡ Useful Commands for Daily Management

## 🧰 Quick status check

```bash
sudo firewall-cmd --state && sudo firewall-cmd --get-default-zone
```

---

## 🧰 List all current rules

```bash
sudo firewall-cmd --list-all
```

---

## 🧰 Enable panic mode

```bash
sudo firewall-cmd --panic-on
```

---

## 🧰 Disable panic mode

```bash
sudo firewall-cmd --panic-off
```

---

## 🧰 Backup firewall configuration

```bash
sudo cp -r /etc/firewalld/ /etc/firewalld.backup.$(date +%Y%m%d)
```

---

# 🧪 Verification and Testing Script

## 🧰 Create Script

```bash
#!/bin/bash
# firewall-test.sh

echo "=== Firewall Configuration Test ==="

echo "1. Checking firewalld status..."
sudo systemctl is-active firewalld

echo "2. Current default zone:"
sudo firewall-cmd --get-default-zone

echo "3. Active zones:"
sudo firewall-cmd --get-active-zones

echo "4. Services in default zone:"
sudo firewall-cmd --list-services

echo "5. Open ports in default zone:"
sudo firewall-cmd --list-ports

echo "6. Rich rules:"
sudo firewall-cmd --list-rich-rules

echo "=== Test Complete ==="
```

---

## 🧰 Make Script Executable and Run

```bash
chmod +x firewall-test.sh
./firewall-test.sh
```

---

# ✅ Conclusion

In this lab, you learned how to:

- Configure firewall rules using firewalld
- Manage firewall zones and interfaces
- Add and remove services and ports
- Create custom services
- Test firewall configurations
- Use rich rules and logging
- Troubleshoot firewall problems

---

# 🚀 Why This Matters

Firewall management is a critical skill for:

- Linux system administration
- RHCSA exam preparation
- Enterprise security
- Production server hardening
- Network troubleshooting

---

# 📚 Next Steps

- Practice real-world firewall configurations
- Explore advanced rich rules
- Learn firewalld D-Bus integration
- Study firewall management for containers
- Pursue advanced Red Hat certifications

---
