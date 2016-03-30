hostname -I > ip1.txt
ip_address=$(cut -d' ' -f1 ip1.txt)

firewall-cmd --permanent --zone=FedoraServer --add-service=http
firewall-cmd --permanent --zone=FedoraServer --add-service=https
firewall-cmd --permanent --zone=FedoraServer --add-port=5544/udp

#iptables -A INPUT -m state --state NEW -p tcp --dport 5601 -j ACCEPT
#iptables -A INPUT -m state --state NEW -p tcp --dport 80 -j ACCEPT
#iptables -A INPUT -m state --state NEW -p tcp --dport 56892 -j ACCEPT
#iptables -A INPUT -m state --state NEW -p tcp --dport 56900 -j ACCEPT
#iptables -A INPUT -m state --state NEW -p tcp --dport 56889 -j ACCEPT
#iptables -A INPUT -m state --state NEW -p tcp --dport 56894 -j ACCEPT
#iptables -A INPUT -m state --state NEW -p tcp --dport 56899 -j ACCEPT
#iptables -A INPUT -m state --state NEW -p tcp --dport 56891 -j ACCEPT
#iptables -A INPUT -m state --state NEW -p tcp --dport 56895 -j ACCEPT
#iptables -A INPUT -m state --state NEW -p tcp --dport 9090 -j ACCEPT
#iptables -A INPUT -m state --state NEW -p tcp --dport 9200 -j ACCEPT
#iptables -A INPUT -m state --state NEW -p tcp --dport 9300 -j ACCEPT
#iptables -A INPUT -m state --state NEW -p tcp --dport 22 -j REJECT

iptables-save

echo "UPDATED RULES"
cat /etc/iptables/rulez
