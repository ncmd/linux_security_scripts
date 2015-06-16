# http://www.ragingcomputer.com/2014/02/removing-old-records-for-logstash-elasticsearch-kibana
# 1. install java - 					ash/java/fedora.sh 
# 2. install elasticsearch - 				ash/elastic_search/yum.sh
# 3. install redis - 					ash/redis/fedora.sh
# 4. install logstash - 				ash/logstash/fedora.sh
# 5. install apache2/nginx -  ash/nginx/fedora.sh
# 6. install kibana - 					ash/kibana/kibana.sh
# 7. install apache2-utils/htpasswd 
# 8. bind redis to localhost
# 9. bind elasticsearch to localhost
# 10. config kibana to use nginx
# 11. install nxlog on client node, start service
# 12. **create scheduled task to clear logs

# ** not implemented

# CONFIG FILE LOCATIONS:
# /var/www/config/kibana.yml
# /etc/elasticsearch/elasticsearch.yml
# /etc/logstash/logstash.conf
# /etc/logstash/logstash-index.conf
# /etc/init.d/logstash
# /etc/init.d/logstash-index

echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
echo 1 > /proc/sys/net/ipv6/conf/default/disable_ipv6

sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1

bash ash/nginx/fedora.sh
bash ash/java/fedora.sh
bash ash/redis/fedora.sh
bash ash/logstash/fedora.sh
bash ash/elastic_search/yum.sh
bash ash/apache/fedora.sh
bash ash/kibana/kibana.sh
# bash ash/nxlog/fedora.sh

systemctl stop httpd
systemctl disable httpd

iptables --flush

echo "Starting KIBANA IN: /var/www/bin/kibana in 5 seconds..."
echo "Starting KIBANA IN: /var/www/bin/kibana in 5 seconds..."
echo "Starting KIBANA IN: /var/www/bin/kibana in 5 seconds..."
echo "Starting KIBANA IN: /var/www/bin/kibana in 5 seconds..."
echo "Starting KIBANA IN: /var/www/bin/kibana in 5 seconds..."
echo "Starting KIBANA IN: /var/www/bin/kibana in 5 seconds..."

sleep 5

/etc/logstash/bin/logstash agent -f /etc/logstash/logstash.conf
systemctl restart elasticsearch
systemctl restart nginx
systemctl restart redis
/var/www/bin/kibana &

echo "Kibana has started as a Job"
echo "Check: jobs"
echo "Login and start adding pattern!"

# port 5601; 80
