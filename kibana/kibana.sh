# kibanananana
wget https://download.elasticsearch.org/kibana/kibana/kibana-4.0.1-linux-x64.tar.gz
tar -xzvf kibana-4.0.1-linux-x64.tar.gz
cp -r kibana-4.0.1-linux-x64/* /var/www/

yum provides \*bin/htpasswd

echo "TIME TO ASSIGN PASSWORDS"
echo "TIME TO ASSIGN PASSWORDS"
echo "TIME TO ASSIGN PASSWORDS"
echo "TIME TO ASSIGN PASSWORDS"
echo "TIME TO ASSIGN PASSWORDS"
echo "ASSIGN ADMIN PASSWORDS - full access"
htpasswd -c /etc/nginx/conf.d/kibana.htpasswd root
htpasswd /etc/nginx/conf.d/kibana.htpasswd root
echo "ASSING USER PASSWORD - write access"
htpasswd -c /etc/nginx/conf.d/kibana-write.htpasswd root

bash ash/iptables/add_kibana_rulez.sh
cp -r ash/kibana/kibana.yml /var/www/config/kibana.yml
