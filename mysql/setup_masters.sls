shutdown:
  cmd.run:
    - name: service mysql-server stop

/etc/my.cnf:
  file.managed:
    - source: salt://mysql/masters_my.cnf.jinja
    - template: jinja
    - watch:
      - cmd: shutdown

clean datadir:
  cmd.wait:
    - name: "rm -rf /var/db/mysql"
    - cdw: /
    - watch:
      - file: /etc/my.cnf

install db:
  cmd.wait:
    - name: "/usr/local/bin/mysql_install_db --basedir=/usr/local --datadir=/var/db/mysql --skip-name-resolve --force --user=mysql"
    - cwd: /
    - watch:
      - cmd: clean datadir

restart:
  cmd.wait:
    - name: service mysql-server restart
    - watch:
      - cmd: install db
