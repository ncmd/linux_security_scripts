#!/bin/bash
# Charles M. Chong
# 1. Lists all open files with a TCP Established Connection
# 2. Kills >> Established << connections on any port
# 3. Creates a egress rules per IP found
# 4. Logs found hosts with timestamp and file calling out to .cvs file
#
# For the Blue Team, paranoid AF~~~ Blowing away the Red Team Zerglings!
# Can you hide from lsof? I hope so...
# 
# Only way to stop this is to stop daemon: 
# ~# service blueHellion stop
#
# The following 3 lines makes this script a daemon (run it separately from this script):
# ~# wget https://raw.githubusercontent.com/terminalcloud/terminal-tools/master/daemonize.sh  
# ~# chmod +x daemonize.sh 
# ~# ./daemonize.sh blueHellion /root/blueHellion.sh
 
touch /tmp/capturedEstablishedProcess.txt /root/IPSLog.csv
cat /dev/null > /tmp/capturedEstablishedProcess.txt
echo ">>>>>Script Run at $(date)<<<<<------------------" >> /root/IPSLog.csv
bools=true
# Begin Loop 1.0
while [ $bools=true ]
do
# If something in /tmp/capturedEstablishedProcess.txt file then do Loop 2.1
if [[ $(cat /tmp/capturedEstablishedProcess.txt) ]]; then
# Make inFile = true
inFile=true
# End Loop 2.1
else
inFile=false
fi
# Begin Loop 2.2
if [[ $inFile = false ]]; then
# Gets PID of Established Sessions if they exist and append it in /tmp/capturedEstablishedProcess.txt
lsof -Pnl +M -i4 | grep -v rsyslogd | grep -e ESTABLISHED | grep ":.*" | grep '\<[0-9]\{3,5\}\>' | sed /COMMAND/d | awk '{print $2}' | uniq > /tmp/capturedEstablishedProcess.txt 
# Declare sPID variable = PID of Established Process
sPID=$(lsof -Pnl +M -i4 | grep -v rsyslogd | grep -e ESTABLISHED | grep ":.*" | grep '\<[0-9]\{3,5\}\>' | sed /COMMAND/d | awk '{print $2}' | uniq ) 
# Declare sIP variable = IP of Established Process
sIP=$(lsof -i | grep -e ESTABLISHED | grep -o ">.*" | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | uniq ) 
# End Loop 2.2
fi
# If inFile = true do Loop 2.3
if [[ $inFile = true ]]; then
# Output /tmp/capturedEstablishedProcess.txt, for every line in file, do Loop 3.3
cat /tmp/capturedEstablishedProcess.txt | while read inPort ; do
# Output Port # found
# Epty file because there would be an endless loop to kill the same process
cat /dev/null > /tmp/capturedEstablishedProcess.txt
# Sleep 3 seconds, make an entry to Syslog, tail the last line in Syslog
sleep 3 && kill $inPort > /dev/null 2>&1 && echo $sIP" ===> $(date) Found and Killed Session "$inPort$ >> /var/log/syslog && tail -n 1 /var/log/syslog &
# Add kill process feature (may kill critical services...)
# sleep 3 && kill $inPort > /dev/null 2>&1 && echo $sIP" ===> $(date) Found and Killed Session "$inPort$ >> /var/log/syslog && tail -n 1 /var/log/syslog &
# Create a Firewall Outbound rule for Egress filtering
iptables -A OUTPUT -p tcp -s $sIP -j DROP
iptables -A OUTPUT -p udp -s $sIP -j DROP
# Remove duplicate iptables-rules
iptables-save | uniq | iptables-restore
echo "Check /root/IPSLog.csv!"
# End Loop 3.3
inFile=false
echo "$(date) "$sPID","$sIP  >> /root/IPSLog.csv
done 
# End Loop 2.3
fi
# End Loop 1.0
done
