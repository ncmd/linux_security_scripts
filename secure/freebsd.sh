# bash installed? good now execute this bitch!
echo "Change the root password"
passwd root
service cron stop
service sshd stop

portsnap fetch
portsnap extract


echo "Change the /etc/rc.conf file and disable sshd"

#https://www.freebsd.org/doc/handbook/firewalls-pf.html


# rkhunter -c
