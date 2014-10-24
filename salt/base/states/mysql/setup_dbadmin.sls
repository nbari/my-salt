/root/setup_dbadmin.sh:
  file.managed:
    - source: salt://mysql/setup_dbadmin.sh

create dbadmin user:
  cmd.run:
    - name: sh /root/setup_dbadmin.sh
    - watch:
      - file: /root/setup_dbadmin.sh

clean:
  cmd.wait:
    - name: "rm -f /root/setup_dbadmin*; service mysql-server restart"
    - watch:
      - cmd: create dbadmin user
