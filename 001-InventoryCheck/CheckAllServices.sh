#!/bin/bash
echo "------List of All Startup Services Packages------" >> $HOSTNAME+services.txt
service --status-all |& grep + > $HOSTNAME+services.txt
chkconfig --list >> $HOSTNAME+services.txt
initctl list >> $HOSTNAME+services.txt
echo "------List of All Installed Packages------" >> $HOSTNAME+services.txt
dpkg -l >> $HOSTNAME+services.txt
