/root/dump.sql.gz:
  file.managed:
    - source: salt://mysql/dump.sql.gz

load dump:
  cmd.run:
    - name: 'gunzip < /root/dump.sql.gz | mysql'
    - watch:
      - file: /root/dump.sql.gz

change master:
  cmd.wait:
    - name: mysql -e 'CHANGE MASTER TO MASTER_HOST="mysql.sandbox.pw", MASTER_CONNECT_RETRY=30, MASTER_USER="replica", MASTER_PASSWORD="slavepass", MASTER_PORT=3307, MASTER_LOG_FILE="mysqld-bin.000004", MASTER_LOG_POS=151; START SLAVE; FLUSH PRIVILEGES;'
    #- name: mysql -e 'CHANGE MASTER TO MASTER_HOST="mysql.sandbox.pw", MASTER_CONNECT_RETRY=30, MASTER_USER="replica", MASTER_PASSWORD="slavepass", MASTER_PORT=3307; START SLAVE;'
    - watch:
      - cmd: load dump
