# OS-Info-Skript

## Ziel
Mithilfe dieses Skriptes, sollen bestimmte Werte übersichtlich dargestellt werden.

Zu den Infos gehören:
* Betriebsystem
* CPU
  * Anzahl der Sockets
  * Anzahl der Kerne
  * CPU-Auslastung
* RAM-Nutzung
* Speicherplatz

## Skriptsprache
Die Skriptsprache ist BASH bzw. SH.

## Funktionalität
Die Funktion des Skript wurde auf CentOS 7 getestet und dafür optimiert.

## Nutzung
Für die normale Nutzung:
```bash
  ./script.sh
```

Wenn man spezielle Infos benötigt:
```bash
  ./script.sh cpu/ram/info/mnt cpu/ram/info/mnt
``` 

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
