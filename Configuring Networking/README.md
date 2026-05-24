# 🌐 Configuring Networking 

## 📘 Objectives

By the end of this lab, students will be able to:

* Configure network interfaces using modern Linux networking tools
* Assign static and dynamic IP addresses using `nmcli`
* Modify system hostname using `hostnamectl`
* Test network connectivity using diagnostic tools
* Troubleshoot Linux networking issues
* Understand Linux network administration basics

---

# 🛠️ Prerequisites

Before starting this lab, ensure you have:

* Basic Linux command-line knowledge
* Familiarity with text editors (`nano`, `vim`, `gedit`)
* Understanding of networking basics (IP, DNS, Gateway)
* Sudo privileges
* Previous Linux administration experience

---

# ☁️ Lab Environment Setup

Al Nafi provides ready-to-use cloud machines.

### Environment Includes:

* CentOS/RHEL 8 or 9
* NetworkManager installed
* Internet access
* Networking tools pre-installed
* Root or sudo access

---

# 📡 Task 1: Assign IP Addresses Using nmcli

## 🔧 Subtask 1.1: Explore Current Network Configuration

### 🛠️ Commands

```bash
# Check current network connections
nmcli connection show

# Display network device status
nmcli device status

# Show IP configuration
ip addr show
```

### 📖 Expected Output

* Connection names
* Device states
* Current IP addresses
* Active interfaces

---

## 🔧 Subtask 1.2: Create a Static Network Connection

### 🛠️ Commands

```bash
# Create static connection profile
sudo nmcli connection add \
    type ethernet \
    con-name "lab-static-connection" \
    ifname eth0 \
    ip4 192.168.1.100/24 \
    gw4 192.168.1.1

# Configure DNS servers
sudo nmcli connection modify "lab-static-connection" \
    ipv4.dns "8.8.8.8,8.8.4.4"

# Set manual mode
sudo nmcli connection modify "lab-static-connection" \
    ipv4.method manual
```

### 📖 Command Breakdown

| Option          | Description              |
| --------------- | ------------------------ |
| `type ethernet` | Ethernet connection type |
| `con-name`      | Connection profile name  |
| `ifname eth0`   | Network interface        |
| `ip4`           | IPv4 address             |
| `gw4`           | Default gateway          |

---

## 🔧 Subtask 1.3: Activate Network Connection

### 🛠️ Commands

```bash
# Activate connection
sudo nmcli connection up "lab-static-connection"

# Verify active connection
nmcli connection show --active

# Check IP configuration
ip addr show eth0
```

---

## 🔧 Subtask 1.4: Configure IP Using ifconfig (Legacy Method)

### 🛠️ Commands

```bash
# Install net-tools package
sudo yum install net-tools -y

# Assign temporary IP
sudo ifconfig eth0 192.168.1.101 netmask 255.255.255.0

# Add default gateway
sudo route add default gw 192.168.1.1

# Verify settings
ifconfig eth0
route -n
```

> ⚠️ Note: `ifconfig` changes are temporary and disappear after reboot.

---

# 🖥️ Task 2: Modify Hostname with hostnamectl

## 🔧 Subtask 2.1: Check Current Hostname

### 🛠️ Commands

```bash
# Show hostname details
hostnamectl status

# Display hostname
hostname

# View hostname file
cat /etc/hostname
```

---

## 🔧 Subtask 2.2: Set New Hostname

### 🛠️ Commands

```bash
# Set hostname
sudo hostnamectl set-hostname "lab-server-01"

# Verify hostname
hostnamectl status

# Confirm persistence
cat /etc/hostname
```

---

## 🔧 Subtask 2.3: Configure Hostname Resolution

### 🛠️ Commands

```bash
# Add hostname to hosts file
sudo bash -c 'echo "127.0.0.1 lab-server-01" >> /etc/hosts'

# Verify hosts file
cat /etc/hosts

# Test resolution
nslookup lab-server-01
```

---

## 🔧 Subtask 2.4: Configure Additional Hostname Properties

### 🛠️ Commands

```bash
# Set pretty hostname
sudo hostnamectl set-hostname "Lab Server 01" --pretty

# Set deployment environment
sudo hostnamectl set-deployment "development"

# Set location
sudo hostnamectl set-location "Training Lab"

# View configuration
hostnamectl status
```

---

# 🌍 Task 3: Test Network Connectivity

## 🔧 Subtask 3.1: Connectivity Testing with ping

### 🛠️ Commands

```bash
# Ping local gateway
ping -c 4 192.168.1.1

# Ping external DNS server
ping -c 4 8.8.8.8

# Ping website
ping -c 4 google.com

# Continuous ping
ping google.com
```

### 📖 Options Explained

| Option  | Description     |
| ------- | --------------- |
| `-c 4`  | Send 4 packets  |
| No `-c` | Continuous ping |

---

## 🔧 Subtask 3.2: Advanced Testing with traceroute

### 🛠️ Commands

```bash
# Install traceroute
sudo yum install traceroute -y

# Trace route to domain
traceroute google.com

# Trace route to IP
traceroute 8.8.8.8

# UDP traceroute
traceroute -U google.com
```

### 📖 Understanding traceroute

* Each line is a network hop
* Shows response times
* `*` indicates timeout or blocked response

---

## 🔧 Subtask 3.3: DNS Testing with nslookup

### 🛠️ Commands

```bash
# Basic DNS lookup
nslookup google.com

# MX record lookup
nslookup -type=MX google.com

# Use specific DNS server
nslookup google.com 8.8.8.8

# Reverse DNS lookup
nslookup 8.8.8.8

# Interactive mode
nslookup
> google.com
> facebook.com
> exit
```

---

## 🔧 Subtask 3.4: Additional Diagnostic Tools

### 🛠️ Commands

```bash
# Install networking utilities
sudo yum install bind-utils wget curl -y

# Advanced DNS query
dig google.com

# HTTP connectivity test
curl -I http://google.com

# Download test
wget --spider http://google.com

# Check listening ports
ss -tuln

# Network statistics
netstat -i
```

---

# 📜 Comprehensive Network Configuration Script

### 🛠️ Script

```bash
#!/bin/bash
# Network Configuration Lab Script

echo "=== Network Configuration Lab Script ==="

# Configure network interface
sudo nmcli connection add \
    type ethernet \
    con-name "lab-connection" \
    ifname eth0 \
    ip4 192.168.1.150/24 \
    gw4 192.168.1.1

sudo nmcli connection modify "lab-connection" \
    ipv4.dns "8.8.8.8,8.8.4.4" \
    ipv4.method manual

sudo nmcli connection up "lab-connection"

# Configure hostname
sudo hostnamectl set-hostname "lab-network-server"
sudo bash -c 'echo "127.0.0.1 lab-network-server" >> /etc/hosts'

# Connectivity tests
echo "Testing gateway..."
ping -c 2 192.168.1.1

echo "Testing external DNS..."
ping -c 2 8.8.8.8

echo "Testing domain resolution..."
nslookup google.com

echo "=== Lab Complete ==="
```

---

# 🚨 Troubleshooting Common Issues

## ❌ Issue 1: Network Interface Not Found

### Problem

```text
Device 'eth0' not found
```

### 🛠️ Solution

```bash
# List interfaces
nmcli device status

# Show interfaces
ip link show
```

---

## ❌ Issue 2: DNS Resolution Failure

### 🛠️ Solution

```bash
# Check DNS configuration
cat /etc/resolv.conf

# Set DNS manually
sudo nmcli connection modify "connection-name" ipv4.dns "8.8.8.8,8.8.4.4"

# Restart NetworkManager
sudo systemctl restart NetworkManager
```

---

## ❌ Issue 3: Permission Denied

### 🛠️ Solution

```bash
# Check sudo access
sudo -l

# Add user to wheel group
sudo usermod -a -G wheel username
```

---

## ❌ Issue 4: Configuration Not Persistent

### 🛠️ Solution

```bash
# Enable autoconnect
sudo nmcli connection modify "connection-name" connection.autoconnect yes

# Verify setting
nmcli connection show "connection-name" | grep autoconnect
```

---

# ✅ Verification Checklist

* [ ] Created network connection using `nmcli`
* [ ] Assigned static IP address
* [ ] Changed hostname successfully
* [ ] Verified hostname persistence
* [ ] Pinged local gateway
* [ ] Pinged external IP
* [ ] Pinged domain name
* [ ] Used traceroute successfully
* [ ] Performed DNS lookup
* [ ] Verified network services

---

# 🎯 Conclusion

Congratulations! You successfully completed the **Configuring Networking Lab**.

## 🏆 Skills Learned

* Modern Linux network management
* Static IP configuration
* Hostname management
* DNS troubleshooting
* Network diagnostics
* Linux networking administration

## 💡 Why This Matters

These networking skills are essential for:

* Server administration
* Cloud infrastructure
* Enterprise networking
* Troubleshooting production systems
* RHCSA certification preparation

## 🚀 Next Steps

Explore advanced networking topics:

* Network bonding
* VLAN configuration
* Firewall management (`firewalld`)
* Network security
* Access controls

---

# 📚 RHCSA Exam Relevance

This lab directly supports RHCSA objectives related to:

* Network configuration
* Hostname management
* Connectivity troubleshooting
* DNS configuration
* Linux system administration


