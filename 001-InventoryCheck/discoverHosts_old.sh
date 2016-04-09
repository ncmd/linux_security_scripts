#!/bin/bash
#
# Script used to find all hosts on a network using ARP scan, parse only IP addresses into file
#
# Getting the first 2 octets of current IP address, setting it as a variable
hostIP=$(hostname -I | grep -E -o "([0-9]{1,3}[\.]){2}")
# Creating hidden directory (there is a space after '/tmp/\')
mkdir /tmp/\ 
# Creating files
touch /tmp/\ /foundHosts.txt
touch /tmp/\ /foundHostsSorted.txt
# Adjust this line to narrow search of network scan
hostIP+="0.0/16"
# Scan network according to the found IP address
netdiscover -P -r $hostIP > /tmp/\ /foundHosts.txt
# Delete 0.0.0.0 addresses
sed '/0.0.0.0/d' /tmp/\ /foundHosts.txt > /tmp/\ /filterHosts1.txt
# Delete empty lines
sed '/^$/d' /tmp/\ /filterHosts1.txt > /tmp/\ /filterHosts2.txt
sed '/./!d' /tmp/\ /filterHosts2.txt > /tmp/\ /filterHosts3.txt
# Sorting found IP addresses
grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" /tmp/\ /filterHosts3.txt | sort | uniq > /tmp/\ /foundHostsSorted.txt
# Shows contents of found IP addresses
cp /tmp/\ /foundHostsSorted.txt /root/foundHostsSorted.txt
cat /root/foundHostsSorted.txt
