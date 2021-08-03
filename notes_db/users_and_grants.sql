CREATE USER 'api'@'%' IDENTIFIED WITH mysql_native_password BY '22pantsbanana';

GRANT ALL ON `notes`.* TO 'api'@'%';

FLUSH PRIVILEGES