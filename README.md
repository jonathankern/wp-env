# wp-env

# Prerequisites

+ [Vagrant](http://www.vagrantup.com/downloads.html)
+ [Virtualbox](https://www.virtualbox.org/wiki/Downloads)

paths:
a dir should contain 3 subdirs/projects

1. website
2. wp-env
3. wp-www (wordpress document/root dir)

wp-www dir has extole theme `wp-www/wp-content/themes/extole` as symlink to `/vagrant/theme`.
It's broken on host machine, but will be "right" on vagrant vbox machine, since the path to theme
will be mounted as `/vagrant/theme` resource.

```
  config.vm.synced_folder "../wp-www", "/var/www"
  config.vm.synced_folder "../website", "/vagrant/theme"
```

## Getting Started

1. Clone the project.
2. Run the command `vagrant up` from the directory

## Importing production wordpress db

1. Dump your db (phpmyadmin or other handy tool) into wp-env/files/import/daily-backup.sql;
2. run `vagrant ssh` (will log you into vbox);
3. `cd /vagrant/files`
4. before importing "production" dump, you can substitute "production"
   host with (your) "dev" host e.g `zzztest.extole.com`

  `$ ./bin/update_dump.sh import/daily-backup.sql zzztest.extole.com`
    1st param is the dump you want to import
    2nd param is the dev host
    this will create daily-backup.sql-yyyy-mm-dd file with references to "dev" host

    as output you will see
    ```
    vagrant@lucid64:/vagrant$ ./files/bin/update_dump.sh files/import/daily-backup.sql
    substituting extole host name with zzztest.extole.com
    Done.
    ```
5. import the newly created file
  `$ ./bin/import_daily_bk.sh import/daily-backup.sql-yyyy-mm-dd`

## Install website env (js libs)
6. switch to "website" dir

  ```
    $cd /vagrant/theme
    $npm install; bower install
  ```

8. for development (e.g. scss chanbges')
  ```
    $grunt serve
  ```

## Additional features

##### Enabling Live Reload in Your HTML
Once you've started a live reload server you'll be able to access the live reload script. 
To enable live reload on your page, add a script tag before your closing `</body>` tag pointing to the `livereload.js` script:

```html
<script src="//localhost:35729/livereload.js"></script>
```
