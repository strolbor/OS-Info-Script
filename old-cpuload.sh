#!/bin/bash

cat top.tmp | awk '{print "    * over the last 1 minute: "$10 }' | sed -e 's/ $//g' | sed -e 's/,$//g' 
# 1. sed leerzeichen entfernen
# 2. sed , entfernen
# 3. sed , durch . ersetzen
cat top.tmp | awk '{print "    * over the last 5 minute: "$11 }' | sed -e 's/ $//g' | sed -e 's/,$//g'
cat top.tmp | awk '{print "    * over the last 15 minute: "$12 }'
