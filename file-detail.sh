echo "* Filesystem"
echo "  * Mountpoints"
# $6 sind die Mountpoints
df -h | sed -e '1d' | awk '{print "    * " $6}'


echo "  * Storage usage"
# Device uses just 0M out of a total of 1M
df -h | sed -e '1d' |awk '{print "    * " $1 " uses just " $3 " out of a total of " $2}'