#!/bin/bash
HOSTNAME="localhost"  

PORT="3306"

USERNAME="root"

PASSWORD="dafeifei"

DBNAME="owncloud"

curl https://download.owncloud.org/download/repositories/stable/Ubuntu_16.04/Release.key | sudo apt-key add -
echo 'deb http://download.owncloud.org/download/repositories/stable/Ubuntu_16.04/ /' | sudo tee /etc/apt/sources.list.d/owncloud.list

sudo apt-get update

sudo apt-get install owncloud-files
sudo systemctl restart apache2


create_db_sql="create database owncloud"
grant_db_sql="GRANT ALL ON owncloud.* to 'owncloud'@'localhost' IDENTIFIED BY 'dafeifei'"
sql1="FLUSH PRIVILEGES"

mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} -e "${create_db_sql}"
mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} -e "${grant_db_sql}"
mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} -e "${sql1}"



echo "Alias /owncloud "/var/www/owncloud/"
<Directory /var/www/owncloud/>
  Options +FollowSymlinks
  AllowOverride All
 <IfModule mod_dav.c>
  Dav off
 </IfModule>
 SetEnv HOME /var/www/owncloud
 SetEnv HTTP_HOME /var/www/owncloud
</Directory>" > /etc/apache2/sites-available/owncloud.conf

ln -s /etc/apache2/sites-available/owncloud.conf /etc/apache2/sites-enabled/owncloud.conf

chown -R www-data:www-data /var/www/owncloud/

sudo systemctl restart apache2

cd /var/www/owncloud
sudo -u www-data php occ maintenance:install --database="Mysql" --database-name="owncloud" --database-host="localhost" --database-user="owncloud" --database-pass="dafeifei" --admin-user="owncloud" --admin-pass="dafeifei"


cd /var/www/owncloud
IP=`wget http://ipecho.net/plain -O - -q ; echo`
sed -i "8c 0 => '$IP'," config/config.php
