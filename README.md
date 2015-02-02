# wp-env

# Prerequisites

+ [Vagrant](http://www.vagrantup.com/downloads.html)
+ [Virtualbox](https://www.virtualbox.org/wiki/Downloads)

path to wp
`../wp-www` - your (link) to wordpress document/root dir
`../wp-www/wp-content/themes/extole` - symlink to `/vagrant/theme` (broken on host), will be "right" in the vagrant vbox machine, since the path to theme

`../website` (git clone of website)

will be mounted as `/vagrant/theme` resource.

## Getting Started

1. Clone the project.
2. Run the command `vagrant up` from the directory

## Importing production wordpress db

1. Dump your db (phpmyadmin or other handy tool) into daily-backup.sql;
2. run `vagrant ssh` (will log you into vbox);
3. you can substitute "production" host with "dev" host e.g
	`$ update_dump.sh daily-backup.sql zzztest.extole.com`
    1st param is the dump you want to import
    2nd param is the dev host
    this will create daily-backup.sql-yyyy-mm-dd file with references to "dev" host
4. import the newly created file
  `$ import_daily_bk.sh daily-backup.sql-yyyy-mm-dd`
5. check the content on `zzztest.extole.com`

