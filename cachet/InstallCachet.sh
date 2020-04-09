@@ -1,27 +0,0 @@
#!/bin/bash

SCRIPT_LOCATION="$(pwd)"

apt update && install php-mbstring php-apcu php-apcu-bc


mysql -u root -p -e "create database cachet"

cd /var/www
git clone https://github.com/cachethq/Cachet.git
cd Cachet

git checkout v2.4

cp $SCRIPT_LOCATION/.env .


curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
composer install --no-dev -o

echo "dont configure!"
php artisan cachet:install
php artisan key:generate

chmod -R 777 storage
rm -rf bootstrap/cache/*
chmod -R 777 bootstrap/

a2dissite 000-default
systemctl reload apache2

cp $SCRIPT_LOCATION/cachet.conf /etc/apache2/sites-available/
a2ensite cachet
systemctl restart apache2
