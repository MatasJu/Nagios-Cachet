#!/bin/bash

cd /var/www
git clone https://github.com/cachethq/Cachet.git
cd Cachet

git checkout v2.4

cp $(dirname "$BASH_SOURCE")/.env .


curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer





