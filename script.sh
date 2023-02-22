#!/bin/bash

# Autor: Urs-Benedict Braun <urs-benedict.braun@dataport.de>

 
# kleiner Banner in ASCII Art
echo " _______  _______         ___   __    _  _______  _______ "
echo "|       ||       |       |   | |  |  | ||       ||       |"
echo "|   _   ||  _____| ____  |   | |   |_| ||    ___||   _   |"
echo "|  | |  || |_____ |____| |   | |       ||   |___ |  | |  |"
echo "|  |_|  ||_____  |       |   | |  _    ||    ___||  |_|  |"
echo "|       | _____| |       |   | | | |   ||   |    |       |"
echo "|_______||_______|       |___| |_|  |__||___|    |_______|"
echo ""

# Hier sollen die Informationen vom Betriebsystem sein
echo "* OS"
cat /etc/os-release | grep "NAME" | head -n2 | tail -n1 | awk -F'=' '{print "  * The operating system is " $2}'

 
echo ""

# Hier sollen die Informationen vom Arbeitsspeicher sein
# Diese Informationen erhalten wir von free -h
# -h bedeutet "Human readable", also was die Station will
echo "* RAM"
free -h | tail -n2 | awk '{print "  * The ram usage of " $1 " is " $3 " from total of " $2}'

echo ""

# Hier sollen die Informationen vom Speicher sei
df -h | head -n1 |awk '{print "* " $0}'
 df -h | sed -e '1d' |awk '{print "  * " $0}'

