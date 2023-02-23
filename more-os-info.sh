#!/bin/bash

echo "* OS"
cat /etc/os-release | grep "ID" | head -n1 | awk -F '=' '{print "  * The operating system id is " $2}' #hier wird head benötig, da mehrere einträge drin sind
cat /etc/os-release | grep "VERSION_ID" | head -n1 | awk -F '=' '{print "  * The operating system version id is " $2}'
cat /etc/os-release | grep "ID_LIKE" | head -n1 | awk -F '=' '{print "  * The operating system id_like is " $2}'
cat /etc/os-release | grep "HOME_URL" | head -n1 | awk -F '=' '{print "  * The home_url ofoperating system is " $2}'
