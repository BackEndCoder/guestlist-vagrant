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
apt-get -y install pound
