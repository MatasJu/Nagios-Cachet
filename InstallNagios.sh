#!/bin/bash

#set timezone for host
timedatectl set-timezone Europe/Berlin

# Nagios Core and Nagios Plugins prerequisites 
sudo apt update && apt install -y \
	git autoconf gcc libc6 make wget unzip apache2 apache2-utils php libgd-dev  \
    libmcrypt-dev libssl-dev bc gawk dc build-essential snmp libnet-snmp-perl gettext iptables-persistent && \
	apt clean && rm -Rf /var/lib/apt/lists/*
	
cd /tmp
wget -N nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.5.tar.gz

tar xzvf nagioscore.tar.gz -C /tmp/nagioscore

cd /tmp/nagioscore-nagios-4.4.5
./configure --with-httpd-conf=/etc/apache2/sites-enabled
make all

make install-groups-users
usermod -a -G nagios www-data

make install
make install-daemoninit
make install-commandmode
make install-config

make install-webconf
a2enmod rewrite
a2enmod cgi

htpasswd -bc /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin

# Nagios Plugins

cd /tmp
wget -N --no-check-certificate nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.2.1.tar.gz
tar zxvf nagios-plugins.tar.gz 

cd /tmp/nagios-plugins-release-2.2.1
./tools/setup
./configure
make
make install



echo 'add [date.timezone = "Europe/Berlin] to nano etc/php/7.3/apache2/php.ini' 

systemctl enable apache2.service && systemctl restart apache2.service

systemctl enable nagios.service && systemctl restart nagios.service

systemctl enable nagios.service && systemctl restart nagios.service