wget -qO - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -

echo 'deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main' >> /etc/apt/sources.list

apt-get update && apt-get install elasticsearch

update-rc.d elasticsearch defaults 95 10


sed 53 
sudo vi /etc/pam.d/su
Uncomment pam_limits.so



apt-get install python-pip
pip install elasticsearch-curator

echo "20 0 * * * /usr/local/bin/curator --host 127.0.0.1 -d 120 -c 90" >>  /etc/crontab
