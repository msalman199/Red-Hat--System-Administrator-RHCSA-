# 🔧 Archiving and Compressing Files 

## 🎯 Objectives

By the end of this lab, you will be able to:

- Create and extract archives using the `tar` command
- Compress and decompress files using `gzip`
- Compress and decompress files using `bzip2`
- Combine tar with compression tools
- Verify archive integrity
- Restore archived data successfully

---

# 📋 Prerequisites

Before starting this lab, you should have:

- Basic Linux command-line knowledge
- Understanding of files and directories
- Familiarity with Linux permissions
- Access to a Linux terminal

---

# ☁️ Ready-to-Use Cloud Machines

Al Nafi provides pre-configured Linux cloud machines for this lab.

Click **Start Lab** and begin practicing immediately.

---

# 🛠️ Lab Environment Setup

## 🔧 Step 1: Verify Environment

```bash
# Check current directory
pwd

# Verify required tools
which tar gzip bzip2

# Create working directory
mkdir ~/lab14-archive

# Move into directory
cd ~/lab14-archive
```

---

# 📦 Task 1: Create Archives with tar

The `tar` command is used to archive multiple files and directories into a single file.

---

## 🔧 Subtask 1.1: Create Sample Files and Directories

```bash
# Create directories
mkdir -p documents/reports documents/presentations data/logs data/backups

# Create sample documents
echo "This is a sample document about Linux administration." > documents/linux_guide.txt

echo "Network configuration best practices." > documents/network_config.txt

echo "Security policies and procedures." > documents/security_policy.txt

# Create report files
echo "Monthly server performance report." > documents/reports/monthly_report.txt

echo "Quarterly system analysis." > documents/reports/quarterly_analysis.txt

# Create presentation files
echo "Linux fundamentals presentation slides." > documents/presentations/linux_basics.txt

echo "System administration workshop materials." > documents/presentations/sysadmin_workshop.txt

# Create log files
echo "System log entries from $(date)" > data/logs/system.log

echo "Application log entries from $(date)" > data/logs/application.log

# Create backup files
echo "Database backup metadata" > data/backups/db_backup.txt

echo "Configuration backup information" > data/backups/config_backup.txt

# Verify structure
tree . || find . -type f
```

---

## 🔧 Subtask 1.2: Create Basic tar Archives

```bash
# Create archive
tar -cf documents_archive.tar documents/

# Verify archive
ls -lh documents_archive.tar

# List archive contents
tar -tf documents_archive.tar

# Create archive with verbose output
tar -cvf data_archive.tar data/

# Archive selected files
tar -cf selected_files.tar \
documents/linux_guide.txt \
documents/network_config.txt \
data/logs/system.log
```

---

## 🔧 Subtask 1.3: Extract tar Archives

```bash
# Create extraction directory
mkdir extraction_test

# Enter directory
cd extraction_test

# Extract archive
tar -xf ../documents_archive.tar

# Verify extraction
ls -la

# Display structure
tree documents/ || find documents/ -type f

# Return
cd ..

# Create another extraction directory
mkdir verbose_extraction

cd verbose_extraction

# Extract with verbose output
tar -xvf ../data_archive.tar

# Return
cd ..
```

---

## 🔧 Subtask 1.4: Advanced tar Operations

```bash
# Preserve permissions
tar -cpf permissions_archive.tar documents/

# Exclude log files
tar -cf filtered_archive.tar --exclude="*.log" data/

# Archive using absolute paths
tar -cf absolute_archive.tar -P /home/$(whoami)/lab14-archive/documents/

# Create new file
echo "Additional content for archive" > new_file.txt

# Append file to archive
tar -rf documents_archive.tar new_file.txt

# Verify appended file
tar -tf documents_archive.tar | grep new_file.txt
```

---

# 🗜️ Task 2: Compress and Decompress Files

Compression reduces storage requirements and improves transfer efficiency.

---

## 🔧 Subtask 2.1: Using gzip Compression

```bash
# Create large file
dd if=/dev/zero of=large_file.txt bs=1M count=10

# Add sample text
echo "This file contains sample data for compression testing." >> large_file.txt

# Check original size
ls -lh large_file.txt

# Compress file
gzip large_file.txt

# Check compressed size
ls -lh large_file.txt.gz

# Decompress file
gunzip large_file.txt.gz

# Compress while keeping original
gzip -c large_file.txt > large_file_copy.txt.gz

# View files
ls -lh large_file*

# Fast compression
gzip -1 -c large_file.txt > large_file_fast.txt.gz

# Best compression
gzip -9 -c large_file.txt > large_file_best.txt.gz

# Compare sizes
ls -lh large_file*.gz
```

---

## 🔧 Subtask 2.2: Using bzip2 Compression

```bash
# Compress using bzip2
bzip2 -c large_file.txt > large_file.txt.bz2

# View compressed file
ls -lh large_file.txt.bz2

# Decompress file
bunzip2 -c large_file.txt.bz2 > large_file_restored.txt

# Verify integrity
diff large_file.txt large_file_restored.txt

# Compression comparison
echo "Compression Comparison:"

echo "Original file: $(ls -lh large_file.txt | awk '{print $5}')"

echo "gzip compressed: $(ls -lh large_file_copy.txt.gz | awk '{print $5}')"

echo "bzip2 compressed: $(ls -lh large_file.txt.bz2 | awk '{print $5}')"
```

---

## 🔧 Subtask 2.3: Combine tar with Compression

```bash
# Create gzip compressed archive
tar -czf documents_compressed.tar.gz documents/

# Create bzip2 compressed archive
tar -cjf documents_compressed.tar.bz2 documents/

# Compare archive sizes
ls -lh documents_archive.tar \
documents_compressed.tar.gz \
documents_compressed.tar.bz2

# Create extraction directories
mkdir gzip_extraction bzip2_extraction

# Extract gzip archive
tar -xzf documents_compressed.tar.gz -C gzip_extraction/

# Extract bzip2 archive
tar -xjf documents_compressed.tar.bz2 -C bzip2_extraction/

# Verify extraction
ls -la gzip_extraction/

ls -la bzip2_extraction/
```

---

## 🔧 Subtask 2.4: Compress Multiple Files

```bash
# Create sample files
for i in {1..5}; do
    echo "Sample content for file $i - $(date)" > sample_file_$i.txt
done

# Compress files
gzip sample_file_*.txt

# View compressed files
ls -lh sample_file_*.gz

# Decompress files
gunzip sample_file_*.gz

# Create compressed archive
tar -czf sample_files.tar.gz sample_file_*.txt

# Remove originals
rm sample_file_*.txt

# Restore files
tar -xzf sample_files.tar.gz

# Verify restoration
ls -la sample_file_*.txt
```

---

# 🔄 Task 3: Test Restoration of Archived Data

Testing archive integrity ensures reliable backups and successful recovery.

---

## 🔧 Subtask 3.1: Create Test Archives

```bash
# Move to lab directory
cd ~/lab14-archive

# Generate checksums
find . -type f -exec md5sum {} \; > original_checksums.txt

# Create archives
tar -czf complete_backup.tar.gz documents/ data/ sample_file_*.txt

tar -cjf complete_backup.tar.bz2 documents/ data/ sample_file_*.txt

# Create verified archive
tar -czf verified_backup.tar.gz --verify documents/ data/
```

---

## 🔧 Subtask 3.2: Test Archive Integrity

```bash
# Test gzip archive
gzip -t complete_backup.tar.gz

echo "Gzip archive test result: $?"

# Test bzip2 archive
bzip2 -t complete_backup.tar.bz2

echo "Bzip2 archive test result: $?"

# Test tar gzip archive
tar -tzf complete_backup.tar.gz > /dev/null

echo "Tar gzip archive test result: $?"

# Test tar bzip2 archive
tar -tjf complete_backup.tar.bz2 > /dev/null

echo "Tar bzip2 archive test result: $?"
```

---

## 🔧 Subtask 3.3: Full Restoration Test

```bash
# Create restoration directory
mkdir ~/restoration_test

# Enter directory
cd ~/restoration_test

# Copy archives
cp ~/lab14-archive/complete_backup.tar.gz .

cp ~/lab14-archive/complete_backup.tar.bz2 .

cp ~/lab14-archive/original_checksums.txt .

# Create restore directories
mkdir gzip_restore bzip2_restore

# Restore gzip archive
tar -xzf complete_backup.tar.gz -C gzip_restore/

# Restore bzip2 archive
tar -xjf complete_backup.tar.bz2 -C bzip2_restore/

# Verify restored files
cd gzip_restore

find . -type f -exec md5sum {} \; > restored_checksums.txt

# Compare checksums
diff ../original_checksums.txt restored_checksums.txt
```

---

## 🔧 Subtask 3.4: Selective Restoration

```bash
# Return
cd ~/restoration_test

# Create selective restore directory
mkdir selective_restore

# Restore specific file
tar -xzf complete_backup.tar.gz \
-C selective_restore/ \
documents/linux_guide.txt

# Restore logs directory
tar -xzf complete_backup.tar.gz \
-C selective_restore/ \
data/logs/

# Verify restored files
find selective_restore/ -type f
```

---

## 🔧 Subtask 3.5: Archive Verification Script

```bash
# Create verification script
cat > verify_archive.sh << 'EOF'
#!/bin/bash

ARCHIVE_FILE="$1"

if [ -z "$ARCHIVE_FILE" ]; then
    echo "Usage: $0 <archive_file>"
    exit 1
fi

if [[ "$ARCHIVE_FILE" == *.tar.gz ]]; then
    tar -tzf "$ARCHIVE_FILE" > /dev/null

elif [[ "$ARCHIVE_FILE" == *.tar.bz2 ]]; then
    tar -tjf "$ARCHIVE_FILE" > /dev/null
fi
EOF

# Make executable
chmod +x verify_archive.sh

# Run script
./verify_archive.sh complete_backup.tar.gz

./verify_archive.sh complete_backup.tar.bz2
```

---

# ⚠️ Troubleshooting Common Issues

---

## 🔧 Permission Errors

```bash
# Extract archive
tar -xzf archive.tar.gz

# Fix ownership
sudo chown -R $(whoami):$(whoami) extracted_directory/
```

---

## 🔧 Archive Corruption

```bash
# Verify gzip archive
tar -tzf archive.tar.gz > /dev/null \
&& echo "Archive OK" \
|| echo "Archive corrupted"

# Verify bzip2 archive
tar -tjf archive.tar.bz2 > /dev/null \
&& echo "Archive OK" \
|| echo "Archive corrupted"
```

---

## 🔧 Disk Space Issues

```bash
# Check disk space
df -h .

# Check archive size
du -sh archive_name.tar.gz
```

---

# 📚 Key Commands Summary

## 🔧 tar Commands

```bash
tar -cf archive.tar files/
tar -xf archive.tar
tar -tf archive.tar
tar -czf archive.tar.gz files/
tar -cjf archive.tar.bz2 files/
tar -xzf archive.tar.gz
tar -xjf archive.tar.bz2
```

---

## 🔧 gzip Commands

```bash
gzip file.txt
gunzip file.txt.gz
gzip -c file.txt > file.txt.gz
gzip -t file.txt.gz
```

---

## 🔧 bzip2 Commands

```bash
bzip2 file.txt
bunzip2 file.txt.bz2
bzip2 -c file.txt > file.txt.bz2
bzip2 -t file.txt.bz2
```

---

# ✅ Conclusion

In this lab, you learned how to:

- Create tar archives
- Compress and decompress files
- Use gzip and bzip2
- Verify archive integrity
- Restore archived data
- Manage Linux backups efficiently

These skills are essential for:

- Linux system administration
- Backup management
- Storage optimization
- Disaster recovery
- RHCSA exam preparation

---
