{% from "daemontools/package-map.jinja" import pkgs with context %}

daemontools:
  pkg.installed:
    - name: {{ pkgs.daemontools }}
  service:
    - name: {{ pkgs.service }}
    - enable: True
    - running
  file.directory:
    - name: {{ pkgs.get('service_dir', '/service') }}
    - makedirs: True
