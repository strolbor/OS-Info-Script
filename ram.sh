free -h | tail -n2 | awk '{print "  * The ram usage of " $1 " is " $3 " from total of " $2}'
