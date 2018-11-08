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

apt-get -y install php5-memcache memcached

#sed -i 's/Listen 80/Listen 0.0.0.0:80/' /etc/apache2/ports.conf
sed -i "s/-l 127.0.0.1/-l $1/" /etc/memcached.conf
sed -i "s/session.save_handler = files/session.save_handler = memcache/" /etc/php5/fpm/php.ini
sed -i "s/;session.save_path = \"\/var\/lib\/php5\/sessions\"/session.save_path = \"tcp:\/\/10.5.7.11:11211,tcp:\/\/10.5.7.12:11211\"/" /etc/php5/fpm/php.ini

echo "memcache.allow_failover=1" >> /etc/php5/mods-available/memcache.ini
echo "memcache.session_redundancy=3" >> /etc/php5/mods-available/memcache.ini

service memcached restart
service php5-fpm restart
