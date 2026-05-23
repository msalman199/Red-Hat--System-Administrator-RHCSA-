#!/bin/bash

echo "=== System Log Analysis ==="
echo

# Analyze SSH activities
echo "SSH Login Analysis:"
echo "Successful logins:"
grep "sshd.*Accepted" system.log | awk '{print $9, $11}' | sort | uniq -c | sed 's/^[ ]*/  /'

echo
echo "Failed login attempts:"
grep "sshd.*Failed" system.log | awk '{print $9, $11}' | sort | uniq -c | sed 's/^[ ]*/  /'

echo
echo "=== HTTP Request Analysis ==="
grep "httpd" system.log | awk '{print $7, $8}' | sort | uniq -c | sed 's/^[ ]*/  /'

echo
echo "=== User Account Summary ==="
echo "Regular users with bash access:"
awk -F: '$3 >= 1000 && $7 ~ /bash/ {print "  " $1 " (" $5 ")"}' users.txt

echo
echo "System accounts:"
awk -F: '$3 < 1000 {count++} END {print "  Total system accounts: " count}' users.txt
EOF
