echo "* Filesystem"
echo "  * Mountpoints"
df -h | sed -e '1d' | awk '{print "    * " $6}'


echo "  * Storage usage"
df -h | awk '{print "    * " $1 "nutzt grade " $6 " von insgesamt" $2}'