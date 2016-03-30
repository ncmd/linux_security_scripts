#!/bin/bash
echo "Enter hostname or IP Address"
read host
echo "*.* @@$host:514" >> /etc/rsyslog.conf
