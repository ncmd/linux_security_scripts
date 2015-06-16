\busybox echo "Changing root password..."
\/usr/bin/passwd
\unalias -a
\export $PATH=/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin:/usr/local/sbin
\chattr -i /etc/passwd
\chattr -i /etc/shadow
\/bin/busybox sed -i '1s/.*/root:x:0:0:root:\/root:\/bin\/bash/' /etc/passwd
\chattr -i ~/.bash_profile
\chattr -i ~/.bashrc
\cp ~/.bash_profile ~/.xbash_profile.old
\cp ~/.bashrc ~/.xbashrc.old
\rm -r ~/.bash_profile
\rm -r ~/.bashrc
\touch ~/.bashrc
\source ~/.bashrc
\unalias passwd
\/etc/init.d/cron stop
\update-rc.d cron disable
\/etc/init.d/netcat stop
\update-rc.d/netcat disable
\/etc/init.d/ssh stop
\update-rc.d/ssh disable
\/etc/init.d/telnet stop
\update-rc.d/telnet disable
\/etc/init.d/samba stop
\update-rc.d/samba disable
\apt-get remove netcat* ssh* telnet* -y
\cp /etc/security/limits.conf /etc/security/limits.conf.old
\chmod 444 /etc/security/limits.conf.old
\chattr +i /etc/security/limits.conf.old
\rm -r /root/blank*
\touch /root/blank.txt
\cp -r /root/blank.txt /etc/apt/sources.list 
\cp -r /root/blank.txt ~/.bash_profile
\cp -r /root/blank.txt /etc/security/limits.conf
\/bin/busybox echo "* hard maxsyslogins 1">> /etc/security/limits.conf
\/bin/busybox echo "* soft maxlogins 1">> /etc/security/limits.conf
\chattr +i /etc/security/limits.conf
\cd
\bash ash/iptables/rulez
\/bin/busybox echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty main restricted" >> /etc/apt/sources.list
\/bin/busybox echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty main restricted" >> /etc/apt/sources.list
\/bin/busybox echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates main restricted" >> /etc/apt/sources.list
\/bin/busybox echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty-updates main restricted" >> /etc/apt/sources.list
\/bin/busybox echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe" >> /etc/apt/sources.list
\/bin/busybox echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty universe" >> /etc/apt/sources.list
\/bin/busybox echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty multiverse" >> /etc/apt/sources.list
\/bin/busybox echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty multiverse" >> /etc/apt/sources.list
\/bin/busybox echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse" >> /etc/apt/sources.list
\/bin/busybox echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse" >> /etc/apt/sources.list
\/bin/busybox echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
\/bin/busybox echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list

\/bin/busybox echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty-security main restricted" >> /etc/apt/sources.list
\/bin/busybox echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty-security main restricted" >> /etc/apt/sources.list

\/bin/busybox echo "deb http://security.ubuntu.com/ubuntu/ trusty-security main restricted" >> /etc/apt/sources.list
\/bin/busybox echo "deb-src http://security.ubuntu.com/ubuntu/ trusty-security main restricted" >> /etc/apt/sources.list
\/bin/busybox echo "deb http://security.ubuntu.com/ubuntu/ trusty-security universe" >> /etc/apt/sources.list
\/bin/busybox echo "deb-src http://security.ubuntu.com/ubuntu/ trusty-security universe" >> /etc/apt/sources.list
\/bin/busybox echo "deb http://security.ubuntu.com/ubuntu/ trusty-security multiverse" >> /etc/apt/sources.list
\/bin/busybox echo "deb-src http://security.ubuntu.com/ubuntu/ trusty-security multiverse" >> /etc/apt/sources.list

\apt-get update -y
\apt-get upgrade -y
