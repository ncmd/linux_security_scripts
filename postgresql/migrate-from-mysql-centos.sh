# Disable MySQL
chkconfig mysqld off

# Install Postgres
yum install postgresql-server
chkconfig postgresql on
service postgresql start

service postgresql initdb
service postgresql start

cd /var/www/main
ls -lah

# total 20K
# drwxr-xr-x  2 root root 4.0K Aug 18 02:17 .
# drwxr-xr-x 10 root root 4.0K Aug 18 02:17 ..
# -rw-r--r--  1 root root   24 Aug 18 02:17 .htaccess
# -rw-r--r--  1 root root 1.1K Aug 18 02:17 index.php
# -rw-r--r--  1 root root  332 Aug 18 02:17 settings.php


# cat settings.php
# $db_type = 'mysql';
# $db_host = '127.0.0.1';
# $db_name = '_db_name';
# $db_user = '_db_user';
# $db_pass = '_db_password';

# switch to postgres user
sudo su - postgres
psql
CREATE ROLE root WITH LOGIN PASSWORD '_password_';
CREATE DATABASE _db_name WITH OWNER root;

psql -d _db_name -f /var/dump/_db_name.sql.postgres -U root -W
Password for user root: XXXXX
# psql: FATAL:  Ident authentication failed for user "root"

# Postgres pg_hba.conf must support the md5 authentication mechanism for TCP/IP based connections to and from 127.0.0.1
# /var/lib/pgsql/data
# ls -lah /var/lib/pgsql/data
# total 88K
# drwx------ 12 postgres postgres 4.0K Aug 18 02:21 .
# drwx------  4 postgres postgres 4.0K Aug 18 03:03 ..
# drwx------  6 postgres postgres 4.0K Aug 18 03:07 base
# drwx------  2 postgres postgres 4.0K Aug 18 03:07 global
# drwx------  2 postgres postgres 4.0K Aug 18 02:21 pg_clog
# -rw-------  1 postgres postgres 3.4K Aug 18 02:21 pg_hba.conf
# -rw-------  1 postgres postgres 1.6K Aug 18 02:21 pg_ident.conf
# drwx------  2 postgres postgres 4.0K Aug 18 02:21 pg_log
# drwx------  4 postgres postgres 4.0K Aug 18 02:21 pg_multixact
# drwx------  2 postgres postgres 4.0K Aug 18 03:19 pg_stat_tmp
# drwx------  2 postgres postgres 4.0K Aug 18 02:21 pg_subtrans
# drwx------  2 postgres postgres 4.0K Aug 18 02:21 pg_tblspc
# drwx------  2 postgres postgres 4.0K Aug 18 02:21 pg_twophase
# -rw-------  1 postgres postgres    4 Aug 18 02:21 PG_VERSION
# drwx------  3 postgres postgres 4.0K Aug 18 02:21 pg_xlog
# -rw-------  1 postgres postgres  17K Aug 18 02:21 postgresql.conf
# -rw-------  1 postgres postgres   57 Aug 18 02:21 postmaster.opts
# -rw-------  1 postgres postgres   46 Aug 18 02:21 postmaster.pid


# cat /var/lib/pgsql/data/pg_hba.conf | grep -v "#"
# local   all         all                               ident
# host    all         all         127.0.0.1/32          ident
# host    all         all         ::1/128               ident

# cat /var/lib/pgsql/data/pg_hba.conf | grep -v "#"
# Modify it to look like this:
# local   all         all                               ident
# host    all         all         127.0.0.1/32          md5
# host    all         all         ::1/128               md5

service postgresql restart
psql -d db_name -f /var/dump/db_name.sql.postgres -U root -W

#Password for user root: XXXXX

echo "Need to update the applications ‘settings.php’ to use Postgres, and not MySQL."
tail /var/log/httpd/error_log

# Database driver.  Use either 'mysql' or 'pgsql' (PostgreSQL)
echo "CHANGE SETTINGS/CONF file for Service from mysql to psql"
echo "$\db_type = 'pgsql'"
echo "CHANGE SETTINGS/CONF file for Service from mysql to psql"
echo "\$db_type = 'pgsql'"
echo "CHANGE SETTINGS/CONF file for Service from mysql to psql"
echo "$\db_type = 'pgsql'"

echo "NEED TO INSTALL PHP DRIVER for pdo"
rpm -qa | grep -i php
#php-cli-5.3.3-23.el6_4.x86_64
# php-5.3.3-23.el6_4.x86_64
# php-common-5.3.3-23.el6_4.x86_64
# php-mysql-5.3.3-23.el6_4.x86_64
# php-pdo-5.3.3-23.el6_4.x86_64
echo "Searching for PHP DRIVER for pdo"
yum search php | grep -i postgres

yum install php-pgsql


