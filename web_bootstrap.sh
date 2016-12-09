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

apt-get install -y git htop zip unzip jq

apt-get -y install nginx

apt-get -y install curl php5-fpm php5-cli php5-curl php5-mcrypt php5-mysql


# Install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer

# Install Pip and AWS CLI
cd /tmp
curl -O https://bootstrap.pypa.io/get-pip.py
python2.7 get-pip.py
pip install awscli


rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
mv /home/vagrant/nginx.conf /etc/nginx/sites-available/guestlist
ln -s /etc/nginx/sites-available/guestlist /etc/nginx/sites-enabled/guestlist
#
systemctl restart nginx.service

