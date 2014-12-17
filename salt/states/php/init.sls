{% from "php/package-map.jinja" import pkgs with context %}

php:
  pkg.installed:
    - name: {{ pkgs.php }}
  file.managed:
    - name: {{ pkgs.get('config-path', '/etc') }}/php.ini
    - template: jinja
    - user: root
    - mode: 644
    - source: salt://php/files/php.ini
    - require:
      - pkg: php

php_fpm:
  service:
    - name: {{ pkgs.fpm_service }}
    - enable: True
    - running
    - watch:
      - file: php_fpm
      - file: php
  file.managed:
    - name: {{ pkgs.get('config-path', '/etc') }}/php-fpm.conf
    - template: jinja
    - source: salt://php/files/php-fpm.conf
