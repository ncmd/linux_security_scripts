#!/bin/bash
# This script is used to get a quick .txt Snapshot of all services before shutting them down.
# Used for references to compair
echo "-------------------------------------------------"
echo "------List of All Startup Services Packages------" >> $HOSTNAME+services.txt
echo "-------------------------------------------------"
service --status-all |& grep + > $HOSTNAME+services.txt
chkconfig --list >> $HOSTNAME+services.txt
initctl list >> $HOSTNAME+services.txt
echo "------------------------------------------"
echo "------List of All Installed Packages------" >> $HOSTNAME+services.txt
echo "------------------------------------------"
dpkg -l >> $HOSTNAME+services.txt
echo "--------------------------------------------"
echo "------List of Current Running Processes-----"
echo "--------------------------------------------"
ps aux >> $HOSTNAME+services.txt
