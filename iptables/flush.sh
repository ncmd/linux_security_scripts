\iptables --flush
\iptables -P INPUT ACCEPT
\iptables -P FORWARD ACCEPT
\iptables -P OUTPUT ACCEPT
\iptables -t nat -F
\iptables -t mangle -F
\iptables -F
\iptables -X
\iptables -A INPUT -j ACCEPT
\iptables -A FORWARD -j ACCEPT
\iptables -A OUTPUT -j ACCEPT
