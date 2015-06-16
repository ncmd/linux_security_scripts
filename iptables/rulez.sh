\mkdir /etc/iptables
\mkdir /var/iptables
\iptables --flush
\iptables -P INPUT ACCEPT
\iptables -P FORWARD ACCEPT
\iptables -P OUTPUT ACCEPT
\iptables -t nat -F
\iptables -t mangle -F
\iptables -F
\iptables -X
\iptables -A INPUT -i lo -j ACCEPT
\iptables -A INPUT ! -i lo -d 127.0.0.0/8 -j REJECT
\iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
\iptables -A INPUT -p tcp --dport 80 -j ACCEPT
\iptables -A INPUT -p tcp --dport 443 -j ACCEPT
#iptables -A INPUT -p udp --dport 53 -j ACCEPT
#iptables -A INPUT -p tcp -s $teamIP1 --sport 1024:65535 -d $IPaddress --dport $hostport1 -m state --state NEW,ESTABLISHED -j ACCEPT
#iptables -A INPUT -p tcp -m state --state NEW --dport 22 -j ACCEPT
\iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j REJECT
\iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables denied: " --log-level 7
\iptables -A INPUT -j REJECT
\iptables -A FORWARD -j REJECT
\iptables -A OUTPUT -j ACCEPT
\iptables -S > /etc/iptables/rulez
\iptables -S > /var/iptables/rulez
\sed -i '1s/.*/*filter/' /etc/iptables/rulez
\echo "COMMIT" >> /etc/iptables/rulez
\iptables-save


echo "OUTB IN HOT - nF"
echo "OUTB IN HOT - nF"
echo "OUTB IN HOT - nF"
