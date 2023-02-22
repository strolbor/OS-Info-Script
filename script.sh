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
./os.sh
 
echo ""

# Hier sollen die Informationen vom Arbeitsspeicher sein
# Diese Informationen erhalten wir von free -h
# -h bedeutet "Human readable", also was die Station will
echo "* RAM"
./ram.sh

echo ""

# Hier sollen die Informationen vom Speicher sei
./file-table.sh

