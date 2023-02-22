#!/bin/bash

# benötigt sysstat
# eher unpraktisch
iostat |head -n4

# besser ist
top -b -n 1 |head -n1 | awk '{print "  * over the last 1 minute: "$10 }'
top -b -n 1 |head -n1 | awk '{print "  * over the last 5 minute: "$11 }'
top -b -n 1 |head -n1 | awk '{print "  * over the last 15 minute: "$12 }'

# https://unix.stackexchange.com/questions/255100/get-top-output-for-non-interactive-shell

# uptime
# 10:23:13 up  3:27     ,  2 users          ,  load average: 0,00, 0,01, 0,05
#  Zeit         uptime  , angemdedete user  ,                CPU, disk, other 
#                                                              10,11,12    