#!/usr/bin/env bash
echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list
echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list
wget https://www.dotdeb.org/dotdeb.gpg
apt-key add dotdeb.gpg
apt-get update

apt-get install --reinstall ca-certificates

apt-get -y install nano

if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /development /var/www/html
fi

# Enable required apache modules
#a2enmod headers setenvif rewrite vhost_alias expires

# Force Apache to listen on IPv only
#sed -i 's/Listen 80/Listen 0.0.0.0:80/' /etc/apache2/ports.conf

apt-get install -y git htop zip unzip jq
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password password'
apt-get install -y mysql-server-5.5 mysql-client-5.5

# Add MySQL user and initial database
mysql -uroot -ppassword -e "CREATE USER 'guestlist_new'@'%' IDENTIFIED BY 'password';"
mysql -uroot -ppassword -e "CREATE DATABASE guestlist_new;"
mysql -uroot -ppassword -e "GRANT ALL PRIVILEGES ON guestlist_new.* TO 'guestlist_new'@'%';"
mysql -uroot -ppassword -e "FLUSH PRIVILEGES;"

