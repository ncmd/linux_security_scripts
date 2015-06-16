pkg install -y apache24
echo 'apache24_enable="YES"' >> /etc/rc.conf

echo "Edit httpd config file (using 'vi') in 3 seconds..."
echo 'ServerRoot "/usr/local"'
echo 'ServerAdmin you@your.address'
echo 'ServerName www.example.com:80'
echo 'DocumentRoot "/usr/local/www/apache24/data"'
echo 'Listen :80'
sleep 3
vi /usr/local/etc/apache24/httpd.conf

service apache24 onestart
/usr/local/sbin/apachectl start

#Edit /usr/local/etc/apache24/httpd.conf file and add the following lines under /AddType

echo 'AddType application/x-httpd-php .php' >> /usr/local/etc/apache24.httpd.conf
echo 'AddType application/x-httpd-php-source .phps' >> /usr/local/etc/apache24.httpd.conf
#And add the following line under LoadModule section

echo 'LoadModule php5_module        libexec/apache24/libphp5.so' >> /usr/local/etc/apache24.httpd.conf

echo "Modify the line ‘DirectoryIndex index.html’ to DirectoryIndex index.php index.html"
echo "Modify the line ‘DirectoryIndex index.html’ to DirectoryIndex index.php index.html"
echo "Modify the line ‘DirectoryIndex index.html’ to DirectoryIndex index.php index.html"
sleep 2

#Now restart the apache server by using the following command
echo "Restarting Service"
sleep 1
/usr/local/sbin/apachectl restart
