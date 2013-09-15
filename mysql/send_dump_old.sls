stop:
  cmd.run:
    - name: 'rm -rf /var/db/mysql/*'
    - unless: service mysql-server stop

clean:
  cmd.run:
    - name: 'rm -rf /var/db/mysql/*; mkdir /var/db/mysql; chown -R mysql:mysql /var/db/mysql'
    - prereq_in:
      - cmd: stop

start:
  cmd.wait:
    - name: service mysql-server start
    - watch:
      - cmd: clean

/root/dump.sql.gz:
  file.managed:
    - source: salt://mysql/dump.sql.gz
    - watch:
      - cmd: start

load dump:
  cmd.run:
    - name: 'gunzip < /root/dump.sql.gz | mysql'
    - watch:
      - file: /root/dump.sql.gz

change master:
  cmd.wait:
     - name: mysql -e 'CHANGE MASTER TO MASTER_HOST="mysql.sandbox.pw", MASTER_CONNECT_RETRY=30, MASTER_USER="replica", MASTER_PASSWORD="slavepass", MASTER_PORT=3307, MASTER_LOG_FILE="mysqld-bin.000005", MASTER_LOG_POS=120; START SLAVE; FLUSH PRIVILEGES;'
    - watch:
      - cmd: load dump
