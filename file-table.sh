echo "* Filesystem and Mountpoints"
df -h | awk '{print "  * " $0}'