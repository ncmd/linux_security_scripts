#!/bin/bash
# Ask for IP address or hostname
echo "Enter hostname or IP Address of Logging Server"
# Read user input, make it a variable
read host
# Append info to /etc/rsyslog.conf
echo "*.* @@$host:514" >> /etc/rsyslog.conf
