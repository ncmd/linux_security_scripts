@echo off
echo installing nxlog
msiexec /passive /i "\\shareserver\sharename\path\to\nxlog\nxlog-ce-2.6.1131.msi"
echo copying configuration
move "C:\Program Files\nxlog\conf\nxlog.conf" "C:\Program Files\nxlog\conf\nxlog.conf.default"
copy "\\shareserver\sharename\path\to\nxlog\nxlog.conf" "C:\Program Files\nxlog\conf\nxlog.conf"
echo starting service
net start nxlog
echo done
