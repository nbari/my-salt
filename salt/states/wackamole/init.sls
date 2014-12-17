{% from "wackamole/package-map.jinja" import pkgs with context %}

wackamole:
  pkg.installed:
    - name: {{ pkgs.wackamole }}
  service:
    - running
    - provider: daemontools
    - watch:
      - file: wackamole
    - require:
      - file: run
      - file: log_run
  file.managed:
    - name: {{ pkgs.get('config-path', '/etc') }}/wackamole.conf
    - template: jinja
    - source: salt://wackamole/files/wackamole.conf
    - require:
      - pkg: wackamole


run:
  file.managed:
    - name: {{ pkgs.get('service_dir', '/service') }}/wackamole/run
    - mode: 755
    - makedirs: True
    - source: salt://wackamole/files/run

log_run:
  file.managed:
    - name: {{ pkgs.get('service_dir', '/service') }}/wackamole/log/run
    - mode: 755
    - makedirs: True
    - source: salt://wackamole/files/log_run

/var/log/wackamole:
  file.directory:
    - user: root
    - require:
      - file: run
      - file: log_run
