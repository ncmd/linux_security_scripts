# Default port = 53

# Check resolv.conf nameservers set properly (DNS server):
domain mydomain.local
search mydomain.local
nameserver 127.0.0.1
nameserver _ipofhost_
nameserver _ipofdns02
--
# for (client)
# domain mydomain.local
# search mydomain.local
# nameserver _ip_of_dnsserver_
--
# Check interface is up:
# ip link 
# ip link set _interface_ up

# /etc/init.d/networking restart

# check routes and addressing working. Do test ping

# Check repositories and binaries for update

# Upgrade system first:
apt-get update -y && apt-get upgrade -y
# Install bind - 
apt-get install bind9 bind9-doc dnsutils
# (on client install dnsutils too)

# nano /etc/network/interfaces (server)
# iface _network_interface_name_ inet static
# address x.x.x.x
# netmask 255.x.x.x
# dns-nameservers 127.0.0.1 # for server; for client add dns server ip

TSIG Signature
cat /etc/bind/rndc.key

Cp rndc.key ns-_domainname_.com_rndc-key

To be safe, generate new key
cd /etc/bind
dnssec-keygen –a HMAC-MD5 –b 512 –n USER ns-_domainname_-com_rndc-key
Output: Kns-_domainname-com_rndc-key.+157+18290

Cat Kns…private
Private-key-format: v1.2
Algorithm: 157 (HMAC_MD5)
Key: LZ5m+L/HAmtc9rs9OU2RGstsg+Ud0TMXOT+C4rK7+YNUo3vNxKx/197o2Z80t6gA34AEaAf3F+hEodV4K+SWvA==

Cat Kns…rndc-key
key "ns-_domainname-com_rndc-key" {
        algorithm hmac-md5;
        secret "LZ5m+L/HAmtc9rs9OU2RGstsg+Ud0TMXOT+C4rK7+YNUo3vNxKx/197o2Z80t6gA34AEaAf3F+hEodV4K+SWvA==";
};


Nano /etc/bind/named.conf
// Managing acls
acl internals { 127.0.0.0/8; 192.168.0.0/24; };
// allow 953 port
controls {
inet 127.0.0.1 port 953
allow {127.0.0.1;};
}; 
// Load options for debian
include "/etc/bind/named.conf.options";
include "/etc/bind/named.conf.local";

// TSIG key used for the dynamic update
include "/etc/bind/ns-example-com_rndc-key";

// Configure the communication channel for Administrative BIND9 with rndc
// By default, they key is in the rndc.key file and is used by rndc and bind9 
// on the localhost
controls {
        inet 127.0.0.1 port 953 allow { 127.0.0.1; };
};

the next stuff by default is already made in the /etc/bind/named.conf.default...
--------------------------- 
for arch, centos, etc...
root directory: “/var/named”;
pid-file “/run/named/named.pid”;

// prime the server with knowledge of the root servers
zone "." {
        type hint;
        file "/etc/bind/db.root";//for debian
	file “root.hint”
};

// be authoritative for the localhost forward and reverse zones, and for
// broadcast zones as per RFC 1912
zone "localhost" {
        type master;
        file "/etc/bind/db.local";
};
zone "127.in-addr.arpa" {
        type master;
        file "/etc/bind/db.127";
};
zone "0.in-addr.arpa" {
        type master;
        file "/etc/bind/db.0";
};
zone "255.in-addr.arpa" {
        type master;
        file "/etc/bind/db.255";
};
-----------------------


nano /etc/bind/named.conf.options (for debian)
options {
        directory "/var/cache/bind";

        // Exchange port between DNS servers
        query-source address * port *;

        // Transmit requests to 192.168.1.1 if
        // this server doesn't know how to resolve them
        forward only;
        forwarders { 8.8.8.8; 8.8.4.4; 4.2.2.2; 192.168.1.1; };

        auth-nxdomain no;    # conform to RFC1035

        // Listen on local interfaces only(IPV4)
        listen-on-v6 { none; };
        listen-on { 127.0.0.1; 192.168.0.0/24; };

        // Do not transfer the zone information to the secondary DNS
        allow-transfer { none; };

        // Accept requests for internal network only
        allow-query { 192.168.0.0/24; };

        // Allow recursive queries to the local hosts
        allow-recursion { 127.0.0.1; 192.168.0.0/24 };

        // Do not make public version of BIND
        version none;
};


---------

