#!/bin/bash

echo "* Filesystem (V1)"
echo "  * Mountpoints"
# $6 sind die Mountpoints
df -h | sed -e '1d' | awk '{print "    * " $6}'


echo "  * Storage usage"
# Device uses just 0M out of a total of 1M



#df -h | sed -e '1d' |awk '{print "    * " $1 "("$6") uses " $3 " out of a total of " $2}'
# Output: * 192.168.0.33:/home(/mnt/nfs/home) uses 1,7G out of a total of 29G

df -h | sed -e '1d' |awk '{print "    * " $3 " of " $2 " is used by " $1 " ("$6")"}'
# Output: 1,7G of 29G is used by 192.168.0.33:/home (/mnt/nfs/home)
