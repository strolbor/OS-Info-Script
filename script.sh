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

# Infosbereitstellen für CPU
top -b -n 1 -i | head -n1 > top.tmp
# -b => batch mode
# -n x => x Anzahl der Aktualisierungen bevor top beendet wird
# -i => top beginnt erst, wenn der cpu im idle ist
# und abspeichern, damit weniger Zugriffszeit haben


# Hier sollen die Informationen vom Betriebsystem sein
echo "* OS"

# OS-Name
cat /etc/os-release | grep "PRETTY_NAME" | awk -F'=' '{print "  * The operating system pretty name is " $2}'
# ich benötige nur den pretty name

# mehr infos mit nen extra argument >= 1
ARG1=${1:-0}

if [ $ARG1 -gt 0 ]
then
    cat /etc/os-release | grep "ID" | head -n1 | awk -F '=' '{print "  * The operating system id is " $2}' #hier wird head benötig, da mehrere einträge drin sind
    cat /etc/os-release | grep "VERSION_ID" | head -n1 | awk -F '=' '{print "  * The operating system version id is " $2}'
    cat /etc/os-release | grep "ID_LIKE" | head -n1 | awk -F '=' '{print "  * The operating system id_like is " $2}'
    cat /etc/os-release | grep "HOME_URL" | head -n1 | awk -F '=' '{print "  * The home_url ofoperating system is " $2}'
    echo ""
fi

uptime -p | sed 's/up//g' | awk '{print "  * Uptime:"$0}'

echo ""

echo "* CPU"
# CPU-Anzahl
lscpu | grep "Socket(s)" | awk '{print "  * CPU sockets: " $2}'
lscpu | grep "CPU(s)" | head -n1 | awk '{print "  * CPU cores: " $2}'

echo "  * CPU-load"

cat top.tmp | awk -F 'average' '{print $2 }' | awk -F ' ' '{print $2}' | sed -e 's/ $//g' | sed -e 's/,$//g' | \
    sed  's/,/./g' | awk '{print "    * over the last 1 minute: " $1*100 "%"}'
# 1. awk => wir trennen bei "average", da diese immer gleich sind und erhalten die CPU infos
# 2. awk => wir erhalten den ersten/zweiten/dritten Teil der zahlen folge, die von " " getrennt sind
# 1. sed leerzeichen entfernen
# 2. sed letztes "," entfernen
# 3. sed alle "," durch "." ersetzen
# multiplizieren mit 100 um Prozentwert zu erhalten
cat top.tmp | awk -F 'average' '{print $2 }' | awk -F ' ' '{print $3}' | sed -e 's/ $//g' | sed -e 's/,$//g' | \
    sed  's/,/./g' | awk '{print "    * over the last 5 minute: " $1*100 "%"}'
cat top.tmp | awk -F 'average' '{print $2 }' | awk -F ' ' '{print $4}' | sed -e 's/ $//g' | sed -e 's/,$//g' | \
    sed  's/,/./g' | awk '{print "    * over the last 15 minute: " $1*100 "%"}'
# $1 -> 1 Minute CPU-load
# $2 -> 5 Minuten CPU-load
# $3 -> 15 Minuten CPU-load

# temporäre Datei löschen
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
echo "* Filesystem and Mountpoints"
df -h | awk '{print "  * " $0}'


