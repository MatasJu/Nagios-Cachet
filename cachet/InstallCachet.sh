#!/bin/bash

SCRIPT_LOCATION="$(pwd)"
DB_ROOT_PASS=nagiosadmin

apt update && apt install -y php-mbstring php-apcu php-apcu-bc && \
	apt clean && rm -Rf /var/lib/apt/lists/*


mysql -u root -p -e "create database cachet"

cd /var/www
git clone https://github.com/cachethq/Cachet.git
cd Cachet

git checkout 2.4

cp $SCRIPT_LOCATION/.env .


curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
composer install --no-dev -o

echo "dont configure!"
php artisan cachet:install

chmod -R 777 storage
rm -rf bootstrap/cache/*
chmod -R 777 bootstrap/

a2dissite 000-default

cp $SCRIPT_LOCATION/cachet.conf /etc/apache2/sites-available/
a2ensite cachet
systemctl restart apache2
