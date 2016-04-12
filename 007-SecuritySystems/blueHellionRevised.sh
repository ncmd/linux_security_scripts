#!/bin/bash
#
# Author: Charles M. Chong
#
# Free to use
# 0. Disable IPv6 (Edited manually)
# 0. Add Whitelist IPs to /root/whitelist.txt
# 0. Installs dsniff (Used for tcpkill)
# 1. Lists all open files with a TCP Established Connection
# 2. Kills >> Established << connections on any port
# 3. Creates a TCP & UDP Egress rules per IP found
# 4. Logs found hosts with timestamp and file calling out to .cvs file
#
# For the Blue Team, paranoid AF~~~ Blowing away the Red Team!
#
# The following 3 lines makes this script a daemon (run it separately from this script):
# ~# wget https://raw.githubusercontent.com/terminalcloud/terminal-tools/master/daemonize.sh
# ~# chmod +x daemonize.sh
# ~# ./daemonize.sh blueHellion /root/blueHellion.sh
#
# To stop as daemon:
# ~# service blueHellion stop
#
# >>>>>>>>>> Disable IPv6 <<<<<<<<<<<
# ~# nano /etc/sysctl.conf
# net.ipv6.conf.all.disable_ipv6 = 1
# net.ipv6.conf.default.disable_ipv6 = 1
# net.ipv6.conf.lo.disable_ipv6 = 1
# ~# sysctl -p
# ~# cat /proc/sys/net/ipv6/conf/all/disable_ipv6
# ~# echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
# ~# echo 1 > /proc/sys/net/ipv6/conf/default/disable_ipv6
# ~# nano /etc/avahi/avahi-daemon.conf
# use-ipv6=no
# ~# nano /etc/default/bind9
# OPTIONS="-4 -u bind"
#
# Installs dsniff
# apt-get install dsniff -y
# Create 4 files
touch /tmp/capturedPIDs.txt /root/IPSLog.csv /tmp/capturedIPs.txt /root/whitelist.txt
# Empty temp file
cat /dev/null > /tmp/capturedPIDs.txt
cat /dev/null > /tmp/duplicateRuleCheck.txt
# cat /dev/null > /tmp/capturedIPs.txt
# Log when script started
echo ">>>>>Script Run at $(date)<<<<<" >> /root/IPSLog.csv
bools=true
# Begin Loop 1.0
while [ $bools=true ]
do
# If something in /tmp/capturedIPs.txt file
# Start Loop 2.1
if [[ $(cat /tmp/capturedIPs.txt) ]]; then
# Make inFile = true
inFile=true
echo "inFile True"
else
inFile=false
# End Loop 2.1
fi
# Begin Loop 2.2
if [[ $inFile = false ]]; then
# Get IPv4 Addresses of Established Sessions, if they exist, append to /tmp/capturedIPs.txt
lsof -Pnl +M -i4| grep -e ESTABLISHED | grep -o ">.*" | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sort | uniq >> /tmp/capturedIPs.txt
## Declare sPID variable = PID of Established Process
#sPID=$(lsof -Pnl +M -i4 | grep -v rsyslogd | grep -e ESTABLISHED | grep ":.*" | grep '\<[0-9]\{3,5\}\>' | sed /COMMAND/d | awk '{print $2}' | uniq ) > /tmp/capturedPIDs.txt
# Declare sIP variable = IP of Established Process
sIP=$(lsof -Pnl +M -i4 | grep -e ESTABLISHED | grep -o ">.*" | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | uniq ) 
# sort CapturedIPs and remove Duplicates
cat /tmp/capturedIPs.txt | sort -u | uniq > /tmp/capturedIPsSORTED.txt
# End Loop 2.2
fi
# If inFile = true
# Start Loop 2.3
if [[ $inFile = true ]]; then
# Read capturedIPs.txt, for each line, empty capturedIPs file
# Begin Loop 3.1
cat /tmp/capturedIPsSORTED.txt | while read sIPAddress ; do
echo "Reading CapturedIP"
# Output Port # found
# Create a Firewall Outbound rule for Egress filtering
echo $sIPAddress
iptables -C OUTPUT -s $sIPAddress -j DROP 2> /tmp/duplicateRuleCheck
iptables -C INPUT -s $sIPAddress -j DROP 2> /tmp/duplicateRuleCheck
# Begin Loop 4.1
if [[ $(cat /tmp/duplicateRuleCheck) ]]; then
echo "Killing $sIPAddress Connection in 3 seconds..."
sleep 3
iptables -A OUTPUT -s $sIPAddress -j DROP
iptables -A INPUT -s $sIPAddress -j DROP
tcpkill host $sIPAddress -9
echo "Created Rule for "$sIPAddress
# lsof the sIPAddress
echo "Identify IP-------------------------------------------"
sPID=$(lsof -Pnl +M -i4 | grep $sIPAddress | grep ":.*" | grep '\<[0-9]\{3,5\}\>' | sed /COMMAND/d | awk '{print $2}' | uniq ) > /tmp/capturedPIDs.txt
echo "Killing PID: "$sPID
kill $sPID
cat /dev/null > /tmp/duplicateRuleCheck
# End Loop 4.1
fi
# Comma Delimited
echo "$(date),"$sPID","$sIP"\n"  >> /root/IPSLog.csv
# End Loop 3.1
done
# End Loop 2.3
# Empty file because there would be an endless loop to kill the same process
cat /dev/null > /tmp/capturedIPs.txt
fi
# End Loop 1.0
done