/root/dump.sql.gz:
  file.managed:
    - source: salt://mysql/dump.sql.gz

load dump:
  cmd.run:
    - name: "gunzip < /root/dump.sql.gz | mysql -udbadmin --password=mysql"
    - watch:
      - file: /root/dump.sql.gz
  module.wait:
    - name: mysql.query
    - database: mysql
    - query: 'CHANGE MASTER TO MASTER_HOST="mysql.sandbox.pw", MASTER_USER="replica", MASTER_PASSWORD="e0597c15d721776e8a797581b4cd4e30", MASTER_PORT=3307'
    - watch:
      - cmd: load dump
