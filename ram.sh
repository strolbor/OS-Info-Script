#!/bin/bash

free -h | tail -n2 | awk '{print "  * "$1 " " $3 " of " $2 " is used. " }'
# '{print "  * The ram usage of " $1 " is " $3 " from total of " $2}'

df -h | sed -e '1d' |awk '{print "    * " $3 " of " $2 " is used by " $1 " ("$6")"}'
# Output: 1,7G of 29G is used by 192.168.0.33:/home (/mnt/nfs/home)