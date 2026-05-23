BEGIN {
    FS = ":"
    print "=== User Summary ==="
    bash_users = 0
    system_users = 0
}

$3 < 1000 {
    system_users++
}

$3 >= 1000 && $7 == "/bin/bash" {
    bash_users++
    print "Regular user:", $1, "(" $5 ")"
}

END {
    print "System users:", system_users
    print "Regular bash users:", bash_users
}
EOF
