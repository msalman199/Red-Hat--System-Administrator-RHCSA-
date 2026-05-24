# 📦 Installing and Managing Software Packages

## 🎯 Objectives

By the end of this lab, you will be able to:

- Install software packages using `dnf` and `yum`
- Query and search installed packages using `rpm` and `dnf`
- Remove unwanted software packages
- Update packages to latest versions
- Understand package managers and dependencies
- Verify package integrity and installation status

---

# 🛠️ Prerequisites

Before starting this lab, you should have:

- Basic Linux command-line knowledge
- Familiarity with `cd`, `ls`, and `pwd`
- Experience using `vi` or `nano`
- Root or sudo privileges
- Basic understanding of software packages

---

# ☁️ Lab Environment Setup

This lab uses pre-configured Linux cloud machines with:

- Red Hat Enterprise Linux / CentOS / Rocky Linux
- Root access privileges
- Network connectivity
- Package management tools installed

---

# 📘 Task 1: Installing Packages Using dnf or yum

## 🔧 Subtask 1.1: Understanding Package Managers

| Tool | Description |
|------|-------------|
| `yum` | Traditional package manager |
| `dnf` | Modern replacement for yum |
| `rpm` | Low-level package management tool |

---

## 🔍 Subtask 1.2: Checking Your Package Manager

### 🛠️ Commands

```bash
# Check if dnf exists
which dnf

# Check if yum exists
which yum

# Check system version
cat /etc/redhat-release
```

> ℹ️ RHEL/CentOS 8+ systems use `dnf` by default.

---

## 🔄 Subtask 1.3: Updating Repository Information

### 🛠️ Commands

```bash
# Update packages
sudo dnf update

# Older systems
sudo yum update

# Refresh repository metadata
sudo dnf makecache
```

---

## 🔎 Subtask 1.4: Searching for Packages

### 🛠️ Commands

```bash
# Search package
sudo dnf search wget

# Search related packages
sudo dnf search "text editor"

# Package details
sudo dnf info wget

# List available packages
sudo dnf list available | head -20
```

---

## 📥 Subtask 1.5: Installing Single Packages

### 🛠️ Commands

```bash
# Install wget
sudo dnf install wget -y

# Install nano
sudo dnf install nano -y

# Install tree
sudo dnf install tree -y

# Verify installation
which wget
which nano
which tree
```

---

## 📦 Subtask 1.6: Installing Multiple Packages

### 🛠️ Commands

```bash
# Install multiple packages
sudo dnf install htop curl unzip -y

# Install development tools
sudo dnf install git vim-enhanced bash-completion -y
```

---

## 🧰 Subtask 1.7: Installing Package Groups

### 🛠️ Commands

```bash
# List package groups
sudo dnf group list

# Install Development Tools
sudo dnf group install "Development Tools" -y

# Alternative syntax
sudo dnf groupinstall "System Tools" -y
```

---

# 📘 Task 2: Querying Installed Packages with rpm and dnf

## 📋 Subtask 2.1: Using dnf to Query Packages

### 🛠️ Commands

```bash
# List installed packages
sudo dnf list installed | head -20

# Check installed package
sudo dnf list installed | grep wget

# Package info
sudo dnf info wget

# Recent package history
sudo dnf history list | head -10
```

---

## 📋 Subtask 2.2: Using rpm to Query Packages

### 🛠️ Commands

```bash
# List all installed packages
rpm -qa | head -20

# Query package
rpm -q wget

# Detailed package information
rpm -qi wget

# Files installed by package
rpm -ql wget

# Find package owner
rpm -qf /usr/bin/wget
```

---

## 🧠 Subtask 2.3: Advanced Package Queries

### 🛠️ Commands

```bash
# Packages by installation date
rpm -qa --last | head -10

# Dependency query
sudo dnf repoquery --whatrequires wget

# Show dependencies
sudo dnf repoquery --requires wget

# Configuration files
rpm -qc httpd
```

---

## 🔐 Subtask 2.4: Checking Package Integrity

### 🛠️ Commands

```bash
# Verify package
rpm -V wget

# Verify all packages
rpm -Va | head -10

# Verify package signature
rpm -K /var/cache/dnf/*/packages/wget*.rpm
```

---

# 📘 Task 3: Remove and Update Packages

## 🔄 Subtask 3.1: Updating Individual Packages

### 🛠️ Commands

```bash
# Check available updates
sudo dnf check-update

# Update specific package
sudo dnf update wget -y

# Update multiple packages
sudo dnf update curl nano tree -y

# Simulate update
sudo dnf update --assumeno
```

---

## 🌐 Subtask 3.2: Updating All Packages

### 🛠️ Commands

```bash
# Update all packages
sudo dnf update -y

# Security updates only
sudo dnf update --security -y

# Download updates only
sudo dnf update --downloadonly
```

---

## ❌ Subtask 3.3: Removing Packages

### 🛠️ Commands

```bash
# Remove package
sudo dnf remove tree -y

# Remove multiple packages
sudo dnf remove htop unzip -y

# Remove unused dependencies
sudo dnf autoremove tree -y
```

---

## 🗑️ Subtask 3.4: Removing Package Groups

### 🛠️ Commands

```bash
# Installed groups
sudo dnf group list --installed

# Remove Development Tools
sudo dnf group remove "Development Tools" -y

# Remove System Tools
sudo dnf group remove "System Tools" -y
```

---

## 🧹 Subtask 3.5: Advanced Removal Operations

### 🛠️ Commands

```bash
# Remove orphaned packages
sudo dnf autoremove -y

# Remove duplicate packages
sudo dnf remove --duplicates

# Clean cache
sudo dnf clean all

# Remove old kernels
sudo dnf remove $(dnf repoquery --installonly --latest-limit=-2 -q)
```

---

## 📜 Subtask 3.6: Working with Package History

### 🛠️ Commands

```bash
# View history
sudo dnf history list

# Transaction details
sudo dnf history info 1

# Undo transaction
sudo dnf history undo 1

# Redo transaction
sudo dnf history redo 1
```

---

# 🧪 Practical Exercise: Complete Package Management Scenario

## 🚀 Step 1: System Preparation

### 🛠️ Commands

```bash
sudo dnf update -y
sudo dnf clean all
sudo dnf makecache
```

---

## 🌐 Step 2: Install Web Server Environment

### 🛠️ Commands

```bash
# Install web server packages
sudo dnf install httpd php php-mysql mariadb-server -y

# Install utilities
sudo dnf install wget curl vim-enhanced -y

# Verify installation
rpm -q httpd php mariadb-server
```

---

## 🔍 Step 3: Query and Verify Installation

### 🛠️ Commands

```bash
# List installed packages
sudo dnf list installed | grep -E "(httpd|php|mariadb)"

# Detailed information
sudo dnf info httpd

# Configuration files
rpm -qc httpd
```

---

## 🔄 Step 4: Update and Maintenance

### 🛠️ Commands

```bash
# Check updates
sudo dnf check-update

# Update web packages
sudo dnf update httpd php mariadb-server -y

# Remove unused packages
sudo dnf autoremove -y
```

---

## ❌ Step 5: Selective Removal

### 🛠️ Commands

```bash
# Remove package
sudo dnf remove php-mysql -y

# Verify removal
rpm -q php-mysql
```

---

# 🛠️ Troubleshooting Common Issues

## ⚠️ Package Conflicts

```bash
# Skip broken packages
sudo dnf install package-name --skip-broken

# Force installation (dangerous)
sudo rpm -ivh package.rpm --force --nodeps
```

---

## ⚠️ Corrupted Package Database

```bash
# Rebuild RPM database
sudo rpm --rebuilddb

# Rebuild dnf cache
sudo dnf clean all
sudo dnf makecache
```

---

## ⚠️ Network Issues

```bash
# Check repositories
sudo dnf repolist

# Use specific repository
sudo dnf --enablerepo=repository-name install package-name
```

---

# ✅ Best Practices

- Update repositories before installations
- Use `-y` carefully
- Clean cache regularly
- Document installed packages
- Test updates before production deployment
- Remove orphaned packages frequently

---

# 🔒 Security Considerations

- Verify package signatures
- Install from trusted repositories only
- Apply security updates regularly
- Review dependencies before installation
- Monitor package history

---

# 📚 Conclusion

In this lab, you learned how to:

- Install packages using `dnf` and `yum`
- Query package information with `rpm` and `dnf`
- Update software packages
- Remove unnecessary packages
- Troubleshoot package management issues

These skills are essential for Linux system administration and RHCSA certification preparation.



# 👨‍💻 Author

Linux Administration & RHCSA Practice Lab
