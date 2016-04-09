#!/bin/bash
# Kills >> Established << connections on any port
# For the Blue Team, paranoid AF~~~ Blowing away the Red Team Zerglings!
# Can you hide from lsof? I hope so...

touch /tmp/capturedEstablishedProcess.txt
cat /dev/null > /tmp/capturedEstablishedProcess.txt
touch /root/IPSLog.csv
cat /dev/null > /root/IPSLog.csv
bools=true
# Begin Loop 1.0
while [ $bools=true ]
do
# If something in /tmp/capturedEstablishedProcess.txt file then do Loop 2.1
if [[ $(cat /tmp/capturedEstablishedProcess.txt) ]]; then
# Make inFile = true
inFile=true
else
# Else, make inFile = false
inFile=false
# End Loop 2.1
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
# Sleep 3 seconds, kill process
cat /dev/null > /tmp/capturedEstablishedProcess.txt
# Logging it to Syslog
sleep 3 && kill $inPort > /dev/null 2>&1 && echo $sIP" ===> $(date) Found and Killed Session "$inPort$ >> /var/log/syslog && tail -n 1 /var/log/syslog &
echo "Check /root/IPSLog.csv!"
# End Loop 3.3
inFile=false
echo "$(date) "$sPID","$sIP  >> /root/IPSLog.csv
done 
# End Loop 2.3
fi
# End Loop 1.0
done
