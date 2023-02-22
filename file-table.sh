#!/bin/bash

echo "* Filesystem and Mountpoints (V2)"
df -h | awk '{print "  * " $0}'