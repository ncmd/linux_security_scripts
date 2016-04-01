#!/bin/bash
# Quick Rsyslog Server Setup
# Recieve logs as TCP
# Replace a
sed -i "22s/#$ModLoad imtcp/ c\$ModLoad imtcp" /etc/rsyslog.conf
sed -i "23s/#$InputTCPServerRun/ c\$InputTCPServerRun 514" /etc/rsyslog.conf

