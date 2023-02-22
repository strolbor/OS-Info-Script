echo "* Filesysteme und Mountpoints"
df -h | awk '{print "  * " $0}'