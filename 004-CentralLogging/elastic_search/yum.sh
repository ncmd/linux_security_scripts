rpm --import https://packages.elasticsearch.org/GPG-KEY-elasticsearch
touch  /etc/yum.repos.d/elasticsearch.repo
echo "[elasticsearch-1.4]" >>  /etc/yum.repos.d/elasticsearch.repo
echo "name=Elasticsearch repository for 1.4.x packages" >>  /etc/yum.repos.d/elasticsearch.repo
echo "baseurl=http://packages.elasticsearch.org/elasticsearch/1.4/centos" >>  /etc/yum.repos.d/elasticsearch.repo
echo "gpgcheck=1" >>  /etc/yum.repos.d/elasticsearch.repo
echo "gpgkey=http://packages.elasticsearch.org/GPG-KEY-elasticsearch" >>  /etc/yum.repos.d/elasticsearch.repo
echo "enabled=1" >>  /etc/yum.repos.d/elasticsearch.repo

yum install elasticsearch -y
chkconfig --add elasticsearch
/bin/systemctl daemon-reload
/bin/systemctl enable elasticsearch.service

systemctl start elasticsearch
chkconfig elasticsearch on

mkdir /var/log/elasticsearch/
mkdir /var/log/elasticsearch/log/
mkdir /var/elasticsearch/
mkdir /var/elasticsearch/data/

chown -R elasticsearch:elasticsearch /var/log/elasticsearch/log
chown -R elasticsearch:elasticsearch /var/elasticsearch/data
chmod -R ug+rw /var/log/elasticsearch/log
chmod -R ug+rw /var/elasticsearch/data

echo "elasticsearch soft nofile 32000" >> /etc/security/limits.conf
echo "elasticsearch hard nofile 32000" >> /etc/security/limits.conf

echo "session required pam_limits.so" >> /etc/pam.d/su

cp -r ash/elastic_search/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

systemctl restart elasticsearch

# yum install pip-python 
# pip-python install -U pip
