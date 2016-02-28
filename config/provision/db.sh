#!/bin/bash

PASSWORD=root

echo "Installing MySQL"
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes install mysql-server
sudo mysqladmin -u root password $PASSWORD

echo "Configuring MySQL"
mysql -u root --password=$PASSWORD --execute="SET PASSWORD FOR 'root'@'$(hostname)' = password('$PASSWORD');"
mysql -u root --password=$PASSWORD --execute="SET PASSWORD FOR 'root'@'127.0.0.1' = password('$PASSWORD');"
mysql -u root --password=$PASSWORD --execute="SET PASSWORD FOR 'root'@'::1' = password('$PASSWORD');"
mysql -u root --password=$PASSWORD --execute="FLUSH PRIVILEGES"

echo "Creating databases"
mysql -u root --password=$PASSWORD --execute="CREATE DATABASE flippd"
mysql -u root --password=$PASSWORD --execute="CREATE DATABASE flippd_test"

echo "Setting up lookup data"
mysql -u root --password=$PASSWORD --execute="INSERT INTO flippd.ratings (id, name, symbol) VALUES (1, 'happy', ':)'), (2, 'neutral', ':|'), (3, 'sad', ':(');"
