{% from "haproxy/package-map.jinja" import pkgs with context %}

haproxy:
  pkg.installed:
    - name: {{ pkgs.haproxy }}
  service:
    - enable: True
    - running
    - watch:
      - file: haproxy
  file:
    - managed
    - name: {{ pkgs.get('config-path', '/etc') }}/haproxy.conf
    - template: jinja
    - source: salt://haproxy/files/haproxy.conf


{{ pkgs.get('config-path', '/etc') }}/haproxy/salt:
  file:
    - managed
    - makedirs: True
    - template: jinja
    - source: salt://haproxy/files/salt
    - require:
      - pkg: haproxy

{{ pkgs.get('config-path', '/etc') }}/haproxy/X-pem:
  file.managed:
    - source: salt://haproxy/files/X-pem
