\apt-get install wget nano make g++ bison flex git python sed htop libpcre3-dev libdumbnet-dev zlib1g-dev libpcap-dev -y
cd /usr/src
wget http://www.tcpdump.org/release/libpcap-1.6.2.tar.gz  http://libdnet.googlecode.com/files/libdnet-1.12.tgz 
wget https://www.snort.org/downloads/snort/daq-2.0.4.tar.gz --no-check-certificate
wget https://snort.org/downloads/snort/snort-2.9.7.2.tar.gz --no-check-certificate
tar -xzf libpcap-1.6.2.tar.gz && cd /usr/src/libpcap-1.6.2
./configure --prefix=/usr && make && make install 
cd /usr/src/
tar -xzf libdnet-1.12.tgz z && cd /usr/src/libdnet-1.12
./configure --prefix=/usr --enable-shared && make && make install
cd /usr/src/
tar -xzf daq-2.0.4.tar.gz && cd /usr/src/daq-2.0.4
./configure && make && make install
cd /usr/src/
tar -xzf snort-2.9.7.2.tar.gz && cd /usr/src/snort-2.9.7.2
./configure --enable-sourcefire && make && make install
mkdir /usr/local/etc/snort /usr/local/etc/snort/rules /var/log/snort /usr/local/lib/snort_dynamicrules
groupadd snort && useradd -g snort snort
cp /usr/src/snort-2.9.7.2/etc/*.conf /usr/local/etc/snort
cp /usr/src/snort-2.9.7.2/etc/*.map /usr/local/etc/snort
cp /usr/src/snort-2.9.7.2/etc/*.config /usr/local/etc/snort
cp /root/ash/snort/snort.conf /usr/local/etc/snort

wget http://rules.emergingthreats.net/open/snort-2.9.0/emerging.rules.tar.gz
tar -xzf emerging.rules.tar.gz
cp rules/* /usr/local/etc/snort/rules

touch /usr/local/etc/snort/rules/white_list.rules /usr/local/etc/snort/rules/black_list.rules /usr/local/etc/snort/sid-msg.map

hostname -I > ip1.txt
ip_address=$(cut -d' ' -f1 ip1.txt)

ip_address=$(hostname -I) ; sed -i "45s/.*/ipvar HOME_NET $ip_address/" /usr/local/etc/snort/snort.conf
sed -i "48s/.*/ipvar EXTERNAL_NET !$ip_address/" /usr/local/etc/snort/snort.conf
ldconfig


snort -A console -c /usr/local/etc/snort/snort.conf &
