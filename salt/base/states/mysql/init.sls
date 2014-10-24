/etc/my.cnf:
  file.managed:
    - source: salt://mysql/masters_my.cnf.jinja
    - template: jinja

restart:
  cmd.run:
    - name: service mysql-server restart
    - watch:
      - file: /etc/my.cnf
