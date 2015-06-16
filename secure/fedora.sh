systemctl stop sshd
systemctl stop telnet
systemctl stop netcat
chkconfig --level 0123456 sshd off


echo "UPDATING SYSTEM TAKES 526 (Fedora Server 21) PACKAGES!!! WILL YOU UPDATE???; USES 2GB RAM!!!???"
read answerUpdate

if (answerUpdate == yes)
yum update -y && yum upgrade -y
else
echo "EXITING!"
