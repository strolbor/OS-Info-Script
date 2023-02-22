#!/bin/bash

 

# Autor: Urs-Benedict Braun <urs-benedict.braun@dataport.de>

 

echo " _______  _______         ___   __    _  _______  _______ "
echo "|       ||       |       |   | |  |  | ||       ||       |"
echo "|   _   ||  _____| ____  |   | |   |_| ||    ___||   _   |"
echo "|  | |  || |_____ |____| |   | |       ||   |___ |  | |  |"
echo "|  |_|  ||_____  |       |   | |  _    ||    ___||  |_|  |"
echo "|       | _____| |       |   | | | |   ||   |    |       |"
echo "|_______||_______|       |___| |_|  |__||___|    |_______|"

 

echo "* OS-Infos"

cat /etc/os-release | grep "NAME" | head -n2 | tail -n1 | awk -F'=' '{print "  * " $2}'

 
echo ""
echo "* Ram"

echo "Die Speicherauslastung ist von:"

free -h | tail -n2 | awk '{print "* " $1 " nutzt grade " $3 " von insgesamt: " $2}'