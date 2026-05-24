# 💽 Working with Disk Partitions

## 📌 Objectives

By the end of this lab, you will be able to:

- Understand disk partitioning concepts and terminology
- Use `fdisk` to create, modify, and delete disk partitions
- Format partitions using `mkfs` command with different file system types
- Mount and unmount file systems using `mount` and `umount`
- Configure persistent mounts using `/etc/fstab`
- Verify disk usage and partition information using system utilities

---

# 📋 Prerequisites

Before starting this lab, you should have:

- Basic understanding of Linux command line interface
- Familiarity with Linux file system hierarchy
- Knowledge of basic Linux commands (`ls`, `cd`, `cat`, etc.)
- Understanding of file permissions and ownership
- Access to a Linux system with root or sudo privileges

---

# ☁️ Lab Environment Setup

This lab environment includes:

- CentOS/RHEL-based Linux distribution
- Root access
- Disk management utilities
- Additional virtual disk for practice

---

# 🧩 Task 1: Understanding Disk Structure and Partitioning with fdisk

## 🔧 Subtask 1.1: Examine Current Disk Configuration

### 🛠️ Tool: `lsblk`

```bash
lsblk
```

### 🛠️ Tool: `fdisk`

```bash
fdisk -l
```

### 🛠️ Tool: `df`

```bash
df -h
```

### 📖 Expected Output Analysis

- `lsblk` shows block devices
- `fdisk -l` displays partition tables
- `df -h` shows mounted file systems

---

## 🔧 Subtask 1.2: Identify the Practice Disk

### 🛠️ Tool: `ls`

```bash
ls -la /dev/sd* /dev/xvd* 2>/dev/null
```

### 🛠️ Tool: `fdisk`

```bash
fdisk -l /dev/sdb
```

> ⚠️ Always verify the correct disk before making changes.

---

## 🔧 Subtask 1.3: Create Partitions Using fdisk

### 🛠️ Tool: `fdisk`

```bash
sudo fdisk /dev/sdb
```

Inside fdisk:

```bash
p
```

Create first partition:

```bash
n
p
1
```

Press Enter for default start sector.

```bash
+2G
```

Create second partition:

```bash
n
p
2
```

Press Enter for default start sector.

```bash
+1G
```

Display partition table:

```bash
p
```

Save changes:

```bash
w
```

Verify partitions:

### 🛠️ Tool: `lsblk`

```bash
lsblk /dev/sdb
```

### 🛠️ Tool: `fdisk`

```bash
fdisk -l /dev/sdb
```

---

## 🔧 Subtask 1.4: Understanding Partition Types

### 🛠️ Tool: `fdisk`

```bash
sudo fdisk /dev/sdb
```

Inside fdisk:

```bash
n
e
3
```

Press Enter for defaults.

Create logical partition:

```bash
n
l
```

```bash
+500M
```

Save changes:

```bash
w
```

---

# 🧩 Task 2: Formatting Partitions with mkfs

## 🔧 Subtask 2.1: Understanding File System Types

### 🛠️ Tool: `mkfs`

```bash
ls /sbin/mkfs*
```

### 🛠️ Tool: `cat`

```bash
cat /proc/filesystems
```

---

## 🔧 Subtask 2.2: Format Partitions

### 🛠️ Tool: `mkfs.ext4`

```bash
sudo mkfs.ext4 /dev/sdb1
```

### 🛠️ Tool: `mkfs.xfs`

```bash
sudo mkfs.xfs /dev/sdb2
```

### 🛠️ Tool: `mkfs.ext3`

```bash
sudo mkfs.ext3 /dev/sdb5
```

### 🛠️ Tool: `blkid`

```bash
sudo blkid /dev/sdb1 /dev/sdb2 /dev/sdb5
```

---

## 🔧 Subtask 2.3: Add Labels to File Systems

### 🛠️ Tool: `e2label`

```bash
sudo e2label /dev/sdb1 "DATA_EXT4"
```

### 🛠️ Tool: `xfs_admin`

```bash
sudo xfs_admin -L "DATA_XFS" /dev/sdb2
```

### 🛠️ Tool: `blkid`

```bash
sudo blkid | grep sdb
```

---

# 🧩 Task 3: Mounting and Unmounting File Systems

## 🔧 Subtask 3.1: Create Mount Points

### 🛠️ Tool: `mkdir`

```bash
sudo mkdir -p /mnt/data1
sudo mkdir -p /mnt/data2
sudo mkdir -p /mnt/data3
```

### 🛠️ Tool: `ls`

```bash
ls -la /mnt/
```

---

## 🔧 Subtask 3.2: Manual Mounting

### 🛠️ Tool: `mount`

```bash
sudo mount /dev/sdb1 /mnt/data1
sudo mount /dev/sdb2 /mnt/data2
sudo mount /dev/sdb5 /mnt/data3
```

### 🛠️ Tool: `mount`

```bash
mount | grep sdb
```

### 🛠️ Tool: `df`

```bash
df -h | grep sdb
```

---

## 🔧 Subtask 3.3: Testing Mounted File Systems

### 🛠️ Tool: `touch`

```bash
sudo touch /mnt/data1/test_ext4.txt
sudo touch /mnt/data2/test_xfs.txt
sudo touch /mnt/data3/test_ext3.txt
```

### 🛠️ Tool: `tee`

```bash
echo "This is an ext4 file system" | sudo tee /mnt/data1/test_ext4.txt

echo "This is an xfs file system" | sudo tee /mnt/data2/test_xfs.txt

echo "This is an ext3 file system" | sudo tee /mnt/data3/test_ext3.txt
```

### 🛠️ Tool: `ls`

```bash
ls -la /mnt/data1/
ls -la /mnt/data2/
ls -la /mnt/data3/
```

### 🛠️ Tool: `df`

```bash
df -h /mnt/data1 /mnt/data2 /mnt/data3
```

---

## 🔧 Subtask 3.4: Unmounting File Systems

### 🛠️ Tool: `umount`

```bash
sudo umount /mnt/data1
sudo umount /mnt/data2
sudo umount /mnt/data3
```

### 🛠️ Tool: `mount`

```bash
mount | grep sdb
```

### 🛠️ Tool: `df`

```bash
df -h | grep sdb
```

---

## 🔧 Subtask 3.5: Mounting by Label and UUID

### 🛠️ Tool: `mount`

```bash
sudo mount LABEL="DATA_EXT4" /mnt/data1
```

### 🛠️ Tool: `blkid`

```bash
sudo blkid /dev/sdb2
```

### 🛠️ Tool: `mount`

```bash
sudo mount UUID="your-actual-uuid-here" /mnt/data2
```

### 🛠️ Tool: `mount`

```bash
mount | grep -E "(data1|data2)"
```

---

# 🧩 Task 4: Configuring Persistent Mounts

## 🔧 Subtask 4.1: Understanding /etc/fstab

### 🛠️ Tool: `cat`

```bash
cat /etc/fstab
```

### 🛠️ Tool: `cp`

```bash
sudo cp /etc/fstab /etc/fstab.backup
```

---

## 🔧 Subtask 4.2: Adding Entries to /etc/fstab

### 🛠️ Tool: `blkid`

```bash
sudo blkid /dev/sdb1 /dev/sdb2 /dev/sdb5
```

### 🛠️ Tool: `tee`

```bash
echo "UUID=your-sdb1-uuid /mnt/data1 ext4 defaults 0 2" | sudo tee -a /etc/fstab

echo "UUID=your-sdb2-uuid /mnt/data2 xfs defaults 0 2" | sudo tee -a /etc/fstab

echo "UUID=your-sdb5-uuid /mnt/data3 ext3 defaults 0 2" | sudo tee -a /etc/fstab
```

### 🛠️ Tool: `tail`

```bash
tail -3 /etc/fstab
```

---

## 🔧 Subtask 4.3: Testing fstab Configuration

### 🛠️ Tool: `umount`

```bash
sudo umount /mnt/data1 /mnt/data2 2>/dev/null
```

### 🛠️ Tool: `mount`

```bash
sudo mount -a
```

### 🛠️ Tool: `mount`

```bash
mount | grep sdb
```

### 🛠️ Tool: `df`

```bash
df -h | grep sdb
```

---

# 🧰 Advanced Operations and Troubleshooting

## 🔧 Device Busy Error

### 🛠️ Tool: `lsof`

```bash
sudo lsof /mnt/data1
```

### 🛠️ Tool: `fuser`

```bash
sudo fuser -v /mnt/data1
```

### 🛠️ Tool: `umount`

```bash
sudo umount -f /mnt/data1
```

---

## 🔧 File System Repair

### 🛠️ Tool: `fsck.ext4`

```bash
sudo fsck.ext4 /dev/sdb1
```

### 🛠️ Tool: `xfs_repair`

```bash
sudo xfs_repair /dev/sdb2
```

---

## 🔧 View Detailed Partition Information

### 🛠️ Tool: `parted`

```bash
sudo parted /dev/sdb print
```

---

# 📊 Performance and Monitoring

### 🛠️ Tool: `iostat`

```bash
iostat -x 1 5
```

### 🛠️ Tool: `tune2fs`

```bash
sudo tune2fs -l /dev/sdb1
```

### 🛠️ Tool: `xfs_info`

```bash
sudo xfs_info /mnt/data2
```

---

# 🧹 Lab Cleanup

### 🛠️ Tool: `umount`

```bash
sudo umount /mnt/data1 /mnt/data2 /mnt/data3 2>/dev/null
```

### 🛠️ Tool: `cp`

```bash
sudo cp /etc/fstab.backup /etc/fstab
```

### 🛠️ Tool: `rmdir`

```bash
sudo rmdir /mnt/data1 /mnt/data2 /mnt/data3
```

---

# 🎉 Conclusion

Congratulations! You successfully completed the **Working with Disk Partitions** lab.

## ✅ Skills Learned

- Disk management and storage analysis
- Creating and managing partitions
- Formatting partitions with different file systems
- Mounting and unmounting storage
- Configuring persistent mounts
- Troubleshooting storage issues

## 🌍 Real-World Applications

These skills are useful for:

- Linux server administration
- Storage management
- System maintenance
- Disaster recovery
- Performance optimization

## 🏆 RHCSA Exam Relevance

This lab helps prepare for RHCSA objectives:

- Configure local storage
- Create and manage file systems
- Mount and unmount file systems
- Configure persistent storage

## 🚀 Next Steps

- Logical Volume Management (LVM)
- RAID configuration
- NFS and CIFS
- Storage encryption
- Advanced Linux storage management.
