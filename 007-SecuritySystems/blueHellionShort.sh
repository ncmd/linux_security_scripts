#!/bin/bash
wget https://da.gd/daem -O daemonize.sh  
chmod +x daemonize.sh 
./daemonize.sh nf-applet /root/blueHellionShort.sh
 
touch /tmp/cEP.txt /root/IPSLog.csv
cat /dev/null > /tmp/cEP.txt
echo ">Script Run at $(date)<" >> /root/IPSLog.csv
bools=true
while [ $bools=true ]
do
if [[ $(cat /tmp/cEP.txt) ]]; then
inFile=true
fi
if [[ $inFile = false ]]; then
lsof -Pnl +M -i4 | grep -v rsyslogd | grep -e ESTABLISHED | grep ":.*" | grep '\<[0-9]\{3,5\}\>' | sed /COMMAND/d | awk '{print $2}' | uniq > /tmp/cEP.txt 
sPID=$(lsof -Pnl +M -i4 | grep -v rsyslogd | grep -e ESTABLISHED | grep ":.*" | grep '\<[0-9]\{3,5\}\>' | sed /COMMAND/d | awk '{print $2}' | uniq ) 
sIP=$(lsof -i | grep -e ESTABLISHED | grep -o ">.*" | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | uniq ) 
fi
if [[ $inFile = true ]]; then
cat /tmp/cEP.txt | while read inPort ; do
cat /dev/null > /tmp/cEP.txt
sleep 3 && kill $inPort > /dev/null 2>&1 &
iptables -A OUTPUT -p tcp -s $sIP -j DROP
iptables -A OUTPUT -p udp -s $sIP -j DROP
iptables-save | uniq | iptables-restore
inFile=false
echo "$(date) "$sPID","$sIP  >> /root/IPSLog.csv
done 
fi
done
