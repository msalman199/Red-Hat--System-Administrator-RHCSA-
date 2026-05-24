# 🗂️ Managing Logical Volumes (LVM)

## 🎯 Objectives

By the end of this lab, you will be able to:

- Understand the fundamental concepts of Logical Volume Management (LVM)
- Create and configure physical volumes using `pvcreate`
- Create and manage volume groups using `vgcreate`
- Create logical volumes using `lvcreate`
- Extend logical volumes dynamically using `lvextend`
- Format and mount LVM-based filesystems
- Monitor and display LVM information using various commands

---

# 📋 Prerequisites

Before starting this lab, you should have:

- Basic understanding of Linux command line interface
- Knowledge of disk partitioning concepts
- Familiarity with filesystem operations (`mount`, `umount`, `mkfs`)
- Understanding of storage devices and block devices in Linux
- Basic knowledge of file permissions and directory structure

---

# 🖥️ Lab Environment Setup

## ✅ Environment Includes

- CentOS/RHEL 8 or 9 system with root access
- Multiple unused disk devices for LVM practice
- All necessary LVM tools pre-installed

---

# 📚 Understanding LVM Concepts

Logical Volume Management (LVM) provides flexible storage management by creating an abstraction layer between physical disks and filesystems.

## 🔑 Key Components

| Component | Description |
|---|---|
| Physical Volume (PV) | Raw storage devices prepared for LVM |
| Volume Group (VG) | Storage pool made from one or more PVs |
| Logical Volume (LV) | Virtual partitions created from VG |
| Physical Extent (PE) | Smallest storage unit in LVM |

---

# 🛠️ Task 1: Creating Physical Volumes

## 🔧 Subtask 1.1: Identify Available Storage Devices

### 🧰 Commands

```bash
# List all block devices
lsblk

# Display detailed disk information
fdisk -l

# Show existing physical volumes
pvs
```

---

## 🔧 Subtask 1.2: Prepare Disks for LVM

### 🧰 Commands

```bash
# Check mounted devices
mount | grep -E "(sdb|sdc|sdd)"

# Verify disk information
lsblk /dev/sdb /dev/sdc /dev/sdd
```

---

## 🔧 Subtask 1.3: Create Physical Volumes

### 🧰 Commands

```bash
# Create physical volumes
pvcreate /dev/sdb
pvcreate /dev/sdc
pvcreate /dev/sdd

# Alternative single command
# pvcreate /dev/sdb /dev/sdc /dev/sdd
```

---

## 🔧 Subtask 1.4: Verify Physical Volumes

### 🧰 Commands

```bash
# Display physical volumes
pvs

# Detailed PV information
pvdisplay

# Specific PV details
pvdisplay /dev/sdb
```

### ✅ Expected Output

```bash
PV         VG Fmt  Attr PSize  PFree
/dev/sdb      lvm2 ---  20.00g 20.00g
/dev/sdc      lvm2 ---  20.00g 20.00g
/dev/sdd      lvm2 ---  20.00g 20.00g
```

---

# 🛠️ Task 2: Creating Volume Groups

## 🔧 Subtask 2.1: Create Your First Volume Group

### 🧰 Commands

```bash
# Create volume group
vgcreate vg_data /dev/sdb /dev/sdc

# Verify VG creation
vgs

# Detailed VG information
vgdisplay vg_data
```

---

## 🔧 Subtask 2.2: Create Additional Volume Group

### 🧰 Commands

```bash
# Create another VG
vgcreate vg_backup /dev/sdd

# Display all VGs
vgs
```

---

## 🔧 Subtask 2.3: Extend Volume Group

### 🧰 Commands

```bash
# Optional partition creation
fdisk /dev/sdb

# Remove PV from old VG
vgreduce vg_backup /dev/sdd

# Extend VG
vgextend vg_data /dev/sdd

# Verify extension
vgs
vgdisplay vg_data
```

---

# 🛠️ Task 3: Creating and Managing Logical Volumes

## 🔧 Subtask 3.1: Create Logical Volumes

### 🧰 Commands

```bash
# Create 10GB LV
lvcreate -L 10G -n lv_web vg_data

# Create 5GB LV
lvcreate -L 5G -n lv_database vg_data

# Create LV using percentage
lvcreate -l 50%VG -n lv_logs vg_data

# Show LVs
lvs

# Detailed LV information
lvdisplay
```

---

## 🔧 Subtask 3.2: Format and Mount Logical Volumes

### 🧰 Commands

```bash
# Create filesystems
mkfs.ext4 /dev/vg_data/lv_web
mkfs.xfs /dev/vg_data/lv_database
mkfs.ext4 /dev/vg_data/lv_logs

# Create mount directories
mkdir -p /mnt/web
mkdir -p /mnt/database
mkdir -p /mnt/logs

# Mount logical volumes
mount /dev/vg_data/lv_web /mnt/web
mount /dev/vg_data/lv_database /mnt/database
mount /dev/vg_data/lv_logs /mnt/logs

# Verify mounts
df -h
mount | grep vg_data
```

---

## 🔧 Subtask 3.3: Test Logical Volumes

### 🧰 Commands

```bash
# Create test files
echo "Web server data" > /mnt/web/index.html
echo "Database content" > /mnt/database/data.sql
echo "Application logs" > /mnt/logs/app.log

# Verify files
ls -la /mnt/web/
ls -la /mnt/database/
ls -la /mnt/logs/

# Check disk usage
du -sh /mnt/web /mnt/database /mnt/logs
```

---

# 🛠️ Task 4: Extending Logical Volumes

## 🔧 Subtask 4.1: Extend Logical Volume

### 🧰 Commands

```bash
# Current LV sizes
lvs

# Available VG space
vgs

# Extend LV by 5GB
lvextend -L +5G /dev/vg_data/lv_web

# Verify extension
lvs
```

---

## 🔧 Subtask 4.2: Resize Filesystem

### 🧰 Commands

```bash
# Resize ext4 filesystem
resize2fs /dev/vg_data/lv_web

# Extend XFS LV
lvextend -L +3G /dev/vg_data/lv_database

# Grow XFS filesystem
xfs_growfs /mnt/database

# Verify size
df -h /mnt/web /mnt/database
```

---

## 🔧 Subtask 4.3: One-Step Extension

### 🧰 Commands

```bash
# Extend LV and filesystem together
lvextend -L +2G -r /dev/vg_data/lv_logs

# Verify changes
df -h /mnt/logs
lvs
```

---

# 🛠️ Task 5: Monitoring and Information Commands

## 🔧 Subtask 5.1: Comprehensive Status Check

### 🧰 Commands

```bash
# Show all LVM information
pvs && echo "---" && vgs && echo "---" && lvs

# Detailed information
echo "=== Physical Volumes ==="
pvdisplay

echo "=== Volume Groups ==="
vgdisplay

echo "=== Logical Volumes ==="
lvdisplay
```

---

## 🔧 Subtask 5.2: Advanced Monitoring

### 🧰 Commands

```bash
# Scan LVM components
pvscan
vgscan
lvscan

# LV attributes
lvs -o +lv_layout,lv_role

# VG extent details
vgs -o +vg_extent_size,vg_extent_count,vg_free_count

# PV allocation details
pvs -o +pv_used,pv_free
```

---

# 🛠️ Task 6: Creating Persistent Mounts

## 🔧 Subtask 6.1: Configure Automatic Mounting

### 🧰 Commands

```bash
# Backup fstab
cp /etc/fstab /etc/fstab.backup

# Add entries to fstab
echo "/dev/vg_data/lv_web     /mnt/web      ext4    defaults    0 2" >> /etc/fstab

echo "/dev/vg_data/lv_database /mnt/database xfs     defaults    0 2" >> /etc/fstab

echo "/dev/vg_data/lv_logs    /mnt/logs     ext4    defaults    0 2" >> /etc/fstab

# Verify entries
tail -3 /etc/fstab

# Test configuration
umount /mnt/web /mnt/database /mnt/logs
mount -a

# Verify mounts
df -h | grep vg_data
```

---

# ⭐ Task 7: LVM Snapshots (Bonus)

## 🔧 Subtask 7.1: Create Snapshots

### 🧰 Commands

```bash
# Create snapshot for lv_web
lvcreate -L 1G -s -n lv_web_snapshot /dev/vg_data/lv_web

# Create snapshot for lv_database
lvcreate -L 1G -s -n lv_database_snapshot /dev/vg_data/lv_database

# Display snapshots
lvs -o +origin,snap_percent

# Mount snapshot
mkdir /mnt/web_snapshot
mount /dev/vg_data/lv_web_snapshot /mnt/web_snapshot

# Verify content
ls -la /mnt/web_snapshot/
```

---

## 🔧 Subtask 7.2: Test Snapshots

### 🧰 Commands

```bash
# Modify original data
echo "Modified web content" >> /mnt/web/index.html

# Compare files
cat /mnt/web/index.html
cat /mnt/web_snapshot/index.html

# Cleanup snapshots
umount /mnt/web_snapshot

lvremove /dev/vg_data/lv_web_snapshot
lvremove /dev/vg_data/lv_database_snapshot
```

---

# 🚨 Troubleshooting Common Issues

## ❌ Issue 1: Device Busy Error

### 🧰 Commands

```bash
# Check processes using device
lsof /dev/sdb
fuser -v /dev/sdb

# Unmount filesystem
umount /dev/sdb1

# Kill processes
fuser -k /dev/sdb
```

---

## ❌ Issue 2: Insufficient Space

### 🧰 Commands

```bash
# Check VG space
vgdisplay vg_data | grep -E "(VG Size|Free)"

# Add new PV
pvcreate /dev/sde
vgextend vg_data /dev/sde
```

---

## ❌ Issue 3: LVM Commands Not Found

### 🧰 Commands

```bash
# Install LVM tools
yum install lvm2 -y

# OR
dnf install lvm2 -y

# Start services
systemctl start lvm2-monitor
systemctl enable lvm2-monitor
```

---

# ✅ Lab Verification Checklist

- [ ] Created at least 3 physical volumes
- [ ] Created one or more volume groups
- [ ] Created multiple logical volumes
- [ ] Extended at least one logical volume
- [ ] Formatted logical volumes with ext4 and xfs
- [ ] Mounted logical volumes successfully
- [ ] Extended both LV and filesystem
- [ ] Added persistent mounts in `/etc/fstab`
- [ ] Used monitoring commands (`pvs`, `vgs`, `lvs`)

---

# 🧹 Cleanup Instructions

## 🧰 Commands

```bash
# Unmount filesystems
umount /mnt/web /mnt/database /mnt/logs

# Edit fstab manually
vi /etc/fstab

# Remove logical volumes
lvremove /dev/vg_data/lv_web
lvremove /dev/vg_data/lv_database
lvremove /dev/vg_data/lv_logs

# Remove volume groups
vgremove vg_data

# Remove physical volumes
pvremove /dev/sdb /dev/sdc /dev/sdd
```

---

# 🎉 Conclusion

Congratulations! You have successfully completed the **Managing Logical Volumes (LVM)** lab.

## 🚀 Skills Acquired

- Created and managed Physical Volumes (PV)
- Built and extended Volume Groups (VG)
- Created and resized Logical Volumes (LV)
- Mounted and persisted LVM filesystems
- Used snapshots for backup operations
- Monitored LVM storage infrastructure

---

# 🌍 Real-World Importance of LVM

## ✅ Benefits

| Feature | Benefit |
|---|---|
| Flexibility | Resize storage without repartitioning |
| Scalability | Add disks dynamically |
| Reliability | Create snapshots for backup |
| Efficiency | Better storage utilization |

---

# 💼 Real-World Applications

- Database servers
- Enterprise storage systems
- Web hosting infrastructure
- Cloud storage environments

---

# 📘 RHCSA Exam Relevance

This lab directly supports RHCSA exam objectives related to:

- Storage management
- LVM configuration
- Persistent mounts
- Filesystem management
- Storage troubleshooting

---

# 🏁 Final Note

You now have practical hands-on experience with Linux Logical Volume Management and are ready to manage dynamic storage environments in real-world Linux systems.

```
