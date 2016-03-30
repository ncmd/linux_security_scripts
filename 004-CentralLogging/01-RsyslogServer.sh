#!/bin/bash
# Quick Rsyslog Server Setup
# Recieve logs as TCP
sed -i "/#$ModLoad imtcp/ c\$ModLoad imtcp" /etc/rsyslog.conf
sed -i "/#$InputTCPServerRun/ c\$InputTCPServerRun 514" /etc/rsyslog.conf

