# Artillery Script
\rm -r /var/artillery
\rm -r -f /var/artillery
\git clone https://github.com/trustedsec/artillery
\cp -r ash/artillery/setup.py /root/artillery
\cp -r ash/artillery/config /root/artillery
\python /root/artillery/setup.py
\python /root/artillery/restart_server.py


