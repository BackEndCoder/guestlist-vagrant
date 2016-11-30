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
mysql -uroot -ppassword -e "CREATE USER 'guestlist'@'%' IDENTIFIED BY 'password';"
mysql -uroot -ppassword -e "CREATE DATABASE guestlist;"
mysql -uroot -ppassword -e "GRANT ALL PRIVILEGES ON guestlist.* TO 'guestlist'@'%';"
mysql -uroot -ppassword -e "FLUSH PRIVILEGES;"

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
sudo python2.7 get-pip.py
sudo pip install awscli

#
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
ln -s /etc/nginx/sites-available/guestlist /etc/nginx/sites-enabled/guestlist

systemctl start nginx.service
