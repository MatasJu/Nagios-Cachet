#!/bin/bash

SCRIPT_LOCATION = "$(PWD)"
cd /var/www
git clone https://github.com/cachethq/Cachet.git
cd Cachet

git checkout v2.4

cp $SCRIPT_LOCATION/.env .


curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer





