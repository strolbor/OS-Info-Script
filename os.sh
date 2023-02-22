cat /etc/os-release | grep "NAME" | head -n2 | tail -n1 | awk -F'=' '{print "  * The operating system is " $2}'
