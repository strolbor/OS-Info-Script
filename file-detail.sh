echo "* Filesystem"
echo "  * Mountpoints"
df -h | sed -e '1d' | awk '{print "    * " $6}'


echo "  * Storage usage"
df -h | sed -e '1d' |awk '{print "    * " $1 " nutzt grade " $3 " von insgesamt " $2}'