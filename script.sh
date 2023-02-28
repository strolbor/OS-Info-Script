#!/bin/bash

# Autor: Urs-Benedict Braun <urs-benedict.braun@dataport.de>

# Settings

# Banner anzeigen lassen
#   0 => Nein
#   1 => Ja
showbanner=0



if [[ $showbanner -eq 1 ]]; then
    # kleiner Banner in ASCII Art
    echo " _______  _______         ___   __    _  _______  _______ "
    echo "|       ||       |       |   | |  |  | ||       ||       |"
    echo "|   _   ||  _____| ____  |   | |   |_| ||    ___||   _   |"
    echo "|  | |  || |_____ |____| |   | |       ||   |___ |  | |  |"
    echo "|  |_|  ||_____  |       |   | |  _    ||    ___||  |_|  |"
    echo "|       | _____| |       |   | | | |   ||   |    |       |"
    echo "|_______||_______|       |___| |_|  |__||___|    |_______|"
    echo ""
else
    # Wenn man es nicht wünscht
    echo "# OS-Info"
    echo ""
fi

function cpuinfo ()
{
    # Infosbereitstellen für CPU
    TOPDATA=$(top -b -n 1 -i | head -n1)
    # -b => batch mode
    # -n x => x Anzahl der Aktualisierungen bevor top beendet wird
    # -i => top beginnt erst, wenn der cpu im idle ist
    # und abspeichern als variable
    echo "* CPU"
    # CPU-Anzahl
    lscpu | grep "Socket(s)" | awk '{print "  * CPU sockets: " $2}'
    lscpu | grep "CPU(s)" | head -n1 | awk '{print "  * CPU cores: " $2}'

    echo "  * CPU-load:"

    echo $TOPDATA | awk -F 'average' '{print $2 }' | awk -F ' ' '{print $2}' | sed -e 's/ $//g' | sed -e 's/,$//g' | \
        sed  's/,/./g' | awk '{print "    * over the last 1 minute: " $1*100 "%"}'
    # 1. awk => wir trennen bei "average", da diese immer gleich sind und erhalten die CPU infos
    # 2. awk => wir erhalten den ersten/zweiten/dritten Teil der zahlen folge, die von " " getrennt sind
        # $2 -> 1 Minute CPU-load
        # $3 -> 5 Minuten CPU-load
        # $4 -> 15 Minuten CPU-load
    # 1. sed leerzeichen entfernen
    # 2. sed letztes "," entfernen
    # 3. sed alle "," durch "." ersetzen
    # multiplizieren mit 100 um Prozentwert zu erhalten
    echo $TOPDATA | awk -F 'average' '{print $2 }' | awk -F ' ' '{print $3}' | sed -e 's/ $//g' | sed -e 's/,$//g' | \
        sed  's/,/./g' | awk '{print "    * over the last 5 minute: " $1*100 "%"}'
    echo $TOPDATA | awk -F 'average' '{print $2 }' | awk -F ' ' '{print $4}' | sed -e 's/ $//g' | sed -e 's/,$//g' | \
        sed  's/,/./g' | awk '{print "    * over the last 15 minute: " $1*100 "%"}'
    echo ""
}


function osinfo ()
{
    echo "* OS"

    # OS-Name
    cat /etc/os-release | grep "PRETTY_NAME" | awk -F'=' '{print "  * The operating system pretty name is " $2}'
    # ich benötige nur den pretty name

    echo ""
}

function uptimeinfo ()
{
    echo "* Uptime"
    uptime -p | sed 's/up//g' | awk '{print "  * Current:" $0}'

    echo ""
}

function raminfo ()
{
    # Diese Informationen erhalten wir von free -h
    # -h bedeutet "Human readable", also was die Station will
    echo "* RAM-Usage"

    free -h | tail -n2 | awk '{print "  * "$1 " " $3 " of " $2 " is used. " }'
    # '{print "  * The ram usage of " $1 " is " $3 " from total of " $2}'

    echo ""
}

function mntinfo ()
{
    echo "* Filesystem and Mountpoints"
    df -h | awk '{print "  * " $0}'
    echo ""
}


function helpinfo ()
{
    echo "# Helpmenu"
    echo ""
    echo "* Usage:"
    echo "  * $0"
    echo "  * $0 cpu/ram/info/mnt/?"
    echo "  * $0 cpu/ram/info/mnt cpu/ram/info/mnt"
    echo ""
}

# Wenn Script gestartet wird, überprüfe, ob ich eingaben erhalte
# Wenn nein, soll das hier passieren
if [[ $# -eq 0 ]]; then
    osinfo
    cpuinfo
    uptimeinfo
    raminfo
    mntinfo
fi

# Wenn ich eingaben habe, prüfe, was sie sind und zeige es mir entsprechend an
# Wenn $# == 0 => wird die schleife nie durchgelaufen
((i=$# -1))
while [[ $i -ge 0 ]]
do
    case ${BASH_ARGV[$i]} in
        "cpu")
        cpuinfo
        ;;
        "ram")
        raminfo
        ;;
        "up")
        uptimeinfo
        ;;
        "mnt")
        mntinfo
        ;;
        "os")
        osinfo
        ;;
        *)
        helpinfo
        ;;
    esac
    #echo $i
    #echo ${BASH_ARGV[$i]}
    ((i--))
done
