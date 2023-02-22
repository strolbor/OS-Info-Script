#!/bin/bash

# OS-Name
cat /etc/os-release | grep "NAME" | head -n2 | tail -n1 | awk -F'=' '{print "  * The operating system is " $2}'

# CPU-Anzahl
lscpu | grep "Socket(s)" | head -n1 | awk '{print "  * CPU sockets: " $2}'
lscpu | grep "CPU(s)" | head -n1 | awk '{print "  * CPU cores: " $2}'
