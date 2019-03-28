#!/bin/bash

#Folder name to drop opencart into
echo "please enter folder name"
read fname
sudo mkdir -p /var/www/$fname/public_html

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
