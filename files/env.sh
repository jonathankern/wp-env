#!/bin/bash

PASSWORD="root"

sudo apt-get update

# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"

sudo apt-get install -y lamp-server^

# install phpmyadmin and give password(s) to installer
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get -y install phpmyadmin


sudo cp /vagrant/files/apache/default /etc/apache2/sites-enabled/default

sudo service apache2 restart

mysql -u root --password="$PASSWORD" < /vagrant/files/mysql_setup.sql;

mysql -u root --password="$PASSWORD" wordpress < /vagrant/files/import/daily-backup*;
