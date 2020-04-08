#!/bin/bash


sudo apt update && apt install -y \
	git autoconf gcc libc6 make wget unzip apache2 apache2-utils php libgd-dev  \
    libmcrypt-dev libssl-dev bc gawk dc build-essential snmp libnet-snmp-perl gettext iptables-persistent && \
	apt clean && rm -Rf /var/lib/apt/lists/*
	
cd /tmp
wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.5.tar.gz

tar xzf nagioscore.tar.gz nagioscore -C /tmp/nagioscore

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
wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.2.1.tar.gz
tar zxf nagios-plugins.tar.gz 

cd /tmp/nagios-plugins-release-2.2.1
./tools/setup
./configure
make
make install



systemctl enable apache2.service && systemctl restart apache2.service

systemctl enable nagios.service && systemctl restart nagios.service

systemctl enable nagios.service && systemctl restart nagios.service