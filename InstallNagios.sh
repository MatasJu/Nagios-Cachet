#!/bin/bash
NAGIOS_USER='nagiosadmin'
NAGIOS_PASSWORD='nagiosadmin'
SCRIPT_LOCATION="$(pwd)"
#set timezone for host
timedatectl set-timezone Europe/Berlin

# Nagios Core and Nagios Plugins prerequisites 
sudo apt update && apt install -y \
	git autoconf gcc libc6 make wget unzip apache2 apache2-utils php libgd-dev  \
    libmcrypt-dev libssl-dev bc gawk dc build-essential snmp libnet-snmp-perl gettext mosquitto-clients python3-pip && \
	apt clean && rm -Rf /var/lib/apt/lists/*

sudo pip3 install paho-mqtt

wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.5.tar.gz

tar xzvf nagioscore.tar.gz

cd nagioscore-nagios-4.4.5/
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

htpasswd -bc /usr/local/nagios/etc/htpasswd.users $NAGIOS_USER $NAGIOS_PASSWORD

# Nagios Plugins

cd $SCRIPT_LOCATION
wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.2.1.tar.gz
tar zxvf nagios-plugins.tar.gz 

cd nagios-plugins-release-2.2.1
./tools/setup
./configure
make
make install

echo 'date.timezone = "Europe/Berlin"' >> /etc/php/7.3/apache2/php.ini 

systemctl enable apache2.service && systemctl restart apache2.service
systemctl enable nagios.service && systemctl restart nagios.service
