/root/dump.sql.gz:
  file.managed:
    - source: salt://mysql/dump.sql.gz
  module.wait:
    - name: "mysql.user_list"
    - watch:
      - file: /root/dump.sql.gz
