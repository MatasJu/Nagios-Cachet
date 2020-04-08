#!/bin/bash

#prereq
apt update && apt install -y \
	mariadb-server php-xml
	
	
cd /tmp/
wget http://pear.php.net/go-pear.phar
php go-pear.phar



# nagiosql 
cd /var/www/html/

wget -N -O nagiosql.tar.gz https://gitlab.com/wizonet/nagiosql/-/archive/3.4.1/nagiosql-3.4.1.tar.gz
tar xzvf nagiosql.tar.gz
mv nagiosql-3.4.1/* .
rmdir nagiosql-3.4.1/


# got to //<host>/install/index.php