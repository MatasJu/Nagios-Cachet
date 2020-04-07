FROM ubuntu:18.04
WORKDIR /usr/src/Nagios

# based on official installation guide : https://support.nagios.com/kb/article/nagios-core-installing-nagios-core-from-source-96.html#Ubuntu

RUN apt-get update
RUN apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.2 libgd-dev

#Download Nagios source
RUN cd /tmp
RUN wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.5.tar.gz
RUN tar xzf nagioscore.tar.gz

#compile
RUN cd /tmp/nagioscore-nagios-4.4.5/
RUN ./configure --with-httpd-conf=/etc/apache2/sites-enabled
RUN make all

#Create User And Group This creates the nagios user and group. The www-data user is also added to the nagios group.

RUN make install-groups-users
RUN usermod -a -G nagios www-data
 
# Install Binaries - This step installs the binary files, CGIs, and HTML files.

RUN make install
 
# Install Service / Daemon  - This installs the service or daemon files and also configures them to start on boot.

RUN make install-daemoninit

# Install Command Mode This installs and configures the external command file.

RUN make install-commandmode

#Install Configuration Files This installs the *SAMPLE* configuration files. These are required as Nagios needs some configuration files to allow it to start.

RUN make install-config

#Install Apache Config Files- This installs the Apache web server configuration files and configures Apache settings.

RUN make install-webconf
RUN a2enmod rewrite
RUN a2enmod cgi

# Create nagiosadmin User Account You'll need to create an Apache user account to be able to log into Nagios. The following command will create a user account called nagiosadmin and you will be prompted to provide a password for the account.
# TODO: add ENV var for pass
htpasswd -ci /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin


# Start Apache Web Server

RUN systemctl restart apache2.service

#Start Service / Daemon
RUN systemctl start nagios.service