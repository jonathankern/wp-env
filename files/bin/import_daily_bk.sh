#/bin/bash

PASSWORD="root"

mysql -u root --password="$PASSWORD" wordpress < $1;

