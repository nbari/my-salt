#!/bin/sh

cat > /root/setup_dbadmin.sql <<SQL
DELETE FROM mysql.user;
FLUSH PRIVILEGES;
CREATE USER 'dbadmin'@'localhost' IDENTIFIED BY 'mysql';
GRANT ALL PRIVILEGES ON *.* TO 'dbadmin'@'localhost' WITH GRANT OPTION;
CREATE USER 'replica'@'%' IDENTIFIED BY 'slavepass';
GRANT REPLICATION SLAVE ON *.* TO 'replica'@'%';
SHOW GRANTS FOR 'dbadmin'@'localhost';
FLUSH PRIVILEGES;
SQL

mysql -uroot --password="" < /root/setup_dbadmin.sql
