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

# OS-Name
cat /etc/os-release | grep "NAME" | head -n2 | tail -n1 | awk -F'=' '{print "  * The operating system is " $2}'

echo ""

echo "* CPU"
# CPU-Anzahl
lscpu | grep "Socket(s)" | head -n1 | awk '{print "  * CPU sockets: " $2}'
lscpu | grep "CPU(s)" | head -n1 | awk '{print "  * CPU cores: " $2}'
uptime -p | sed 's/up//g' |awk '{print "  * Uptime:"$0}'

echo "  * CPU-load"
top -b -n 1 -i | head -n1 > top.tmp
cat top.tmp | awk '{print "    * over the last 1 minute: "$10 }' | sed -e 's/ $//g' | sed -e 's/,$//g' 
cat top.tmp | awk '{print "    * over the last 5 minute: "$11 }' | sed -e 's/ $//g' | sed -e 's/,$//g'
cat top.tmp | awk '{print "    * over the last 15 minute: "$12 }'

#in Prozent

cat top.tmp |head -n1 | awk '{print $10 }' | sed -e 's/ $//g' | sed -e 's/,$//g'  | sed  's/,/./g' | awk '{print "    * over the last 15 minute: " $0*100 "%"}'
# 1. sed leerzeichen entfernen
# 2. sed , entfernen
# 3. sed , durch . ersetzen
# dann multiplizieren für prozent
cat top.tmp | awk '{print $11 }' | sed -e 's/ $//g' | sed -e 's/,$//g'  | sed  's/,/./g' | awk '{print "    * over the last 15 minute: " $0*100 "%"}'
cat top.tmp | awk '{print $12 }' | sed -e 's/ $//g' | sed -e 's/,$//g'  | sed  's/,/./g' | awk '{print "    * over the last 15 minute: " $0*100 "%"}'
rm -f top.tmp

echo ""


# Hier sollen die Informationen vom Arbeitsspeicher sein
# Diese Informationen erhalten wir von free -h
# -h bedeutet "Human readable", also was die Station will
echo "* RAM-Usage"

free -h | tail -n2 | awk '{print "  * "$1 " " $3 " of " $2 " is used. " }'
# '{print "  * The ram usage of " $1 " is " $3 " from total of " $2}'

echo ""

# Hier sollen die Informationen vom Speicher sei
./file-table.sh
./file-detail.sh


