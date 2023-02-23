# TZ-OS-Info-Skript

## Ziel
Mithilfe dieses Skriptes, sollen bestimmte Werte übersichtlich dargestellt werden.

Zu den Infos gehören:
* Betriebsystem
* CPU
  * Anzahl der Sockets
  * Anzahl der Kerne
  * CPU-Auslastung
* RAM-Nutzung
* Harddisk-Drive Nutzung

## Skriptsprache
Die Skriptsprache ist BASH bzw. SH.

## Funktionalität
Die Funktion des Skript wurde auf CentOS 7 getestet und dafür optimiert.

## Nutzung
Für die normale Nutzung:
```bash
  ./info.sh
```

Wenn man mehr Infos benötigt:
```bash
  ./info.sh 1
``` 

Wobei 1, auch durch eine beliebige Zahl größer 0 ersetzt werden kann.

## Aufgabe
* Betriebssystem
  * via cat /etc/os-release
  * [x] erledigt
* Anzahl CPU/Kerne
  * via lscpu
  * [x] erledigt
* CPU Auslastung
  * via top
  * [x] erledigt
* RAM Gesamt
  * via free -h
  * [x] erledigt
* RAM Auslastung
  * free -h
  * [x] erledigt
* Festplattenplatz
  * via df -h sehr gut machbar
  * [x] erledigt
* Mountpoints (angehängte NFS Mountpoints)
  * via df -h sehr gut machbar
    * selbst NFS Mountpoints werden dargestellt.
  * [x] erledigt