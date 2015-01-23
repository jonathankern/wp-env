CREATE DATABASE wordpress;
CREATE USER wordpress@localhost IDENTIFIED by 'wordpress';
GRANT ALL ON wordpress.* to wordpress@localhost;
FLUSH PRIVILEGES;
