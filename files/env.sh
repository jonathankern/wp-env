#!/bin/bash

PASSWORD="root"

sudo apt-get update

# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"

sudo apt-get install -y lamp-server^
sudo apt-get install -y php5-curl

# install phpmyadmin and give password(s) to installer
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get -y install phpmyadmin

# copy config with updated options
sudo cp /vagrant/files/apache/default /etc/apache2/sites-available/default

# enable permalinks
sudo ln -sfn /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/

sudo service apache2 restart

mysql -u root --password="$PASSWORD" < /vagrant/files/mysql_setup.sql;

echo "Updating bashrc.."

echo 'export PATH=$PATH:/vagrant/files/bin' >> /home/vagrant/.bashrc

#install node
apt-get install -y curl git-core
curl -sL https://deb.nodesource.com/setup | sudo bash -;

sudo apt-get install -y nodejs;
sudo echo "192.168.33.10   localtest.extole.com" >> /etc/hosts
sudo npm install -g bower grunt grunt-cli

cd /var/www/wp-content/themes/extole;

npm install; bower install;

