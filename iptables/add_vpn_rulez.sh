\iptables -A INPUT -p tcp --dport 904 -j ACCEPT
\iptables -A INPUT -p tcp --dport 905 -j ACCEPT
\iptables -A INPUT -p tcp --dport 906 -j ACCEPT
\iptables -A INPUT -p tcp --dport 907 -j ACCEPT
\iptables -A INPUT -p tcp --dport 908 -j ACCEPT
\iptables -A INPUT -p tcp --dport 909 -j ACCEPT
\iptables -A INPUT -p tcp --dport 943 -j ACCEPT
\iptables -A INPUT -p udp --dport 1194 -j ACCEPT

\iptables-save

\cat /etc/iptables/rulez
