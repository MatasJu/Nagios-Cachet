#!/bin/bash
apt update && apt install -y \
	mariadb-server
	
cd /var/www/html/

wget -N -O nagiosql.tar.gz https://gitlab.com/wizonet/nagiosql/-/archive/3.4.1/nagiosql-3.4.1.tar.gz
tar xzvf nagiosql.tar.gz


# got to //<host>/install/index.php