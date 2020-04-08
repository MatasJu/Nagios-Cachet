#!/bin/bash

#prereq
apt update && apt install -y \
	mariadb-server php-xml php-pear php-mysql
	
# nagiosql 
cd /usr/local/nagios/share

wget -O nagiosql.tar.gz https://gitlab.com/wizonet/nagiosql/-/archive/3.4.1/nagiosql-3.4.1.tar.gz
tar xzvf nagiosql.tar.gz
mkdir webadmin
mv nagiosql-3.4.1/* webadmin
rm -rf nagiosql-3.4.1/#

chown -R nagios:nagios .
chmod -R 775 .

cd /usr/local/
mkdir nagiosql
cd /usr/local/nagiosql
chown -R nagios:nagios .
chmod -R 775 .


echo "set root pass for maria https://linuxize.com/post/how-to-reset-a-mysql-root-password/"
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '<pass>';"
echo "MariaDB [(none)]> FLUSH PRIVILEGES;"
echo "got to //<url>/nagios/webadmin/install/index.php"
echo "nagiosql config path : /usr/local/nagiosql"
echo "nagios config path :  /usr/local/nagios/etc"
echo "edit Administration-> Config targets->localhost according to Tools->Nagios config.
