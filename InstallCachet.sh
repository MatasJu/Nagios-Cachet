#!/bin/bash

SCRIPT_LOCATION="$(pwd)"

apt update && install php-mbstring

cd /var/www
git clone https://github.com/cachethq/Cachet.git
cd Cachet

git checkout v2.4

cp $SCRIPT_LOCATION/.env .


curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
composer install --no-dev -o
php artisan key:generate

a2dissite 000-default
systemctl reload apache2

cp $SCRIPT_LOCATION/cachet.conf .
a2ensite cachet

systemctl reload apache2

