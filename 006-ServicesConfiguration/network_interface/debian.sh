cd
cp -r ash/network_interface/interfaces /etc/network/interfaces

/etc/init.d/networking restart
ip link set eth0 up



# default dhcp
# auto lo
# iface lo inet loopback
# allow-hotplug eth0
# iface eth0 inet dhcp
