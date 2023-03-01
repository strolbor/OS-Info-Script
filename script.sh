#!/bin/bash

# Autor: Urs-Benedict Braun <urs-benedict.braun@dataport.de>

# Settings

# Banner anzeigen lassen
#   0 => Nein
#   1 => Ja
showbanner=1


function bannerinfo ()
{
    if [[ $showbanner -eq 1 ]]; then
        # kleiner Banner
        echo ".---------."
        echo "| OS-Info |"
        echo "'---------'"
    else
        # Wenn man es nicht wünscht
        echo "# OS-Info"
    fi
    echo ""
}

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
    # Wir benötigen wieder nur den 2. Teil des Strings.
    # siehe osinfo erklärtext

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
    
    
    echo "" # End echo
}


function osinfo ()
{
    echo "* OS"

    # OS-Name
    cat /etc/os-release | grep "PRETTY_NAME" | awk -F'=' '{print "  * The operating system pretty name is " $2}'
    # ich benötige nur den pretty name
    # und formatiert ausgeben. Dafür benötigen wir nur den 2. Teil des Strings
    # PRETTY_NAME="CentOS Linux 7 (Core)"
        # RRETTY_NAME => erster Teil
        # "CentOS Linux 7 (Core)" => zweiter Teil

    echo "" # End echo
}

function uptimeinfo ()
{
    echo "* Uptime"
    uptime -p | sed 's/up//g' | awk '{print "  * Current:" $0}'
    # erst uptime erhalten
    # dann up weg schneiden
    # und formatiert ausgeben

    echo "" # End echo
}

function raminfo ()
{
    # Diese Informationen erhalten wir von free -h
    # -h bedeutet "Human readable", also was die Station will
    echo "* RAM-Usage"

    free -h | tail -n2 | awk '{print "  * "$1 " " $3 " of " $2 " is used. " }'
    # wir erhalten alle infos von free -h (human readable)
    # dann benötigen wir nur die 2 letzten zeilen
    # und geben es formatiert aus
        # $1 => Name des Speichers
        # $2 => total Platz auf dem Speichermedium
        # §3 => grade benutzter Speicher auf dem Medium

    echo "" # End echo
}

function mntinfo ()
{
    echo "* Filesystem and Mountpoints"
    df -h | awk '{print "  * " $0}'

    echo "" # End echo
}


function helpinfo ()
{
    echo "* Helpmenu"
    echo "  * Usage:"
    echo "    * $0"
    echo "    * $0 cpu/ram/info/mnt/?"
    echo "    * $0 cpu/ram/info/mnt cpu/ram/info/mnt"
    echo "" # End echo
    exit 0
}

# Hauptprogramm
    # Hier wird alles angezeigt

# Banneranzeigen
bannerinfo

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

# Setze i auf $# (|Args|) und rechne -1
((i=$# -1))

# Wenn i größer ist als 0, durchlaufe die Schleife
# ("Rückwärtsschleife")
while [[ $i -ge 0 ]] 
do
    # BASH_ARGV ist eine reverse Liste der eingebenen Argumente
    # Deswegen müssen wir die Schleife auch rückwärts druchlaufen.
    case ${BASH_ARGV[$i]} in # switch-Case
        "cpu") #1
        cpuinfo
        ;;
        "ram") #2
        raminfo
        ;;
        "up") #3
        uptimeinfo
        ;;
        "mnt") #4
        mntinfo
        ;;
        "os") #5
        osinfo
        ;;
        *) #6
        helpinfo
        ;;
    esac
    ((i--))
done
