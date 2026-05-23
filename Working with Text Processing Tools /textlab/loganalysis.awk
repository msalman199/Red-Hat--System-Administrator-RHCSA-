BEGIN {
    print "=== Log Analysis Report ==="
    ssh_success = 0
    ssh_failed = 0
    http_requests = 0
}

/sshd.*Accepted/ {
    ssh_success++
}

/sshd.*Failed/ {
    ssh_failed++
}

/httpd/ {
    http_requests++
}

END {
    print "SSH Successful logins:", ssh_success
    print "SSH Failed logins:", ssh_failed
    print "HTTP Requests:", http_requests
    print "=== End Report ==="
}
EOF
