userdel smbuser
groupdel domainusers

groupadd domainusers
useradd smbuser –m –G domainusers
echo "---!!!--SET PASSWORD FOR smbuser--!!!---"
echo "---!!!--SET PASSWORD FOR smbuser--!!!---"
echo "---!!!--SET PASSWORD FOR smbuser--!!!---"
echo "---!!!--SET PASSWORD FOR smbuser--!!!---"

read thePassword
echo $thePassword | passwd smbuser --stdin
passwd smbuser



hostname -I > ip1.txt
ip_address=$(cut -d' ' -f1 ip1.txt)

apt-get install samba-common samba -y


echo "-A RH-Firewall-1-INPUT -s $ip_address/24 -m state --state NEW -p tcp --dport 137 -j ACCEPT" >> /etc/iptables/rulez
echo "-A RH-Firewall-1-INPUT -s $ip_address/24 -m state --state NEW -p tcp --dport 138 -j ACCEPT" >> /etc/iptables/rulez
echo "-A RH-Firewall-1-INPUT -s $ip_address/24 -m state --state NEW -p tcp --dport 139 -j ACCEPT" >> /etc/iptables/rulez
echo "-A RH-Firewall-1-INPUT -s $ip_address/24 -m state --state NEW -p tcp --dport 445 -j ACCEPT" >> /etc/iptables/rulez
iptables-restore < /etc/iptables/rulez


getsebool –a | grep samba
getsebool –a | grep smb
setsebool –P samba_domain_controller on

/etc/init.d/samba start

mkdir /var/smb
chmod -R root:domainusers /var/smb
chown root:smbuser /var/smb

echo "[smb]" >> /etc/samba/smb.conf
echo "Comment = all domainusers" >> /etc/samba/smb.conf
echo "Path = /var/smb" >> /etc/samba/smb.conf
echo "Valid users = @smbuser" >> /etc/samba/smb.conf
echo "Force group = domainusers" >> /etc/samba/smb.conf
echo "Create mask = 0660" >> /etc/samba/smb.conf
echo "Directory mask = 0771" >> /etc/samba/smb.conf
echo "Writeable = yes" >> /etc/samba/smb.conf
echo "Browseable = yes" >> /etc/samba/smb.conf

/etc/init.d/samba restart 


