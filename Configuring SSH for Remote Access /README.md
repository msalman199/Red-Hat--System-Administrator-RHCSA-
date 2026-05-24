# 🔐 Configuring SSH for Remote Access

## 📌 Objectives

By the end of this lab, students will be able to:

- Install and configure OpenSSH server and client components
- Understand SSH service management and configuration files
- Test SSH connectivity both locally and remotely
- Implement key-based authentication for enhanced security
- Configure SSH security best practices
- Troubleshoot common SSH connection issues

---

# 📋 Prerequisites

Before starting this lab, students should have:

- Basic understanding of Linux command line operations
- Knowledge of file permissions and ownership concepts
- Familiarity with text editors like `nano` or `vim`
- Understanding of network concepts (IP addresses and ports)
- Basic knowledge of Linux user management

---

# 🖥️ Lab Environment Setup

## 🌐 Environment Includes

- Two CentOS/RHEL 8 or 9 virtual machines
- Root and regular user access
- Network connectivity between machines
- Required repositories preconfigured

---

# 🚀 Task 1: Install OpenSSH Server and Client

---

## 🛠️ Subtask 1.1: Check Current SSH Installation Status

### 🔧 Commands

```bash
# Check if SSH client is installed
which ssh

# Check if SSH server is installed
which sshd

# Check SSH service status
systemctl status sshd
```

---

## 🛠️ Subtask 1.2: Install OpenSSH Components

### 🔧 Commands

```bash
# Update package repositories
sudo dnf update -y

# Install OpenSSH server and client
sudo dnf install -y openssh-server openssh-clients

# Verify installation
rpm -qa | grep openssh
```

### ✅ Expected Output

```bash
openssh-server
openssh-clients
openssh
```

---

## 🛠️ Subtask 1.3: Start and Enable SSH Service

### 🔧 Commands

```bash
# Start SSH service immediately
sudo systemctl start sshd

# Enable SSH service at boot
sudo systemctl enable sshd

# Verify SSH service status
sudo systemctl status sshd

# Check if SSH is listening on port 22
sudo netstat -tlnp | grep :22
```

---

## 🛠️ Subtask 1.4: Configure Firewall for SSH

### 🔧 Commands

```bash
# Check firewall status
sudo firewall-cmd --state

# Allow SSH service permanently
sudo firewall-cmd --permanent --add-service=ssh

# Reload firewall rules
sudo firewall-cmd --reload

# Verify allowed services
sudo firewall-cmd --list-services
```

---

# 🌐 Task 2: Test SSH Access Locally and Remotely

---

## 🛠️ Subtask 2.1: Create Test User Account

### 🔧 Commands

```bash
# Create new user
sudo useradd -m sshuser

# Set password
sudo passwd sshuser

# Add sudo privileges (optional)
sudo usermod -aG wheel sshuser

# Verify user details
id sshuser
```

---

## 🛠️ Subtask 2.2: Test Local SSH Connection

### 🔧 Commands

```bash
# Display IP address
ip addr show

# SSH into localhost
ssh sshuser@localhost

# SSH using loopback IP
ssh sshuser@127.0.0.1

# Exit session
exit
```

---

## 🛠️ Subtask 2.3: Test Remote SSH Connection

### 🔧 Commands

```bash
# Connect to remote machine
ssh sshuser@IP_ADDRESS

# Verbose connection output
ssh -v sshuser@IP_ADDRESS

# Specify SSH port manually
ssh -p 22 sshuser@IP_ADDRESS
```

---

## 🛠️ Subtask 2.4: Verify SSH Configuration File

### 🔧 Commands

```bash
# View SSH server configuration
sudo cat /etc/ssh/sshd_config

# Check important configuration parameters
sudo grep -E "^(Port|PermitRootLogin|PasswordAuthentication|PubkeyAuthentication)" /etc/ssh/sshd_config
```

### 📌 Important Parameters

| Parameter | Description |
|---|---|
| Port 22 | Default SSH port |
| PermitRootLogin | Controls root SSH access |
| PasswordAuthentication | Enables password login |
| PubkeyAuthentication | Enables SSH key login |

---

# 🔑 Task 3: Set Up Key-Based Authentication

---

## 🛠️ Subtask 3.1: Generate SSH Key Pair

### 🔧 Commands

```bash
# Switch to test user
su - sshuser

# Generate RSA key pair
ssh-keygen -t rsa -b 4096 -C "sshuser@lab-machine"

# Generate ED25519 key pair (recommended)
ssh-keygen -t ed25519 -C "sshuser@lab-machine"

# View generated keys
ls -la ~/.ssh/
```

### 📌 Notes

- Press `Enter` for default file location
- Use a strong passphrase for better security

---

## 🛠️ Subtask 3.2: Copy Public Key to Target Machine

### 🔧 Local Machine

```bash
# Copy SSH key locally
ssh-copy-id sshuser@localhost

# Manual method
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# Secure permissions
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
```

### 🔧 Remote Machine

```bash
# Copy SSH key remotely
ssh-copy-id sshuser@REMOTE_IP_ADDRESS

# Verify authorized_keys
ssh sshuser@REMOTE_IP_ADDRESS "cat ~/.ssh/authorized_keys"
```

---

## 🛠️ Subtask 3.3: Test Key-Based Authentication

### 🔧 Commands

```bash
# Test local SSH key login
ssh sshuser@localhost

# Verbose authentication details
ssh -v sshuser@localhost

# Test remote login
ssh sshuser@REMOTE_IP_ADDRESS
```

---

## 🛠️ Subtask 3.4: Disable Password Authentication

### 🔧 Backup Configuration

```bash
# Exit user session
exit

# Backup SSH config
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
```

### 🔧 Edit SSH Configuration

```bash
sudo nano /etc/ssh/sshd_config
```

### ✏️ Update These Settings

```bash
PasswordAuthentication no
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
PermitRootLogin no
```

### 🔧 Apply Changes

```bash
# Validate configuration
sudo sshd -t

# Restart SSH service
sudo systemctl restart sshd

# Verify service status
sudo systemctl status sshd
```

---

## 🛠️ Subtask 3.5: Test Security Configuration

### 🔧 Commands

```bash
# Attempt password authentication
ssh -o PreferredAuthentications=password sshuser@localhost

# Successful key login
ssh sshuser@localhost
```

---

# 🔒 Advanced SSH Configuration and Security

---

## 🛠️ Configure SSH Client Settings

### 🔧 Commands

```bash
# Create SSH config directory
mkdir -p ~/.ssh

# Create SSH client config
nano ~/.ssh/config
```

### ✏️ Add Configuration

```bash
# SSH Client Configuration

Host lab-server
    HostName localhost
    User sshuser
    Port 22
    IdentityFile ~/.ssh/id_rsa

Host remote-server
    HostName REMOTE_IP_ADDRESS
    User sshuser
    Port 22
    IdentityFile ~/.ssh/id_rsa
```

### 🔧 Secure Config File

```bash
chmod 600 ~/.ssh/config
```

### 🔧 Test Alias Connection

```bash
ssh lab-server
```

---

# 🛡️ SSH Security Best Practices

---

## 🛠️ Harden SSH Server

### 🔧 Edit Configuration

```bash
sudo nano /etc/ssh/sshd_config
```

### ✏️ Recommended Security Settings

```bash
# Change default SSH port
Port 2222

# Allow specific users only
AllowUsers sshuser

# Disable empty passwords
PermitEmptyPasswords no

# Limit login attempts
MaxAuthTries 3

# Connection limits
MaxStartups 3

# Disable X11 forwarding
X11Forwarding no

# Idle timeout settings
ClientAliveInterval 300
ClientAliveCountMax 2
```

### 🔧 Apply Changes

```bash
# Validate SSH configuration
sudo sshd -t

# Update firewall rules
sudo firewall-cmd --permanent --remove-service=ssh
sudo firewall-cmd --permanent --add-port=2222/tcp
sudo firewall-cmd --reload

# Restart SSH service
sudo systemctl restart sshd
```

---

# 🧰 Troubleshooting Common SSH Issues

---

## ❌ Issue 1: Connection Refused

### 🔧 Commands

```bash
# Check SSH service
sudo systemctl status sshd

# Verify listening port
sudo netstat -tlnp | grep :22

# Check firewall configuration
sudo firewall-cmd --list-all
```

---

## ❌ Issue 2: Permission Denied

### 🔧 Commands

```bash
# Check SSH permissions
ls -la ~/.ssh/

# Fix permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/authorized_keys
```

---

## ❌ Issue 3: SSH Key Authentication Fails

### 🔧 Commands

```bash
# Monitor SSH logs
sudo journalctl -u sshd -f

# Verify authorized_keys
cat ~/.ssh/authorized_keys

# Debug SSH connection
ssh -vvv sshuser@localhost
```

---

# ✅ Verification and Testing

---

## 🛠️ Complete System Test

### 🔧 Commands

```bash
# Verify SSH service
sudo systemctl is-active sshd
sudo systemctl is-enabled sshd

# Verify listening port
sudo ss -tlnp | grep :22

# Test public key authentication
ssh -o PreferredAuthentications=publickey sshuser@localhost

# Validate configuration syntax
sudo sshd -t

# Verify security settings
sudo grep -E "^(PasswordAuthentication|PubkeyAuthentication|PermitRootLogin)" /etc/ssh/sshd_config
```

---

# 📚 Conclusion

In this lab, you successfully:

- Installed and configured OpenSSH server and client
- Tested local and remote SSH connectivity
- Configured SSH key-based authentication
- Applied SSH security hardening techniques
- Learned troubleshooting and debugging methods

---

# 🌍 Real-World Applications

SSH is widely used for:

- Managing cloud servers
- Secure remote administration
- CI/CD automation
- Secure file transfers using SCP/SFTP
- Remote development environments
- Database tunneling and port forwarding

This lab also supports practical RHCSA exam preparation and real-world Linux administration skills.



