#!/bin/bash

#Folder name to drop opencart into
echo "please enter folder name"
read fname
directory=/var/www/$fname/public_html
if [ ! -d "$directory" ]; then
 sudo mkdir -p $directory
fi


#download opencart to directory then delete files in tmp
cd /tmp
wget https://github.com/opencart/opencart/archive/master.zip
sudo unzip master.zip
sudo mv opencart-master/upload/* /var/www/$fname/public_html
sudo rm -rf opencart-master/ master.zip

#rename opencart config files
sudo cp /var/www/$fname/public_html/config-dist.php /var/www/$fname/public_html/config.php
sudo cp /var/www/$fname/public_html/admin/config-dist.php /var/www/$fname/public_html/admin/config.php

#change ownership
sudo chown -R www-data:www-data /var/www/$fname
sudo chmod 755 -R /var/www/$fname

#SQL to create opencart database
dname=_db
dbname=$fname$dname

mysql -u root -p<<MYSQL_SCRIPT
CREATE DATABASE $dbname;
GRANT ALL PRIVILEGES ON $dbname.* TO 'localuser'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT
