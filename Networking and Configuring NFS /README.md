# 🌐 Networking and Configuring NFS 

<div align="center">

![NFS](https://img.shields.io/badge/Linux-NFS-blue?style=for-the-badge&logo=linux)
![CentOS](https://img.shields.io/badge/CentOS-RHEL-red?style=for-the-badge&logo=redhat)
![Firewall](https://img.shields.io/badge/Security-Firewalld-orange?style=for-the-badge&logo=firefox)

# 📚 Complete Hands-On NFS Administration Lab

</div>

---

# 📘 Overview

This lab provides hands-on experience with configuring and managing the **Network File System (NFS)** on Linux systems.

You will learn how to:

- 📂 Create and manage NFS shares
- 🌐 Mount remote file systems
- 🔥 Configure firewall access
- 🛡️ Secure NFS deployments
- 🧪 Troubleshoot NFS connectivity issues
- ⚙️ Configure persistent mounts

---

# 🎯 Objectives

By the end of this lab, students will be able to:

| ✅ Skills | 📘 Description |
|---|---|
| 📡 Understand NFS | Learn NFS fundamentals and architecture |
| 🖥️ Configure NFS Server | Create and export shared directories |
| 💻 Configure NFS Client | Mount remote NFS shares |
| 🔥 Configure Firewall | Allow secure NFS communication |
| 🛠️ Troubleshoot Issues | Diagnose NFS problems |
| 🛡️ Apply Security | Implement NFS security practices |

---

# 📋 Prerequisites

Before starting this lab, students should have:

- 🛠️ Basic Linux command line knowledge
- 🛠️ Understanding of file permissions
- 🛠️ Familiarity with systemd services
- 🛠️ Knowledge of networking concepts
- 🛠️ Experience using text editors
- 🛠️ Basic firewall understanding

---

# ☁️ Lab Environment

## 🖥️ Ready-to-Use Cloud Machines

| 🖥️ System | 📘 Description |
|---|---|
| 🖥️ NFS Server | CentOS/RHEL 8 or 9 (`nfs-server`) |
| 💻 NFS Client | CentOS/RHEL 8 or 9 (`nfs-client`) |
| 🌐 Networking | Both systems communicate with each other |
| 🔑 Access | Root access available |

---

# 🚀 Task 1: Configure an NFS Server

---

# 🔹 Subtask 1.1: Install NFS Server Packages

## 🛠️ Tool: Switch to Root User

```bash
sudo su -
```

---

## 🛠️ Tool: Update System Packages

```bash
dnf update -y
```

---

## 🛠️ Tool: Install Required Packages

```bash
dnf install -y nfs-utils rpcbind
```

---

## 🛠️ Tool: Verify Installation

```bash
rpm -qa | grep nfs-utils
rpm -qa | grep rpcbind
```

---

# 🔹 Subtask 1.2: Create Directories for NFS Shares

## 🛠️ Tool: Create Shared Directories

```bash
mkdir -p /nfs/shared
mkdir -p /nfs/public
mkdir -p /nfs/private
```

---

## 🛠️ Tool: Configure Permissions

```bash
# Shared directory
chmod 755 /nfs/shared
chown nobody:nobody /nfs/shared

# Public directory
chmod 755 /nfs/public
chown nobody:nobody /nfs/public

# Private directory
chmod 750 /nfs/private
chown root:root /nfs/private
```

---

## 🛠️ Tool: Create Test Files

```bash
echo "This is a shared file" > /nfs/shared/shared_file.txt
echo "This is a public file" > /nfs/public/public_file.txt
echo "This is a private file" > /nfs/private/private_file.txt
```

---

# 🔹 Subtask 1.3: Configure NFS Exports

## 🛠️ Tool: Backup Existing Export Configuration

```bash
cp /etc/exports /etc/exports.backup
```

---

## 🛠️ Tool: Edit Exports File

```bash
vi /etc/exports
```

---

## 🛠️ Tool: Add Export Entries

```bash
# NFS Export Configuration

# Shared directory - read/write access
/nfs/shared     *(rw,sync,no_root_squash,no_subtree_check)

# Public directory - read-only access
/nfs/public     *(ro,sync,root_squash,no_subtree_check)

# Private directory - restricted network access
/nfs/private    192.168.1.0/24(rw,sync,root_squash,no_subtree_check)
```

---

# 📖 Export Options Explained

| ⚙️ Option | 📘 Description |
|---|---|
| `rw` | Read-write access |
| `ro` | Read-only access |
| `sync` | Write changes before responding |
| `no_root_squash` | Keep remote root privileges |
| `root_squash` | Map remote root to anonymous |
| `no_subtree_check` | Disable subtree verification |

---

## 🛠️ Tool: Validate Export Configuration

```bash
exportfs -a
exportfs -v
```

---

# 🔹 Subtask 1.4: Start and Enable NFS Services

## 🛠️ Tool: Start NFS Services

```bash
systemctl start rpcbind
systemctl start nfs-server
systemctl start rpc-statd
systemctl start nfs-idmapd
```

---

## 🛠️ Tool: Enable Services at Boot

```bash
systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable rpc-statd
systemctl enable nfs-idmapd
```

---

## 🛠️ Tool: Check Service Status

```bash
systemctl status nfs-server
systemctl status rpcbind
```

---

## 🛠️ Tool: Verify Listening Ports

```bash
rpcinfo -p localhost
```

---

# 🚀 Task 2: Configure NFS Client

---

# 🔹 Subtask 2.1: Prepare the NFS Client

## 🛠️ Tool: Switch to Root User

```bash
sudo su -
```

---

## 🛠️ Tool: Install Client Utilities

```bash
dnf install -y nfs-utils
```

---

## 🛠️ Tool: Start RPC Service

```bash
systemctl start rpcbind
systemctl enable rpcbind
systemctl status rpcbind
```

---

# 🔹 Subtask 2.2: Discover Available NFS Shares

## 🛠️ Tool: Find Server IP Address

```bash
SERVER_IP=$(hostname -I | awk '{print $1}' | sed 's/\.[0-9]*$/.1/')
echo "Server IP: $SERVER_IP"
```

---

## 🛠️ Tool: Show Available Exports

```bash
showmount -e $SERVER_IP
```

---

## 🛠️ Tool: Test Connectivity

```bash
rpcinfo -p $SERVER_IP
```

---

# 🔹 Subtask 2.3: Create Mount Points

## 🛠️ Tool: Create Mount Directories

```bash
mkdir -p /mnt/nfs-shared
mkdir -p /mnt/nfs-public
mkdir -p /mnt/nfs-private
```

---

## 🛠️ Tool: Configure Permissions

```bash
chmod 755 /mnt/nfs-shared
chmod 755 /mnt/nfs-public
chmod 755 /mnt/nfs-private
```

---

# 🔹 Subtask 2.4: Mount NFS Shares Manually

## 🛠️ Tool: Mount Shared Directory

```bash
mount -t nfs $SERVER_IP:/nfs/shared /mnt/nfs-shared
```

---

## 🛠️ Tool: Mount Public Directory

```bash
mount -t nfs $SERVER_IP:/nfs/public /mnt/nfs-public
```

---

## 🛠️ Tool: Mount Private Directory

```bash
mount -t nfs $SERVER_IP:/nfs/private /mnt/nfs-private
```

---

## 🛠️ Tool: Verify Mounted Shares

```bash
df -h | grep nfs
mount | grep nfs
```

---

## 🛠️ Tool: Test Mounted Shares

```bash
# Shared directory
ls -la /mnt/nfs-shared/
cat /mnt/nfs-shared/shared_file.txt

# Public directory
ls -la /mnt/nfs-public/
cat /mnt/nfs-public/public_file.txt

# Private directory
ls -la /mnt/nfs-private/
cat /mnt/nfs-private/private_file.txt
```

---

# 🔹 Subtask 2.5: Configure Persistent Mounts

## 🛠️ Tool: Backup fstab File

```bash
cp /etc/fstab /etc/fstab.backup
```

---

## 🛠️ Tool: Edit fstab Configuration

```bash
vi /etc/fstab
```

---

## 🛠️ Tool: Add NFS Mount Entries

```bash
# NFS Mounts
192.168.1.100:/nfs/shared    /mnt/nfs-shared    nfs    defaults,_netdev    0 0
192.168.1.100:/nfs/public    /mnt/nfs-public    nfs    defaults,_netdev,ro    0 0
192.168.1.100:/nfs/private   /mnt/nfs-private   nfs    defaults,_netdev    0 0
```

> ⚠️ Replace `192.168.1.100` with your actual NFS server IP address.

---

# 📖 fstab Options Explained

| ⚙️ Option | 📘 Description |
|---|---|
| `defaults` | Default mount settings |
| `_netdev` | Wait for network availability |
| `ro` | Read-only mount |
| `0 0` | Disable dump and fsck |

---

## 🛠️ Tool: Test fstab Configuration

```bash
umount /mnt/nfs-shared
umount /mnt/nfs-public
umount /mnt/nfs-private

mount -a

df -h | grep nfs
```

---

# 🚀 Task 3: Configure Firewall Rules

---

# 🔹 Subtask 3.1: Configure Firewall on NFS Server

## 🛠️ Tool: Check Firewall Status

```bash
firewall-cmd --state
firewall-cmd --list-all
```

---

## 🛠️ Tool: Allow NFS Services

```bash
firewall-cmd --permanent --add-service=nfs
firewall-cmd --permanent --add-service=rpc-bind
firewall-cmd --permanent --add-service=mountd
```

---

## 🛠️ Tool: Open Required Ports

```bash
# NFS daemon
firewall-cmd --permanent --add-port=2049/tcp
firewall-cmd --permanent --add-port=2049/udp

# RPC portmapper
firewall-cmd --permanent --add-port=111/tcp
firewall-cmd --permanent --add-port=111/udp

# Mount daemon
firewall-cmd --permanent --add-port=20048/tcp
firewall-cmd --permanent --add-port=20048/udp
```

---

## 🛠️ Tool: Reload Firewall Configuration

```bash
firewall-cmd --reload
```

---

## 🛠️ Tool: Verify Firewall Rules

```bash
firewall-cmd --list-services
firewall-cmd --list-ports
```

---

# 🚀 Task 4: Troubleshooting NFS Issues

---

# 🔹 Common Troubleshooting Commands

## 🛠️ Tool: Verify Exported Shares

```bash
exportfs -v
```

---

## 🛠️ Tool: Verify NFS Services

```bash
systemctl status nfs-server
systemctl status rpcbind
```

---

## 🛠️ Tool: Check RPC Services

```bash
rpcinfo -p
```

---

## 🛠️ Tool: Test NFS Connectivity

```bash
showmount -e SERVER_IP
```

---

## 🛠️ Tool: Verify Mounted Shares

```bash
mount | grep nfs
```

---

## 🛠️ Tool: View System Logs

```bash
journalctl -xe
```

---

# 🚀 Task 5: Secure NFS Deployment

---

# 🔹 Security Best Practices

| 🔒 Security Practice | 📘 Description |
|---|---|
| Restrict Access | Allow only trusted IP addresses |
| Use `root_squash` | Prevent remote root privileges |
| Read-Only Exports | Use `ro` when possible |
| Configure Firewall | Allow only required ports |
| Monitor Logs | Detect suspicious activity |

---

# 🧪 Verification Checklist

| ✅ Verification Task | 📋 Status |
|---|---|
| NFS packages installed | ⬜ |
| Shared directories created | ⬜ |
| Exports configured | ⬜ |
| Services started successfully | ⬜ |
| Firewall configured | ⬜ |
| Client mounts successful | ⬜ |
| Persistent mounts working | ⬜ |
| Security settings applied | ⬜ |

---

# 📚 Useful NFS Commands Reference

| 💻 Command | 📘 Description |
|---|---|
| `exportfs -v` | View exported shares |
| `showmount -e SERVER_IP` | Show remote exports |
| `rpcinfo -p` | Display RPC services |
| `mount -t nfs` | Mount NFS share |
| `umount` | Unmount NFS share |
| `systemctl status nfs-server` | Check NFS server status |
| `firewall-cmd --list-all` | View firewall configuration |

---

# 🏁 Conclusion

In this lab, you successfully learned how to:

- ✅ Configure an NFS server
- ✅ Export shared directories
- ✅ Mount NFS shares on clients
- ✅ Configure persistent mounts
- ✅ Secure NFS using firewalld
- ✅ Troubleshoot common NFS issues
- ✅ Apply security best practices

