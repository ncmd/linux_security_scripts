
# https://fosskb.wordpress.com/2014/04/10/famp-installing-apache2-4-mysql-php-on-freebsd-10/
# http://www.freebsdmadeeasy.com/tutorials/web-server/install-mysql-server-on-freebsd.php
cd /usr/ports/databases/mysql56-server
make install

cd /usr/ports/databases/mysql56-client
make install

# The standard port installation places the server into /usr/local/libexec/mysqld, with the startup script for the MySQL server placed in /usr/local/etc/rc.d/mysql-server.

#Some additional notes on the BSD implementation:

# To remove MySQL after installation using the ports system:

# cd /usr/ports/databases/mysql51-server
# make deinstall

# cd /usr/ports/databases/mysql51-client
# make deinstall
echo 'mysql_enable="YES"' >> /etc/rc.conf

#sh /usr/local/etc/rc.d/mysql-server.sh start
/usr/local/etc/rc.d/mysql-server onestart

rehash
mysqladmin -uroot password ''
# SET PASSWORD FOR ''@'localhost' = PASSWORD('newpwd');
# SET PASSWORD FOR ''@'host_name' = PASSWORD('newpwd');
# To set a password for the root account use

# mysql -u root
# SET PASSWORD FOR 'root'@'localhost' = PASSWORD('newpwd');
# SET PASSWORD FOR 'root'@'host_name' = PASSWORD('newpwd');


#Create for remote access
#CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';

#GRANT ALL PRIVILEGES ON *.* TO 'username'@'localhost' WITH GRANT OPTION;
#GRANT ALL PRIVILEGES ON testdb.* TO 'testuser' identified by ‘password’;

#CREATE USER 'username'@'%' IDENTIFIED BY 'password';

#GRANT ALL PRIVILEGES ON _databasename.* TO 'username'@'%' WITH GRANT OPTION;
#flush privileges;
