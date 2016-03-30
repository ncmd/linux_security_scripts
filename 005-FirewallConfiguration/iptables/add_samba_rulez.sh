hostname -I > ip1.txt
ip_address=$(cut -d' ' -f1 ip1.txt)

iptables -A INPUT --sport $ip_address -m state --state NEW -p tcp --dport 137 -j ACCEPT
iptables -A INPUT --sport $ip_address -m state --state NEW -p tcp --dport 138 -j ACCEPT
iptables -A INPUT --sport $ip_address -m state --state NEW -p tcp --dport 139 -j ACCEPT
iptables -A INPUT --sport $ip_address -m state --state NEW -p tcp --dport 445 -j ACCEPT

iptables-save

echo "UPDATED RULES"
cat /etc/iptables/rulez
