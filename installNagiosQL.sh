#!/bin/bash
DB_ROOT_PASS=nagiosadmin
NAGIOSQL_DIR=/usr/local/nagiosql
SCRIPT_LOCATION="$(pwd)"
CONFIG_SQL=$SCRIPT_LOCATION/nagios/working_targetConfig.sql


#prereq
apt update && apt install -y mariadb-server php-xml php-pear php-mysql  && \
	apt clean && rm -Rf /var/lib/apt/lists/*

systemctl restart apache2

# nagiosql 
cd /usr/local/nagios/share

wget -O nagiosql.tar.gz https://gitlab.com/wizonet/nagiosql/-/archive/3.4.1/nagiosql-3.4.1.tar.gz
tar xzvf nagiosql.tar.gz
mkdir webadmin
mv nagiosql-3.4.1/* webadmin
rm -rf nagiosql-3.4.1/


mkdir $NAGIOSQL_DIR
cd $NAGIOSQL_DIR
mkdir hosts services backup backup/hosts backup/services 

chown -R www-data:nagios .
chmod -R 750 .


# echo "set root pass for maria https://linuxize.com/post/how-to-reset-a-mysql-root-password/"
mysql -u root -p -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS'; FLUSH PRIVILEGES;"
FLUSH PRIVILEGES;
mysql -u root -p $DB_ROOT_PASS -e "$CONFIG_SQL"

cp $NAGIOSQL_DIR/nagios.cfg /usr/local/nagios/etc/nagios.cfg


systemctl restart nagios.service

#rm -rf /usr/local/nagios/share/webadmin/install/* #remove incase insert config works.
#rm /usr/local/nagios/share/nagiosql.tar.gz 

echo "got to //<url>/nagios/webadmin/install/index.php"

echo "edit Administration-> Config targets->localhost according to Tools->Nagios config.
