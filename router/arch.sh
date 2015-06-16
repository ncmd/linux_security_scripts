#!/bin/bash

outnetwork=192.168.4.0
outip=192.168.4.15
outipwmask=192.168.4.15/24
outnetmask=192.168.4.0/24
default=192.168.4.1

innetwork=10.0.0.0
inip=10.0.1.1
inipwmask=10.0.1.1/24
innetmask=10.0.1.0/24

phyint=eth0
internal=internal
external=external
vlanidoutside=5
vlanidinside=10

########### DNS Nameservers are to be configured here! ###########
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

ip link set ${phyint} up

echo "*********Adding subinterfaces and addresses to interfaces*********"
ip link add link ${phyint} name ${external} type vlan id ${vlanidoutside}
ip addr add ${outipwmask} brd + dev ${external}
ip link set ${external} up

ip link add link ${phyint} name ${internal} type vlan id ${vlanidinside}
ip addr add  ${inipwmask} brd + dev ${internal}
ip link set ${internal} up

echo "**********Changing routing tables in Main*****************"
ip route change ${outnetmask} dev ${phyint} src ${outip}
ip route add default via ${default}
ip route change ${innetmask} dev ${phyint} src ${inip}

echo "********Adding routing rule and routes to table*******"
ip route add ${innetmask} dev ${phyint} src ${inip} table 5
echo "add route"
ip rule add prio 5 to ${innetmask} table 5
echo "add rule"
#cant take the route out of main until it is in a table
ip route delete ${innetmask}


echo "**********Configuring IPTables to do NAT******************"
echo "**********************Warning*****************************"
echo "******************Flushing Rules!*************************"
iptables -F -t nat
# allow forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
# enable masquerading
iptables -t nat -A POSTROUTING -o ${phyint} -s ${innetmask} -j MASQUERADE
# enable logging of all forwarded traffic
iptables -A FORWARD -j LOG
# Display iptables configuration
iptables -L -v -t nat --line-numbers

echo "************END**************"
