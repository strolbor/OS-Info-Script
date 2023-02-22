#!/bin/bash

 

# Autor: Urs-Benedict Braun <urs-benedict.braun@dataport.de>

 

echo " _______  _______         ___   __    _  _______  _______ "
echo "|       ||       |       |   | |  |  | ||       ||       |"
echo "|   _   ||  _____| ____  |   | |   |_| ||    ___||   _   |"
echo "|  | |  || |_____ |____| |   | |       ||   |___ |  | |  |"
echo "|  |_|  ||_____  |       |   | |  _    ||    ___||  |_|  |"
echo "|       | _____| |       |   | | | |   ||   |    |       |"
echo "|_______||_______|       |___| |_|  |__||___|    |_______|"
echo ""
 
echo "* OS"
cat /etc/os-release | grep "NAME" | head -n2 | tail -n1 | awk -F'=' '{print "* The operating system is " $2}'

 
echo ""
echo "* RAM"
free -h | tail -n2 | awk '{print "  * The ram usage of " $1 " is " $3 " from total of " $2}'