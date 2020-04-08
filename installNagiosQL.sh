#!/bin/bash

#prereq
apt update && apt install -y \
	mariadb-server php-xml php-pear php-mysql
	
# nagiosql 
cd /usr/local/nagios/share

wget -O nagiosql.tar.gz https://gitlab.com/wizonet/nagiosql/-/archive/3.4.1/nagiosql-3.4.1.tar.gz
tar xzvf nagiosql.tar.gz
mv nagiosql-3.4.1/* webadmin
rm -rf nagiosql-3.4.1/

echo "reboot the system"

# got to //<host>/install/index.php