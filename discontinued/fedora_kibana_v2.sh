# 0. Confirm IP is STATIC
# 1. install java - 					ash/java/fedora.sh 
# 2. install elasticsearch - 				ash/elastic_search/yum.sh
# 3. install redis - 					ash/redis/fedora.sh
# 4. install logstash - 				ash/logstash/fedora.sh
# 5. install apache2/nginx -  				ash/nginx/fedora.sh
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

# Disabling IPV6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
echo 1 > /proc/sys/net/ipv6/conf/default/disable_ipv6
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1



