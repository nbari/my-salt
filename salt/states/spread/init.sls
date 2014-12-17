{% from "spread/package-map.jinja" import pkgs with context %}

spread:
  pkg.installed:
    - name: {{ pkgs.spread }}
  service:
    - enable: True
    - running
  file.managed:
    - name: {{ pkgs.get('config-path', '/etc') }}/spread.conf
    - template: jinja
    - source: salt://spread/files/spread.conf
